# Proxy Server Basico Linux

## 1. Introduccion al Proxy

Un servidor proxy actua como intermediario entre clientes y servidores, permitiendo control de acceso, cache y registro de actividad.

### 1.1 Tipos de Proxy

- Forward Proxy: Para clientes internos acceder a internet
- Reverse Proxy: Para externos acceder a servidores internos
- Transparent Proxy: Sin configuracion en cliente

### 1.2 Servidores Proxy Populares

- Squid: El mas popular y completo
- Tinyproxy: Ligero y simple
- Nginx: Como reverse proxy
- HAProxy: Para alta disponibilidad

## 2. Squid - Proxy Forward

### 2.1 Instalacion

```bash
apt install -y squid
dnf install -y squid
```

### 2.2 Configuracion Basica

```bash
nano /etc/squid/squid.conf
```

```conf
http_port 3128

acl localnet src 192.168.1.0/24

acl SSL_ports port 443
acl Safe_ports port 80
acl Safe_ports port 443

http_access allow localnet
http_access allow localhost
http_access deny all

cache_dir ufs /var/spool/squid 100 16 256
maximum_object_size 4096 MB

dns_nameservers 8.8.8.8 8.8.4.4
```

### 2.3 Iniciar Servicio

```bash
squid -k parse
systemctl enable squid
systemctl start squid
systemctl status squid

ss -tulpn | grep 3128
```

### 2.4 Configurar Cliente

#### Navegador Firefox

Preferences - Network Settings - Manual proxy configuration
HTTP Proxy: 192.168.1.10
Port: 3128

#### Sistema

```bash
export http_proxy="http://192.168.1.10:3128"
export https_proxy="http://192.168.1.10:3128"
```

```bash
nano /etc/environment

http_proxy="http://192.168.1.10:3128"
https_proxy="http://192.168.1.10:3128"
no_proxy="localhost,127.0.0.1"
```

## 3. Autenticacion Basica

### 3.1 Autenticacion NCSA

```bash
htpasswd -c /etc/squid/passwd usuario1
htpasswd /etc/squid/passwd usuario2
```

### 3.2 Configurar Squid con Auth

```conf
auth_param basic program /usr/lib/squid/basic_ncsa_auth /etc/squid/passwd
auth_param basic children 5
auth_param basic realm "Proxy Autenticado"
auth_param basic credentialsttl 2 hours

acl authenticated proxy_auth REQUIRED

http_access allow authenticated
http_access deny all
```

```bash
systemctl restart squid
```

## 4. Squid Transparent

### 4.1 Configuracion

```conf
http_port 3128 transparent
```

### 4.2 Redireccionar Trafico iptables

```bash
sysctl -w net.ipv4.ip_forward=1
nano /etc/sysctl.conf
net.ipv4.ip_forward=1

iptables -t nat -A PREROUTING -i eth0 -p tcp --dport 80 -j REDIRECT --to-port 3128
iptables -t nat -A PREROUTING -i eth0 -p tcp --dport 443 -j REDIRECT --to-port 3128
iptables-save > /etc/iptables/rules.v4
```

### 4.3 RHEL firewalld

```bash
firewall-cmd --permanent --add-service=squid
firewall-cmd --permanent --direct --add-rule ipv4 nat PREROUTING 0 -i eth0 -p tcp --dport 80 -j REDIRECT --to-ports 3128
firewall-cmd --reload
```

## 5. Reverse Proxy con Squid

### 5.1 Configuracion

```conf
http_port 80 accel defaultsite=vhost

cache_peer 192.168.1.10 parent 80 0 no-query originserver
cache_peer_domain 192.168.1.10 midominio.com

acl dinamico urlpath_regex \.php$ \.asp$ \.cgi$
cache deny dinamico
```

### 5.2 SSL Transparent

```conf
https_port 443 cert=/etc/ssl/certs/server.crt key=/etc/ssl/private/server.key defaultsite=vhost

cache_peer 192.168.1.10 parent 443 0 no-query originserver ssl
```

## 6. Nginx como Reverse Proxy

### 6.1 Instalacion

```bash
apt install -y nginx
dnf install -y nginx
```

### 6.2 Reverse Proxy Basico

```bash
nano /etc/nginx/conf.d/proxy.conf
```

```nginx
server {
    listen 80;
    server_name midominio.com;
    
    location / {
        proxy_pass http://192.168.1.10:8080;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    }
}
```

### 6.3 Load Balancing

```nginx
upstream backend {
    server 192.168.1.10:8080;
    server 192.168.1.11:8080;
    server 192.168.1.12:8080;
}

server {
    listen 80;
    server_name midominio.com;
    
    location / {
        proxy_pass http://backend;
    }
}
```

### 6.4 SSL Termination

```nginx
server {
    listen 443 ssl http2;
    server_name midominio.com;
    
    ssl_certificate /etc/ssl/certs/server.crt;
    ssl_certificate_key /etc/ssl/private/server.key;
    
    location / {
        proxy_pass http://192.168.1.10:8080;
    }
}
```

## 7. Tinyproxy

### 7.1 Instalacion

```bash
apt install -y tinyproxy
dnf install -y tinyproxy
```

### 7.2 Configuracion

```bash
nano /etc/tinyproxy/tinyproxy.conf
```

```conf
Port 8888
Allow 192.168.1.0/24
Timeout 600
```

```bash
systemctl enable tinyproxy
systemctl start tinyproxy
```

## 8. Cache de Contenido

### 8.1 Configuracion de Cache Squid

```conf
cache_dir ufs /var/spool/squid 1000 16 256
minimum_object_size 0 KB
maximum_object_size 4096 MB
cache_mem 256 MB
maximum_object_size_in_memory 512 KB

refresh_pattern ^ftp:       1440    20%     10080
refresh_pattern ^http:     0       20%     4320
refresh_pattern .          0       20%     4320
```

### 8.2 Verificar Cache

```bash
du -sh /var/spool/squid/
squid -k shdf
tail -f /var/log/squid/access.log
```

## 9. Logs y Monitoreo

### 9.1 Logs Squid

```bash
tail -f /var/log/squid/access.log
tail -f /var/log/squid/cache.log
```

### 9.2 Analisis de Logs

```bash
cat /var/log/squid/access.log | awk '{print $3}' | sort | uniq -c | sort -rn | head -10
cat /var/log/squid/access.log | awk '{print $7}' | sort | uniq -c | sort -rn | head -10
```

## 10. Comandos de Gestion

### 10.1 Squid

```bash
squid -k parse
squid -k reconfigure
squid -k shutdown
squid -z
```

### 10.2 Nginx

```bash
nginx -t
systemctl reload nginx
systemctl restart nginx
```

## 11. Resumen de Puertos

| Servicio | Puerto |
|----------|--------|
| Squid | 3128 |
| Tinyproxy | 8888 |
| Nginx | 80/443 |

## 12. Script de Instalacion

```bash
#!/bin/bash
set -e

echo "Instalando Proxy Server"

apt install -y squid

cat > /etc/squid/squid.conf << 'EOF'
http_port 3128
acl localnet src 192.168.1.0/24
acl SSL_ports port 443
acl Safe_ports port 80
acl Safe_ports port 443
http_access allow localnet
http_access allow localhost
http_access deny all
cache_dir ufs /var/spool/squid 100 16 256
dns_nameservers 8.8.8.8
EOF

systemctl enable squid
systemctl start squid

echo "Proxy instalado en puerto 3128"
