# Guía Completa de Fedora: Instalación, Configuración y Administración

## ¿Qué es Fedora?

Fedora es una distribución Linux patrocinada por Red Hat, conocida por ser una plataforma de innovación tecnológica. Utiliza el gestor de paquetes RPM con DNF y ofrece las últimas versiones de software de código abierto. Es la base upstream de Red Hat Enterprise Linux.

## Características Principales de Fedora

- **Ciclo de lanzamiento**: 6 meses con versiones estables
- **Gestor de paquetes**: DNF (Dynamic Package Manager)
- **Sistema de inicio**: systemd
- **Entorno de escritorio**: GNOME por defecto (otras opciones disponibles)
- ** Filosofía**: Software libre y código abierto primero

## Instalación de Fedora

### Requisitos del Sistema

- Procesador: x86_64 (AMD64) o ARM64
- Memoria RAM: Mínimo 2 GB (recomendado 4 GB)
- Espacio en disco: Mínimo 15 GB (recomendado 20 GB)
- Conexión a internet recomendada para actualizaciones

### Pasos de Instalación

1. Descargar imagen ISO desde fedora.org
2. Crear USB booteable con Fedora Media Writer o dd
3. Arrancar desde USB
4. Seleccionar "Install to Hard Drive"
5. Elegir idioma y ubicación
6. Configurar partitioning:
   - /boot: 1 GB
   - /: 20-30 GB (root)
   - /home: resto del espacio
   - swap: tamaño igual a RAM (hasta 8 GB máximo)
7. Configurar red e hostname
8. Crear usuario root y usuario regular
9. Iniciar instalación
10. Reiniciar y retirar USB

### Post-Instalación

```bash
# Actualizar sistema
sudo dnf update

# Instalar repositorios esenciales
sudo dnf install epel-release

# Instalar herramientas de desarrollo
sudo dnf groupinstall "Development Tools"

# Instalar utilidades comunes
sudo dnf install vim wget curl git net-tools
```

## Configuración de Red en Fedora

### Configuración de IP Estática

```bash
# Ver interfaces de red
nmcli device status

# Configurar IP estática
sudo nmcli connection modify eth0 ipv4.addresses 192.168.1.100/24
sudo nmcli connection modify eth0 ipv4.gateway 192.168.1.1
sudo nmcli connection modify eth0 ipv4.dns "8.8.8.8 8.8.4.4"
sudo nmcli connection modify eth0 ipv4.method manual
sudo nmcli connection up eth0
```

### Configuración mediante archivo

```bash
# Editar archivo de configuración
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
DNS2=8.8.4.4

# Reiniciar red
sudo systemctl restart NetworkManager
```

## Gestión de Paquetes con DNF

### Comandos Básicos

```bash
# Actualizar sistema
sudo dnf update
sudo dnf upgrade

# Buscar paquetes
dnf search nombre_paquete
dnf provides comando

# Instalar paquetes
sudo dnf install nombre_paquete
sudo dnf install grupo_nombre_grupo

# Eliminar paquetes
sudo dnf remove nombre_paquete

# Listar paquetes instalados
dnf list installed
dnf list updates

# Ver información de paquete
dnf info nombre_paquete

# Limpiar caché
sudo dnf clean all
```

### Repositorios

```bash
# Listar repositorios
dnf repolist

# Habilitar/deshabilitar repositorio
sudo dnf config-manager --enable repo_name
sudo dnf config-manager --disable repo_name

# Agregar repositorio RPM
sudo dnf install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
```

## Configuración de Firewalld

```bash
# Ver estado
sudo firewall-cmd --state

# Listar zonas y servicios
sudo firewall-cmd --list-all-zones
sudo firewall-cmd --list-services

# Agregar servicio
sudo firewall-cmd --permanent --add-service=http
sudo firewall-cmd --permanent --add-service=https
sudo firewall-cmd --permanent --add-service=ssh

# Agregar puerto
sudo firewall-cmd --permanent --add-port=8080/tcp

# Recargar reglas
sudo firewall-cmd --reload
```

## Instalación de LAMP en Fedora

### Apache

```bash
# Instalar Apache
sudo dnf install httpd httpd-tools

# Iniciar y habilitar servicio
sudo systemctl enable httpd
sudo systemctl start httpd

# Verificar estado
sudo systemctl status httpd

# Configuración principal
sudo vim /etc/httpd/conf/httpd.conf

# Directorio web
/var/www/html/

# Logs
/var/log/httpd/
```

