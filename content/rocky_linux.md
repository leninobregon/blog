# Guía Completa de Rocky Linux: Instalación, Configuración y Administración

## ¿Qué es Rocky Linux?

Rocky Linux es una distribución Linux de código abierto desarrollada por la comunidad, diseñada como alternativa gratuita y binariamente compatible con Red Hat Enterprise Linux (RHEL). Fue creada como respuesta al cambio de dirección de CentOS y es mantenido por Rocky Enterprise Software Foundation.

## Características Principales de Rocky Linux

- **Ciclo de soporte**: 10 años (como RHEL)
- **Gestor de paquetes**: RPM con DNF/YUM
- **Sistema de inicio**: systemd
- **Filosofía**: Compatible 100% con RHEL, código abierto
- **Repositorios**: Exactamente los mismos que RHEL

## Instalación de Rocky Linux

### Requisitos del Sistema

- Procesador: x86_64/AMD64 o ARM64
- Memoria RAM: Mínimo 2 GB (recomendado 4 GB)
- Espacio en disco: Mínimo 10 GB (recomendado 20 GB)
- Conexión a internet necesaria para actualizaciones

### Pasos de Instalación

1. Descargar imagen ISO desde rockylinux.org
2. Crear USB booteable con herramienta como Rufus o dd
3. Arrancar desde USB
4. Seleccionar "Install Rocky Linux"
5. Elegir idioma (español disponible)
6. Configurar fecha y hora
7. Elegir software:
   - Servidor con GUI
   - Servidor (minimal)
   - Personalizable
8. Configurar particiones:
   - /boot: 1 GB
   - /: 10-20 GB
   - /home: resto
   - swap: tamaño de RAM
9. Configurar red (DHCP o IP estática)
10. Establecer contraseña root
11. Crear usuario administrador
12. Iniciar instalación
13. Reiniciar y entrar al sistema

### Post-Instalación

```bash
# Actualizar sistema
sudo dnf update

# Instalar herramientas esenciales
sudo dnf install vim wget curl git net-tools bash-completion

# Habilitar repositorios adicionales
sudo dnf install epel-release

# Instalar Development Tools
sudo dnf groupinstall "Development Tools"
```

## Configuración de Red en Rocky Linux

### Configuración con nmcli

```bash
# Ver interfaces
nmcli device status
ip addr show

# Configurar IP estática
sudo nmcli con mod eth0 ipv4.addresses 192.168.1.100/24
sudo nmcli con mod eth0 ipv4.gateway 192.168.1.1
sudo nmcli con mod eth0 ipv4.dns "8.8.8.8 8.8.4.4"
sudo nmcli con mod eth0 ipv4.method manual
sudo nmcli con up eth0

# Configurar hostname
sudo hostnamectl set-hostname servidor.ejemplo.com
```

### Configuración mediante archivo

```bash
# Crear archivo de configuración
sudo vim /etc/sysconfig/network-scripts/ifcfg-eth0

# Contenido:
TYPE=Ethernet
BOOTPROTO=static
NAME=eth0
DEVICE=eth0
ONBOOT=yes
IPADDR=192.168.1.100
NETMASK=255.255.255.0
GATEWAY=192.168.1.1
DNS1=8.8.8.8

# Reiniciar red
sudo systemctl restart NetworkManager
```

## Gestión de Paquetes con DNF/YUM

### Comandos Básicos

```bash
# Actualizar sistema
sudo dnf update
sudo dnf upgrade

# Buscar paquetes
dnf search palabra_clave
dnf provides nombre_comando

# Instalar paquetes
sudo dnf install nombre_paquete
sudo dnf install @group_name

# Eliminar paquetes
sudo dnf remove nombre_paquete

# Ver paquetes instalados
dnf list installed
dnf list available

# Información de paquete
dnf info nombre_paquete

# Limpiar caché
sudo dnf clean all
```

### Gestión de Repositorios

```bash
# Listar repositorios
dnf repolist all

# Habilitar/deshabilitar repositorio
sudo dnf config-manager --set-enabled repo_name
sudo dnf config-manager --set-disabled repo_name

# Agregar repositorio
sudo dnf install https://dl.fedoraproject.org/pub/epel/epel-release-latest-9.noarch.rpm
```

## Configuración de Firewalld

```bash
# Estado del firewall
sudo firewall-cmd --state

# Listar reglas
sudo firewall-cmd --list-all
sudo firewall-cmd --list-services

# Agregar servicios
sudo firewall-cmd --permanent --add-service=http
sudo firewall-cmd --permanent --add-service=https
sudo firewall-cmd --permanent --add-service=ssh
sudo firewall-cmd --permanent --add-service=ftp

# Agregar puertos
sudo firewall-cmd --permanent --add-port=8080/tcp
sudo firewall-cmd --permanent --add-port=3306/tcp

# Recargar
sudo firewall-cmd --reload

# Eliminar reglas
sudo firewall-cmd --permanent --remove-service=http
```

## Instalación de LAMP en Rocky Linux

### Apache

```bash
# Instalar Apache
sudo dnf install httpd httpd-tools mod_ssl

# Iniciar y habilitar
sudo systemctl enable httpd
sudo systemctl start httpd

# Verificar
sudo systemctl status httpd

# Puertos
# HTTP: 80
# HTTPS: 443

# Directorio web
/var/www/html/

# Logs
/var/log/httpd/
```

### MariaDB

