# Guía Completa de Linux: El Sistema Operativo de Código Abierto

## 1. Introducción a Linux

### ¿Qué es Linux?

Linux es un sistema operativo de código abierto basado en Unix, desarrollado originalmente por Linus Torvalds en 1991. Es el kernel (núcleo) del sistema, que junto con aplicaciones y bibliotecas forma una distribución Linux completa.

### Historia de Linux

- **1991**: Linus Torvalds announce un proyecto personal de un sistema operativo gratuito
- **1991**: Se lanza la primera versión del kernel Linux (0.01)
- **1992**: Linux se distribuye bajo Licencia GPL
- **1993**: Nace Debian, primera distribución importante
- **1994**: Versión 1.0 del kernel Linux
- **2004**: Ubuntu hace su aparición
- **2007**: Android usa el kernel Linux
- **2024**: Linux alimenta supercomputadoras, servidores, móviles y dispositivos IoT

### Importancia de Linux

Linux es el sistema operativo más utilizado en el mundo:
- **96.3%** de los servidores web más importantes usan Linux
- **100%** de las supercomputadoras TOP 500 usan Linux
- **68%** de los smartphones usan Android (kernel Linux)
- Millones de dispositivos IoT, routers, smart TVs

## 2. Arquitectura de Linux

### Componentes del Sistema

```
┌─────────────────────────────────────────┐
│         Aplicaciones de Usuario         │
├─────────────────────────────────────────┤
│     Shell (Bash, Zsh, Fish)             │
├─────────────────────────────────────────┤
│ Bibliotecas (glibc, libc, libssl)      │
├─────────────────────────────────────────┤
│            Kernel de Linux              │
├─────────────────────────────────────────┤
│         Hardware (CPU, RAM, disco)      │
└─────────────────────────────────────────┘
```

### El Kernel Linux

El kernel es el corazón del sistema operativo:

1. **Gestión de Procesos**: Planifica qué proceso se ejecuta y cuándo
2. **Gestión de Memoria**: Asigna y libera memoria RAM
3. **Sistema de Archivos**: Lee, escribe y organiza datos en disco
4. **Control de Dispositivos**: Comunicación con hardware
5. **Seguridad**: Permisos, SELinux, AppArmor
6. **Networking**: TCP/IP, sockets, firewall

### Sistema de Archivos Linux

Estructura de directorios estándar:

| Directorio | Descripción |
|------------|-------------|
| `/` | Raíz del sistema |
| `/bin` | Ejecutables esenciales |
| `/boot` | Archivos de arranque |
| `/dev` | Dispositivos |
| `/etc` | Configuración del sistema |
| `/home` | Directorios de usuarios |
| `/lib` | Bibliotecas del sistema |
| `/media` | Medios extraíbles |
| `/mnt` | Puntos de montaje temporales |
| `/opt` | Software opcional |
| `/proc` | Información de procesos |
| `/root` | Directorio del administrador |
| `/run` | Datos runtime |
| `/sbin` | Ejecutables del sistema |
| `/srv` | Datos de servicios |
| `/sys` | Información del sistema |
| `/tmp` | Archivos temporales |
| `/usr` | Recursos de usuario |
| `/var` | Datos variables |

## 3. Características Principales

### Código Abierto

- Código fuente disponible públicamente
- Libertad para usar, estudiar, modificar y distribuir
- Comunidad activa de desarrolladores
- Transparente y auditable

### Multitarea

- Múltiples procesos ejecutándose simultáneamente
- Scheduling preemptivo
- Prioridades configurables
- Eficiente uso de CPU

### Multiusuario

- Múltiples usuarios conectados simultáneamente
- Permisos granulares por archivo
- Aislamiento seguro entre usuarios
- sudo para privilegios temporales

### Portabilidad

- Funciona en múltiples arquitecturas
- x86, ARM, MIPS, PowerPC, RISC-V
- Desde embedded devices hasta supercomputadoras

### Estabilidad

- Sistemas que funcionan años sin reiniciar
- Manejo elegante de errores
- Modularidad

### Seguridad

- Permisos UNIX (rwx)
- SELinux para control obligatorio
- AppArmor
- Actualizaciones frecuentes
- Menor malware

## 4. Comandos Básicos

### Navegación de Directorios

```bash
# Mostrar directorio actual
pwd

# Listar archivos
ls                      # Básico
ls -l                   # Formato largo
ls -la                  # Incluir ocultos
ls -lh                  # Tamaños legibles
ls -la | grep patron   # Filtrar resultados

# Cambiar directorio
cd /directorio         # Ir a directorio absoluto
cd ..                   # Ir al padre
cd ~                    # Ir a home
cd -                    # Volver al anterior

# Crear y eliminar directorios
mkdir nuevo_dir                 # Crear
mkdir -p ruta/profunda/nueva    # Crear ruta completa
rmdir空的 directorio            # Eliminar directorio vacío
rm -rf directorio              # Eliminar con contenido
```

