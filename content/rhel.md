# RHEL Linux - Guia Completa

## 1. Introduccion a RHEL

Red Hat Enterprise Linux (RHEL) es una distribucion Linux empresarial desarrollada por Red Hat. Es conocida por su estabilidad, seguridad y soporte comercial.

### 1.1 Caracteristicas

- Soporte comercial de Red Hat
- Ciclo de vida largo (10 anos)
- Alta estabilidad y seguridad
- Certificaciones empresariales
- DNF como gestor de paquetes

### 1.2 Versiones

| Version | Fecha | Soporte |
|---------|-------|----------|
| RHEL 9 | 2022 | 2032 |
| RHEL 8 | 2019 | 2029 |
| RHEL 7 | 2014 | 2024 |

## 2. Instalacion

### 2.1 Requisitos Minimos

- Procesador: 2 nucleos
- RAM: 8 GB (16 GB recomendado)
- Disco: 40 GB
- Conexion a internet

### 2.2 Metodos de Instalacion

#### Instalacion Grafica
Descargar ISO desde access.redhat.com y ejecutar instalador grafico.

#### Kickstart

```bash
# Archivo kickstart
nano ks.cfg
```

```text
lang es_ES.UTF-8
keyboard es
timezone America/Managua --isUtc
rootpw --iscrypted $6$rounds=656000$hash
user --name=admin --password=$6$hash --iscrypted
url --url="http://mirror.example.com/RHEL-9/Server/x86_64/os"
autopart --type=lvm
zerombr
clearpart --all --initlabel
bootloader --location=mbr
reboot

%packages
@^minimal-environment
openssh-server
%end
```

```bash
# Instalar con kickstart
kernel vmlinuz initrd=initrd.img inst.ks=http://servidor/ks.cfg
```

## 3. Gestion de Paquetes

### 3.1 DNF

```bash
# Actualizar
dnf update
dnf upgrade

# Instalar
dnf install nombre_paquete
dnf install -y nombre_paquete

# Remover
dnf remove nombre_paquete
dnf erase nombre_paquete

# Buscar
dnf search palabra
dnf provides nombre

# Info
dnf info nombre_paquete

# Lista de paquetes
dnf list installed
dnf list available
```

### 3.2 RPM

```bash
# Instalar
rpm -ivh paquete.rpm

# Actualizar
rpm -Uvh paquete.rpm

# Desinstalar
rpm -e nombre_paquete

# Verificar
rpm -qa | grep nombre
rpm -ql nombre
```

### 3.3 Repositorios

```bash
# Listar repos
dnf repolist
dnf repolist all

# Agregar repositorio
dnf config-manager --add-repo http://ejemplo.com/repo.repo

# Habilitar/deshabilitar
dnf config-manager --set-enabled nombre-repo
dnf config-manager --set-disabled nombre-repo
```

## 4. Gestion de Modulos (AppStream)

### 4.1 Modulos PHP

```bash
# Listar modulo
dnf module list php

# Resetear
dnf module reset php

# Habilitar version
dnf module enable php:8.1

# Instalar
dnf install php php-fpm
```

### 4.2 Modulos Node.js

```bash
dnf module list nodejs
dnf module enable nodejs:18
dnf install @nodejs
```

### 4.3 Modulos MariaDB

```bash
dnf module list mariadb
dnf module enable mariadb:10.11
dnf install @mariadb
```

## 5. Red

### 5.1 Configuracion Estatica

```bash
# Ver interfaces
ip addr
nmcli device status

# Configurar IP
nmcli con mod eth0 ipv4.addresses 192.168.1.100/24
nmcli con mod eth0 ipv4.gateway 192.168.1.1
nmcli con mod eth0 ipv4.dns "8.8.8.8 8.8.4.4"
nmcli con mod eth0 ipv4.method manual
nmcli con up eth0
```

### 5.2 Archivos de Configuracion

```bash
# RHEL 8/9 - NetworkScripts
nano /etc/sysconfig/network-scripts/ifcfg-eth0

DEVICE=eth0
BOOTPROTO=static
ONBOOT=yes
IPADDR=192.168.1.100
NETMASK=255.255.255.0
GATEWAY=192.168.1.1
DNS1=8.8.8.8

systemctl restart network
```

### 5.3 Hostname

```bash
hostnamectl set-hostname servidor.dominio.com
hostnamectl status
```

## 6. Firewall - firewalld

