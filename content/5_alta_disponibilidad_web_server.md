# Alta Disponibilidad Web Server Linux

## 1. Introduccion a la Alta Disponibilidad

La Alta Disponibilidad HA busca garantizar que los servicios esten disponibles el maximo tiempo posible, minimizando el tiempo de inactividad mediante redundancia.

### 1.1 Componentes de HA

- Balanceador de carga: Distribuye trafico entre servidores
- Servidores redundantes: Multiples servidores para el mismo servicio
- IP flotante: IP que se mueve entre servidores automaticamente
- Monitoreo: Deteccion de fallos y recuperacion automatica

### 1.2 Arquitectura Comunes

```
         Usuario
            |
      Load Balancer
        /          \
   Web Server 1   Web Server 2
        \          /
      Base de Datos HA
```

## 2. Keepalived - IP Flotante

### 2.1 Instalacion

```bash
apt install -y keepalived

dnf install -y keepalived
```

### 2.2 Configuracion Maestro-Esclavo

#### Servidor Maestro

```bash
nano /etc/keepalived/keepalived.conf
```

```conf
vrrp_instance VI_1 {
    state MASTER
    interface eth0
    virtual_router_id 51
    priority 100
    advert_int 1
    authentication {
        auth_type PASS
        auth_pass micontrasena123
    }
    
    virtual_ipaddress {
        192.168.1.100/24 dev eth0
    }
}
```

#### Servidor Esclavo

```conf
vrrp_instance VI_1 {
    state BACKUP
    interface eth0
    virtual_router_id 51
    priority 50
    advert_int 1
    authentication {
        auth_type PASS
        auth_pass micontrasena123
    }
    
    virtual_ipaddress {
        192.168.1.100/24 dev eth0
    }
}
```

### 2.3 Iniciar y Verificar

```bash
systemctl enable keepalived
systemctl start keepalived
systemctl status keepalived

ip addr show eth0

journalctl -u keepalived -f
```

## 3. HAProxy - Balanceador de Carga

### 3.1 Instalacion

```bash
apt install -y haproxy
dnf install -y haproxy
```

### 3.2 Configuracion Basica

```bash
nano /etc/haproxy/haproxy.cfg
```

```conf
global
    log /dev/log local0
    chroot /var/lib/haproxy
    maxconn 4000
    user haproxy
    group haproxy
    daemon

defaults
    log     global
    mode    http
    option  httplog
    option  dontlognull
    option  redispatch
    retries 3
    timeout connect 5000
    timeout client  50000
    timeout server  50000

frontend http_front
    bind *:80
    default_backend web_back

backend web_back
    mode http
    balance roundrobin
    option httpchk GET /health.html
    
    server web1 192.168.1.10:80 check inter 2000 rise 2 fall 3
    server web2 192.168.1.11:80 check inter 2000 rise 2 fall 3
    server web3 192.168.1.12:80 check inter 2000 rise 2 fall 3

listen stats
    bind *:8404
    mode http
    stats enable
    stats uri /stats
    stats refresh 30s
    stats auth admin:password123
```

### 3.3 Modo SSL

```conf
frontend https_front
    bind *:443 ssl crt /etc/ssl/certs/server.pem
    mode http
    default_backend web_back
```

### 3.4 Algoritmos de Balanceo

```conf
balance roundrobin
balance leastconn
balance source
balance uri
```

### 3.5 Iniciar HAProxy

```bash
haproxy -c -f /etc/haproxy/haproxy.cfg

systemctl enable haproxy
systemctl start haproxy
systemctl status haproxy

http://tu-servidor:8404/stats
```

## 4. Combinacion Keepalived + HAProxy

### 4.1 Arquitectura Completa

```
                    IP Virtual 192.168.1.100
                           |
                    Keepalived
                           |
            +-------------+-------------+
            |                           |
      HAProxy Master            HAProxy Backup
            |                           |
    +-------+-------+            +-------+-------+
    |               |            |               |
 Web 1           Web 2        Web 3           Web 4
```

### 4.2 Keepalived con HAProxy

```conf
vrrp_script chk_haproxy {
    script "killall -0 haproxy"
    interval 2
    weight 2
}

vrrp_instance VI_1 {
    state MASTER
    interface eth0
    virtual_router_id 51
    priority 100
    
    track_script {
        chk_haproxy
    }
    
    virtual_ipaddress {
        192.168.1.100/24 dev eth0
    }
}
```

