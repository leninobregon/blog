# LAMP Stack Debian/Ubuntu PHP 7.0 a 8.x

## 1. Introduccion al Stack LAMP

El stack LAMP es la base para el desarrollo web en Linux. Esta guia cubre instalacion completa desde PHP 7.0 hasta 8.x en distribuciones basadas en Debian.

### 1.1 Componentes del Stack

- Linux: Sistema operativo base (Debian 12, Ubuntu 22.04/24.04)
- Apache: Servidor web HTTP
- MySQL/MariaDB: Sistema de gestion de bases de datos
- PHP: Lenguaje de programacion del lado del servidor

### 1.2 Versiones de PHP Soportadas

| Serie PHP | Debian | Ubuntu LTS | Estado |
|-----------|--------|------------|--------|
| PHP 7.4 | 11 | 22.04 | Seguridad |
| PHP 8.0 | 12 | 22.04 | Seguridad |
| PHP 8.1 | 12 | 22.04 | Actual |
| PHP 8.2 | 12/13 | 24.04 | Actual |
| PHP 8.3 | 13 | 24.04 | Actual |
| PHP 8.4 | 13 | 24.04 | Latest |

## 2. Preparacion del Sistema

### 2.1 Actualizacion Inicial

```bash
apt update && apt upgrade -y

apt install -y curl wget git unzip software-properties-common \
    apt-transport-https lsb-release ca-certificates
```

### 2.2 Agregar Repositorios PHP

#### Ubuntu - PPA Ondrej PHP

```bash
add-apt-repository ppa:ondrej/php -y
apt update
```

#### Debian - Repositorio SURY

```bash
apt install -y apt-transport-https lsb-release ca-certificates curl wget

curl -sSL https://packages.sury.org/php/apt.gpg | gpg --dearmor -o /usr/share/keyrings/php-sury.gpg

echo "deb [signed-by=/usr/share/keyrings/php-sury.gpg] https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/php-sury.list

apt update
```

## 3. Instalacion de Apache

### 3.1 Instalacion Basica

```bash
apt install -y apache2 apache2-utils

apache2 -v

systemctl enable apache2
systemctl start apache2
systemctl status apache2
```

### 3.2 Modulos Esenciales

```bash
a2enmod rewrite
a2enmod ssl
a2enmod headers
a2enmod proxy
a2enmod proxy_fcgi
a2enmod setenvif
```

### 3.3 Configuracion de MPM

```bash
a2dismod mpm_prefork
a2enmod mpm_event
```

### 3.4 Configuracion de Seguridad

```bash
nano /etc/apache2/apache2.conf

ServerTokens Prod
ServerSignature Off
TraceEnable Off

systemctl restart apache2
```

### 3.5 Virtual Hosts

```bash
mkdir -p /var/www/midominio.com/public_html
mkdir -p /var/www/midominio.com/logs

chown -R www-data:www-data /var/www/midominio.com
chmod -R 755 /var/www
```

```apache
<VirtualHost *:80>
    ServerName midominio.com
    ServerAlias www.midominio.com
    DocumentRoot /var/www/midominio.com/public_html
    
    ErrorLog /var/www/midominio.com/logs/error.log
    CustomLog /var/www/midominio.com/logs/access.log combined
    
    <Directory /var/www/midominio.com/public_html>
        Options -Indexes +FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>
</VirtualHost>
```

```bash
a2ensite midominio.com.conf
apache2ctl configtest
systemctl reload apache2
```

## 4. Instalacion de MySQL/MariaDB

### 4.1 Instalacion de MariaDB

```bash
apt install -y mariadb-server mariadb-client

mysql --version

systemctl enable mariadb
systemctl start mariadb
systemctl status mariadb
```

### 4.2 Configuracion de Seguridad

```bash
mysql_secure_installation
```

### 4.3 Crear Usuario y Base de Datos

```bash
mysql -u root -p

CREATE DATABASE blog_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE USER 'bloguser'@'localhost' IDENTIFIED BY 'ContrasenaSegura123!';
GRANT ALL PRIVILEGES ON blog_db.* TO 'bloguser'@'localhost';
FLUSH PRIVILEGES;
EXIT;
```

