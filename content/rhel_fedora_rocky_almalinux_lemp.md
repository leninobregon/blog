# LEMP Stack RHEL Fedora Rocky AlmaLinux

## 1. Introduccion

LEMP con Nginx en RHEL, Fedora, Rocky Linux y AlmaLinux.

### Diferencias

- Nginx en lugar de Apache
- PHP-FPM para PHP
- DNF para paquetes
- firewalld y SELinux

## 2. Preparacion

```bash
dnf upgrade -y
dnf install -y epel-release
dnf install -y dnf-utils
dnf install -y https://rpms.remirepo.net/enterprise/remi-release-latest-$(rpm -E %rhel).rpm
```

## 3. Instalar Nginx

```bash
dnf install -y nginx
systemctl enable nginx
systemctl start nginx
nginx -v
ss -tulpn | grep :80
```

## 4. Instalar MariaDB

```bash
dnf install -y mariadb-server mariadb
systemctl enable mariadb
systemctl start mariadb
mysql_secure_installation
```

## 5. Instalar PHP-FPM

### PHP 7.4

```bash
dnf module reset php
dnf module enable php:remi-7.4
dnf install -y php php-fpm php-mysql php-curl php-gd php-mbstring php-xml php-zip
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
user = nginx
group = nginx
listen = /run/php-fpm/www.sock
pm = dynamic
pm.max_children = 50

systemctl restart php-fpm
```

## 7. Virtual Host Nginx

```bash
mkdir -p /var/www/midominio.com/public_html
chown -R nginx:nginx /var/www/midominio.com
```

```nginx
server {
    listen 80;
    server_name midominio.com;
    root /var/www/midominio.com/public_html;
    index index.php index.html;
    
    location / {
        try_files $uri $uri/ /index.php?$query_string;
    }
    
    location ~ \.php$ {
        include fastcgi_params;
        fastcgi_pass unix:/run/php-fpm/www.sock;
    }
}
```

```bash
ln -s /etc/nginx/conf.d/midominio.com.conf /etc/nginx/sites-enabled/
nginx -t
systemctl reload nginx
```

## 8. Balanceo de Carga

```nginx
upstream backend {
    server 192.168.1.10:80;
    server 192.168.1.11:80;
}

server {
    location / {
        proxy_pass http://backend;
    }
}
```

## 9. SSL

```bash
dnf install -y certbot python3-certbot-nginx
certbot --nginx -d midominio.com
```

## 10. Firewall

```bash
firewall-cmd --permanent --add-service=http
firewall-cmd --permanent --add-service=https
firewall-cmd --reload
```

## 11. SELinux

```bash
setsebool -P httpd_can_network_connect 1
setsebool -P nginx_can_network_connect 1
```

## 12. Verificacion

```bash
echo "<?php phpinfo(); ?>" > /var/www/html/info.php
systemctl status nginx
systemctl status php-fpm
systemctl status mariadb
```

## 13. Comandos

```bash
systemctl reload nginx
systemctl restart php-fpm
systemctl restart mariadb

tail -f /var/log/nginx/error.log
```

## 14. Resumen

| Servicio | Puerto |
|----------|--------|
| HTTP | 80 |
| HTTPS | 443 |
| MySQL | 3306 |

## 15. Script

```bash
#!/bin/bash
dnf install -y nginx
systemctl start nginx

dnf install -y mariadb-server mariadb
systemctl start mariadb

dnf module reset php
dnf module enable php:remi-8.2
dnf install -y php php-fpm php-mysql php-curl

systemctl start php-fpm

echo "LEMP RHEL instalado"
