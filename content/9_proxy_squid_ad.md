# Proxy Squid con Autenticacion Active Directory

## 1. Introduccion

Integrar Squid con Active Directory permite autenticacion centralizada, politicas de grupo y control de acceso basado en usuarios de dominio.

### 1.1 Componentes Necesarios

- Squid: Servidor proxy
- Winbind: Autenticacion AD
- Kerberos: Autenticacion SSO
- NTLM: Autenticacion legacy

### 1.2 Arquitectura

```
Cliente -> Squid -> Winbind/Kerberos -> Active Directory
```

## 2. Preparacion del Sistema

### 2.1 Configuracion de Red

```bash
hostnamectl set-hostname proxy.midominio.com
```

```bash
nano /etc/hosts

192.168.1.10 proxy.midominio.com proxy
192.168.1.1 dc01.midominio.com dc01
```

### 2.2 Configuracion DNS

```bash
cat /etc/resolv.conf

domain midominio.com
search midominio.com
nameserver 192.168.1.1
```

### 2.3 Sincronizacion de Tiempo

```bash
apt install -y chrony
```

```bash
nano /etc/chrony/chrony.conf

server 192.168.1.1 iburst
```

```bash
systemctl enable chrony
systemctl start chrony

chronyc sources
```

## 3. Instalacion de Dependencias

### 3.1 Debian/Ubuntu

```bash
apt update && apt upgrade -y

apt install -y squid squid-common squid-langpack \
    krb5-user winbind libpam-krb5 libnss-winbind \
    libpam-winbind adcli sssd realmd
```

### 3.2 RHEL/Fedora

```bash
dnf install -y squid krb5-workstation winbind \
    pam_krb5 sssd realmd oddjob oddjob-mkhomedir
```

## 4. Configuracion de Kerberos

### 4.1 krb5.conf

```bash
nano /etc/krb5.conf
```

```ini
[libdefaults]
    default_realm = MIDOMINIO.COM
    dns_lookup_realm = false
    dns_lookup_kdc = false
    ticket_lifetime = 24h
    renew_lifetime = 7d
    forwardable = true

[realms]
    MIDOMINIO.COM = {
        kdc = dc01.midominio.com
        admin_server = dc01.midominio.com
    }

[domain_realm]
    .midominio.com = MIDOMINIO.COM
    midominio.com = MIDOMINIO.COM
```

### 4.2 Probar Kerberos

```bash
kinit administrator@MIDOMINIO.COM
klist
kinit -R
```

## 5. Union al Dominio AD

### 5.1 Usando Realmd

```bash
realm discover midominio.com
realm join midominio.com -U administrator
realm list
```

### 5.2 Usando Winbind

```bash
nano /etc/samba/smb.conf
```

```ini
[global]
    workgroup = MIDOMINIO
    realm = MIDOMINIO.COM
    security = ADS
    encrypt passwords = yes
    winbind use default domain = yes
    idmap uid = 10000-20000
    idmap gid = 10000-20000
    template shell = /bin/bash
```

```bash
net ads join -U administrator

systemctl enable winbind
systemctl start winbind

wbinfo -u
wbinfo -g
```

### 5.3 Configurar NSS

```bash
nano /etc/nsswitch.conf

passwd:         compat winbind
group:          compat winbit
```

```bash
getent passwd administrator
getgroup "Domain Users"
```

## 6. Configurar PAM

```bash
nano /etc/pam.d/squid
```

```
auth       include      password-auth
account    include      password-auth
password   include      password-auth
session    include      password-auth
```

## 7. Configurar Squid con Autenticacion AD

### 7.1 Autenticacion NTLM

```bash
nano /etc/squid/squid.conf
```

```conf
auth_param ntlm program /usr/bin/ntlm_auth \
    --domain=MIDOMINIO.COM \
    --helper-protocol=squid-2.5-ntlmssp

auth_param ntlm children 10
auth_param ntlm max_ntlm_auth_children 20
auth_param ntlm keep_alive on
```

### 7.2 Autenticacion Basica

```conf
auth_param basic program /usr/bin/ntlm_auth \
    --domain=MIDOMINIO.COM \
    --helper-protocol=squid-2.5-basic

auth_param basic children 5
auth_param basic realm "Proxy AD - Ingrese credenciales"
auth_param basic credentialsttl 2 hours
```

### 7.3 ACLs para AD

```conf
acl authenticated proxy_auth REQUIRED

external_acl_group_check nt_group /usr/lib/squid/ext_ldap_group_acl \
    -b "dc=midominio,dc=com" \
    -D "cn=proxy,ou=service,dc=midominio,dc=com" \
    -w "Password123" \
    -f "(&(memberOf=%g)(sAMAccountName=%u))"

acl allowed_users external nt_group "CN=Internet-Users,OU=Groups,DC=midominio,DC=com"
acl admin_group external nt_group "CN=IT-Admins,OU=Groups,DC=midominio,DC=com"

http_access allow allowed_users
http_access allow admin_group
http_access deny all
```

### 7.4 Configuracion Completa

```conf
http_port 3128

acl localnet src 192.168.1.0/24

auth_param basic program /usr/bin/ntlm_auth --domain=MIDOMINIO.COM
auth_param basic children 5
auth_param basic realm "Proxy Corporativo AD"

acl password proxy_auth REQUIRED

http_access allow localnet
http_access allow password
http_access deny all

cache_mem 256 MB
cache_dir ufs /var/spool/squid 1000 16 256
```

### 7.5 Verificar y Probar

