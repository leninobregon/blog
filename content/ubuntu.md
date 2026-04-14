# Ubuntu Linux - Guia Completa

## 1. Introduccion a Ubuntu

Ubuntu es una distribucion Linux basada en Debian, desarrollada por Canonical. Es una de las distribuciones mas populares para servidores y escritorio.

### 1.1 Caracteristicas

- Facilidad de uso
- Actualizaciones regulares cada 6 meses
- Versiones LTS cada 2 anos (soporte 5 anos)
- Amplia documentacion
- Gran comunidad

### 1.2 Versiones

| Version | Fecha | Tipo | Soporte |
|---------|-------|------|----------|
| Ubuntu 24.04 LTS | 2024 | LTS | 2034 |
| Ubuntu 22.04 LTS | 2022 | LTS | 2032 |
| Ubuntu 20.04 LTS | 2020 | LTS | 2030 |
| Ubuntu 24.10 | 2024 | Normal | 2025 |
| Ubuntu 25.04 | 2025 | Normal | 2026 |

## 2. Instalacion

### 2.1 Requisitos Minimos

- Procesador: 2 nucleos
- RAM: 4 GB (8 GB recomendado)
- Disco: 25 GB
- Conexion a internet

### 2.2 Tipos de Instalacion

#### Desktop
```bash
# Descargar
wget https://releases.ubuntu.com/24.04/ubuntu-24.04-desktop-amd64.iso

# Crear USB
sudo dd if=ubuntu-24.04-desktop-amd64.iso of=/dev/sdX bs=4M status=progress
```

#### Server
```bash
wget https://releases.ubuntu.com/24.04/ubuntu-24.04-live-server-amd64.iso
```

### 2.3 Instalacion con autoinstall

```bash
# Crear archivo de configuracion
cat > user-data << 'EOF'
#cloud-config
autoinstall:
  version: 1
  locale: es_ES.UTF-8
  identity:
    hostname: ubuntu-server
    password: "$6$rounds=4096$hash$contrasena"
    username: ubuntu
  ssh:
    install-server: true
    allow-pw: true
  storage:
    layout:
      name: lvm
EOF

# Instalar
echo "autoinstall ds=nocloud-net;s=http://servidor/user-data/" | boot
```

## 3. Gestion de Paquetes

### 3.1 APT

```bash
# Actualizar
apt update
apt upgrade

# Instalar
apt install nombre_paquete
apt install -y nombre_paquete  # Sin preguntar

# Remover
apt remove nombre_paquete
apt purge nombre_paquete

# Buscar
apt search palabra
apt-cache search palabra

# Ver info
apt show nombre_paquete
```

### 3.2 snap

```bash
# Instalar snap
apt install snapd

# Buscar
snap find palabra

# Instalar
snap install nombre

# Actualizar
snap refresh

# Remover
snap remove nombre
```

### 3.3 PPA (Personal Package Archive)

```bash
# Agregar PPA
add-apt-repository ppa:nombre/ppa

# Ejemplo: PHP
add-apt-repository ppa:ondrej/php -y
apt update

# Remover PPA
add-apt-repository --remove ppa:nombre/ppa
```

## 4. Configuracion de Red

### 4.1 netplan

```bash
# Ver interfaces
ip addr
ip link

# Configurar IP estatica
nano /etc/netplan/01-netcfg.yaml
```

```yaml
network:
  version: 2
  renderer: networkd
  ethernets:
    eno1:
      addresses:
        - 192.168.1.100/24
      gateway4: 192.168.1.1
      nameservers:
        addresses:
          - 8.8.8.8
          - 8.8.4.4
```

```bash
# Aplicar configuracion
netplan apply

# DHCP
network:
  version: 2
  ethernets:
    eno1:
      dhcp4: true
```

### 4.2 DNS

```bash
# Resolv.conf
nano /etc/resolv.conf

nameserver 8.8.8.8
nameserver 8.8.4.4
```

### 4.3 Hostname

```bash
hostnamectl set-hostname mi-servidor
hostnamectl set-hostname mi-servidor --static
hostnamectl set-hostname mi-servidor --pretty
```

## 5. Servicios

### 5.1 systemd

```bash
systemctl start servicio
systemctl stop servicio
systemctl restart servicio
systemctl status servicio
systemctl enable servicio
systemctl disable servicio

# Ver logs
journalctl -u servicio
journalctl -u servicio -f
```