### Manipulación de Archivos

```bash
# Ver contenido
cat archivo              # Mostrar todo
head -n 10 archivo      # Primeras 10 líneas
tail -n 10 archivo      # Últimas 10 líneas
tail -f archivo         # Ver en tiempo real
less archivo            # Navegar página a página
wc -l archivo           # Contar líneas

# Copiar
cp origen destino
cp -r directorio/ destino/
cp -p permisos origen destino
cp -a origen destino   # Preservar todo

# Mover/Renombrar
mv origen destino
mv nombreviejo nombrenuevo

# Eliminar
rm archivo
rm -f archivo           # Forzar
rm -r directorio       # Recursivo
rm -rf directorio      # Forzar recursivo

# Buscar archivos
find /ruta -name "*.txt"
find /ruta -type f -mtime -7
locate archivo          # Requiere updatedb
which comando          # Ruta de ejecutable
whereis comando        # Binarios, fuentes, manuales
```

### Permisos de Archivos

```bash
# Ver permisos
ls -l archivo
# -rw-r--r-- 1 usuario grupo 1234 abr 13 10:30 archivo

# Permisos en formato numérico
# 4 = lectura (r)
# 2 = escritura (w)
# 1 = ejecución (x)

# Cambiar permisos
chmod 755 archivo          # rwxr-xr-x
chmod +x archivo           # Agregar ejecución
chmod -w archivo           # Quitar escritura
chmod u+x archivo          # Usuario + ejecución
chmod g+w archivo          # Grupo + escritura
chmod o+r archivo          # Otros + lectura

# Cambiar propietario
chown usuario archivo
chown usuario:grupo archivo
chown -R usuario directorio/
chgrp grupo archivo
```

### Comandos de Texto

```bash
# Editores
nano archivo          # Editor básico
vim archivo           # Editor avanzado
vi archivo            # Editor clásico
gedit archivo         # Editor gráfico

# Procesamiento de texto
grep "patron" archivo         # Buscar patrón
grep -r "patron" directorio # Buscar recursivamente
grep -i "patron" archivo     # Ignorar mayúsculas
grep -n "patron" archivo     # Mostrar número de línea

sed 's/viejo/nuevo/g' archivo     # Reemplazar
awk '{print $1}' archivo          # Procesar columnas
sort archivo                      # Ordenar
uniq archivo                       # Eliminar duplicados
cut -d',' -f1 archivo             # Cortar campos
```

### Compresión y Descompresión

```bash
# tar
tar -cvf archivo.tar directorio/     # Crear
tar -xvf archivo.tar                # Extraer
tar -cvzf archivo.tar.gz directorio # Crear gzip
tar -xvzf archivo.tar.gz            # Extraer gzip

# zip
zip -r archivo.zip directorio/
unzip archivo.zip

# gzip
gzip archivo
gunzip archivo.gz
```

## 5. Gestión de Procesos

### Ver Procesos

```bash
# Listar procesos
ps              # Procesos del usuario actual
ps -ef          # Todos los procesos
ps aux          # Formato BSD
top             # Monitor en tiempo real
htop            # Monitor interactivo (instalar)

# Ver procesos específicos
ps -ef | grep nginx
pkill nombre_proceso
pgrep -a nombre
```

### Gestión de Procesos

```bash
# Matar procesos
kill pid                 # Terminar con señal
kill -9 pid             # Forzar terminación
killall nombre          # Matar por nombre
pkill -f "patron"       # Matar por patrón

# Prioridades
nice -n 10 comando      # Ejecutar con prioridad menor
renice 5 -p pid         # Cambiar prioridad
```

## 6. Gestión de Paquetes

### Debian/Ubuntu (APT)

```bash
# Actualizar
apt update                              # Actualizar repositorios
apt upgrade                             # Actualizar paquetes
apt full-upgrade                        # Actualizar con dependencias
apt dist-upgrade                        # Actualizar distribución

# Instalar
apt install nombre_paquete              # Instalar
apt install nombre1 nombre2             # Múltiples
apt install --no-install-recommends pkg # Sin recomendados

# Buscar
apt search palabra                      # Buscar paquetes
apt show nombre_paquete                 # Ver información

# Eliminar
apt remove nombre_paquete               # Eliminar
apt purge nombre_paquete                # Eliminar + config
apt autoremove                          # Limpiar dependencias
apt clean                               # Limpiar cache

# Ver
apt list --installed                    # Paquetes instalados
dpkg -l                                 # Lista detallada
```

