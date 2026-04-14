# Debian Linux - Guia Completa

## 1. Introduccion a Debian

Debian es una distribucion de Linux desarrollada por la comunidad. Es conocida por su estabilidad y por ser la base de muchas otras distribuciones incluyendo Ubuntu.

### 1.1 Caracteristicas

- 100% software libre
- Extremadamente estable
- Mas de 59000 paquetes
- Soporte para multiples arquitecturas
- Tres ramas: Stable, Testing, Unstable

### 1.2 Versiones Actuales

| Version | Codigo | Fecha | Estado |
|---------|--------|-------|--------|
| Debian 12 | Bookworm | 2023 | Stable |
| Debian 13 | Trixie | 2024 | Testing |
| Debian 14 | Forky | 2025 | Unstable |

## 2. Instalacion

### 2.1 Requisitos Minimos

- Procesador: 1 GHz
- RAM: 512 MB (1 GB recomendado)
- Disco: 10 GB (20 GB recomendado)
- GPU: Compatible con X11

### 2.2 Instalacion Grafica

```bash
# Descargar imagen
wget https://cdimage.debian.org/debian-cd/12.5.0/amd64/iso-dvd/debian-12.5.0-amd64-DVD-1.iso

# Crear USB booteable
dd if=debian-12.5.0-amd64-DVD-1.iso of=/dev/sdX bs=4M status=progress
```

### 2.3 Instalacion Automatizada ( preseed )

```bash
# Archivo de configuracion
nano preseed.cfg
```

```d-i
d-i debian-installer/locale string es_ES.UTF-8
d-i debian-installer/language string spanish
d-i debian-installer/country string ES
d-i passwd/root-password password MiContrasena123
d-i passwd/root-password again password MiContrasena123
d-i passwd/user-fullname string Usuario Debian
d-i passwd/username string usuario
d-i passwd/user-password password Usuario123
d-i partman-auto/method string regular
d-i partman-auto/choose_recipe select atomic
d-i finish-install/reboot_in_progress note
```

```bash
# Instalar con preseed
boot: auto=true priority=critical url=debian/preseed.cfg
```

## 3. Gestion de Paquetes

### 3.1 APT Basico

```bash
# Actualizar repositorios
apt update

# Actualizar sistema
apt upgrade
apt full-upgrade

# Instalar paquete
apt install nombre_paquete

# Remover paquete
apt remove nombre_paquete
apt purge nombre_paquete

# Buscar paquetes
apt search palabra_clave
apt-cache search palabra_clave

# Informacion de paquete
apt show nombre_paquete
apt-cache show nombre_paquete
```

### 3.2 dpkg

```bash
# Instalar .deb
dpkg -i paquete.deb

# Remover
dpkg -r paquete

# Listar instalados
dpkg -l

# Ver contenido
dpkg -L paquete

# Corregir dependencias rotas
dpkg --configure -a
apt install -f
```

### 3.3 Repositorios

```bash
# Archivo sources.list
nano /etc/apt/sources.list

# Ejemplo para Debian 12
deb http://deb.debian.org/debian bookworm main contrib non-free-firmware
deb http://deb.debian.org/debian-security bookworm-security main contrib non-free-firmware
deb http://deb.debian.org/debian bookworm-updates main contrib non-free-firmware
deb http://deb.debian.org/debian bookworm-backports main contrib non-free-firmware
```

```bash
# Agregar repositorio pinning
nano /etc/apt/preferences

Package: *
Pin: release a=stable
Pin-Priority: 700
```

## 4. Configuracion del Sistema

### 4.1 Red

```bash
# Ver interfaces
ip addr
ip link

# Configurar IP estatica
nano /etc/network/interfaces

auto eth0
iface eth0 inet static
    address 192.168.1.100
    netmask 255.255.255.0
    gateway 192.168.1.1
    dns-nameservers 8.8.8.8 8.8.4.4

# Restart red
systemctl restart networking
```

### 4.2 DNS

```bash
nano /etc/resolv.conf

nameserver 8.8.8.8
nameserver 8.8.4.4
```

### 4.3 Hostname

```bash
# Ver hostname
hostname

# Cambiar
hostnamectl set-hostname mi-servidor

# Archivo hosts
nano /etc/hosts

127.0.0.1 localhost
192.168.1.100 mi-servidor.dominio.com mi-servidor
```

### 4.4 Zona Horaria

```bash
timedatectl list-timezones
timedatectl set-timezone America/Managua
date
```

## 5. Servicios

### 5.1 systemd

```bash
# Iniciar servicio
systemctl start servicio

# Detener servicio
systemctl stop servicio

# Reiniciar servicio
systemctl restart servicio

# Ver estado
systemctl status servicio

# Habilitar al inicio
systemctl enable servicio

# Deshabilitar
systemctl disable servicio

# Ver servicios activos
systemctl list-units --type=service
```

### 5.2 Servicios Comunes

```bash
# Apache
systemctl enable --now apache2

# MySQL
systemctl enable --now mariadb

# PHP-FPM
systemctl enable --now php8.2-fpm

# SSH
systemctl enable --now ssh

# Firewall
systemctl enable --now ufw
```

## 6. Firewall - UFW

### 6.1 Instalacion

```bash
apt install ufw
```

### 6.2 Comandos Basicos

