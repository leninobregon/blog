# Guía Completa de AlmaLinux: Instalación, Configuración y Administración

## ¿Qué es AlmaLinux?

AlmaLinux es una distribución Linux de código abierto, mantenida por CloudLinux, diseñada como取代 (reemplazo) directo y gratuito de Red Hat Enterprise Linux. Nace como respuesta a la transición de CentOS Linux y ofrece compatibilidad binaria completa con RHEL.

## Características Principales de AlmaLinux

- **Ciclo de soporte**: 10 años (hasta 2029 para AlmaLinux 8, 2032 para AlmaLinux 9)
- **Gestor de paquetes**: DNF/YUM con RPM
- **Sistema de inicio**: systemd
- **Compatibilidad**: 100% binariamente compatible con RHEL
- **Desarrollado por**: CloudLinux (empresa con experiencia en sistemas Linux empresariales)

## Instalación de AlmaLinux

### Requisitos del Sistema

- Procesador: x86_64/AMD64 (también ARM64 disponible en AlmaLinux 9)
- Memoria RAM: Mínimo 2 GB (recomendado 4 GB)
- Espacio en disco: Mínimo 10 GB (recomendado 20 GB)
- Conexión a internet recomendada

### Pasos de Instalación

1. Descargar ISO desde almalinux.org
2. Crear USB booteable con Rufus, Etcher o dd
3. Arrancar desde USB
4. Seleccionar "Install AlmaLinux"
5. Elegir idioma
6. Configurar teclado
7. Configurar zona horaria
8. Seleccionar tipo de instalación:
   - Servidor con GUI
   - Servidor (minimal)
   - Personalizable
9. Configurar particiones:
   - /boot: 1 GB
   - /: 10-20 GB
   - swap: igual a RAM
   - /home: espacio restante
10. Configurar red y hostname
11. Establecer contraseña root
12. Crear usuario normal
13. Iniciar instalación
14. Reiniciar sistema

### Post-Instalación

```bash
# Actualizar sistema completamente
sudo dnf update

# Instalar herramientas básicas
sudo dnf install vim wget curl git net-tools bash-completion

# Habilitar repositorio EPEL
sudo dnf install epel-release

# Instalar herramientas de desarrollo
sudo dnf groupinstall "Development Tools"

# Verificar versión
cat /etc/os-release
hostnamectl
```

## Configuración de Red en AlmaLinux

### Usando nmcli

```bash
# Ver estado de interfaces
nmcli device status
ip link show

# Conectar a red WiFi
nmcli device wifi list
nmcli device wifi connect SSID password PASSWORD

# Configurar IP estática
sudo nmcli connection modify enp0s3 ipv4.addresses 192.168.1.50/24
sudo nmcli connection modify enp0s3 ipv4.gateway 192.168.1.1
sudo nmcli connection modify enp0s3 ipv4.dns "8.8.8.8 8.8.4.4"
sudo nmcli connection modify enp0s3 ipv4.method manual
sudo nmcli connection up enp0s3

# Configurar hostname
sudo hostnamectl set-hostname servidor.almalinux.local
```

### Configuración mediante archivo

```bash
# Editar archivo de configuración
sudo vim /etc/sysconfig/network-scripts/ifcfg-ens33

# Contenido:
TYPE=Ethernet
BOOTPROTO=static
NAME=ens33
DEVICE=ens33
ONBOOT=yes
IPADDR=192.168.1.50
NETMASK=255.255.255.0
GATEWAY=192.168.1.1
DNS1=8.8.8.8

# Reiniciar servicio
sudo systemctl restart NetworkManager
```

## Gestión de Paquetes con DNF

### Comandos Esenciales

```bash
# Buscar paquetes
dnf search nombre_paquete
dnf provides /usr/bin/comando

# Instalar paquetes
sudo dnf install nombre_paquete
sudo dnf install @group_name

# Actualizar paquetes específicos
sudo dnf update nombre_paquete
sudo dnf update

# Eliminar paquetes
sudo dnf remove nombre_paquete

# Ver información
dnf info nombre_paquete
dnf list installed

# Limpiar caché
sudo dnf clean all
sudo dnf makecache
```

### Gestión de Repositorios

