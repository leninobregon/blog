# LEMP Stack Debian/Ubuntu PHP 7.0 a 8.x

## 1. Introduccion al Stack LEMP

LEMP es un stack alternatif a LAMP que utiliza Nginx en lugar de Apache, ofreciendo mejor rendimiento bajo carga alta.

### 1.1 Componentes del Stack

- Linux: Sistema operativo base
- Nginx: Servidor web
- MySQL/MariaDB: Base de datos
- PHP: Lenguaje de programacion con PHP-FPM

### 1.2 Ventajas de Nginx

- Mejor rendimiento bajo carga alta
- Menor consumo de memoria
- Manejo eficiente de conexiones concurrentes

## 2. Preparacion del Sistema

### 2.1 Actualizacion Inicial

```bash
apt update && apt upgrade -y

apt install -y curl wget git unzip software-properties-common ca-certificates lsb-release
```

### 2.2 Agregar Repositorios PHP

#### Ubuntu

```bash
add-apt-repository ppa:ondrej/php -y
apt update
```

#### Debian

```bash
apt install -y apt-transport-https lsb-release ca-certificates curl wget

curl -sSL https://packages.sury.org/php/apt.gpg | gpg --dearmor -o /usr/share/keyrings/php-sury.gpg

echo "deb [signed-by=/usr/share/keyrings/php-sury.gpg] https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/php-sury.list

apt update
```

## 3. Instalacion de Nginx

### 3.1 Instalacion Basica

```bash
apt install -y nginx

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

## 4. Instalacion de MySQL/MariaDB

### 4.1 MariaDB

```bash
apt install -y mariadb-server mariadb-client

systemctl enable mariadb
systemctl start mariadb
systemctl status mariadb
```

### 4.2 Configuracion de Seguridad

```bash
mysql_secure_installation
```

### 4.3 Crear Base de Datos

```bash
mysql -u root -p

CREATE DATABASE app_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE USER 'appuser'@'localhost' IDENTIFIED BY 'PasswordSegura123!';
GRANT ALL PRIVILEGES ON app_db.* TO 'appuser'@'localhost';
FLUSH PRIVILEGES;
EOF
```

### 4.4 Tuning

```bash
nano /etc/mysql/mariadb.conf.d/50-server.cnf

[mysqld]
innodb_buffer_pool_size = 1G
max_connections = 200
character-set-server = utf8mb4
```

```bash
systemctl restart mariadb
```

## 5. Instalacion de PHP Multi Version

### 5.1 PHP 7.4

```bash
apt install -y php7.4-fpm php7.4-mysql php7.4-curl php7.4-gd \
    php7.4-mbstring php7.4-xml php7.4-zip php7.4-intl php7.4-bcmath

php7.4 -v
```

### 5.2 PHP 8.0

```bash
apt install -y php8.0-fpm php8.0-mysql php8.0-curl php8.0-gd \
    php8.0-mbstring php8.0-xml php8.0-zip php8.0-intl php8.0-bcmath
```

### 5.3 PHP 8.1

```bash
apt install -y php8.1-fpm php8.1-mysql php8.1-curl php8.1-gd \
    php8.1-mbstring php8.1-xml php8.1-zip php8.1-intl php8.1-bcmath
```

### 5.4 PHP 8.2

```bash
apt install -y php8.2-fpm php8.2-mysql php8.2-curl php8.2-gd \
    php8.2-mbstring php8.2-xml php8.2-zip php8.2-intl php8.2-bcmath \
    php8.2-sqlite3 php8.2-opcache
```

### 5.5 PHP 8.3

```bash
apt install -y php8.3-fpm php8.3-mysql php8.3-curl php8.3-gd \
    php8.3-mbstring php8.3-xml php8.3-zip php8.3-intl php8.3-bcmath \
    php8.3-sqlite3 php8.3-opcache
```

### 5.6 PHP 8.4

```bash
apt install -y php8.4-fpm php8.4-mysql php8.4-curl php8.4-gd \
    php8.4-mbstring php8.4-xml php8.4-zip php8.4-intl php8.4-bcmath \
    php8.4-sqlite3 php8.4-opcache