```bash
# Habilitar
ufw enable

# Deshabilitar
ufw disable

# Ver estado
ufw status verbose

# Reglas por defecto
ufw default deny incoming
ufw default allow outgoing

# Permirir puertos
ufw allow 22/tcp
ufw allow 80/tcp
ufw allow 443/tcp

# Denegar
ufw deny 8080/tcp

# Ver reglas numeradas
ufw status numbered

# Eliminar regla
ufw delete 1
```

### 6.3 Reglas por IP

```bash
ufw allow from 192.168.1.0/24
ufw deny from 10.0.0.0/8
```

## 7. Usuario y Permisos

### 7.1 Gestion de Usuarios

```bash
# Crear usuario
adduser nombre_usuario

# Cambiar contrasena
passwd nombre_usuario

# Modificar usuario
usermod -aG sudo nombre_usuario
usermod -s /bin/bash nombre_usuario

# Eliminar usuario
userdel -r nombre_usuario

# Ver usuarios
cat /etc/passwd

# Ver grupos
groups nombre_usuario
```

### 7.2 Permisos

```bash
# Ver permisos
ls -l archivo

# chmod
chmod 755 script.sh
chmod +x script.sh
chmod 644 archivo.conf

# chown
chown usuario:grupo archivo
chown -R usuario:grupo /directorio
```

## 8. Actualizacion del Sistema

### 8.1 Actualizacion Normal

```bash
apt update
apt upgrade
apt dist-upgrade
```

### 8.2 Actualizacion de Version

```bash
# Hacer backup antes
cp /etc/apt/sources.list /etc/apt/sources.list.backup

# Cambiar repositorios
sed -i 's/bookworm/trixie/g' /etc/apt/sources.list

# Actualizar
apt update
apt full-upgrade
```

## 9. LAMP en Debian

### 9.1 Instalar Apache

```bash
apt update
apt install apache2 apache2-utils
a2enmod rewrite ssl headers
systemctl enable --now apache2
```

### 9.2 Instalar MariaDB

```bash
apt install mariadb-server mariadb-client
systemctl enable --now mariadb
mysql_secure_installation
```

### 9.3 Instalar PHP

```bash
# Agregar repo SURY
apt install -y apt-transport-https lsb-release ca-certificates curl wget
curl -sSL https://packages.sury.org/php/apt.gpg | gpg --dearmor -o /usr/share/keyrings/php-sury.gpg
echo "deb [signed-by=/usr/share/keyrings/php-sury.gpg] https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/php-sury.list
apt update

# Instalar PHP
apt install php8.2 php8.2-fpm php8.2-mysql php8.2-curl php8.2-gd php8.2-mbstring php8.2-xml php8.2-zip php8.2-intl php8.2-bcmath php8.2-opcache
```

### 9.4 Configurar Virtual Host

```bash
nano /etc/apache2/sites-available/midominio.conf
```

```apache
<VirtualHost *:80>
    ServerName midominio.com
    DocumentRoot /var/www/midominio
    
    <Directory /var/www/midominio>
        Options -Indexes +FollowSymLinks
        AllowOverride All
    </Directory>
</VirtualHost>
```

```bash
a2ensite midominio
systemctl reload apache2
```

## 10. SSH

### 10.1 Instalacion

```bash
apt install openssh-server
systemctl enable --now ssh
```

### 10.2 Configuracion

```bash
nano /etc/ssh/sshd_config

# Cambiar puerto
Port 2222

# Prohibir root
PermitRootLogin no

# Autenticacion por clave
PubkeyAuthentication yes
PasswordAuthentication no

# Restart
systemctl restart ssh
```

### 10.3 Conexion

```bash
ssh usuario@servidor -p 2222
ssh -i clave.pem usuario@servidor
```

## 11. Monitoreo

### 11.1 Comandos

```bash
# Procesos
ps aux
top
htop

# Memoria
free -h

# Disco
df -h
du -sh /directorio

# CPU
lscpu
cat /proc/cpuinfo
```

### 11.2 Logs

```bash
# Logs del sistema
tail -f /var/log/syslog
journalctl -xe

# Logs de Apache
tail -f /var/log/apache2/access.log
tail -f /var/log/apache2/error.log

# Logs de MySQL
tail -f /var/log/mysql/error.log
```

## 12. Backup

### 12.1 rsync

```bash
rsync -avz /origen/ usuario@servidor:/destino/
rsync -avz --delete /origen/ /destino/
```

### 12.2 tar

```bash
tar -cvzf backup.tar.gz /directorio
tar -xvzf backup.tar.gz
```

### 12.3 MySQL

```bash
mysqldump -u root -p base_datos > backup.sql
mysqldump -u root -p --all-databases > all_databases.sql
```

## 13. Comandos Utiles

```bash
# Buscar archivos
find / -name archivo
locate archivo
which comando

# Uso de disco
ncdu

# Procesos por puerto
ss -tulpn | grep :80

# Kill proceso
kill -9 PID
pkill -f nombre
```

## 14. Resumen de Puertos

| Servicio | Puerto |
|----------|--------|
| SSH | 22 |
| HTTP | 80 |
| HTTPS | 443 |
| MySQL | 3306 |

## 15. Script de Instalacion LAMP

```bash
#!/bin/bash
apt update && apt upgrade -y

apt install -y apache2 mariadb-server php8.2

systemctl enable --now apache2 mariadb

echo "LAMP instalado"