## 5. Nginx como Load Balancer

### 5.1 Configuracion Basica

```bash
nano /etc/nginx/conf.d/loadbalancer.conf
```

```nginx
upstream backend {
    server 192.168.1.10:80;
    server 192.168.1.11:80;
    server 192.168.1.12:80 backup;
}

server {
    listen 80;
    server_name midominio.com;
    
    location / {
        proxy_pass http://backend;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    }
}
```

### 5.2 Health Checks

```nginx
upstream backend {
    server 192.168.1.10:80 max_fails=3 fail_timeout=30s;
    server 192.168.1.11:80 max_fails=3 fail_timeout=30s;
    server 192.168.1.12:80 max_fails=3 fail_timeout=30s;
}
```

## 6. Sincronizacion de Archivos

### 6.1 Rsync

```bash
apt install -y rsync
```

```bash
nano /usr/local/bin/sync_web.sh
```

```bash
#!/bin/bash
RSYNC_USER="webadmin"
RSYNC_SERVER="192.168.1.11"
SOURCE_DIR="/var/www/html"
DEST_DIR="/var/www/html"

rsync -avz --delete -e ssh $SOURCE_DIR/ $RSYNC_USER@$RSYNC_SERVER:$DEST_DIR/
```

```bash
crontab -e
*/5 * * * * /usr/local/bin/sync_web.sh
```

### 6.2 NFS Compartido

```bash
apt install -y nfs-server
```

```bash
nano /etc/exports
/var/www/html 192.168.1.0/24(rw,sync,no_subtree_check,no_root_squash)

exportfs -a
```

```bash
mount -t nfs 192.168.1.10:/var/www/html /var/www/html
```

## 7. Monitoreo

### 7.1 Monit

```bash
apt install -y monit
```

```conf
set httpd port 2812
    use address localhost
    allow admin:monit123

check process haproxy with pidfile /var/run/haproxy.pid
    start program = "/usr/sbin/haproxy -f /etc/haproxy/haproxy.cfg"
    stop program = "/usr/sbin/haproxy -f /etc/haproxy/haproxy.cfg"
    if failed host 127.0.0.1 port 80 protocol http then restart
```

## 8. Comandos de Gestion

### 8.1 Keepalived

```bash
systemctl status keepalived
ip addr show
journalctl -u keepalived -f
systemctl restart keepalived
```

### 8.2 HAProxy

```bash
systemctl status haproxy
haproxy -c -f /etc/haproxy/haproxy.cfg
echo "show stats" | nc -U /run/haproxy/admin.sock
echo "disable server web_back/web1" | nc -U /run/haproxy/admin.sock
```

## 9. Resumen de Arquitectura

| Componente | Funcion | Puerto |
|------------|---------|--------|
| Keepalived | IP Flotante | VRRP 112 |
| HAProxy | Balanceo | 80, 443, 8404 |
| Nginx | Balanceo/Proxy | 80, 443 |
| NFS | File Sharing | 2049 |

## 10. Testing de HA

### 10.1 Simular Fallo

```bash
systemctl stop haproxy

ip addr show

journalctl -u keepalived -f
```

### 10.2 Verificar Balanceo

```bash
for i in {1..10}; do curl -s http://192.168.1.100 | head -1; done
```

## 11. Script de Instalacion

```bash
#!/bin/bash
set -e

echo "Instalando HA Web Server"

apt install -y haproxy

cat > /etc/haproxy/haproxy.cfg << 'EOF'
global
    log /dev/log local0
    chroot /var/lib/haproxy
    maxconn 4000
    user haproxy
    group haproxy

defaults
    mode http
    option httplog
    option redispatch

frontend http_front
    bind *:80
    default_backend web_back

backend web_back
    balance roundrobin
    server web1 192.168.1.10:80 check
    server web2 192.168.1.11:80 check
EOF

systemctl enable haproxy
systemctl start haproxy

apt install -y keepalived

cat > /etc/keepalived/keepalived.conf << 'EOF'
vrrp_instance VI_1 {
    state MASTER
    interface eth0
    virtual_router_id 51
    priority 100
    authentication {
        auth_type PASS
        auth_pass ha123
    }
    virtual_ipaddress {
        192.168.1.100/24
    }
}
EOF

systemctl enable keepalived
systemctl start keepalived

echo "HA Web Server instalado"