### RHEL/Fedora (DNF/YUM)

```bash
# Actualizar
dnf update                          # Actualizar
dnf upgrade                         # Actualizar todo
dnf update --refresh                # Forzar refresh

# Instalar
dnf install nombre_paquete
dnf install @group                  # Grupo de paquetes

# Buscar
dnf search palabra
dnf provides /usr/bin/comando
dnf info nombre_paquete

# Eliminar
dnf remove nombre_paquete
dnf autoremove                       # Limpiar

# Ver
dnf list installed
dnf list available
dnf repolist                          # Repositorios
```

### Arch Linux (Pacman)

```bash
# Sincronizar
pacman -Sy                            # Actualizar base de datos
pacman -Syu                          # Actualizar sistema

# Instalar
pacman -S nombre_paquete
pacman -Syu nombre_paquete           # Actualizar + instalar

# Buscar
pacman -Ss palabra                   # Buscar en repos
pacman -Qs palabra                   # Buscar instalado

# Eliminar
pacman -R nombre_paquete
pacman -Rns nombre_paquete            # + dependencias + config

# Limpiar
pacman -Scc                           # Limpiar cache
```

## 7. Gestión de Servicios (systemd)

### Comandos Básicos

```bash
# Servicios
systemctl start servicio         # Iniciar
systemctl stop servicio         # Detener
systemctl restart servicio      # Reiniciar
systemctl reload servicio       # Recargar configuración
systemctl status servicio       # Ver estado
systemctl enable servicio       # Habilitar al inicio
systemctl disable servicio      # Deshabilitar
systemctl is-enabled servicio   # Ver si está habilitado
systemctl is-active servicio    # Ver si está activo

# Listar servicios
systemctl list-units --type=service
systemctl list-unit-files
systemctl list-dependencies multi-user.target
```

### Crear Servicio Personalizado

```bash
# Crear archivo de servicio
sudo vim /etc/systemd/system/mi-servicio.service

# Contenido:
[Unit]
Description=Mi Servicio Personalizado
After=network.target

[Service]
Type=simple
User=www-data
WorkingDirectory=/opt/mi-servicio
ExecStart=/opt/mi-servicio/start.sh
Restart=always
RestartSec=10

[Install]
WantedBy=multi-user.target

# Recargar y habilitar
sudo systemctl daemon-reload
sudo systemctl enable mi-servicio
sudo systemctl start mi-servicio
```

## 8. Gestión de Red

### Ver Configuración de Red

```bash
# Interfaces
ip addr show                    # Ver direcciones IP
ip link show                    # Ver interfaces
ip route show                   # Ver rutas
ip neighbor show                # Ver tabla ARP

# DNS
cat /etc/resolv.conf            # Servidores DNS
nslookup dominio                # Consulta DNS
dig dominio                     # Consulta DNS detallada
host dominio                    # Consulta simple

# Conectividad
ping google.com                 # Probar conectividad
traceroute google.com           # Trazar ruta
mtr google.com                  # Ping + traceroute
netstat -tulpn                  # Puertos abiertos
ss -tulpn                       # Más detallado

# Configurar
nmcli device status             # NetworkManager
nmtui                           # UI interactiva
```

### Configurar IP Estática

```bash
# Usando nmcli (NetworkManager)
nmcli con add type ethernet con-name "eth0-static" ifname eth0 ipv4.addresses 192.168.1.100/24 ipv4.gateway 192.168.1.1 ipv4.dns "8.8.8.8 8.8.4.4" ipv4.method manual
nmcli con up "eth0-static"

# Archivo de configuración
vim /etc/sysconfig/network-scripts/ifcfg-eth0
```

## 9. Gestión de Usuarios

```bash
# Crear usuario
useradd -m -s /bin/bash usuario
useradd -m -s /bin/bash -G grupo1,grupo2 usuario

# Contraseña
passwd usuario

# Modificar usuario
usermod -aG grupo usuario      # Agregar a grupo
usermod -L usuario             # Bloquear
usermod -U usuario             # Desbloquear

# Eliminar usuario
userdel usuario
userdel -r usuario             # + directorio home

# Grupos
groupadd grupo
groupdel grupo
groups usuario                 # Ver grupos de usuario

# Información
id usuario                     # UID, GID, grupos
who                            # Usuarios conectados
w                              # Usuarios + actividad
last                           # Historial de login
```

## 10. Firewall

### firewalld (RHEL/Fedora)

