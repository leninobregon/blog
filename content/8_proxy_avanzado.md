# Proxy Server Avanzado con Reglas

## 1. Introduccion

El proxy avanzado permite control granular del trafico mediante listas de control, reglas de horario, limitacion de ancho de banda y autenticacion.

### 1.1 Componentes Avanzados

- ACLs: Listas de control de acceso
- Delay Pools: Limitar ancho de banda
- SquidGuard: Filtrado de contenido
- Autenticacion multiple: LDAP, AD, RADIUS

## 2. Squid ACLs Avanzadas

### 2.1 Tipos de ACL

```conf
acl red_local src 192.168.1.0/24
acl ips_bloqueadas src 192.168.1.100 192.168.1.101

acl dominios_porno dstdomain .pornhub.com .xvideos.com
acl sitios_permitidos dstdomain .google.com .youtube.com

acl url_bloqueadas url_regex -i ^http://.*\.exe$
acl descargas_grandes urlpath_regex \.(exe|zip|rar|iso|mp3|mp4)$

acl hora_pico time 09:00-18:00
acl horario_oficina time MWFH 08:00-17:00

acl puertos_seguros port 80 443
```

### 2.2 Reglas de Control

```conf
http_access deny dominios_porno
http_access allow horario_oficina sitios_permitidos
http_access deny hora_pico !sitios_permitidos
http_access deny descargas_grandes
http_access allow red_local
http_access deny all
```

### 2.3 ACLs Expresiones Regulares

```conf
acl palabras_bloqueadas url_regex -i facebook|myspace|twitter
acl extensiones_peligrosas urlpath_regex \.(scr|bat|cmd|exe|vbs|js|jar)$
acl streaming urlpath_regex \.(flv|mp4|avi|mkv)$

http_access deny palabras_bloqueadas
http_access deny extensiones_peligrosas
http_access deny streaming
```

## 3. Control de Ancho de Banda

### 3.1 Delay Pools

```conf
acl empleados src 192.168.1.10-192.168.1.50
acl invitados src 192.168.1.200-192.168.1.250

delay_pools 3

delay_class 1 1
delay_parameters 1 -1/-1
delay_access 1 allow red_local
delay_access 1 deny all

delay_class 2 1
delay_parameters 2 32000/32000
delay_access 2 allow empleados
delay_access 2 deny all

delay_class 3 1
delay_parameters 3 8000/8000
delay_access 3 allow invitados
delay_access 3 deny all
```

### 3.2 Limit por Tipo de Archivo

```conf
acl descargas urlpath_regex \.(zip|rar|iso|exe)$

delay_pools 1
delay_class 1 2
delay_parameters 1 16000/32000 64000/64000
delay_access 1 allow descargas
delay_access 1 deny all
```

## 4. Autenticacion con LDAP

### 4.1 Instalacion Helper

```bash
apt install -y squid-ldap-auth
```

### 4.2 Configuracion LDAP

```conf
auth_param basic program /usr/lib/squid/basic_ldap_auth \
    -R \
    -b "dc=midominio,dc=com" \
    -f "(&(uid=%s)(memberOf=cn=internet,ou=groups,dc=midominio,dc=com))" \
    -D "cn=admin,dc=midominio,dc=com" \
    -w "ContrasenaAdmin123"

auth_param basic children 10
auth_param basic realm "Proxy Corporativo"
auth_param basic credentialsttl 2 hours

acl usuarios_ldap proxy_auth REQUIRED
http_access allow usuarios_ldap
http_access deny all
```

### 4.3 Autenticacion NCSA

```conf
auth_param basic program /usr/lib/squid/basic_ncsa_auth /etc/squid/passwd
auth_param basic children 5
```

## 5. Filtrado de Contenido

### 5.1 Instalacion SquidGuard

```bash
apt install -y squidguard
```

### 5.2 Descargar Blacklists

```bash
cd /var/lib/squidguard/db
wget http://www.shallalist.de/download/bigblacklist.tar.gz
tar -xzf bigblacklist.tar.gz
```

### 5.3 Configuracion

```bash
nano /etc/squidguard/squidGuard.conf
```

```conf
dbhome /var/lib/squidguard/db/blacklists
logdir /var/log/squidguard

dest porn {
    domainlist porn/domains
    urllist porn/urls
}

dest malware {
    domainlist malware/domains
    urllist malware/urls
}

dest ads {
    domainlist ads/domains
    urllist ads/urls
}

acl {
    default {
        pass !porn !malware !ads all
        redirect http://192.168.1.1/blocked.html
    }
}
```

### 5.4 Compilar y Activas

```bash
squidGuard -C all
chown -R proxy:proxy /var/lib/squidguard/db/
systemctl restart squid
```

## 6. Reportes y Estadisticas

### 6.1 SARG

```bash
apt install -y sarg

nano /etc/sarg/sarg.conf

access_log /var/log/squid/access.log
output_dir /var/www/html/sarg
report_by user
```