### 6.1 Comandos Basicos

```bash
# Estado
systemctl status firewalld
firewall-cmd --state

# Listar zonas
firewall-cmd --list-all-zones

# Zona por defecto
firewall-cmd --get-default-zone
firewall-cmd --set-default-zone=public
```

### 6.2 Reglas

```bash
# Puertos
firewall-cmd --permanent --add-port=80/tcp
firewall-cmd --permanent --add-port=443/tcp
firewall-cmd --permanent --add-port=3306/tcp
firewall-cmd --permanent --add-port=22/tcp

# Servicios
firewall-cmd --permanent --add-service=http
firewall-cmd --permanent --add-service=https
firewall-cmd --permanent --add-service=ssh
firewall-cmd --permanent --add-service=mysql

# Eliminar
firewall-cmd --permanent --remove-port=8080/tcp

# Recargar
firewall-cmd --reload

# Ver reglas activas
firewall-cmd --list-all
firewall-cmd --list-ports
firewall-cmd --list-services
```

### 6.3 Reglas por Zona

```bash
# Agregar a zona
firewall-cmd --permanent --zone=trusted --add-source=192.168.1.0/24
firewall-cmd --permanent --zone=trusted --add-service=http

# Cambiar zona de interface
firewall-cmd --zone=public --change-interface=eth0
```

## 7. SELinux

### 7.1 Estados

```bash
# Ver estado
getenforce
sestatus

# Cambiar modo
setenforce 0  # Permisivo
setenforce 1  # Enforcing

# Configuracion permanente
nano /etc/selinux/config

SELINUX=enforcing
SELINUX=permissive
SELINUX=disabled
```

### 7.2 Booleans

```bash
# Listar
getsebool -a

# Ver especifico
getsebool httpd_can_network_connect

# Activar
setsebool -P httpd_can_network_connect 1
setsebool -P ftp_home_dir 1
```

### 7.3 Contextos

```bash
# Ver contexto
ls -Z archivo
ls -Z /directorio

# Cambiar contexto
chcon -t httpd_sys_content_t archivo
chcon -R -t httpd_sys_content_t /directorio

# Restaurar contexto
restorecon -Rv /directorio
```

## 8. LAMP en RHEL

### 8.1 Instalar Apache

```bash
dnf install -y httpd httpd-tools mod_ssl
systemctl enable --now httpd
systemctl status httpd
```

### 8.2 Instalar MariaDB

```bash
dnf install -y mariadb-server mariadb
systemctl enable --now mariadb
systemctl status mariadb

mysql_secure_installation
```

### 8.3 Instalar PHP

```bash
# Instalar repositorio Remi
dnf install -y https://rpms.remirepo.net/enterprise/remi-release-latest-$(rpm -E %rhel).rpm

# Habilitar PHP 8.2
dnf module reset php
dnf module enable php:remi-8.2

# Instalar PHP
dnf install -y php php-fpm php-mysql php-curl php-gd php-mbstring php-xml php-zip php-intl php-bcmath php-opcache

systemctl enable --now php-fpm
systemctl status php-fpm
```

### 8.4 Configurar Virtual Host

```bash
mkdir -p /var/www/midominio.com
chown -R apache:apache /var/www/midominio.com
```

```bash
nano /etc/httpd/conf.d/midominio.com.conf
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
    
    ErrorLog logs/midominio-error_log
    CustomLog logs/midominio-access_log combined
</VirtualHost>
```

```bash
httpd -t
systemctl reload httpd
```

## 9. LEMP en RHEL

### 9.1 Instalar Nginx

```bash
dnf install -y nginx
systemctl enable --now nginx
systemctl status nginx
```

### 9.2 Configurar PHP-FPM

```bash
nano /etc/php-fpm.d/www.conf

[www]
user = nginx
group = nginx
listen = /run/php-fpm/www.sock
listen.owner = nginx
listen.group = nginx

systemctl restart php-fpm
```

### 9.3 Virtual Host Nginx

```bash
nano /etc/nginx/conf.d/midominio.com.conf
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
        fastcgi_pass unix:/run/php-fpm/www.sock;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
    }
}
```

```bash
nginx -t
systemctl reload nginx
```

## 10. SSH

### 10.1 Instalacion

```bash
dnf install -y openssh-server openssh-clients
systemctl enable --now sshd
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
systemctl restart sshd
```