### 5.2 systemctl ejemplos

```bash
# Apache
systemctl enable --now apache2

# Nginx
systemctl enable --now nginx

# MySQL
systemctl enable --now mysql

# PHP-FPM
systemctl enable --now php8.2-fpm

# Docker
systemctl enable --now docker
```

## 6. Firewall - UFW

### 6.1 Comandos Basicos

```bash
# Instalar
apt install ufw

# Habilitar
ufw enable
ufw disable

# Estado
ufw status verbose

# Reglas por defecto
ufw default deny incoming
ufw default allow outgoing

# Puertos
ufw allow 22/tcp
ufw allow 80/tcp
ufw allow 443/tcp

# Denegar
ufw deny 8080

# Numeracion
ufw status numbered
ufw delete 1
```

### 6.2 Reglas por Servicio

```bash
ufw allow ssh
ufw allow http
ufw allow https
ufw allow mysql
```

## 7. LAMP en Ubuntu

### 7.1 Instalar Apache

```bash
apt update
apt install -y apache2 apache2-utils
a2enmod rewrite ssl headers proxy_fcgi
systemctl enable --now apache2
systemctl status apache2
```

### 7.2 Instalar MySQL

```bash
apt install -y mysql-server mysql-client
systemctl enable --now mysql
systemctl status mysql

mysql_secure_installation
```

### 7.3 Instalar PHP

```bash
# Agregar PPA
add-apt-repository ppa:ondrej/php -y
apt update

# Instalar PHP 8.2
apt install -y php8.2 php8.2-fpm php8.2-mysql php8.2-curl php8.2-gd php8.2-mbstring php8.2-xml php8.2-zip php8.2-intl php8.2-bcmath php8.2-opcache

# Instalar PHP 8.3
apt install -y php8.3 php8.3-fpm php8.3-mysql php8.3-curl php8.3-gd php8.3-mbstring php8.3-xml
```

### 7.4 Cambiar Version PHP

```bash
update-alternatives --list php
# /usr/bin/php8.2
# /usr/bin/php8.3

update-alternatives --set php /usr/bin/php8.3
php -v
```

### 7.5 Configurar Virtual Host

```bash
mkdir -p /var/www/midominio.com
chown -R www-data:www-data /var/www/midominio.com
chmod -R 755 /var/www
```

```bash
nano /etc/apache2/sites-available/midominio.com.conf
```

```apache
<VirtualHost *:80>
    ServerName midominio.com
    ServerAlias www.midominio.com
    DocumentRoot /var/www/midominio.com
    
    <Directory /var/www/midominio.com>
        Options -Indexes +FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>
    
    ErrorLog ${APACHE_LOG_DIR}/midominio-error.log
    CustomLog ${APACHE_LOG_DIR}/midominio-access.log combined
</VirtualHost>
```

```bash
a2ensite midominio.com.conf
a2dissite 000-default.conf
systemctl reload apache2
```

## 8. LEMP en Ubuntu

### 8.1 Instalar Nginx

```bash
apt install -y nginx
systemctl enable --now nginx
systemctl status nginx
```

### 8.2 Configurar PHP-FPM con Nginx

```bash
nano /etc/nginx/sites-available/midominio.com
```

```nginx
server {
    listen 80;
    server_name midominio.com;
    
    root /var/www/midominio.com;
    index index.php index.html;
    
    location / {
        try_files $uri $uri/ /index.php?$query_string;
    }
    
    location ~ \.php$ {
        include fastcgi_params;
        fastcgi_pass unix:/run/php/php8.2-fpm.sock;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
    }
}
```

```bash
ln -s /etc/nginx/sites-available/midominio.com /etc/nginx/sites-enabled/
nginx -t
systemctl reload nginx
```

## 9. Docker en Ubuntu

### 9.1 Instalacion

```bash
# Instalar dependencias
apt install -y ca-certificates curl gnupg

# Agregar repositorio Docker
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
chmod a+r /etc/apt/keyrings/docker.gpg

echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list

apt update
apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

systemctl enable --now docker
```

### 9.2 Comandos Docker

```bash
# Ver contenedores
docker ps -a

# Ver imagenes
docker images

# Crear contenedor
docker run -d --name mi-contenedor -p 8080:80 nginx

# Parar/Iniciar
docker stop mi-contenedor
docker start mi-contenedor

# Eliminar
docker rm mi-contenedor

# Ver logs
docker logs -f mi-contenedor
```