```bash
# Listar todos los repositorios
dnf repolist all

# Ver repositorios habilitados
dnf repolist enabled

# Agregar repositorio EPEL
sudo dnf install epel-release

# Agregar repositorio REMI (para PHP newer)
sudo dnf install https://rpms.remirepo.net/enterprise/remi-release-9.rpm

# Habilitar módulo PHP
sudo dnf module enable php:remi-8.2

# Configurar mirror
sudo dnf config-manager --set-enabled baseos
sudo dnf config-manager --set-enabled appstream
```

## Firewalld en AlmaLinux

```bash
# Estado actual
sudo firewall-cmd --state

# Listar servicios activos
sudo firewall-cmd --list-services

# Agregar servicios permanentes
sudo firewall-cmd --permanent --add-service=http
sudo firewall-cmd --permanent --add-service=https
sudo firewall-cmd --permanent --add-service=ssh
sudo firewall-cmd --permanent --add-service=ftp

# Agregar puertos personalizados
sudo firewall-cmd --permanent --add-port=8080/tcp
sudo firewall-cmd --permanent --add-port=3306/tcp

# Recargar reglas
sudo firewall-cmd --reload

# Ver reglas permanentes
sudo firewall-cmd --list-all

# Eliminar servicio
sudo firewall-cmd --permanent --remove-service=http
```

## Instalación de LAMP en AlmaLinux

### Instalar Apache

```bash
# Instalar Apache HTTP Server
sudo dnf install httpd httpd-tools mod_ssl

# Habilitar e iniciar servicio
sudo systemctl enable httpd
sudo systemctl start httpd

# Verificar estado
sudo systemctl status httpd

# Puertos listening
# HTTP: 80
# HTTPS: 443

# Directorio raíz web
/var/www/html/

# Logs de Apache
/var/log/httpd/error_log
/var/log/httpd/access_log
```

### Instalar MariaDB

```bash
# Instalar MariaDB Server
sudo dnf install mariadb-server mariadb

# Iniciar y habilitar
sudo systemctl enable mariadb
sudo systemctl start mariadb

# Ejecutar configuración segura
sudo mysql_secure_installation

# Conectar a MariaDB
mysql -u root -p

# Comandos básicos de base de datos
CREATE DATABASE mi_proyecto_db;
CREATE USER 'usuario'@'localhost' IDENTIFIED BY 'PasswordFuerte123!';
GRANT ALL PRIVILEGES ON mi_proyecto_db.* TO 'usuario'@'localhost';
FLUSH PRIVILEGES;
SHOW DATABASES;
EXIT;
```

### Instalar PHP

```bash
# Instalar PHP con extensiones comunes
sudo dnf install php php-mysqlnd php-pdo php-gd php-mbstring php-xml php-json php-cli

# Instalar PHP específico desde módulo
sudo dnf module list php
sudo dnf module enable php:remi-8.2
sudo dnf install php php-mysqlnd php-pdo php-gd php-mbstring php-cli

# Ver versión de PHP
php -v

# Reiniciar Apache
sudo systemctl restart httpd

# Probar PHP
echo "<?php phpinfo(); ?>" | sudo tee /var/www/html/phpinfo.php
```

## Virtual Hosts en Apache

```bash
# Crear directorio del sitio
sudo mkdir -p /var/www/dominio.com/public_html
sudo chown -R apache:apache /var/www/dominio.com
sudo chmod -R 755 /var/www

# Crear archivo de configuración
sudo vim /etc/httpd/conf.d/dominio.com.conf

# Contenido:
<VirtualHost *:80>
    ServerName dominio.com
    ServerAlias www.dominio.com
    DocumentRoot /var/www/dominio.com/public_html
    
    <Directory /var/www/dominio.com/public_html>
        Options -Indexes +FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>
    
    ErrorLog /var/log/httpd/dominio.com-error.log
    CustomLog /var/log/httpd/dominio.com-access.log combined
</VirtualHost>

# Verificar sintaxis
sudo httpd -t

# Recargar configuración
sudo systemctl reload httpd
```

## SSH Seguro en AlmaLinux