### 4.4 Tuning de Rendimiento

```bash
nano /etc/mysql/mariadb.conf.d/50-server.cnf

[mysqld]
innodb_buffer_pool_size = 1G
innodb_log_file_size = 256M
max_connections = 200
slow_query_log = 1
character-set-server = utf8mb4
```

```bash
systemctl restart mariadb
```

## 5. Instalacion de PHP Multi Version

### 5.1 Instalar PHP 7.4

```bash
apt install -y php7.4 php7.4-cli php7.4-fpm php7.4-mysql \
    php7.4-curl php7.4-gd php7.4-mbstring php7.4-xml \
    php7.4-zip php7.4-intl php7.4-bcmath php7.4-json

php7.4 -v
```

### 5.2 Instalar PHP 8.0

```bash
apt install -y php8.0 php8.0-cli php8.0-fpm php8.0-mysql \
    php8.0-curl php8.0-gd php8.0-mbstring php8.0-xml \
    php8.0-zip php8.0-intl php8.0-bcmath php8.0-json

php8.0 -v
```

### 5.3 Instalar PHP 8.1

```bash
apt install -y php8.1 php8.1-cli php8.1-fpm php8.1-mysql \
    php8.1-curl php8.1-gd php8.1-mbstring php8.1-xml \
    php8.1-zip php8.1-intl php8.1-bcmath php8.1-json

php8.1 -v
```

### 5.4 Instalar PHP 8.2

```bash
apt install -y php8.2 php8.2-cli php8.2-fpm php8.2-mysql \
    php8.2-curl php8.2-gd php8.2-mbstring php8.2-xml \
    php8.2-zip php8.2-intl php8.2-bcmath php8.2-json \
    php8.2-sqlite3 php8.2-opcache

php8.2 -v
```

### 5.5 Instalar PHP 8.3

```bash
apt install -y php8.3 php8.3-cli php8.3-fpm php8.3-mysql \
    php8.3-curl php8.3-gd php8.3-mbstring php8.3-xml \
    php8.3-zip php8.3-intl php8.3-bcmath php8.3-json \
    php8.3-sqlite3 php8.3-opcache

php8.3 -v
```

### 5.6 Instalar PHP 8.4

```bash
apt install -y php8.4 php8.4-cli php8.4-fpm php8.4-mysql \
    php8.4-curl php8.4-gd php8.4-mbstring php8.4-xml \
    php8.4-zip php8.4-intl php8.4-bcmath php8.4-json \
    php8.4-sqlite3 php8.4-opcache

php8.4 -v
```

### 5.7 Cambiar Version de PHP Predeterminada

```bash
update-alternatives --list php

update-alternatives --set php /usr/bin/php8.2

php -v
```

### 5.8 Configuracion PHP-FPM

```bash
ls /etc/php/

nano /etc/php/8.2/fpm/pool.d/www.conf

[www]
user = www-data
group = www-data
listen = /run/php/php8.2-fpm.sock
listen.owner = www-data
listen.group = www-data
pm = dynamic
pm.max_children = 50
pm.start_servers = 5
pm.min_spare_servers = 5
pm.max_spare_servers = 10

systemctl restart php8.2-fpm
```

### 5.9 Configuracion php.ini

```bash
nano /etc/php/8.2/fpm/php.ini

memory_limit = 256M
upload_max_filesize = 64M
post_max_size = 64M
max_execution_time = 300
max_input_time = 300
date.timezone = America/Mexico_City

opcache.enable = 1
opcache.memory_consumption = 128
opcache.max_accelerated_files = 10000

systemctl restart php8.2-fpm
```

### 5.10 Extensiones PHP Recomendadas

```bash
apt install -y php-imagick php-recode php-tidy php-xmlrpc php-xdebug
```

## 6. Configuracion de Apache con PHP-FPM

### 6.1 Configuracion por Defecto

```bash
a2enmod proxy_fcgi setenvif
a2enconf php8.2-fpm
```

### 6.2 Virtual Host con PHP Especifico