```bash
sarg -x
crontab -e
0 23 * * * /usr/bin/sarg -x
```

### 6.2 Estadisticas Custom

```bash
grep "BLOCK" /var/log/squidguard/squidGuard.log | awk '{print $6}' | sort | uniq -c
grep "BLOCK" /var/log/squidguard/squidGuard.log | awk '{print $8}' | sort | uniq -c | sort -rn | head -10
```

## 7. Reglas de Tiempo

### 7.1 Control por Horario

```conf
acl hora_almuerzo time 12:00-14:00
acl fin_semana time SA,SU
acl horario_laboral time MTWHF 08:00-18:00

http_access allow hora_almuerzo
http_access allow fin_semana red_local
http_access allow horario_laboral empleados
http_access deny hora_laboral !empleados
```

## 8. Proxy Transparente con SSL

### 8.1 MITM Proxy

```conf
http_port 3129 ssl-bump \
    cert=/etc/squid/ssl_cert/ca.pem \
    key=/etc/squid/ssl_cert/ca.key

ssl_bump server-first all

ssl_bump allow all
```

### 8.2 Generar CA

```bash
mkdir /etc/squid/ssl_cert
cd /etc/squid/ssl_cert

openssl genrsa -out ca.pem 2048
openssl req -new -x509 -days 3650 -key ca.pem -out ca.crt

cp ca.crt /usr/local/share/ca-certificates/
update-ca-certificates
```

## 9. Balanceo de Carga

### 9.1 Multi-Backend

```conf
cache_peer 192.168.1.10 parent 80 0 no-query round-robin originserver
cache_peer 192.168.1.11 parent 80 0 no-query round-robin originserver
cache_peer 192.168.1.12 parent 80 0 no-query round-robin originserver
```

### 9.2 Parent Proxy

```conf
cache_peer proxy.empresa.com parent 3128 0 no-query default

acl dominios_locales dstdomain .midominio.com
always_direct allow dominios_locales
```

## 10. Seguridad Avanzada

### 10.1 Filtrado de Headers

```conf
request_header_access X-Forwarded-For deny all
request_header_access Via deny all
request_header_access User-Agent deny all
```

### 10.2 Proteccion contra Malware

```conf
acl malware url_regex -i http://.*\.exe$ http://.*\.zip$
http_access deny malware
```

## 11. Tuning de Rendimiento

### 11.1 Configuracion de Cache

```conf
cache_mem 512 MB
maximum_object_size_in_memory 512 KB
minimum_object_size 0 KB
maximum_object_size 4096 MB
cache_dir ufs /var/spool/squid 10000 16 256
cache_swap_low 90
cache_swap_high 95
```

### 11.2 Conexiones

```conf
cache_effective_user proxy
cache_effective_group proxy
max_filedescriptors 4096

connect_timeout 1 minutes
read_timeout 1 minutes
request_timeout 1 minutes
```

## 12. Monitoreo

### 12.1 SNMP

```bash
nano /etc/squid/squid.conf

snmp_port 3401
acl snmpcommunity snmp_community public
snmp_access allow snmpcommunity localhost
snmp_access deny all
```

### 12.2 Cache Manager

```conf
acl manager proto cache_object
http_access allow manager localhost
http_access deny manager
```

Acceso: http://tu-servidor:3128/cachemgr.cgi

## 13. Resumen de Configuracion

| Funcion | Puerto | Archivo |
|---------|--------|---------|
| Proxy | 3128 | /etc/squid/squid.conf |
| SSL Bump | 3129 | /etc/squid/squid.conf |
| SNMP | 3401 | /etc/squid/squid.conf |
| SARG | 80 | /var/www/html/sarg |

## 14. Script de Configuracion Avanzada

```bash
#!/bin/bash
set -e

echo "Configurando Proxy Avanzado"

apt install -y squid squidguard sarg

cp /etc/squid/squid.conf /etc/squid/squid.conf.backup

cat > /etc/squid/squid.conf << 'EOF'
http_port 3128

acl localnet src 192.168.1.0/24

acl bloqueados dstdomain .pornhub.com .xvideos.com
acl descargas urlpath_regex \.(exe|zip|rar|iso)$

auth_param basic program /usr/lib/squid/basic_ncsa_auth /etc/squid/passwd
auth_param basic children 5
auth_param basic realm "Proxy Corporativo"
acl usuarios proxy_auth REQUIRED

delay_pools 2
delay_class 1 1
delay_parameters 1 32000/32000

http_access allow localnet usuarios
http_access deny bloqueados
http_access deny descargas
http_access allow usuarios
http_access deny all

cache_mem 256 MB
cache_dir ufs /var/spool/squid 1000 16 256

access_log /var/log/squid/access.log
cache_log /var/log/squid/cache.log
EOF

squid -z
systemctl restart squid

echo "Proxy Avanzado configurado"
