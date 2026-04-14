# LEMP Stack RHEL Fedora Rocky Linux AlmaLinux

## 1. Introduccion

LEMP stack con Nginx en distribuciones RHEL-based. Esta guia aplica a RHEL 8/9, Fedora 38+, Rocky Linux 8/9 y AlmaLinux 8/9.

### 1.1 Diferencias con LAMP

- Nginx en lugar de Apache
- PHP-FPM para procesamiento PHP
- Gestion con DNF
- firewalld para firewall
- SELinux para seguridad

## 2. Preparacion del Sistema

### 2.1 Actualizacion

```bash
dnf upgrade -y
```

### 2.2 Repositorios

```bash
dnf install -y epel-release
dnf install -y dnf-utils
dnf install -y https://rpms.remirepo.net/enterprise/remi-release-latest-$(rpm -E %rhel).rpm
```

## 3. Instalacion de Nginx

### 3.1 Instalacion

```bash
dnf install -y nginx

nginx -v

systemctl enable nginx
systemctl start nginx
systemctl status nginx

ss -tulpn | grep :80
```

### 3.2 Estructura de Archivos

```
/etc/nginx/
nginx.conf
conf.d/
default.d/
sites-available/
sites-enabled/
ssl/
```

### 3.3 Configuracion de Seguridad

```bash
nano /etc/nginx/nginx.conf

server_tokens off;
keepalive_timeout 65;
client_max_body_size 8M;

nginx -t
systemctl reload nginx
```

## 4. Instalacion de MariaDB

### 4.1 Instalacion

```bash
dnf install -y mariadb-server mariadb

systemctl enable mariadb
systemctl start mariadb
systemctl status mariadb
```

### 4.2 Configuracion

```bash
mysql_secure_installation
```

### 4.3 Tuning

```bash
nano /etc/my.cnf.d/mariadb-server.cnf

[mysqld]
innodb_buffer_pool_size = 1G
max_connections = 200
character-set-server = utf8mb4
```

```bash
systemctl restart mariadb
```

## 5. Instalacion de PHP

### 5.1 PHP-FPM con AppStream

```bash
dnf module list php

dnf module reset php
dnf module enable php:remi-8.1

dnf install -y php php-fpm php-mysql php-curl php-gd php-mbstring \
    php-xml php-zip php-intl php-bcmath php-json php-opcache

php -v
```

### 5.2 PHP 8.2/8.3

```bash
dnf module reset php
dnf module enable php:remi-8.2
dnf install -y php php-fpm php-mysql php-curl php-gd php-mbstring \
    php-xml php-zip php-intl php-bcmath php-opcache
```

### 5.3 PHP 7.4

```bash
dnf module reset php
dnf module enable php:remi-7.4
dnf install -y php php-fpm php-mysql php-curl php-gd php-mbstring \
    php-xml php-zip php-intl php-bcmath
```

### 5.4 Configuracion PHP-FPM

```bash
systemctl enable php-fpm
systemctl start php-fpm

nano /etc/php-fpm.d/www.conf

[www]
user = nginx
group = nginx
listen = /run/php-fpm/www.sock
listen.owner = nginx
listen.group = nginx
pm = dynamic
pm.max_children = 50

systemctl restart php-fpm
```

### 5.5 php.ini

```bash
nano /etc/php.ini

memory_limit = 256M
upload_max_filesize = 64M
post_max_size = 64M
max_execution_time = 300
date.timezone = America/Mexico_City

opcache.enable = 1
opcache.memory_consumption = 128

systemctl restart php-fpm
```

## 6. Configuracion de Virtual Hosts

### 6.1 Directorios

```bash
mkdir -p /var/www/midominio.com/public_html
mkdir -p /var/www/midominio.com/logs
chown -R nginx:nginx /var/www/midominio.com
```

### 6.2 Virtual Host

```bash
nano /etc/nginx/conf.d/midominio.com.conf
```