```

### 5.7 Cambiar Version Predeterminada

```bash
update-alternatives --config php

php -v
```

### 5.8 Configuracion PHP-FPM

```bash
nano /etc/php/8.2/fpm/pool.d/www.conf

[www]
user = www-data
group = www-data
listen = /run/php/php8.2-fpm.sock
listen.owner = www-data
listen.group = www-data
pm = dynamic
pm.max_children = 50

systemctl restart php8.2-fpm
```

### 5.9 php.ini

```bash
nano /etc/php/8.2/fpm/php.ini

memory_limit = 256M
upload_max_filesize = 64M
post_max_size = 64M
max_execution_time = 300
date.timezone = America/Mexico_City

opcache.enable = 1
opcache.memory_consumption = 128
```

```bash
systemctl restart php8.2-fpm
```

## 6. Configuracion de Virtual Hosts

### 6.1 Directorios

```bash
mkdir -p /var/www/midominio.com/public_html
mkdir -p /var/www/midominio.com/logs
chown -R www-data:www-data /var/www/midominio.com
```

### 6.2 Virtual Host

```bash
nano /etc/nginx/sites-available/midominio.com
```

```nginx
server {
    listen 80;
    listen [::]:80;
    
    server_name midominio.com www.midominio.com;
    root /var/www/midominio.com/public_html;
    index index.php index.html;
    
    access_log /var/www/midominio.com/logs/access.log;
    error_log /var/www/midominio.com/logs/error.log;
    
    location / {
        try_files $uri $uri/ /index.php?$query_string;
    }
    
    location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/run/php/php8.2-fpm.sock;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
    }
    
    location ~ /\. {
        deny all;
    }
}
```

```bash
ln -s /etc/nginx/sites-available/midominio.com /etc/nginx/sites-enabled/
nginx -t
systemctl reload nginx
```

### 6.3 SSL/TLS

```bash
apt install -y certbot python3-certbot-nginx
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
apt install -y phpmyadmin
ln -s /usr/share/phpmyadmin /var/www/html/phpmyadmin
```

## 10. Verificacion

### 10.1 Paginas de Prueba

```bash
echo "<?php phpinfo(); ?>" > /var/www/html/info.php
```

### 10.2 Servicios

```bash
ss -tulpn | grep -E ":80|:443|:3306"
systemctl status nginx
systemctl status php8.2-fpm
systemctl status mariadb
```

## 11. Comandos de Gestion

```bash
systemctl reload nginx
systemctl restart php8.2-fpm
systemctl restart mariadb

tail -f /var/log/nginx/error.log
tail -f /var/log/nginx/access.log
```

## 12. Resumen de Puertos

| Servicio | Puerto |
|----------|--------|
| HTTP | 80 |
| HTTPS | 443 |
| MySQL | 3306 |

## 13. Script de Instalacion

```bash
#!/bin/bash
set -e

PHP_VERSION="8.2"
DB_PASS="ChangeMe123!"

echo "Instalando LEMP Stack"

apt update && apt upgrade -y

apt install -y nginx
systemctl enable nginx

apt install -y mariadb-server mariadb-client
systemctl enable mariadb
systemctl start mariadb

mysql_secure_installation <<EOF
y
$DB_PASS
y
y
y
y
EOF

add-apt-repository ppa:ondrej/php -y
apt update

apt install -y php${PHP_VERSION}-fpm php${PHP_VERSION}-mysql \
    php${PHP_VERSION}-curl php${PHP_VERSION}-gd php${PHP_VERSION}-mbstring \
    php${PHP_VERSION}-xml php${PHP_VERSION}-zip

systemctl enable php${PHP_VERSION}-fpm
systemctl start php${PHP_VERSION}-fpm

apt install -y phpmyadmin

echo "LEMP Stack instalado"
echo "PHP: ${PHP_VERSION}"
