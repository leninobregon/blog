# Squid + SquidGuard Filtrado de Contenido

## 1. Introduccion

SquidGuard es un filtrador de contenido rapido y eficiente que se integra con Squid para bloquear sitios web segun categorias, horarios y grupos de usuarios.

### 1.1 Caracteristicas

- Categorias predefinidas: Porn, violencia, malware, ads
- Blacklists: Listas actualizadas automaticamente
- Filtrado por horario
- Redireccion personalizada
- Soporte LDAP/AD

### 1.2 Flujo de Filtrado

```
Cliente -> Squid:3128 -> SquidGuard -> Sitio/Bloqueado
```

## 2. Instalacion

### 2.1 Debian/Ubuntu

```bash
apt update && apt upgrade -y
apt install -y squidguard
squidGuard -v
```

### 2.2 RHEL/Fedora

```bash
dnf install -y epel-release
dnf install -y squid squidguard
```

### 2.3 Compilar desde Fuente

```bash
apt install -y gcc make wget

cd /tmp
wget http://sourceforge.net/projects/squidguard/files/squidguard/squidguard-1.6/squidGuard-1.6.tar.gz/download -O squidGuard-1.6.tar.gz
tar -xzf squidGuard-1.6.tar.gz
cd squidGuard-1.6

./configure --prefix=/usr
make && make install

mkdir -p /var/lib/squidguard/db
```

## 3. Estructura de Directorios

```bash
ls -la /var/lib/squidguard/db/

mkdir -p /var/lib/squidguard/db/{blacklists,custom}
mkdir -p /var/log/squidguard
chown -R proxy:proxy /var/log/squidguard
```

## 4. Configuracion de Blacklists

### 4.1 Descargar Blacklists

```bash
cd /var/lib/squidguard/db
wget http://www.shallalist.de/download/bigblacklist.tar.gz
tar -xzf bigblacklist.tar.gz
ls BL/
```

### 4.2 Categorias Disponibles

| Categoria | Descripcion |
|-----------|-------------|
| adult | Contenido adulto |
| porn | Pornografia |
| violence | Violencia |
| malware | Sitios maliciosos |
| phishing | Phishing |
| ads | Publicidad |
| social_networks | Redes sociales |
| gambling | Apuestas |
| streaming | Streaming |
| drugs | Drogas |

### 4.3 Blacklist Personalizada

```bash
mkdir -p /var/lib/squidguard/db/custom/denied

echo "facebook.com" > /var/lib/squidguard/db/custom/denied/domains
echo "twitter.com" >> /var/lib/squidguard/db/custom/denied/domains

echo "youtube.com/watch" > /var/lib/squidguard/db/custom/denied/urls

echo "porn" > /var/lib/squidguard/db/custom/denied/expressions
echo "xxx" >> /var/lib/squidguard/db/custom/denied/expressions
```

## 5. Configuracion Principal

### 5.1 squidGuard.conf

```bash
nano /etc/squidguard/squidGuard.conf
```

```conf
dbhome /var/lib/squidguard/db/blacklists
logdir /var/log/squidguard

dest porn {
    domainlist porn/domains
    urllist porn/urls
    expressionlist porn/expressions
}

dest adult {
    domainlist adult/domains
    urllist adult/urls
}

dest malware {
    domainlist malware/domains
    urllist malware/urls
}

dest phishing {
    domainlist phishing/domains
    urllist phishing/urls
}

dest ads {
    domainlist ads/domains
    urllist ads/urls
}

dest socialnetworks {
    domainlist social_networks/domains
    urllist social_networks/urls
}

dest denied {
    domainlist custom/denied/domains
    urllist custom/denied/urls
    expressionlist custom/denied/expressions
}

acl {
    default {
        pass !porn !adult !malware !phishing !ads !socialnetworks !denied all
        redirect http://192.168.1.1/blocked.html?c=%c&u=%u
    }
}
```

### 5.2 Compilar Base de Datos

```bash
squidGuard -C all
squidGuard -C porn

ls -la /var/lib/squidguard/db/blacklists/*/
chown -R proxy:proxy /var/lib/squidguard/
```

### 5.3 Pagina de Bloqueo

```bash
nano /var/www/html/blocked.html
```

```html
<!DOCTYPE html>
<html>
<head>
    <title>Acceso Bloqueado</title>
    <style>
        body { font-family: Arial; background: #f0f0f0; text-align: center; padding: 50px; }
        .box { background: white; padding: 30px; border-radius: 10px; max-width: 500px; margin: auto; }
        h1 { color: #d00; }
    </style>
</head>
<body>
    <div class="box">
        <h1>Acceso Bloqueado</h1>
        <p>El sitio que intenta acceder ha sido bloqueado.</p>
        <p>Categoria: %c</p>
        <p>Usuario: %u</p>
    </div>
</body>
</html>
```

## 6. Integracion con Squid

### 6.1 Configurar Squid

```bash
nano /etc/squid/squid.conf
```

```conf
redirect_program /usr/bin/squidGuard -c /etc/squidguard/squidGuard.conf
redirect_children 5
```

### 6.2 Verificar Integracion

```bash
squid -k parse
systemctl reload squid

echo "http://pornhub.com" | squidGuard -c /etc/squidguard/squidGuard.conf -d
```

### 6.3 Logs

```bash
tail -f /var/log/squidguard/squidGuard.log
tail -f /var/log/squid/access.log | grep TAG_NONE
```

## 7. Filtrado por Tiempo