## 10. SSH

### 10.1 Instalacion

```bash
apt install -y openssh-server
systemctl enable --now ssh
```

### 10.2 Configuracion

```bash
nano /etc/ssh/sshd_config
```

```bash
Port 2222
PermitRootLogin no
PubkeyAuthentication yes
PasswordAuthentication no
MaxAuthTries 3
ClientAliveInterval 300
ClientAliveCountMax 2
```

```bash
systemctl restart ssh
```

### 10.3 Conexion

```bash
ssh usuario@servidor -p 2222
ssh -i clave.pem usuario@servidor
scp archivo usuario@servidor:/ruta/
```

## 11. Usuario y Permisos

### 11.1 Gestion de Usuarios

```bash
# Agregar usuario
adduser nombre

# Agregar a grupo sudo
usermod -aG sudo nombre

# Cambiar shell
usermod -s /bin/bash nombre

# Eliminar usuario
deluser --remove-home nombre
```

### 11.2 Permisos

```bash
# Propietario
chown usuario:grupo archivo
chown -R usuario:grupo /directorio

# Permisos
chmod 755 archivo
chmod +x script.sh
```

## 12. Actualizacion

### 12.1 Actualizar Sistema

```bash
apt update
apt upgrade -y
apt full-upgrade -y

#Limpiar
apt autoremove
apt autoclean
```

### 12.2 Actualizar a Nueva Version

```bash
do-release-upgrade
```

## 13. Monitoreo

### 13.1 Comandos

```bash
# CPU
lscpu
top
htop

# Memoria
free -h
vmstat 1

# Disco
df -h
du -sh /directorio

# Red
iftop
nethogs
```

### 13.2 Logs

```bash
tail -f /var/log/syslog
journalctl -u servicio -f
tail -f /var/log/apache2/access.log
```

## 14. SSL/TLS con Let's Encrypt

### 14.1 Instalar Certbot

```bash
snap install --classic certbot
ln -s /snap/bin/certbot /usr/bin/certbot
```

### 14.2 Obtener Certificado

```bash
# Apache
certbot --apache -d midominio.com -d www.midominio.com

# Nginx
certbot --nginx -d midominio.com -d www.midominio.com

# Solo certificado
certbot certonly --webroot -w /var/www/midominio -d midominio.com
```

### 14.3 Renew

```bash
# Test renew
certbot renew --dry-run

# Renew manual
certbot renew
```

## 15. Ubuntu Server - Configuracion Post-Instalacion

### 15.1 Script Completo

```bash
#!/bin/bash

# Actualizar sistema
apt update && apt upgrade -y

# Instalar utilidades
apt install -y curl wget git vim net-tools ufw

# Configurar firewall
ufw default deny incoming
ufw default allow outgoing
ufw allow 22/tcp
ufw allow 80/tcp
ufw allow 443/tcp
ufw enable

# Instalar Apache
apt install -y apache2
a2enmod rewrite ssl headers
systemctl enable --now apache2

# Instalar MySQL
apt install -y mysql-server
systemctl enable --now mysql
mysql_secure_installation

# Agregar repo PHP e instalar
add-apt-repository ppa:ondrej/php -y
apt update
apt install -y php8.2 php8.2-fpm php8.2-mysql php8.2-curl php8.2-gd php8.2-mbstring php8.2-xml php8.2-zip php8.2-intl php8.2-bcmath
systemctl enable --now php8.2-fpm

echo "Servidor Ubuntu configurado"
```

## 16. Comandos Utiles

```bash
# Buscar
find / -name archivo
locate archivo

# Procesos
ps aux | grep nombre
kill -9 PID

# Red
ip addr
ip route
ss -tulpn
```

## 17. Resumen de Puertos

| Servicio | Puerto |
|----------|--------|
| SSH | 22 |
| HTTP | 80 |
| HTTPS | 443 |
| MySQL | 3306 |
| Docker | 2375 |

## 18. Diferencias Ubuntu Server vs Desktop

- Server: Sin interfaz grafica, optimizado para servicios
- Desktop: Interfaz grafica (GNOME), aplicaciones de usuario
- Ambos usan mismo kernel y paquetes base
