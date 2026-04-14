# LEMP Stack Debian Ubuntu

## 1. Introduccion

LEMP usa Nginx en lugar de Apache para mejor rendimiento.

### Diferencias con LAMP

- Nginx: Mas rapido que Apache
- PHP-FPM: Gestor de procesos PHP
- Menor consumo de memoria

## 2. Preparacion

```bash
apt update && apt upgrade -y
apt install -y curl wget git
```

## 3. Instalar Nginx

```bash
apt install -y nginx
systemctl enable nginx
systemctl start nginx
nginx -v
ss -tulpn | grep :80
```

## 4. Instalar MariaDB

```bash
apt install -y mariadb-server mariadb-client
systemctl enable mariadb
systemctl start mariadb
mysql_secure_installation
```

## 5. Instalar PHP-FPM

### PHP 7.4

```bash
apt install -y php7.4-fpm php7.4-mysql php7.4-curl php7.4-gd php7.4-mbstring php7.4-xml php7.4-zip php7.4-intl php7.4-bcmath
```

### PHP 8.0

```bash
apt install -y php8.0-fpm php8.0-mysql php8.0-curl php8.0-gd php8.0-mbstring php8.0-xml php8.0-zip
```

### PHP 8.1

```bash
apt install -y php8.1-fpm php8.1-mysql php8.1-curl php8.1-gd php8.1-mbstring php8.1-xml php8.1-zip php8.1-opcache
```

### PHP 8.2

```bash
apt install -y php8.2-fpm php8.2-mysql php8.2-curl php8.2-gd php8.2-mbstring php8.2-xml php8.2-zip php8.2-opcache
```

### PHP 8.3

```bash
apt install -y php8.3-fpm php8.3-mysql php8.3-curl php8.3-gd php8.3-mbstring php8.3-xml php8.3-zip php8.3-opcache
```

## 6. Configurar PHP-FPM

```bash
nano /etc/php/8.2/fpm/pool.d/www.conf

[www]
user = www-data
group = www-data
listen = /run/php/php8.2-fpm.sock
listen.owner = www-data
pm = dynamic
pm.max_children = 50

systemctl restart php8.2-fpm
```

## 7. Virtual Host Nginx

```bash
mkdir -p /var/www/midominio.com/public_html
chown -R www-data:www-data /var/www/midominio.com
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
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/run/php/php8.2-fpm.sock;
    }
}
```

```bash
ln -s /etc/nginx/sites-available/midominio.com /etc/nginx/sites-enabled/
nginx -t
systemctl reload nginx
```

## 8. SSL con Certbot

```bash
apt install -y certbot python3-certbot-nginx
certbot --nginx -d midominio.com
```

## 9. Balanceo de Carga

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

## 10. Optimizacion

```nginx
gzip on;
gzip_types text/plain text/css application/json application/javascript;
```

## 11. Verificacion

```bash
echo "<?php phpinfo(); ?>" > /var/www/html/info.php
systemctl status nginx
systemctl status php8.2-fpm
systemctl status mariadb
```

## 12. Comandos

```bash
systemctl reload nginx
systemctl restart php8.2-fpm
systemctl restart mariadb

tail -f /var/log/nginx/error.log
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
PHP_VERSION="8.2"

apt install -y nginx
systemctl start nginx

apt install -y mariadb-server mariadb-client
systemctl start mariadb
mysql_secure_installation

add-apt-repository ppa:ondrej/php -y
apt update
apt install -y php${PHP_VERSION}-fpm php${PHP_VERSION}-mysql php${PHP_VERSION}-curl

systemctl start php${PHP_VERSION}-fpm

echo "LEMP Debian/Ubuntu instalado"