### 7.1 ACLs de Tiempo

```conf
time workhours 08:00-18:00
time lunch 12:00-14:00
time weekend 00:00-23:59

src employees {
    ip 192.168.1.10-192.168.1.50
}

src guests {
    ip 192.168.1.200-192.168.1.250
}
```

### 7.2 Reglas por Tiempo

```conf
acl {
    employees within workhours {
        pass !porn !violence all
    }
    
    employees {
        pass !porn !violence !gambling all
    }
    
    guests within workhours {
        pass !porn !violence !ads all
    }
    
    guests {
        pass white-list all
    }
    
    default {
        pass !porn !violence !malware !phishing all
    }
}
```

## 8. Reglas Avanzadas

### 8.1 Multiple Destinations

```conf
dest bad_content {
    domainlist porn/domains
    domainlist adult/domains
    domainlist violence/domains
    urllist porn/urls
    expressionlist porn/expressions
}

dest whitelist {
    domainlist whitelist/domains
}
```

### 8.2 Reglas con Whitelist

```conf
acl {
    default {
        pass whitelist !bad_content all
        redirect http://192.168.1.1/blocked.html
    }
}
```

## 9. Autenticacion con AD

### 9.1 Configurar Autenticacion

```conf
auth_param basic program /usr/bin/ntlm_auth --domain=MIDOMINIO.COM
acl password proxy_auth REQUIRED
```

### 9.2 Reglas por Usuario

```conf
external_acl_group_check nt_group /usr/lib/squid/ext_ldap_group_acl \
    -b "dc=midominio,dc=com" \
    -f "(&(memberOf=%g)(sAMAccountName=%u))"

acl admin_group external nt_group "CN=IT-Admins,OU=Groups,DC=midominio,DC=com"
acl employees_group external nt_group "CN=Empleados,OU=Groups,DC=midominio,DC=com"
acl guests_group external nt_group "CN=Invitados,OU=Groups,DC=midominio,DC=com"

acl {
    admin_group {
        pass all
    }
    
    employees_group {
        pass !porn !violence !gambling all
    }
    
    guests_group {
        pass !porn !violence !ads !socialnetworks all
    }
    
    password {
        pass !porn !violence all
    }
    
    default {
        pass none
    }
}
```

## 10. Actualizacion de Blacklists

### 10.1 Script de Actualizacion

```bash
#!/bin/bash
BLACKLIST_URL="http://www.shallalist.de/download/bigblacklist.tar.gz"
DB_DIR="/var/lib/squidguard/db"

cd $DB_DIR
wget -q -N $BLACKLIST_URL

if [ -f bigblacklist.tar.gz ]; then
    tar -xzf bigblacklist.tar.gz
    squidGuard -C all
    chown -R proxy:proxy $DB_DIR
    systemctl reload squid
fi
```

### 10.2 Programar Cron

```bash
crontab -e
0 3 * * * /usr/local/bin/update-blacklists.sh
```

## 11. Reportes

### 11.1 SARG con SquidGuard

```bash
nano /etc/sarg/sarg.conf

access_log /var/log/squid/access.log
squidguard_log /var/log/squidguard/squidGuard.log
report_by user

sarg -x
```

### 11.2 Estadisticas Custom

```bash
grep "BLOCK" /var/log/squidguard/squidGuard.log | awk '{print $6}' | sort | uniq -c
grep "BLOCK" /var/log/squidguard/squidGuard.log | awk '{print $8}' | sort | uniq -c | sort -rn | head -10
```

## 12. Troubleshooting

### 12.1 Errores Comunes

- Error db null destination: squidGuard -C all
- Error cannot stat: chown -R proxy:proxy /var/lib/squidguard/
- Error No such file: Verificar dbhome en config

### 12.2 Debug Mode

```bash
squidGuard -d -c /etc/squidguard/squidGuard.conf
echo "http://pornhub.com/test" | squidGuard -c /etc/squidguard/squidGuard.conf -d
```

### 12.3 Verificar Estado

```bash
ps aux | grep squidGuard
tail -f /var/log/squidguard/squidGuard.log
tail -f /var/log/squid/access.log | grep TAG_NONE
```

## 13. Tuning de Rendimiento

### 13.1 Optimizaciones

```conf
expressiondb 10000
max_db_connections 50
```

### 13.2 squid.conf

```conf
redirect_children 10 startup=5 idle=5
redirector_bypass on
```

## 14. Resumen de Comandos

| Comando | Descripcion |
|---------|-------------|
| squidGuard -C all | Compilar todas las listas |
| squidGuard -C categoria | Compilar una categoria |
| squidGuard -d -c config | Modo debug |
| squid -k reconfigure | Recargar Squid |

## 15. Script de Instalacion

```bash
#!/bin/bash
set -e

echo "Instalando Squid + SquidGuard"

apt install -y squid squidguard

cd /var/lib/squidguard/db
wget http://www.shallalist.de/download/bigblacklist.tar.gz
tar -xzf bigblacklist.tar.gz

chown -R proxy:proxy /var/lib/squidguard/
squidGuard -C all

echo 'redirect_program /usr/bin/squidGuard -c /etc/squidguard/squidGuard.conf
redirect_children 5' >> /etc/squid/squid.conf

mkdir -p /var/www/html
cat > /var/www/html/blocked.html << 'EOF'
<html><head><title>Bloqueado</title></head>
<body><h1>Sitio bloqueado</h1></body></html>
EOF

squid -z
systemctl restart squid

echo "SquidGuard instalado"
