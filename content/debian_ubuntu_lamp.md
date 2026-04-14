# LAMP Stack Debian Ubuntu

## 1. Introduccion

Esta guia cubre la instalacion del stack LAMP en Debian y Ubuntu.

### 1.1 Componentes

- Linux: Sistema operativo
- Apache: Servidor web
- MySQL/MariaDB: Base de datos
- PHP: Lenguaje de programacion

### 1.2 Versiones de PHP

| Version | Debian | Ubuntu | Estado |
|---------|--------|--------|--------|
| PHP 7.4 | 11 | 22.04 | Soporte |
| PHP 8.0 | 12 | 22.04 | Actual |
| PHP 8.1 | 12 | 22.04 | Actual |
| PHP 8.2 | 12/13 | 24.04 | Actual |
| PHP 8.3 | 13 | 24.04 | Actual |
| PHP 8.4 | 13 | 24.04 | Latest |

## 2. Preparacion

### 2.1 Actualizacion

```bash
apt update && apt upgrade -y
apt install -y curl wget git unzip software-properties-common
```

### 2.2 Repositorios PHP Ubuntu

```bash
add-apt-repository ppa:ondrej/php -y
apt update
```

### 2.3 Repositorios PHP Debian

```bash
apt install -y apt-transport-https lsb-release ca-certificates curl wget
curl -sSL https://packages.sury.org/php/apt.gpg | gpg --dearmor -o /usr/share/keyrings/php-sury.gpg
echo "deb [signed-by=/usr/share/keyrings/php-sury.gpg] https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/php-sury.list
apt update
```

## 3. Instalar Apache

```bash
apt install -y apache2 apache2-utils
systemctl enable apache2
systemctl start apache2
a2enmod rewrite ssl headers
```

## 4. Instalar MariaDB

```bash
apt install -y mariadb-server mariadb-client
systemctl enable mariadb
systemctl start mariadb
mysql_secure_installation
```

Crear base de datos:

```bash
mysql -u root -p
CREATE DATABASE app_db;
CREATE USER 'appuser'@'localhost' IDENTIFIED BY 'Password123!';
GRANT ALL PRIVILEGES ON app_db.* TO 'appuser'@'localhost';
FLUSH PRIVILEGES;
EXIT;
```

## 5. Instalar PHP

### PHP 7.4

```bash
apt install -y php7.4 php7.4-fpm php7.4-mysql php7.4-curl php7.4-gd php7.4-mbstring php7.4-xml php7.4-zip php7.4-intl php7.4-bcmath
php7.4 -v
```

### PHP 8.0

```bash
apt install -y php8.0 php8.0-fpm php8.0-mysql php8.0-curl php8.0-gd php8.0-mbstring php8.0-xml php8.0-zip php8.0-intl php8.0-bcmath
```

### PHP 8.1

```bash
apt install -y php8.1 php8.1-fpm php8.1-mysql php8.1-curl php8.1-gd php8.1-mbstring php8.1-xml php8.1-zip php8.1-intl php8.1-bcmath php8.1-opcache
```

### PHP 8.2

```bash
apt install -y php8.2 php8.2-fpm php8.2-mysql php8.2-curl php8.2-gd php8.2-mbstring php8.2-xml php8.2-zip php8.2-intl php8.2-bcmath php8.2-opcache
```

### PHP 8.3

```bash
apt install -y php8.3 php8.3-fpm php8.3-mysql php8.3-curl php8.3-gd php8.3-mbstring php8.3-xml php8.3-zip php8.3-intl php8.3-bcmath php8.3-opcache
```

## 6. Cambiar Version PHP

```bash
update-alternatives --list php
update-alternatives --set php /usr/bin/php8.2
php -v
```

## 7. Configurar PHP-FPM

```bash
nano /etc/php/8.2/fpm/pool.d/www.conf

[www]
user = www-data
group = www-data
listen = /run/php/php8.2-fpm.sock
pm = dynamic
pm.max_children = 50

systemctl restart php8.2-fpm
```

## 8. Configurar php.ini

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

## 9. Virtual Host

```bash
mkdir -p /var/www/midominio.com/public_html
chown -R www-data:www-data /var/www/midominio.com
```

```apache
<VirtualHost *:80>
    ServerName midominio.com
    DocumentRoot /var/www/midominio.com/public_html
    
    <Directory /var/www/midominio.com/public_html>
        Options -Indexes +FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>
</VirtualHost>
```

```bash
a2ensite midominio.com.conf
systemctl reload apache2
```

## 10. Certificado SSL

```bash
apt install -y certbot python3-certbot-apache
certbot --apache -d midominio.com -d www.midominio.com
```

## 11. Firewall

```bash
ufw allow 80/tcp
ufw allow 443/tcp
ufw allow OpenSSH
ufw enable
```

## 12. Verificacion

```bash
echo "<?php phpinfo(); ?>" > /var/www/html/info.php
systemctl status apache2
systemctl status php8.2-fpm
systemctl status mariadb
ss -tulpn | grep -E ":80|:443|:3306"
```

## 13. Comandos

```bash
systemctl restart apache2
systemctl restart php8.2-fpm
systemctl restart mariadb

tail -f /var/log/apache2/error.log
tail -f /var/log/php8.2-fpm.log
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
PHP_VERSION="8.2"
DB_PASS="ChangeMe123!"

apt update && apt upgrade -y
apt install -y apache2 apache2-utils a2enmod rewrite ssl headers

apt install -y mariadb-server mariadb-client
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
apt install -y php${PHP_VERSION} php${PHP_VERSION}-fpm php${PHP_VERSION}-mysql php${PHP_VERSION}-curl php${PHP_VERSION}-gd php${PHP_VERSION}-mbstring php${PHP_VERSION}-xml

systemctl restart apache2
systemctl restart php${PHP_VERSION}-fpm

echo "LAMP Debian/Ubuntu instalado"