```bash
# Instalar OpenSSH Server
sudo dnf install openssh-server openssh-clients

# Habilitar servicio
sudo systemctl enable sshd
sudo systemctl start sshd

# Configurar SSH
sudo vim /etc/ssh/sshd_config

# Cambios recomendados:
Port 2222
PermitRootLogin no
PubkeyAuthentication yes
PasswordAuthentication no
MaxAuthTries 3
ClientAliveInterval 300
ClientAliveCountMax 2
AllowUsers usuario1 usuario2

# Generar clave SSH en cliente
ssh-keygen -t ed25519 -C "mi@email.com"

# Copiar clave pública al servidor
ssh-copy-id -p 2222 usuario@192.168.1.50

# Reiniciar servicio
sudo systemctl restart sshd
```

## SELinux en AlmaLinux

```bash
# Ver estado actual
getenforce

# Cambiar modo temporalmente
sudo setenforce 0    # Modo permisivo
sudo setenforce 1    # Modo enforce

# Editar configuración persistente
sudo vim /etc/selinux/config

# Opciones:
# SELINUX=enforcing
# SELINUX=permissive
# SELINUX=disabled

# Contextos típicos para Apache
sudo chcon -R -t httpd_sys_content_t /var/www/misitio
sudo chcon -R -t httpd_sys_rw_content_t /var/www/misitio/datos

# Persistir cambios de contexto
sudo semanage fcontext -a -t httpd_sys_content_t "/var/www/misitio(/.*)?"
sudo restorecon -Rv /var/www/misitio

# Permitir puertos personalizados
sudo semanage port -a -t http_port_t -p tcp 8080
```

## Gestión de LVM

```bash
# Ver estado de volúmenes
sudo pvs
sudo vgs
sudo lvs
sudo lvdisplay

# Extender volumen lógico
sudo lvextend -L +15G /dev/almalinux/root
sudo xfs_growfs /dev/almalinux/root   # para XFS
sudo resize2fs /dev/almalinux/root    # para ext4

# Crear nuevo volumen lógico
sudo lvcreate -L 10G -n datos /dev/almalinux
sudo mkfs.xfs /dev/almalinux/datos
sudo mount /dev/almalinux/datos /datos

# Agregar al /etc/fstab
echo "/dev/almalinux/datos /datos xfs defaults 0 0" | sudo tee -a /etc/fstab
```

## Actualización del Sistema

```bash
# Actualización completa
sudo dnf update

# Actualización de seguridad
sudo dnf update --security

# Limpiar paquetes innecesarios
sudo dnf autoremove
sudo dnf clean all
```

## Containers con Podman

```bash
# Verificar Podman (ya incluido)
podman --version

# Buscar imágenes
podman search almalinux

# Descargar imagen
podman pull almalinux/almalinux:9

# Ejecutar contenedor
podman run -it almalinux/almalinux:9 /bin/bash

# Ejecutar en background
podman run -d --name mi-web -p 8080:80 almalinux/almalinux:9

# Listar contenedores
podman ps -a

# Detener y eliminar
podman stop mi-web
podman rm mi-web
```

## Monitoreo del Sistema

```bash
# Ver procesos y uso de recursos
top
htop

# Ver uso de disco
df -h
du -sh /var/*

# Ver memoria
free -h

# Ver información de CPU
lscpu
cat /proc/cpuinfo

# Ver logs del sistema
sudo journalctl -xe
sudo journalctl -u httpd
sudo tail -f /var/log/messages
```

## Sincronización de Tiempo con Chrony

```bash
# Instalar chrony
sudo dnf install chrony

# Habilitar y iniciar
sudo systemctl enable chronyd
sudo systemctl start chronyd

# Ver estado
timedatectl status

# Configurar zona horaria
sudo timedatectl set-timezone America/Mexico_City

# Forzar sincronización
sudo chronyc -a makestep
```

## Respaldo y Restauración

```bash
# Respaldar base de datos
mysqldump -u root -p mi_base_datos > backup.sql

# Respaldar directorio web
tar -czvf web_backup.tar.gz /var/www/html/

# Respaldar configuración
tar -czvf config_backup.tar.gz /etc/httpd/ /etc/nginx/ /etc/my.cnf.d/

# Restaurar
tar -xzvf web_backup.tar.gz -C /
mysql -u root -p mi_base_datos < backup.sql
```

## Conclusión

AlmaLinux es una distribución Linux robusta y confiable, ideal para entornos de producción que requieren estabilidad a largo plazo. Su completa compatibilidad con RHEL y su naturaleza de código abierto la convierten en una excelente opción para替换 CentOS y para implementar servidores web, bases de datos y aplicaciones empresariales.