```bash
# Instalar MariaDB
sudo dnf install mariadb-server mariadb

# Iniciar y habilitar
sudo systemctl enable mariadb
sudo systemctl start mariadb

# Configuración segura
sudo mysql_secure_installation

# Conectar
mysql -u root -p

# Crear base de datos y usuario
CREATE DATABASE aplicaciones_db;
CREATE USER 'appuser'@'localhost' IDENTIFIED BY 'Password123!';
GRANT ALL PRIVILEGES ON aplicaciones_db.* TO 'appuser'@'localhost';
FLUSH PRIVILEGES;
EXIT;
```

### PHP

```bash
# Instalar PHP y extensiones comunes
sudo dnf install php php-mysqlnd php-pdo php-gd php-mbstring php-xml php-json php-cli

# Instalar PHP desde repositorio alternativo
sudo dnf module enable php:remi-8.2
sudo dnf install php php-mysqlnd php-pdo php-gd php-mbstring

# Reiniciar Apache
sudo systemctl restart httpd

# Probar PHP
echo "<?php phpinfo(); ?>" | sudo tee /var/www/html/info.php
```

## Virtual Hosts en Apache

```bash
# Crear directorio
sudo mkdir -p /var/www/misitio.com/public_html
sudo chown -R apache:apache /var/www/misitio.com
sudo chmod -R 755 /var/www

# Crear configuración
sudo vim /etc/httpd/conf.d/misitio.com.conf

# Contenido:
<VirtualHost *:80>
    ServerName misitio.com
    ServerAlias www.misitio.com
    DocumentRoot /var/www/misitio.com/public_html
    
    <Directory /var/www/misitio.com/public_html>
        Options -Indexes +FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>
    
    ErrorLog /var/log/httpd/misitio.com-error.log
    CustomLog /var/log/httpd/misitio.com-access.log combined
</VirtualHost>

# Verificar configuración
sudo httpd -t

# Recargar
sudo systemctl reload httpd
```

## SSH en Rocky Linux

```bash
# Instalar si no está
sudo dnf install openssh-server

# Habilitar servicio
sudo systemctl enable sshd
sudo systemctl start sshd

# Configurar
sudo vim /etc/ssh/sshd_config

# Configuraciones recomendadas:
Port 22
PermitRootLogin no
PubkeyAuthentication yes
PasswordAuthentication yes
MaxAuthTries 3
ClientAliveInterval 300

# Reiniciar
sudo systemctl restart sshd

# Conexión desde cliente
ssh usuario@servidor.ejemplo.com
```

## SELinux en Rocky Linux

```bash
# Ver estado
getenforce

# Modo permisivo (temporal)
sudo setenforce 0

# Modo enforcing
sudo setenforce 1

# Configuración persistente
sudo vim /etc/selinux/config

# SELINUX=enforcing
# SELINUX=permissive
# SELINUX=disabled

# Permitir HTTP en directorio
sudo chcon -R -t httpd_sys_content_t /var/www/misitio
sudo semanage fcontext -a -t httpd_sys_content_t "/var/www/misitio(/.*)?"
sudo restorecon -Rv /var/www/misitio

# Permitir puerto personalizado
sudo semanage port -a -t http_port_t -p tcp 8080
```

## LVM en Rocky Linux

```bash
# Ver volúmenes
sudo pvs
sudo vgs
sudo lvs
sudo lvdisplay

# Extender volumen lógico
sudo lvextend -L +10G /dev/rl/root
sudo xfs_growfs /dev/rl/root  # para XFS
sudo resize2fs /dev/rl/root   # para ext4

# Reducir volumen (solo ext4)
sudo umount /home
sudo e2fsck -f /dev/rl/home
sudo lvreduce -L -5G /dev/rl/home
sudo resize2fs /dev/rl/home
sudo mount /home
```

## Actualización de Rocky Linux

```bash
# Actualización de paquetes
sudo dnf update

# Actualización de sistema (minor release)
sudo dnf upgrade

# Limpiar paquetes antiguos
sudo dnf autoremove
sudo dnf clean all
```

## Configuración de Repo Mirror

```bash
# Instalar fastestmirror si no existe
sudo dnf install dnf-plugin-fastestmirror

# Ver mirrors disponibles
sudo dnf repolist

# Forzar uso de mirror específico
sudo dnf config-manager --save baseurl=http://mirror.example.com/rocky/9/BaseOS/x86_64/os/
```

## Containers con Podman

```bash
# Podman ya viene instalado en Rocky Linux minimal

# Buscar imágenes
podman search rockylinux

# Descargar imagen
podman pull rockylinux/rockylinux:latest

# Ejecutar contenedor interactivo
podman run -it rockylinux/rockylinux:latest /bin/bash

# Ejecutar como daemon
podman run -d --name mi-servidor -p 8080:80 rockylinux/rockylinux:latest

# Listar contenedores
podman ps
podman ps -a

# Detener y eliminar
podman stop mi-servidor
podman rm mi-servidor
```

## Configuración dechrony (NTP)

```bash
# Instalar chrony si no está
sudo dnf install chrony

# Habilitar servicio
sudo systemctl enable chronyd
sudo systemctl start chronyd

# Ver estado
timedatectl status

# Configurar zona horaria
sudo timedatectl set-timezone America/Mexico_City

# Sincronización forzada
sudo chronyc -a makestep
```

## Monitoreo del Sistema

```bash
# Ver recursos
top
htop

# Uso de disco
df -h
du -sh /*

# Uso de memoria
free -h

# Procesos
ps aux
ps -eo pid,comm,%mem,%cpu --sort=-%cpu | head -10

# Ver logs
sudo journalctl -xe
sudo tail -f /var/log/messages
```

## Conclusión

Rocky Linux es una excelente opción para entornos de producción que requieren estabilidad y soporte a largo plazo. Su compatibilidad binaria con RHEL garantiza que el software empresarial funcione correctamente, siendo ideal para servidores web, bases de datos y aplicaciones críticas.