```nginx
server {
    listen 80;
    server_name midominio.com www.midominio.com;
    
    root /var/www/midominio.com/public_html;
    index index.php index.html;
    
    access_log /var/www/midominio.com/logs/access.log;
    error_log /var/www/midominio.com/logs/error.log;
    
    location / {
        try_files $uri $uri/ /index.php?$query_string;
    }
    
    location ~ \.php$ {
        include fastcgi_params;
        fastcgi_pass unix:/run/php-fpm/www.sock;
        fastcgi_index index.php;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
    }
    
    location ~ /\. {
        deny all;
    }
}
```

```bash
nginx -t
systemctl reload nginx
```

### 6.3 SSL/TLS

```bash
dnf install -y certbot python3-certbot-nginx
certbot --nginx -d midominio.com -d www.midominio.com
```

## 7. Balanceador de Carga

### 7.1 Upstream

```nginx
upstream backend {
    server 192.168.1.10:80;
    server 192.168.1.11:80;
    server 192.168.1.12:80;
}

server {
    location / {
        proxy_pass http://backend;
    }
}
```

### 7.2 Sticky Sessions

```nginx
upstream backend {
    ip_hash;
    server 192.168.1.10:80;
    server 192.168.1.11:80;
}
```

## 8. Optimizacion

### 8.1 Gzip

```nginx
gzip on;
gzip_types text/plain text/css application/json application/javascript;
gzip_min_length 1000;
```

### 8.2 Cache

```nginx
location ~* \.(jpg|jpeg|png|gif|ico|css|js)$ {
    expires 30d;
}
```

## 9. phpMyAdmin

### 9.1 Instalacion

```bash
dnf install -y phpmyadmin
ln -s /usr/share/phpmyadmin /var/www/html/phpmyadmin
```

## 10. Firewall

```bash
systemctl enable firewalld
systemctl start firewalld

firewall-cmd --permanent --add-service=http
firewall-cmd --permanent --add-service=https
firewall-cmd --reload
```

## 11. SELinux

```bash
setsebool -P httpd_can_network_connect 1
setsebool -P nginx_can_network_connect 1

chcon -R -t httpd_sys_content_t /var/www/
restorecon -Rv /var/www/
```

## 12. Verificacion

### 12.1 Test Pages

```bash
echo "<?php phpinfo(); ?>" > /var/www/html/info.php
```

### 12.2 Servicios

```bash
ss -tulpn | grep -E ":80|:443|:3306"
systemctl status nginx
systemctl status php-fpm
systemctl status mariadb
```

## 13. Comandos de Gestion

```bash
systemctl reload nginx
systemctl restart php-fpm
systemctl restart mariadb

tail -f /var/log/nginx/error.log
tail -f /var/log/nginx/access.log
```

## 14. Resumen de Puertos

| Servicio | Puerto |
|----------|--------|
| HTTP | 80 |
| HTTPS | 443 |
| MySQL | 3306 |

## 15. Script de Instalacion

```bash
#!/bin/bash
set -e

echo "Instalando LEMP Stack RHEL-based"

dnf install -y epel-release
dnf install -y dnf-utils
dnf install -y https://rpms.remirepo.net/enterprise/remi-release-latest-$(rpm -E %rhel).rpm

dnf install -y nginx
systemctl enable nginx
systemctl start nginx

dnf install -y mariadb-server mariadb
systemctl enable mariadb
systemctl start mariadb
mysql_secure_installation <<EOF
y
Password123!
y
y
y
y
EOF

dnf module reset php
dnf module enable php:remi-8.1
dnf install -y php php-fpm php-mysql php-curl php-gd php-mbstring \
    php-xml php-zip php-intl php-bcmath php-opcache

systemctl enable php-fpm
systemctl start php-fpm

firewall-cmd --permanent --add-service=http
firewall-cmd --permanent --add-service=https
firewall-cmd --reload

echo "LEMP Stack instalado"
