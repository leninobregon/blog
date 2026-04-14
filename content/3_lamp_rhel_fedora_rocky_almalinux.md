# LAMP Stack RHEL Fedora Rocky Linux AlmaLinux

## 1. Introduccion

Esta guia cubre la instalacion del stack LAMP en distribuciones basadas en RHEL: RHEL, Fedora, Rocky Linux y AlmaLinux.

### 1.1 Caracteristicas Distintivas

- DNF como gestor de paquetes
- AppStream para multiples versiones de software
- firewalld como firewall por defecto
- SELinux habilitado por defecto

### 1.2 Versiones Soportadas

| Distribucion | PHP Disponible |
|--------------|----------------|
| RHEL 9 | PHP 8.0, 8.1 |
| RHEL 8 | PHP 7.4, 8.0 |
| Fedora 39/40 | PHP 8.2, 8.3 |
| Rocky 9 | PHP 8.1 |
| AlmaLinux 9 | PHP 8.1 |

## 2. Preparacion del Sistema

### 2.1 Actualizacion Inicial

```bash
dnf upgrade -y
```

### 2.2 Instalar Repositorios Extras

```bash
dnf install -y epel-release

dnf install -y dnf-utils http://rpms.remirepo.net/fedora/remi-release-latest-$(rpm -E %fedora).rpm

dnf install -y https://rpms.remirepo.net/enterprise/remi-release-latest-$(rpm -E %rhel).rpm
```

## 3. Instalacion de Apache

### 3.1 Instalacion

```bash
dnf install -y httpd httpd-tools mod_ssl

httpd -v

systemctl enable httpd
systemctl start httpd
systemctl status httpd

ss -tulpn | grep :80
```

### 3.2 Configuracion Basica

```bash
nano /etc/httpd/conf/httpd.conf

ServerTokens Prod
ServerSignature Off
```

### 3.3 Virtual Hosts

```bash
mkdir -p /var/www/midominio.com/public_html
mkdir -p /var/www/midominio.com/logs
chown -R apache:apache /var/www/midominio.com
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
httpd -t
systemctl reload httpd
```

## 4. Instalacion de MySQL/MariaDB

### 4.1 Instalacion en RHEL 9/Fedora

```bash
dnf install -y mariadb-server mariadb

systemctl enable mariadb
systemctl start mariadb
systemctl status mariadb
```

### 4.2 Instalacion en RHEL 8

```bash
dnf module reset mysql
dnf module enable mysql:8.0
dnf install -y mysql-server
```

### 4.3 Configuracion

```bash
mysql_secure_installation
```

### 4.4 Crear Base de Datos

```bash
mysql -u root -p

CREATE DATABASE app_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE USER 'appuser'@'localhost' IDENTIFIED BY 'Password123!';
GRANT ALL PRIVILEGES ON app_db.* TO 'appuser'@'localhost';
FLUSH PRIVILEGES;
EXIT;
```

### 4.5 Tuning

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

### 5.1 PHP con AppStream RHEL 8/9

```bash
dnf module list php

dnf module reset php
dnf module enable php:8.1

dnf install -y php php-fpm php-mysql php-curl php-gd php-mbstring \
    php-xml php-zip php-intl php-bcmath php-json

php -v
```

### 5.2 PHP con Remi Multi Version

```bash
dnf module list php

dnf module reset php
dnf module enable php:remi-8.2

dnf install -y php php-fpm php-mysql php-curl php-gd php-mbstring \
    php-xml php-zip php-intl php-bcmath php-json php-opcache
```

### 5.3 PHP 7.4

```bash
dnf module reset php
dnf module enable php:remi-7.4
dnf install -y php php-fpm php-mysql php-curl php-gd php-mbstring \
    php-xml php-zip php-intl php-bcmath
```

### 5.4 PHP 8.3

```bash
dnf module reset php
dnf module enable php:remi-8.3
dnf install -y php php-fpm php-mysql php-curl php-gd php-mbstring \
    php-xml php-zip php-intl php-bcmath php-opcache
```

### 5.5 Configuracion PHP-FPM

```bash
systemctl enable php-fpm
systemctl start php-fpm
systemctl status php-fpm

nano /etc/php-fpm.d/www.conf

[www]
user = apache
group = apache
listen = /run/php-fpm/www.sock
listen.owner = apache
listen.group = apache
pm = dynamic
pm.max_children = 50

systemctl restart php-fpm
```

### 5.6 php.ini

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

## 6. Configuracion de Apache con PHP-FPM

### 6.1 Configurar Proxy

