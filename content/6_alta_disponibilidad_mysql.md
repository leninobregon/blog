# Alta Disponibilidad MySQL Linux

## 1. Introduccion a MySQL HA

MySQL Alta Disponibilidad garantiza que la base de datos este siempre accesible mediante replicacion, clustering y failover automatico.

### 1.1 Metodos de HA para MySQL

| Metodo | Tipo | Complexity |
|--------|------|------------|
| Replicacion Master-Slave | Async | Baja |
| MySQL Group Replication | Sync | Media |
| Galera Cluster | Sync | Media |
| MySQL InnoDB Cluster | Sync | Alta |

### 1.2 Arquitectura

```
         Aplicacion
              |
      Load Balancer / Proxy SQL
              |
    +---------+---------+
    |                   |
 Master DB           Replica DB
    |                   |
 Slave DB 1          Slave DB 2
```

## 2. Replicacion Master-Slave

### 2.1 Configuracion del Master

```bash
nano /etc/mysql/my.cnf

[mysqld]
server-id = 1
log_bin = /var/log/mysql/mysql-bin.log
binlog_do_db = mi_base_de_datos
binlog_format = ROW
expire_logs_days = 7
max_binlog_size = 100M

systemctl restart mysql
```

### 2.2 Crear Usuario de Replicacion

```bash
mysql -u root -p

CREATE USER 'replicator'@'%' IDENTIFIED BY 'ReplPassword123!';
GRANT REPLICATION SLAVE ON *.* TO 'replicator'@'%';
FLUSH PRIVILEGES;
SHOW MASTER STATUS;
EOF
```

### 2.3 Configuracion del Esclavo

```bash
nano /etc/mysql/my.cnf

[mysqld]
server-id = 2
relay_log = /var/log/mysql/mysql-relay-bin
read_only = 1
log_replica_updates = 1
skip_slave_start = 1

systemctl restart mysql
```

### 2.4 Configurar Esclavo

```bash
mysql -u root -p

CHANGE MASTER TO
    MASTER_HOST='192.168.1.10',
    MASTER_USER='replicator',
    MASTER_PASSWORD='ReplPassword123!',
    MASTER_LOG_FILE='mysql-bin.000001',
    MASTER_LOG_POS=XXX;

START SLAVE;
SHOW SLAVE STATUS\G
EOF
```

### 2.5 Verificar Replicacion

```bash
mysql -u root -p -e "SHOW SLAVE STATUS\G"

mysql -u root -p -e "SHOW SLAVE STATUS\G" | grep Seconds_Behind_Master
```

## 3. Replicacion Master-Master

### 3.1 Configuracion Servidor 1

```bash
nano /etc/mysql/my.cnf

[mysqld]
server-id = 1
auto_increment_increment = 2
auto_increment_offset = 1
log_bin = /var/log/mysql/mysql-bin.log
```

### 3.2 Configuracion Servidor 2

```bash
nano /etc/mysql/my.cnf

[mysqld]
server-id = 2
auto_increment_increment = 2
auto_increment_offset = 2
log_bin = /var/log/mysql/mysql-bin.log
```

## 4. Galera Cluster

### 4.1 Instalacion Debian/Ubuntu

```bash
apt install -y software-properties-common
add-apt-repository ppa:galera

apt install -y mariadb-server mariadb-client galera-3
```

### 4.2 Instalacion RHEL/Fedora

```bash
dnf install -y MariaDB-server MariaDB-client galera
```

### 4.3 Configuracion Nodo 1

```bash
nano /etc/mysql/conf.d/galera.cnf

[mysqld]
binlog_format=ROW
default-storage-engine=innodb
innodb_autoinc_lock_mode=2
bind-address=0.0.0.0

wsrep_on=ON
wsrep_provider=/usr/lib/galera/libgalera_smm.so
wsrep_cluster_name="mi_cluster"
wsrep_cluster_address="gcomm://192.168.1.10,192.168.1.11,192.168.1.12"
wsrep_node_name="nodo1"
wsrep_node_address="192.168.1.10"
```

### 4.4 Iniciar Cluster

```bash
galera_new_cluster

systemctl start mysql

mysql -u root -p -e "SHOW STATUS LIKE 'wsrep%';"
```

## 5. ProxySQL para MySQL

### 5.1 Instalacion

```bash
apt install -y proxysql
dnf install -y proxysql
```

### 5.2 Configuracion

```bash
systemctl start proxysql
systemctl enable proxysql

mysql -u admin -p -h 127.0.0.1 -P 6032
```

### 5.3 Agregar Backends

```sql
INSERT INTO mysql_servers(hostgroup_id, hostname, port) VALUES (0, '192.168.1.10', 3306);
INSERT INTO mysql_servers(hostgroup_id, hostname, port) VALUES (0, '192.168.1.11', 3306);

INSERT INTO mysql_users(username, password, default_hostgroup) VALUES ('appuser', 'Password123!', 0);

LOAD MYSQL SERVERS TO RUNTIME;
LOAD MYSQL USERS TO RUNTIME;
```

### 5.4 Reglas de Query

```sql
INSERT INTO mysql_query_rules(rule_id, active, match_pattern, destination_hostgroup, apply) VALUES
(1, 1, '^SELECT.*FOR UPDATE', 0, 1),
(2, 1, '^SELECT', 1, 1),
(3, 1, '^INSERT|^UPDATE|^DELETE', 0, 1);

LOAD MYSQL QUERY RULES TO RUNTIME;
```