```apache
<VirtualHost *:80>
    ServerName midominio.com
    DocumentRoot /var/www/midominio.com/public_html
    
    <FilesMatch \.php$>
        SetHandler "proxy:unix:/run/php/php8.2-fpm.sock|fcgi://localhost"
    </FilesMatch>
    
    <Directory /var/www/midominio.com/public_html>
        Options -Indexes +FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>
</VirtualHost>
```

## 7. Instalacion de phpMyAdmin

### 7.1 Instalacion Basica

```bash
apt install -y phpmyadmin
```

Durante instalacion:
- Web server: apache2
- Configure db: yes
- Password: ingresar contrasena root MySQL

### 7.2 Configuracion Avanzada

```bash
ln -s /usr/share/phpmyadmin /var/www/html/phpmyadmin

htpasswd -c /etc/phpmyadmin/.htpasswd admin
```

```bash
a2enconf phpmyadmin
systemctl restart apache2
```

## 8. Certificados SSL/TLS

### 8.1 Let's Encrypt con Certbot

```bash
snap install --classic certbot

certbot --apache -d midominio.com -d www.midominio.com

certbot renew --dry-run
```

### 8.2 SSL Manual

```bash
a2enmod ssl
a2enmod headers

openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/ssl/private/server.key \
    -out /etc/ssl/certs/server.crt
```

```apache
<VirtualHost *:443>
    SSLEngine on
    SSLCertificateFile /etc/ssl/certs/server.crt
    SSLCertificateKeyFile /etc/ssl/private/server.key
</VirtualHost>
```

## 9. Verificacion y Testing

### 9.1 Crear Pagina de Prueba

```bash
echo "<?php phpinfo(); ?>" > /var/www/html/info.php
```

### 9.2 Verificar Servicios

```bash
systemctl status apache2
ss -tulpn | grep :80

systemctl status php8.2-fpm
ls -la /run/php/

systemctl status mariadb
ss -tulpn | grep :3306
```

### 9.3 Logs Importantes

```bash
tail -f /var/log/apache2/error.log
tail -f /var/log/apache2/access.log
tail -f /var/log/php8.2-fpm.log
```

## 10. Comandos de Gestion

### 10.1 Gestion de Servicios

```bash
systemctl restart apache2
systemctl reload apache2
apache2ctl configtest

systemctl restart php8.2-fpm

systemctl restart mariadb
```

### 10.2 Gestion de Versiones PHP

```bash
ls /usr/bin/php*

update-alternatives --config php

a2dismod php8.2
a2enmod php8.3
systemctl restart apache2
```

## 11. Resumen de Puertos y Servicios

| Servicio | Puerto | Protocolo |
|----------|--------|-----------|
| HTTP | 80 | TCP |
| HTTPS | 443 | TCP |
| MySQL | 3306 | TCP |

## 12. Script de Instalacion Automatica

```bash
#!/bin/bash
set -e

PHP_VERSION="8.2"
DB_PASS="ChangeMe123!"

echo "Instalando LAMP Stack"

apt update && apt upgrade -y

apt install -y apache2 apache2-utils
a2enmod rewrite ssl headers proxy_fcgi

apt install -y mariadb-server
systemctl start mariadb
systemctl enable mariadb

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

apt install -y php${PHP_VERSION} php${PHP_VERSION}-fpm \
    php${PHP_VERSION}-mysql php${PHP_VERSION}-curl \
    php${PHP_VERSION}-gd php${PHP_VERSION}-mbstring \
    php${PHP_VERSION}-xml php${PHP_VERSION}-zip \
    php${PHP_VERSION}-intl php${PHP_VERSION}-bcmath

sed -i "s/memory_limit = .*/memory_limit = 256M/" /etc/php/${PHP_VERSION}/fpm/php.ini
sed -i "s/upload_max_filesize = .*/upload_max_filesize = 64M/" /etc/php/${PHP_VERSION}/fpm/php.ini

a2enconf php${PHP_VERSION}-fpm
systemctl restart apache2

apt install -y phpmyadmin

echo "LAMP Stack instalado exitosamente"
echo "PHP Version: ${PHP_VERSION}"
echo "MariaDB root password: ${DB_PASS}"