```bash
# Estado
firewall-cmd --state
firewall-cmd --list-all

# Servicios
firewall-cmd --list-services
firewall-cmd --add-service=http
firewall-cmd --add-service=https
firewall-cmd --remove-service=http

# Puertos
firewall-cmd --list-ports
firewall-cmd --add-port=8080/tcp
firewall-cmd --add-port=5000-5100/udp
firewall-cmd --remove-port=8080/tcp

# Zonas
firewall-cmd --list-zones
firewall-cmd --set-default-zone=public
firewall-cmd --permanent --add-source=192.168.1.0/24

# Recargar
firewall-cmd --reload
```

### iptables (通用)

```bash
# Ver reglas
iptables -L -n -v
iptables -t nat -L -n -v

# Agregar reglas
iptables -A INPUT -p tcp --dport 22 -j ACCEPT
iptables -A INPUT -p icmp --icmp-type echo-request -j ACCEPT
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A INPUT -j DROP

# Guardar reglas
iptables-save > /etc/iptables/rules.v4
```

### ufw (Ubuntu)

```bash
# Estado
ufw status
ufw status verbose

# Habilitar/Deshabilitar
ufw enable
ufw disable

# Reglas
ufw allow 22/tcp
ufw deny 80/tcp
ufw delete allow 22/tcp
ufw allow from 192.168.1.0/24
```

## 11. Gestión de Disco y Particiones

### Ver Uso de Disco

```bash
df -h                     # Espacio usado/disponible
du -sh directorio/        # Tamaño de directorio
du -sh */                 # Tamaño de subdirectorios
lsblk                     # Listar dispositivos de bloque
fdisk -l                  # Particiones
parted -l                 # Particiones (detallado)
```

### Crear y Montar Partición

```bash
# Crear partición
fdisk /dev/sdb
# n (nueva), p (primaria), w (escribir)

# Formatear
mkfs.ext4 /dev/sdb1
mkfs.xfs /dev/sdb1
mkfs.ntfs /dev/sdb1

# Montar
mount /dev/sdb1 /mnt/datos
mount -o rw,noexec /dev/sdb1 /mnt/datos

# Montaje automático
vim /etc/fstab
# /dev/sdb1 /mnt/datos ext4 defaults 0 0
```

### LVM (Logical Volume Manager)

```bash
# Ver
pvs                     # Volumes físicos
vgs                     # Volume groups
lvs                     # Logical volumes

# Crear
pvcreate /dev/sdb1
vgcreate vg_datos /dev/sdb1
lvcreate -L 10G -n lv_datos vg_datos

# Formatear y montar
mkfs.ext4 /dev/vg_datos/lv_datos
mount /dev/vg_datos/lv_datos /mnt/datos

# Extender
lvextend -L +10G /dev/vg_datos/lv_datos
resize2fs /dev/vg_datos/lv_datos

# Reducir (solo ext4)
umount /mnt/datos
e2fsck -f /dev/vg_datos/lv_datos
lvreduce -L 5G /dev/vg_datos/lv_datos
resize2fs /dev/vg_datos/lv_datos
mount /dev/vg_datos/lv_datos /mnt/datos
```

## 12. Monitor del Sistema

### Recursos del Sistema

```bash
# CPU y memoria
top                  # Monitor en tiempo real
htop                 # Monitor interactivo
uptime               # Tiempo de actividad
mpstat -P ALL 1      # Estadísticas de CPU

# Memoria
free -h              # Memoria RAM y swap
vmstat 1             # Estadísticas virtuales

# Discos
iostat -x 1          # I/O de disco
iotop                # Procesos de I/O

# Redes
iftop                # Ancho de banda
nethogs              # Tráfico por proceso
```

### Logs del Sistema

```bash
# Logs generales
journalctl                           # Todos los logs
journalctl -u servicio               # Logs de servicio
journalctl -f                        # Follow en tiempo real
journalctl --since "1 hour ago"      # Rango de tiempo
journalctl -p err                    # Solo errores

# Logs legacy
/var/log/syslog        # Syslog general
/var/log/messages      # Mensajes del sistema
/var/log/auth.log     # Autenticación
/var/log/kern.log     # Kernel
/var/log/dmesg        # Mensajes de arranque

# Aplicaciones
/var/log/nginx/        # Nginx
/var/log/apache2/     # Apache
/var/log/mysql/       # MySQL/MariaDB
```

## 13. Scripting en Bash

### Variables y Operaciones

