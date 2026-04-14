# LAMP Stack RHEL Fedora Rocky AlmaLinux

## 1. Introduccion

Esta guia cubre LAMP en RHEL, Fedora, Rocky Linux y AlmaLinux.

### Caracteristicas

- DNF como gestor de paquetes
- AppStream para multiples versiones
- firewalld para firewall
- SELinux para seguridad

## 2. Preparacion

```bash
dnf upgrade -y
dnf install -y epel-release
dnf install -y dnf-utils
dnf install -y https://rpms.remirepo.net/enterprise/remi-release-latest-$(rpm -E %rhel).rpm
```

## 3. Instalar Apache

```bash
dnf install -y httpd httpd-tools mod_ssl
systemctl enable httpd
systemctl start httpd
httpd -v
ss -tulpn | grep :80
```

## 4. Instalar MariaDB

```bash
dnf install -y mariadb-server mariadb
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
dnf module reset php
dnf module enable php:remi-7.4
dnf install -y php php-fpm php-mysql php-curl php-gd php-mbstring php-xml php-zip php-intl php-bcmath
```

### PHP 8.0

```bash
dnf module reset php
dnf module enable php:remi-8.0
dnf install -y php php-fpm php-mysql php-curl php-gd php-mbstring php-xml php-zip
```

### PHP 8.1

```bash
dnf module reset php
dnf module enable php:remi-8.1
dnf install -y php php-fpm php-mysql php-curl php-gd php-mbstring php-xml php-zip php-opcache
```

### PHP 8.2

```bash
dnf module reset php
dnf module enable php:remi-8.2
dnf install -y php php-fpm php-mysql php-curl php-gd php-mbstring php-xml php-zip php-opcache
```

### PHP 8.3

```bash
dnf module reset php
dnf module enable php:remi-8.3
dnf install -y php php-fpm php-mysql php-curl php-gd php-mbstring php-xml php-zip php-opcache
```

## 6. Configurar PHP-FPM

```bash
systemctl enable php-fpm
systemctl start php-fpm

nano /etc/php-fpm.d/www.conf

[www]
user = apache
group = apache
listen = /run/php-fpm/www.sock
pm = dynamic
pm.max_children = 50

systemctl restart php-fpm
```

## 7. Virtual Host

```bash
mkdir -p /var/www/midominio.com/public_html
chown -R apache:apache /var/www/midominio.com
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
httpd -t
systemctl reload httpd
```

## 8. Firewall firewalld

```bash
systemctl enable firewalld
systemctl start firewalld
firewall-cmd --permanent --add-service=http
firewall-cmd --permanent --add-service=https
firewall-cmd --reload
```

## 9. SELinux

```bash
setsebool -P httpd_can_network_connect 1
chcon -R -t httpd_sys_content_t /var/www/
restorecon -Rv /var/www/
```

## 10. Certificado SSL

```bash
dnf install -y certbot python3-certbot-apache
certbot --apache -d midominio.com
```

## 11. Verificacion

```bash
echo "<?php phpinfo(); ?>" > /var/www/html/info.php
systemctl status httpd
systemctl status php-fpm
systemctl status mariadb
ss -tulpn | grep -E ":80|:443"
```

## 12. Comandos

```bash
systemctl restart httpd
systemctl restart php-fpm
systemctl restart mariadb

tail -f /var/log/httpd/error_log
```

## 13. Resumen

| Servicio | Puerto |
|----------|--------|
| HTTP | 80 |
| HTTPS | 443 |
| MySQL | 3306 |

## 14. Script

```bash
#!/bin/bash
dnf update -y
dnf install -y epel-release
dnf install -y https://rpms.remirepo.net/enterprise/remi-release-latest-$(rpm -E %rhel).rpm

dnf install -y httpd httpd-tools
systemctl start httpd

dnf install -y mariadb-server mariadb
systemctl start mariadb
mysql_secure_installation

dnf module reset php
dnf module enable php:remi-8.2
dnf install -y php php-fpm php-mysql php-curl php-gd php-mbstring php-xml

systemctl start php-fpm

firewall-cmd --permanent --add-service=http
firewall-cmd --permanent --add-service=https
firewall-cmd --reload

echo "LAMP RHEL instalado"