## 6. HAProxy para MySQL

### 6.1 Configuracion Balanceador

```bash
apt install -y haproxy
```

```bash
nano /etc/haproxy/haproxy.cfg
```

```conf
global
    log /dev/log local0
    maxconn 4000
    user haproxy
    group haproxy

defaults
    mode    tcp
    option  tcplog
    retries 3
    timeout connect 5000

backend mysql_back
    mode tcp
    balance leastconn
    option tcp-check
    
    server mysql1 192.168.1.10:3306 check inter 2000 rise 2 fall 3
    server mysql2 192.168.1.11:3306 check inter 2000 rise 2 fall 3
    server mysql3 192.168.1.12:3306 check inter 2000 rise 2 fall 3 backup

frontend mysql_front
    bind *:3306
    default_backend mysql_back
```

```bash
systemctl restart haproxy
```

## 7. Keepalived para MySQL IP Flotante

### 7.1 Configuracion Maestro

```bash
apt install -y keepalived
```

```bash
nano /etc/keepalived/keepalived.conf
```

```conf
vrrp_instance VI_MYSQL {
    state MASTER
    interface eth0
    virtual_router_id 52
    priority 100
    authentication {
        auth_type PASS
        auth_pass mysqlha123
    }
    
    virtual_ipaddress {
        192.168.1.200/24 dev eth0
    }
    
    track_script {
        chk_mysql
    }
}

vrrp_script chk_mysql {
    script "mysqladmin -u root -pPassword123! ping"
    interval 5
    weight 2
}
```

### 7.2 Configuracion Esclavo

```conf
vrrp_instance VI_MYSQL {
    state BACKUP
    interface eth0
    virtual_router_id 52
    priority 50
    
    virtual_ipaddress {
        192.168.1.200/24
    }
}
```

```bash
systemctl enable keepalived
systemctl start keepalived
```

## 8. Backup y Restauracion

### 8.1 Backup en caliente

```bash
#!/bin/bash
DATE=$(date +%Y%m%d_%H%M%S)
BACKUP_DIR="/backup/mysql"
MYSQL_USER="backup"
MYSQL_PASS="BackupPass123!"

mkdir -p $BACKUP_DIR

mysqldump -u $MYSQL_USER -p$MYSQL_PASS \
    --single-transaction \
    --routines \
    --triggers \
    --all-databases | gzip > $BACKUP_DIR/full_backup_$DATE.sql.gz

find $BACKUP_DIR -name "*.sql.gz" -mtime +7 -delete
```

### 8.2 Restauracion

```bash
gunzip < backup_20240115_120000.sql.gz | mysql -u root -p
```

## 9. Monitoreo

### 9.1 Scripts de Monitoreo

```bash
#!/bin/bash
STATUS=$(mysql -u root -pPassword123! -e "SHOW SLAVE STATUS\G" | grep -E "Slave_IO_Running|Slave_SQL_Running")

if echo "$STATUS" | grep -q "Slave_IO_Running: No"; then
    echo "Alerta: IO Thread detenido" | mail -s "MySQL HA Alert" admin@midominio.com
fi
```

### 9.2 Agregar a Cron

```bash
crontab -e
*/5 * * * * /usr/local/bin/check_mysql_replication.sh
```

## 10. Comandos de Gestion

### 10.1 Replicacion

```bash
START SLAVE;
STOP SLAVE;
SHOW SLAVE STATUS\G;
SHOW PROCESSLIST;
```

### 10.2 Galera

```bash
SHOW STATUS LIKE 'wsrep_cluster%';
SHOW STATUS LIKE 'wsrep_incoming%';
```

## 11. Resumen de Puertos

| Servicio | Puerto |
|----------|--------|
| MySQL | 3306 |
| Galera | 4567 |
| ProxySQL Admin | 6032 |
| HAProxy Stats | 8404 |

## 12. Script de Instalacion Master-Slave

```bash
#!/bin/bash
set -e

MASTER_IP="192.168.1.10"
SLAVE_IP="192.168.1.11"
REPL_PASS="ReplPass123!"

echo "Configurando MySQL Master-Slave"

ssh root@$MASTER_IP "echo '[mysqld]
server-id=1
log_bin=/var/log/mysql/mysql-bin.log' >> /etc/mysql/my.cnf"

ssh root@$MASTER_IP "systemctl restart mysql"
ssh root@$MASTER_IP "mysql -u root -e \"CREATE USER 'repl'@'%' IDENTIFIED BY '$REPL_PASS'; GRANT REPLICATION SLAVE ON *.* TO 'repl'@'%'; FLUSH PRIVILEGES;\""

ssh root@$SLAVE_IP "echo '[mysqld]
server-id=2
relay_log=/var/log/mysql/mysql-relay-bin
read_only=1' >> /etc/mysql/my.cnf"

ssh root@$SLAVE_IP "systemctl restart mysql"

echo "Configurar replicacion en esclavo"
echo "CHANGE MASTER TO MASTER_HOST='$MASTER_IP', MASTER_USER='repl', MASTER_PASSWORD='$REPL_PASS';"
echo "START SLAVE;"