### MySQL/MariaDB

```bash
# Instalar MariaDB
sudo dnf install mariadb-server mariadb

# Iniciar y habilitar
sudo systemctl enable mariadb
sudo systemctl start mariadb

# Configuración de seguridad
sudo mysql_secure_installation

# Crear base de datos
mysql -u root -p

CREATE DATABASE ejemplo_db;
CREATE USER 'usuario'@'localhost' IDENTIFIED BY 'contraseña';
GRANT ALL PRIVILEGES ON ejemplo_db.* TO 'usuario'@'localhost';
FLUSH PRIVILEGES;
EXIT;
```

### PHP

```bash
# Instalar PHP y extensiones
sudo dnf install php php-mysqlnd php-pdo php-gd php-mbstring

# Instalar PHP específico (ejemplo PHP 8.2)
sudo dnf module enable php:remi-8.2
sudo dnf install php php-mysqlnd php-pdo php-gd php-mbstring php-cli

# Reiniciar Apache
sudo systemctl restart httpd

# Probar PHP
echo "<?php phpinfo(); ?>" | sudo tee /var/www/html/info.php
```

## Configuración de Apache con Virtual Hosts

```bash
# Crear directorio para sitio
sudo mkdir -p /var/www/misitio.com/public_html
sudo chown -R apache:apache /var/www/misitio.com

# Crear archivo de configuración
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

# Recargar Apache
sudo systemctl reload httpd
```

## SSH en Fedora

```bash
# Instalar y configurar SSH
sudo dnf install openssh-server

# Habilitar servicio
sudo systemctl enable sshd
sudo systemctl start sshd

# Configurar SSH
sudo vim /etc/ssh/sshd_config

# Cambios recomendados:
Port 22
PermitRootLogin no
PasswordAuthentication yes
MaxAuthTries 3
ClientAliveInterval 300
ClientAliveCountMax 2

# Reiniciar servicio
sudo systemctl restart sshd
```

## SELinux en Fedora

```bash
# Ver estado
getenforce

# Cambiar modo temporalmente
setenforce 0  # Permisivo
setenforce 1  # Enforcando

# Cambiar modo persistente
sudo vim /etc/selinux/config

# SELINUX=enforcing
# SELINUX=permissive
# SELINUX=disabled

# Cambiar contexto SELinux para directorio
sudo chcon -R -t httpd_sys_content_t /var/www/misitio

# Making SELinux changes persistent
sudo semanage fcontext -a -t httpd_sys_content_t "/var/www/misitio(/.*)?"
sudo restorecon -Rv /var/www/misitio

# Permitir servicio en puerto no estándar
sudo semanage port -a -t http_port_t -p tcp 8080
```

## Actualización de Fedora

```bash
# Actualización simple
sudo dnf upgrade

# Actualización con limpiado
sudo dnf upgrade --refresh
sudo dnf autoremove

# Actualizar a nueva versión
sudo dnf system-upgrade download --releasever=40
sudo dnf system-upgrade reboot
```

## Configuración de LVM

```bash
# Ver volúmenes lógicos
sudo lvs
sudo lvdisplay

# Extender volumen lógico
sudo lvextend -L +10G /dev/fedora/root
sudo resize2fs /dev/fedora/root

# Reducir volumen lógico
sudo umount /home
sudo e2fsck -f /dev/fedora/home
sudo lvreduce -L -5G /dev/fedora/home
sudo resize2fs /dev/fedora/home
sudo mount /home
```

## Optimización de Rendimiento

### Tuning

```bash
# Instalar tuner
sudo dnf install tuned

# Habilitar y comenzar
sudo systemctl enable tuned
sudo systemctl start tuned

# Ver perfiles disponibles
tuned-adm list

# Aplicar perfil
tuned-adm profile throughput-performance

# Ver perfil activo
tuned-adm active
```

## Containers con Podman

```bash
# Instalar Podman
sudo dnf install podman docker

# Buscar imágenes
podman search fedora

# Descargar imagen
podman pull fedora:latest

# Ejecutar contenedor
podman run -it fedora:latest /bin/bash

# Listar contenedores
podman ps -a

# Ver imágenes
podman images
```

## Conclusión

Fedora es una distribución robusta y moderna, ideal para desarrolladores y usuarios que buscan las últimas tecnologías. Su ciclo de lanzamiento frecuente garantiza acceso a nuevas características, pero requiere actualizaciones regulares para mantener la seguridad del sistema.