```bash
#!/bin/bash

# Variables
NOMBRE="Juan"
EDAD=30
echo "Hola $NOMBRE, tienes $EDAD años"

# Operaciones aritméticas
RESULTADO=$((5 + 3))
RESULTADO=$(expr 5 + 3)

# Argumentos
$0 = nombre del script
$1 = primer argumento
$2 = segundo argumento
$# = número de argumentos
$* = todos los argumentos
```

### Condicionales

```bash
# if
if [ $EDAD -ge 18 ]; then
    echo "Eres mayor de edad"
elif [ $EDAD -ge 13 ]; then
    echo "Eres adolescente"
else
    echo "Eres niño"
fi

# case
case $OPCION in
    1) echo "Opción 1" ;;
    2) echo "Opción 2" ;;
    *) echo "Opción inválida" ;;
esac
```

### Bucles

```bash
# for
for i in {1..5}; do
    echo "Iteración $i"
done

for archivo in *.txt; do
    echo "Procesando $archivo"
done

# while
contador=0
while [ $contador -lt 5 ]; do
    echo $contador
    contador=$((contador+1))
done
```

### Funciones

```bash
#!/bin/bash

saludar() {
    echo "Hola $1"
    return 0
}

saludar "Mundo"
```

## 14. SSH y Acceso Remoto

### Conexión SSH

```bash
# Conexión básica
ssh usuario@servidor
ssh -p 2222 usuario@servidor

# Clave SSH
ssh-keygen -t ed25519 -C "mi@email.com"
ssh-copy-id usuario@servidor

# Configuración
vim ~/.ssh/config
```

### Configuración SSH

```bash
# /etc/ssh/sshd_config
Port 22
PermitRootLogin no
PubkeyAuthentication yes
PasswordAuthentication no
MaxAuthTries 3
ClientAliveInterval 300
AllowUsers usuario1 usuario2
```

### Transferencia de Archivos

```bash
# SCP
scp archivo usuario@servidor:/ruta/
scp -r directorio usuario@servidor:/ruta/
scp usuario@servidor:/ruta/remoto local/

# SFTP
sftp usuario@servidor
put archivo
get archivo
```

## 15. Copias de Seguridad

```bash
# Backup básico
tar -czvf backup-$(date +%Y%m%d).tar.gz /directorio/

# rsync
rsync -avz /origen/ usuario@servidor:/destino/
rsync -avz --delete /origen/ usuario@servidor:/destino/

# MySQL
mysqldump -u root -p base_datos > backup.sql
mysql -u root -p base_datos < backup.sql

# Automatizar con cron
crontab -e
# 0 2 * * * /script/backup.sh
```

## 16. Virtualización y Containers

### Docker

```bash
# Imágenes
docker search ubuntu
docker pull ubuntu:latest
docker images

# Contenedores
docker run -it ubuntu /bin/bash
docker run -d --name mi-servicio -p 8080:80 imagen
docker ps
docker ps -a

# Gestión
docker start contenedor
docker stop contenedor
docker rm contenedor
docker exec -it contenedor bash
```

### Podman (RHEL)

```bash
# Similar a Docker pero sin daemon
podman pull rockylinux:9
podman run -d -p 8080:80 rockylinux:9
podman ps
```

## 17. Actualización del Sistema

```bash
# Debian/Ubuntu
apt update && apt upgrade -y
apt update && apt full-upgrade -y
do-release-upgrade           # Actualizar versión

# RHEL/Fedora
dnf update -y
dnf upgrade -y
dnf system-upgrade download --releasever=39
dnf system-upgrade reboot

# Arch Linux
pacman -Syu

# Limpiar después de actualizar
apt autoremove && apt clean
dnf autoremove && dnf clean all
pacman -Scc
```

## 18. Información del Sistema

```bash
# Sistema
uname -a                  # Información del kernel
uname -r                  # Versión del kernel
cat /etc/os-release       # Información de OS
hostnamectl               # Hostname y detalles
lsb_release -a            # Información de distribución

# Hardware
lscpu                     # CPU
lsmem                     # Memoria
lsblk                     # Dispositivos de bloque
lspci                     # Dispositivos PCI
lsusb                     # Dispositivos USB
dmidecode                 # Información DMI

# Tiempo de actividad
uptime
who -b                    # Último reinicio

# Usuarios
whoami
w
last
```

## Conclusión

Linux es un sistema operativo versátil, poderoso y ampliamente utilizado en el mundo moderno. Desde servidores web hasta dispositivos móviles, pasando por supercomputadoras y sistemas embebidos, Linux está presente en casi todas partes.

Esta guía cubre los fundamentos para comenzar a trabajar con Linux, desde comandos básicos hasta configuraciones avanzadas. La práctica constante es la mejor manera de dominar estas herramientas.

**¡Explora, experimenta y aprende Linux!**