```bash
squid -k parse
systemctl restart squid

tail -f /var/log/squid/access.log

wbinfo -a usuario%password
```

## 8. Autenticacion LDAP Directa

### 8.1 Instalar Helper LDAP

```bash
apt install -y squid-ldap-auth
```

### 8.2 Configurar LDAP

```conf
auth_param basic program /usr/lib/squid/basic_ldap_auth \
    -R \
    -b "dc=midominio,dc=com" \
    -f "sAMAccountName=%s" \
    -D "cn=proxy,ou=Service Accounts,dc=midominio,dc=com" \
    -w "Password123"

auth_param basic children 10
```

### 8.3 Verificacion de Grupo LDAP

```conf
external_acl_group_check nt_group /usr/lib/squid/ext_ldap_group_acl \
    -R \
    -b "dc=midominio,dc=com" \
    -D "cn=proxy,ou=Service Accounts,dc=midominio,dc=com" \
    -w "Password123" \
    -f "(&(objectClass=user)(sAMAccountName=%u)(memberOf=%g))"
```

## 9. Control por Grupo AD

### 9.1 Permisos por Grupo

```conf
external_acl_group_check nt_group /usr/lib/squid/ext_ldap_group_acl \
    -b "dc=midominio,dc=com" \
    -f "(&(memberOf=%g)(sAMAccountName=%u))"

acl grupo_sin_restricciones external nt_group "CN=Sin-Restricciones,OU=Groups,DC=midominio,DC=com"
acl grupo_internet external nt_group "CN=Internet-Users,OU=Groups,DC=midominio,DC=com"

acl sitios_bloqueados dstdomain .facebook.com .twitter.com .instagram.com

http_access allow grupo_sin_restricciones
http_access allow grupo_internet !sitios_bloqueados
http_access deny all
```

### 9.2 Cuotas por Grupo

```conf
delay_pools 3
delay_class 1 1
delay_class 2 1
delay_class 3 1

delay_parameters 1 -1/-1
delay_parameters 2 32000/32000
delay_parameters 3 8000/8000

acl empleados external nt_group "CN=Empleados,OU=Groups,DC=midominio,DC=com"
acl invitados external nt_group "CN=Invitados,OU=Groups,DC=midominio,DC=com"

delay_access 1 allow admin_group
delay_access 2 allow empleados
delay_access 3 allow invitados
```

## 10. Autenticacion SSO Kerberos

### 10.1 Generar Keytab

```bash
ktutil
addent -password -p proxy/MIDOMINIO.COM -k 1 -e RC4-HMAC
wkt /tmp/proxy.keytab

scp /tmp/proxy.keytab proxy:/etc/squid/squid.keytab

chown proxy:proxy /etc/squid/squid.keytab
chmod 640 /etc/squid/squid.keytab
```

### 10.2 Configurar Squid para SSO

```conf
auth_param negotiate program /usr/lib/squid/negotiate_kerberos_auth -t HTTP/proxy.midominio.com@MIDOMINIO.COM
auth_param negotiate children 20
auth_param negotiate keep_alive on

acl kerb_auth proxy_auth REQUIRED
http_access allow kerb_auth
http_access deny all
```

## 11. Logs y Reportes

### 11.1 Logs con Usuario AD

```conf
logformat squid_hierarchical %>a %[ui %un] [%tl] "%rm %ru HTTP/%rv" %Hs %<st
access_log /var/log/squid/access.log squid_hierarchical
```

### 11.2 Reportes por Usuario

```bash
apt install -y sarg

nano /etc/sarg/sarg.conf

access_log /var/log/squid/access.log
report_by user
topuser_sort_field bytes reverse

sarg -x
```

## 12. Troubleshooting

### 12.1 Problemas Comunes

```bash
klist
wbinfo -u
wbinfo -g

ntlm_auth --domain=MIDOMINIO.COM --username=usuario
```

### 12.2 Errores y Soluciones

- Error NTLM failed: Verificar credenciales y nombre de dominio
- Error Domain does not exist: Verificar DNS y /etc/krb5.conf
- Error Winbind not running: systemctl start winbind
- Error Keytab entry not found: Regenerar keytab en DC

## 13. Resumen de Configuracion

| Componente | Archivo |
|------------|---------|
| Kerberos | /etc/krb5.conf |
| Samba | /etc/samba/smb.conf |
| NSS | /etc/nsswitch.conf |
| Squid | /etc/squid/squid.conf |

## 14. Script de Instalacion

```bash
#!/bin/bash
set -e

DOMAIN="midominio.com"
DC="192.168.1.1"
ADMIN="administrator"

echo "Configurando Proxy con AD"

apt install -y squid krb5-user winbind libpam-krb5 libnss-winbind

echo "domain $DOMAIN
nameserver $DC" > /etc/resolv.conf

cat > /etc/krb5.conf << EOF
[libdefaults]
    default_realm = ${DOMAIN^^}
[realms]
    ${DOMAIN^^} = {
        kdc = dc01.$DOMAIN
    }
[domain_realm]
    .$DOMAIN = ${DOMAIN^^}
EOF

net ads join -U $ADMIN

cat > /etc/squid/squid.conf << 'EOF'
http_port 3128
auth_param basic program /usr/bin/ntlm_auth --domain=MIDOMINIO.COM
auth_param basic children 5
auth_param basic realm "Proxy Corporativo AD"
acl localnet src 192.168.1.0/24
acl password proxy_auth REQUIRED
http_access allow localnet password
http_access deny all
cache_mem 256 MB
EOF

systemctl restart winbind
systemctl restart squid

echo "Proxy AD configurado"