## 11. Gestion de Servicios

### 11.1 systemd

```bash
systemctl start servicio
systemctl stop servicio
systemctl restart servicio
systemctl reload servicio
systemctl status servicio

systemctl enable servicio
systemctl disable servicio

systemctl list-units --type=service
systemctl list-unit-files --type=service
```

### 11.2 Chroot

```bash
# Crear jail
mkdir -p /var/chroot/servicio
dnf --installroot=/var/chroot/servicio install openssh

# Configurar servicio
systemctl edit servicio
```

## 12. Usuario y Permisos

### 12.1 Gestion de Usuarios

```bash
# Crear usuario
useradd -m -s /bin/bash nombre
useradd -m -s /bin/bash -G wheel nombre

# Con contrasena
useradd -m -p $(openssl passwd -1 Contrasena123) nombre

# Modificar
usermod -aG grupo nombre
usermod -s /bin/false nombre

# Eliminar
userdel -r nombre
```

### 12.2 sudo

```bash
# Agregar a wheel
usermod -aG wheel nombre

# Configurar sudo
nano /etc/sudoers

# Agregar linea
nombre ALL=(ALL) ALL
```

## 13. Actualizacion

### 13.1 Actualizar Sistema

```bash
dnf update
dnf upgrade
```

### 13.2 Actualizar Version

```bash
# RHEL 8 a 9
dnf install -y leapp-upgrade
leapp upgrade

# RHEL minor version
dnf update
```

## 14. Monitoreo

### 14.1 Comandos

```bash
# Procesos
ps aux
top
htop

# Memoria
free -h
vmstat 1

# Disco
df -h
du -sh /directorio
iostat -x 1

# Red
ss -tulpn
iftop
nethogs
```

### 14.2 Logs

```bash
# Logs del sistema
journalctl
journalctl -u servicio
journalctl -f

# Logs de Apache
tail -f /var/log/httpd/error_log
tail -f /var/log/httpd/access_log

# Logs de Nginx
tail -f /var/log/nginx/error.log
tail -f /var/log/nginx/access.log
```

## 15. Backup

### 15.1 rsync

```bash
rsync -avz /origen/ usuario@servidor:/destino/
rsync -avz --delete /origen/ /destino/
```

### 15.2 tar

```bash
tar -cvzf backup.tar.gz /directorio
tar -xvzf backup.tar.gz
```

### 15.3 MySQL

```bash
mysqldump -u root -p base_datos > backup.sql
mysqldump -u root -p --all-databases > all.sql
```

## 16. Docker en RHEL

### 16.1 Instalacion

```bash
# Agregar repositorio
dnf config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

# Instalar
dnf install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

systemctl enable --now docker
```

### 16.2 Configuracion

```bash
# Agregar usuario a grupo docker
usermod -aG docker nombre

# Iniciar servicio
systemctl start docker
systemctl enable docker
```

## 17. Cron

### 17.1 Comandos

```bash
# Ver crontab
crontab -l

# Editar crontab
crontab -e

# Archivo del sistema
nano /etc/cron.d/nombre
```

### 17.2 Formato

```bash
# Formato
# minuto hora dia mes dia_semana comando

# Ejemplos
0 2 * * * /script/backup.sh
*/15 * * * * /script/monitoreo.sh
0 3 * * 0 /script/weekly.sh
```

## 18. Resumen de Puertos

| Servicio | Puerto |
|----------|--------|
| SSH | 22 |
| HTTP | 80 |
| HTTPS | 443 |
| MySQL | 3306 |
| Docker | 2375 |

## 19. Subscriptions

### 19.1 Registrar Sistema

```bash
# Registrar
subscription-manager register --username=usuario --password=contrasena

# Listar pools
subscription-manager list --available

# Adjuntar suscripcion
subscription-manager attach --pool=pool_id

# Ver status
subscription-manager status
subscription-manager list --consumed
```

### 19.2 Repositorios

```bash
# Habilitar repos
subscription-manager repos --enable=rhel-9-for-x86_64-baseos-rpms
subscription-manager repos --enable=rhel-9-for-x86_64-appstream-rpms

# Ver repos
subscription-manager repos --list
```

## 20. Comandos Utiles

```bash
# Buscar archivos
find / -name archivo
locate archivo

# Procesos
ps aux | grep nombre
pkill -f nombre

# Red
ip addr
ip route
ss -tulpn | grep :80
```