```bash
LoadModule proxy_module modules/mod_proxy.so
LoadModule proxy_fcgi_module modules/mod_proxy_fcgi.so
```

### 6.2 Virtual Host con PHP-FPM

```bash
nano /etc/httpd/conf.d/midominio.conf
```

```apache
<VirtualHost *:80>
    ServerName midominio.com
    DocumentRoot /var/www/midominio.com/public_html
    
    <FilesMatch \.php$>
        SetHandler "proxy:unix:/run/php-fpm/www.sock|fcgi://localhost"
    </FilesMatch>
    
    <Directory /var/www/midominio.com/public_html>
        Options -Indexes +FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>
</VirtualHost>
```

## 7. Instalacion de phpMyAdmin

### 7.1 Instalacion

```bash
dnf install -y phpmyadmin

ln -s /usr/share/phpmyadmin /var/www/html/phpmyadmin
```

### 7.2 Configuracion

```bash
nano /etc/httpd/conf.d/phpmyadmin.conf

Alias /phpmyadmin /usr/share/phpmyadmin

<Directory /usr/share/phpmyadmin>
    Options -Indexes +FollowSymLinks
    AllowOverride All
    Require all granted
</Directory>

systemctl reload httpd
```

## 8. Firewall firewalld

### 8.1 Configuracion Basica

```bash
systemctl status firewalld
firewall-cmd --state

firewall-cmd --list-all

firewall-cmd --permanent --add-service=http
firewall-cmd --permanent --add-service=https
firewall-cmd --permanent --add-service=mysql
firewall-cmd --reload
```

### 8.2 Puertos Especificos

```bash
firewall-cmd --permanent --add-port=80/tcp
firewall-cmd --permanent --add-port=443/tcp
firewall-cmd --permanent --add-port=3306/tcp
firewall-cmd --reload
```

## 9. SELinux

### 9.1 Estados de SELinux

```bash
getenforce
sestatus

setenforce 0
setenforce 1
```

```bash
nano /etc/selinux/config
SELINUX=enforcing
```

### 9.2 Permisos para Web

```bash
setsebool -P httpd_can_network_connect 1

chcon -R -t httpd_sys_content_t /var/www/
restorecon -Rv /var/www/
```

### 9.3 Permisos para Base de Datos

```bash
setsebool -P mysql_connect_any 1
```

## 10. Certificados SSL/TLS

### 10.1 Let's Encrypt

```bash
dnf install -y certbot python3-certbot-apache

certbot --apache -d midominio.com -d www.midominio.com

certbot renew --dry-run
```

### 10.2 SSL Manual

```bash
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/pki/tls/private/server.key \
    -out /etc/pki/tls/certs/server.crt
```

```apache
SSLCertificateFile /etc/pki/tls/certs/server.crt
SSLCertificateKeyFile /etc/pki/tls/private/server.key
```

## 11. Verificacion

### 11.1 Paginas de Prueba

```bash
echo "<?php phpinfo(); ?>" > /var/www/html/info.php
```

### 11.2 Verificar Servicios

```bash
ss -tulpn | grep -E ":80|:443|:3306"

ps aux | grep httpd
ps aux | grep php-fpm
ps aux | grep mariadb
```

## 12. Comandos de Gestion

### 12.1 Gestion de Servicios

```bash
systemctl enable httpd
systemctl start httpd
systemctl restart httpd
systemctl status httpd
httpd -t

systemctl enable php-fpm
systemctl restart php-fpm

systemctl restart mariadb
```

### 12.2 Logs

```bash
tail -f /var/log/httpd/error_log
tail -f /var/log/httpd/access_log
tail -f /var/log/php-fpm/www.log
tail -f /var/log/mariadb/mariadb.log
```

## 13. Resumen de Puertos

| Servicio | Puerto |
|----------|--------|
| HTTP | 80 |
| HTTPS | 443 |
| MySQL | 3306 |

## 14. Script de Instalacion

```bash
#!/bin/bash
set -e

echo "Instalando LAMP Stack RHEL-based"

dnf update -y

dnf install -y epel-release
dnf install -y dnf-utils
dnf install -y https://rpms.remirepo.net/enterprise/remi-release-latest-$(rpm -E %rhel).rpm

dnf install -y httpd httpd-tools mod_ssl
systemctl enable httpd
systemctl start httpd

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
    php-xml php-zip php-intl php-bcmath php-json

systemctl enable php-fpm
systemctl start php-fpm

firewall-cmd --permanent --add-service=http
firewall-cmd --permanent --add-service=https
firewall-cmd --reload

echo "LAMP Stack instalado exitosamente"
