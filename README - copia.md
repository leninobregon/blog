# 📚 Blog de Tutoriales

Blog de tutoriales para **Lenin Obregón Espinoza** (Ingeniero Nicaragüense). Sistema completo de publicaciones con soporte Markdown, multi-idioma, 20 temas de color y panel de administración.

---

## 🌟 Características Principales

### 📝 Sistema de Publicaciones
- Editor con soporte Markdown
- Tabla de contenidos automática
- Tiempo de lectura estimado
- Contador de visitas
- Posts relacionados por categoría
- Comentarios en cada publicación
- Botones de compartir (WhatsApp, Telegram, Facebook, Twitter)
- Botón copiar código en bloques de código

### 👥 Sistema de Usuarios
- Registro con preguntas de recuperación
- Login seguro con hash bcrypt
- Perfil editable (foto, biografía, redes sociales)
- Roles: Admin, Autor, Usuario
- Panel de usuario para crear publicaciones

### 📊 Admin Dashboard
- Estadísticas con gráficas Chart.js
  - Visitas últimos 30 días
  - Publicaciones por categoría
  - Páginas más visitadas
  - Usuarios por rol
- Gestión de usuarios
- Gestión de publicaciones
- Editor de página "Acerca de"
- Respaldos de base de datos

### 🎨 Sistema de Temas (20 Colores)
- Blanco, Azul, Azul Oscuro, Negro
- Verde, Rojo, Morado, Naranja
- Rosa, Teal, Amarillo, Cian
- Marrón, Índigo, Lima, Ámbar
- Rojo Rosa, Pizarra, Esmeralda, Cielo, Violeta

### 🌐 Multi-idioma
- Español (por defecto)
- English
- Selector de idioma en el menú

### 📧 Newsletter
- Suscripción por email
- Envío masivo desde admin
- Gestión de suscriptores

---

## 🛠️ Tecnologías Utilizadas

| Tecnología | Uso |
|------------|-----|
| PHP 7.4+ | Backend (PDO) |
| MySQL / MariaDB | Base de datos |
| HTML5, CSS3 | Frontend |
| JavaScript | Interactividad |
| Chart.js | Gráficos y visualización |
| Font Awesome 6 | Iconos profesionales |
| Parsedown | Markdown a HTML |
| Poppins / Fira Code | Tipografías |

---

## 🏗️ Arquitectura PHP POO - MVC

El blog está desarrollado con **Programación Orientada a Objetos (POO)** siguiendo el patrón **MVC (Modelo - Vista - Controlador)**.

### 🔷 Modelo (Model)
- Clases que gestionan la base de datos
- Consultas SQL preparadas con PDO
- Métodos CRUD reutilizables
- Ejemplo: `User.php`, `Post.php`, `Comment.php`

### 🔶 Vista (View)
- Plantillas HTML con código PHP embebido
- Variables pasadas desde los controladores
- Layouts reutilizables (header, footer)
- Ejemplo: `views/index.php`, `views/post.php`

### 🔷 Controlador (Controller)
- Recibe peticiones del usuario
- Coordina Modelo y Vista
- Maneja lógica de negocio
- Ejemplo: `HomeController.php`, `PostController.php`

### 🔄 Flujo de una Petición

```
Usuario → index.php (Router) → Controlador → Modelo → Vista → HTML
```

---

## 📋 Requisitos

### Software

| Requisito | Versión mínima |
|-----------|----------------|
| PHP | 7.4+ |
| MySQL / MariaDB | 5.7+ |
| Apache / Nginx | any |

### Hardware

| Nivel | CPU | RAM | Disco |
|-------|-----|-----|-------|
| **Mínimo** | 1 núcleo | 512 MB | 1 GB |
| **Óptimo** | 2+ núcleos | 2 GB | 10 GB |
| **Máximo** | 4+ núcleos | 4+ GB | 50+ GB |

> **Nota**: El blog es ligero y funciona bien en un VPS básico (1 núcleo, 1 GB RAM). 50 GB es más que suficiente para el código, imágenes y datos.

---

## 🚀 Instalación

### Opción 1: Importar base de datos manualmente (recomendado)

Puedes importar el archivo SQL directamente:

- **Con datos de ejemplo**: `db/blog_tutoriales.sql`
- **Solo admin (vacío)**: `db/blog_tutoriales_empty.sql`

### Opción 2: Usar phpMyAdmin

1. Crea la base de datos `blog_tutoriales`
2. Importa el archivo SQL elegido

---

## 🪟 Windows con XAMPP

### Requisitos
- [XAMPP](https://www.apachefriends.org) instalado
- Apache y MySQL iniciados

### Pasos

1. **Copiar proyecto**: Coloca la carpeta en `C:\xampp\htdocs\proyecto\blog_responsivo`

2. **Iniciar servicios**: Desde el Panel de Control de XAMPP, inicia **Apache** y **MySQL**

3. **Crear base de datos**:
   - Abre phpMyAdmin: `http://localhost/phpmyadmin`
   - Crea una base de datos llamada `blog_tutoriales` (utf8mb4_unicode_ci)

4. **Instalar** (elige una opción):

   **Opción A - Importar SQL (con datos de ejemplo)**:
   - Ve a phpMyAdmin > blog_tutoriales > Importar
   - Selecciona el archivo `db/blog_tutoriales.sql`
   - Click en "Continuar"

   **Opción B - Importar SQL (vacío, solo admin)**:
   - Ve a phpMyAdmin > blog_tutoriales > Importar
   - Selecciona el archivo `db/blog_tutoriales_empty.sql`
   - Click en "Continuar"

5. **Configurar credenciales** en `config.php`:
```php
'db' => array (
  'host' => 'localhost',
  'user' => 'root',
  'pass' => '',        // Sin contraseña en XAMPP
  'name' => 'blog_tutoriales',
),
```

---

## 🐧 Linux (Debian/Ubuntu) con LAMP

### Requisitos
- Debian 11+ o Ubuntu 20.04+
- Acceso root o sudo

### Pasos

1. **Actualizar sistema**:
```bash
sudo apt update && sudo apt upgrade -y
```

2. **Instalar LAMP**:
```bash
sudo apt install apache2 mariadb-server php php-mysql php-cli php-zip php-curl php-xml php-mbstring php-gd unzip git -y
```

3. **Habilitar servicios**:
```bash
sudo systemctl enable apache2 mariadb
sudo systemctl start apache2 mariadb
```

4. **IMPORTANTE: Configurar acceso root para PHP**:
```bash
sudo mysql -u root -p -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password; FLUSH PRIVILEGES;"
```
(presiona Enter cuando pida contraseña)

5. **Configurar MariaDB**:
```bash
sudo mysql -u root
```

```sql
CREATE DATABASE blog_tutoriales CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE USER 'bloguser'@'localhost' IDENTIFIED BY 'blogpass';
GRANT ALL PRIVILEGES ON blog_tutoriales.* TO 'bloguser'@'localhost';
FLUSH PRIVILEGES;
EXIT;
```

6. **Descargar proyecto**:
```bash
cd /var/www/html
sudo git clone https://github.com/leninobregon/blog_v2.git blog_responsivo
```

7. **Permisos**:
```bash
sudo chown -R www-data:www-data /var/www/html/blog_responsivo
sudo chmod -R 755 /var/www/html/blog_responsivo
sudo chmod 777 /var/www/html/blog_responsivo/uploads
sudo chmod 777 /var/www/html/blog_responsivo/db
```

8. **Instalar** (elige una opción):

**Opción A - Importar SQL (con datos de ejemplo)**:
```bash
sudo mysql -u bloguser -p blog_tutoriales < /var/www/html/blog_responsivo/db/blog_tutoriales.sql
```

**Opción B - Importar SQL (vacío, solo admin)**:
```bash
sudo mysql -u bloguser -p blog_tutoriales < /var/www/html/blog_responsivo/db/blog_tutoriales_empty.sql
```

9. **Configurar credenciales** en `config.php`:
```php
'db' => array (
  'host' => 'localhost',
  'user' => 'bloguser',
  'pass' => 'blogpass',
  'name' => 'blog_tutoriales',
),
```

10. **Habilitar Apache**:
```bash
sudo a2enmod rewrite
sudo systemctl reload apache2
```

11. **Configurar VirtualHost** (opcional):
```bash
sudo nano /etc/apache2/sites-available/blog_responsivo.conf
```

```apache
<VirtualHost *:80>
    ServerName blog.local
    DocumentRoot /var/www/html/blog_responsivo

    <Directory /var/www/html/blog_responsivo>
        Options -Indexes +FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>

    ErrorLog ${APACHE_LOG_DIR}/blog_responsivo_error.log
    CustomLog ${APACHE_LOG_DIR}/blog_responsivo_access.log combined
</VirtualHost>
```

```bash
sudo a2ensite blog_responsivo.conf
sudo a2enmod rewrite
sudo systemctl reload apache2

# Si hay errores, usar:
sudo a2ensite blog_responsivo.conf --force
sudo systemctl restart apache2
```

12. **Deshabilitar sitio por defecto** (si carga la página de Apache):
```bash
sudo a2dissite 000-default.conf
sudo systemctl restart apache2
```

13. **Agregar al archivo hosts** (si usas dominio local):
```bash
sudo nano /etc/hosts
```
Agregar línea:
```
127.0.0.1    blog.local
```

---

## 🐧 Linux (Debian/Ubuntu) con LEMP (Nginx)

### Requisitos
- Debian 11+ o Ubuntu 20.04+
- Acceso root o sudo

### Pasos

1. **Actualizar sistema**:
```bash
sudo apt update && sudo apt upgrade -y
```

2. **Instalar LEMP**:
```bash
sudo apt install nginx mariadb-server php-fpm php-mysql php-cli php-zip php-curl php-xml php-mbstring php-gd unzip git -y
```

3. **Habilitar servicios**:
```bash
sudo systemctl enable nginx mariadb php-fpm
sudo systemctl start nginx mariadb php-fpm
```

4. **Configurar MariaDB**:
```bash
sudo mysql -u root
```

```sql
CREATE DATABASE blog_tutoriales CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE USER 'bloguser'@'localhost' IDENTIFIED BY 'blogpass';
GRANT ALL PRIVILEGES ON blog_tutoriales.* TO 'bloguser'@'localhost';
FLUSH PRIVILEGES;
EXIT;
```

5. **Descargar proyecto**:
```bash
cd /var/www/html
sudo git clone https://github.com/leninobregon/blog_v2.git blog_responsivo
```

6. **Permisos**:
```bash
sudo chown -R www-data:www-data /var/www/html/blog_responsivo
sudo chmod -R 755 /var/www/html/blog_responsivo
sudo chmod 777 /var/www/html/blog_responsivo/uploads
sudo chmod 777 /var/www/html/blog_responsivo/db
```

7. **Configurar Nginx**:
```bash
sudo nano /etc/nginx/sites-available/blog_responsivo
```

```nginx
server {
    listen 80;
    server_name tu-servidor;
    root /var/www/html/blog_responsivo;
    index index.php index.html;

    location / {
        try_files $uri $uri/ /index.php?$query_string;
    }

    location ~ \.php$ {
        include fastcgi_params;
        fastcgi_pass unix:/run/php/php-fpm.sock;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
    }

    location ~ /\.ht {
        deny all;
    }
}
```

8. **Habilitar sitio**:
```bash
sudo ln -s /etc/nginx/sites-available/blog_responsivo /etc/nginx/sites-enabled/
sudo nginx -t
sudo systemctl reload nginx
```

9. **Instalar** (elige una opción):

**Opción A - Importar SQL (con datos de ejemplo)**:
```bash
sudo mysql -u bloguser -p blog_tutoriales < /var/www/html/blog_responsivo/db/blog_tutoriales.sql
```

**Opción B - Importar SQL (vacío, solo admin)**:
```bash
sudo mysql -u bloguser -p blog_tutoriales < /var/www/html/blog_responsivo/db/blog_tutoriales_empty.sql
```

10. **Configurar credenciales** en `config.php`:
```php
'db' => array (
  'host' => 'localhost',
  'user' => 'bloguser',
  'pass' => 'blogpass',
  'name' => 'blog_tutoriales',
),
```

---

## 🦊 Linux (Fedora) con LAMP

### Requisitos
- Fedora 38+
- Acceso root o sudo

### Pasos

1. **Actualizar sistema**:
```bash
sudo dnf update -y
```

2. **Instalar LAMP**:
```bash
sudo dnf install httpd mariadb-server php php-mysqlnd php-json php-zip php-curl php-xml php-mbstring php-gd php-intl git unzip -y
```

3. **Habilitar servicios**:
```bash
sudo systemctl enable httpd mariadb
sudo systemctl start httpd mariadb
```

4. **IMPORTANTE: Configurar acceso root para PHP**:
```bash
sudo mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password; FLUSH PRIVILEGES;"
```

5. **Configurar MariaDB**:
```bash
sudo mysql -u root
```

```sql
CREATE DATABASE blog_tutoriales CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE USER 'bloguser'@'localhost' IDENTIFIED BY 'blogpass';
GRANT ALL PRIVILEGES ON blog_tutoriales.* TO 'bloguser'@'localhost';
FLUSH PRIVILEGES;
EXIT;
```

6. **Descargar proyecto**:
```bash
cd /var/www/html
sudo git clone https://github.com/leninobregon/blog_v2.git blog_responsivo
```

7. **Permisos**:
```bash
sudo chown -R apache:apache /var/www/html/blog_responsivo
sudo chmod -R 755 /var/www/html/blog_responsivo
sudo chmod 777 /var/www/html/blog_responsivo/uploads
sudo chmod 777 /var/www/html/blog_responsivo/db
```

8. **Configurar firewall**:
```bash
sudo firewall-cmd --permanent --add-service=http --add-service=https
sudo firewall-cmd --reload
```

9. **Permitir Apache en SELinux**:
```bash
sudo setsebool -P httpd_can_network_connect 1
sudo setsebool -P httpd_read_user_content 1
```

10. **Configurar VirtualHost**:
```bash
sudo nano /etc/httpd/conf.d/blog_responsivo.conf
```

```apache
<VirtualHost *:80>
    ServerName tu-servidor
    DocumentRoot /var/www/html/blog_responsivo

    <Directory /var/www/html/blog_responsivo>
        Options -Indexes +FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>

    ErrorLog /var/log/httpd/blog_error.log
    CustomLog /var/log/httpd/blog_access.log combined
</VirtualHost>
```

11. **Reiniciar Apache**:
```bash
sudo httpd -t
sudo systemctl restart httpd
```

12. **Instalar** (elige una opción):

**Opción A - Importar SQL (con datos de ejemplo)**:
```bash
sudo mysql -u bloguser -p blog_tutoriales < /var/www/html/blog_responsivo/db/blog_tutoriales.sql
```

**Opción B - Importar SQL (vacío, solo admin)**:
```bash
sudo mysql -u bloguser -p blog_tutoriales < /var/www/html/blog_responsivo/db/blog_tutoriales_empty.sql
```

13. **Configurar credenciales** en `config.php`:
```php
'db' => array (
  'host' => 'localhost',
  'user' => 'bloguser',
  'pass' => 'blogpass',
  'name' => 'blog_tutoriales',
),
```

---

## 🦊 Linux (Fedora) con LEMP (Nginx)

### Requisitos
- Fedora 38+
- Acceso root o sudo

### Pasos

1. **Actualizar sistema**:
```bash
sudo dnf update -y
```

2. **Instalar LEMP**:
```bash
sudo dnf install epel-release -y
sudo dnf install nginx -y
sudo dnf install php-fpm php-mysqlnd php-json php-zip php-curl php-xml php-mbstring php-gd php-intl -y
sudo dnf install mariadb-server -y
```

3. **Habilitar servicios**:
```bash
sudo systemctl enable nginx mariadb php-fpm
sudo systemctl start nginx mariadb php-fpm
```

4. **IMPORTANTE: Configurar acceso root para PHP**:
```bash
sudo mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password; FLUSH PRIVILEGES;"
```

5. **Configurar MariaDB**:
```bash
sudo mysql -u root
```

```sql
CREATE DATABASE blog_tutoriales CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE USER 'bloguser'@'localhost' IDENTIFIED BY 'blogpass';
GRANT ALL PRIVILEGES ON blog_tutoriales.* TO 'bloguser'@'localhost';
FLUSH PRIVILEGES;
EXIT;
```

6. **Descargar proyecto**:
```bash
cd /var/www/html
sudo git clone https://github.com/leninobregon/blog_v2.git blog_responsivo
```

7. **Permisos**:
```bash
sudo chown -R nginx:nginx /var/www/html/blog_responsivo
sudo chmod -R 755 /var/www/html/blog_responsivo
sudo chmod 777 /var/www/html/blog_responsivo/uploads
sudo chmod 777 /var/www/html/blog_responsivo/db
```

8. **Configurar Nginx**:
```bash
sudo nano /etc/nginx/conf.d/blog_responsivo.conf
```

```nginx
server {
    listen 80;
    server_name tu-servidor;
    root /var/www/html/blog_responsivo;
    index index.php index.html;

    location / {
        try_files $uri $uri/ /index.php?$query_string;
    }

    location ~ \.php$ {
        fastcgi_pass unix:/run/php-fpm/www.sock;
        fastcgi_index index.php;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        include fastcgi_params;
    }

    location ~ /\.ht {
        deny all;
    }
}
```

9. **Verificar y reiniciar**:
```bash
sudo nginx -t
sudo systemctl restart nginx php-fpm
```

10. **Configurar firewall**:
```bash
sudo firewall-cmd --permanent --add-service=http --add-service=https
sudo firewall-cmd --reload
```

11. **Permitir Nginx en SELinux**:
```bash
sudo setsebool -P httpd_can_network_connect 1
```

12. **Instalar** (elige una opción):

**Opción A - Importar SQL (con datos de ejemplo)**:
```bash
sudo mysql -u bloguser -p blog_tutoriales < /var/www/html/blog_responsivo/db/blog_tutoriales.sql
```

**Opción B - Importar SQL (vacío, solo admin)**:
```bash
sudo mysql -u bloguser -p blog_tutoriales < /var/www/html/blog_responsivo/db/blog_tutoriales_empty.sql
```

13. **Configurar credenciales** en `config.php`:
```php
'db' => array (
  'host' => 'localhost',
  'user' => 'bloguser',
  'pass' => 'blogpass',
  'name' => 'blog_tutoriales',
),
```

---

## 🐉 Linux (RHEL/CentOS/Rocky/AlmaLinux) con LAMP

### Requisitos
- RHEL 8+ / CentOS 8+ / Rocky 8+ / AlmaLinux 8+
- Acceso root o sudo

### Pasos

1. **Actualizar sistema**:
```bash
sudo dnf update -y
```

2. **Instalar LAMP**:
```bash
sudo dnf install httpd mariadb-server php php-mysqlnd php-json php-zip php-curl php-xml php-mbstring php-gd php-intl git unzip -y
```

3. **Habilitar servicios**:
```bash
sudo systemctl enable httpd mariadb
sudo systemctl start httpd mariadb
```

4. **IMPORTANTE: Configurar acceso root para PHP**:
```bash
sudo mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password; FLUSH PRIVILEGES;"
```

5. **Configurar MariaDB**:
```bash
sudo mysql -u root
```

```sql
CREATE DATABASE blog_tutoriales CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE USER 'bloguser'@'localhost' IDENTIFIED BY 'blogpass';
GRANT ALL PRIVILEGES ON blog_tutoriales.* TO 'bloguser'@'localhost';
FLUSH PRIVILEGES;
EXIT;
```

6. **Descargar proyecto**:
```bash
cd /var/www/html
sudo git clone https://github.com/leninobregon/blog_v2.git blog_responsivo
```

7. **Permisos**:
```bash
sudo chown -R apache:apache /var/www/html/blog_responsivo
sudo chmod -R 755 /var/www/html/blog_responsivo
sudo chmod 777 /var/www/html/blog_responsivo/uploads
sudo chmod 777 /var/www/html/blog_responsivo/db
```

8. **Configurar firewall**:
```bash
sudo firewall-cmd --permanent --add-service=http --add-service=https
sudo firewall-cmd --reload
```

9. **Permitir Apache en SELinux**:
```bash
sudo setsebool -P httpd_can_network_connect 1
sudo setsebool -P httpd_read_user_content 1
```

10. **Configurar VirtualHost**:
```bash
sudo nano /etc/httpd/conf.d/blog_responsivo.conf
```

```apache
<VirtualHost *:80>
    ServerName tu-servidor
    DocumentRoot /var/www/html/blog_responsivo

    <Directory /var/www/html/blog_responsivo>
        Options -Indexes +FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>

    ErrorLog /var/log/httpd/blog_error.log
    CustomLog /var/log/httpd/blog_access.log combined
</VirtualHost>
```

11. **Reiniciar Apache**:
```bash
sudo httpd -t
sudo systemctl restart httpd
```

12. **Instalar** (elige una opción):

**Opción A - Importar SQL (con datos de ejemplo)**:
```bash
sudo mysql -u bloguser -p blog_tutoriales < /var/www/html/blog_responsivo/db/blog_tutoriales.sql
```

**Opción B - Importar SQL (vacío, solo admin)**:
```bash
sudo mysql -u bloguser -p blog_tutoriales < /var/www/html/blog_responsivo/db/blog_tutoriales_empty.sql
```

13. **Configurar credenciales** en `config.php`:
```php
'db' => array (
  'host' => 'localhost',
  'user' => 'bloguser',
  'pass' => 'blogpass',
  'name' => 'blog_tutoriales',
),
```

5. **Configurar MariaDB**:
```bash
sudo mysql -u root
```

```sql
CREATE DATABASE blog_tutoriales CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE USER 'bloguser'@'localhost' IDENTIFIED BY 'blogpass';
GRANT ALL PRIVILEGES ON blog_tutoriales.* TO 'bloguser'@'localhost';
FLUSH PRIVILEGES;
EXIT;
```

6. **Descargar proyecto**:
```bash
cd /var/www/html
sudo git clone https://github.com/leninobregon/blog_v2.git blog_responsivo
```

7. **Permisos**:
```bash
sudo chown -R nginx:nginx /var/www/html/blog_responsivo
sudo chmod -R 755 /var/www/html/blog_responsivo
sudo chmod 777 /var/www/html/blog_responsivo/uploads
sudo chmod 777 /var/www/html/blog_responsivo/db
```

8. **Configurar Nginx**:
```bash
sudo nano /etc/nginx/conf.d/blog_responsivo.conf
```

```nginx
server {
    listen 80;
    server_name tu-servidor;
    root /var/www/html/blog_responsivo;
    index index.php index.html;

    location / {
        try_files $uri $uri/ /index.php?$query_string;
    }

    location ~ \.php$ {
        fastcgi_pass unix:/run/php-fpm/www.sock;
        fastcgi_index index.php;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        include fastcgi_params;
    }

    location ~ /\.ht {
        deny all;
    }
}
```

9. **Verificar y reiniciar**:
```bash
sudo nginx -t
sudo systemctl restart nginx php-fpm
```

10. **Configurar firewall**:
```bash
sudo firewall-cmd --permanent --add-service=http --add-service=https
sudo firewall-cmd --reload
```

11. **Permitir Nginx en SELinux**:
```bash
sudo setsebool -P httpd_can_network_connect 1
```

12. **Instalar** (elige una opción):

   **Opción A - Importar SQL (con datos de ejemplo)**:
   ```bash
   sudo mysql -u bloguser -p blog_tutoriales < /var/www/html/blog_responsivo/db/blog_tutoriales.sql
   ```

   **Opción B - Importar SQL (vacío, solo admin)**:
   ```bash
   sudo mysql -u bloguser -p blog_tutoriales < /var/www/html/blog_responsivo/db/blog_tutoriales_empty.sql
   ```

13. **Configurar credenciales** en `config.php`:
```php
'db' => array (
  'host' => 'localhost',
  'user' => 'bloguser',
  'pass' => 'blogpass',
  'name' => 'blog_tutoriales',
),
```

---

## 🐉 Linux (RHEL/CentOS/Rocky/AlmaLinux) con LAMP

### Requisitos
- RHEL 8+ / CentOS 8+ / Rocky 8+ / AlmaLinux 8+
- Acceso root o sudo

### Pasos

1. **Actualizar sistema**:
```bash
sudo dnf update -y
```

2. **Instalar LAMP**:
```bash
sudo dnf install httpd mariadb-server php php-mysqlnd php-json php-zip php-curl php-xml php-mbstring php-gd php-intl git unzip -y
```

3. **Habilitar servicios**:
```bash
sudo systemctl enable httpd mariadb
sudo systemctl start httpd mariadb
```

4. **IMPORTANTE: Configurar acceso root para PHP**:
```bash
sudo mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password; FLUSH PRIVILEGES;"
```

5. **Configurar MariaDB**:
```bash
sudo mysql -u root
```

```sql
CREATE DATABASE blog_tutoriales CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE USER 'bloguser'@'localhost' IDENTIFIED BY 'blogpass';
GRANT ALL PRIVILEGES ON blog_tutoriales.* TO 'bloguser'@'localhost';
FLUSH PRIVILEGES;
EXIT;
```

6. **Descargar proyecto**:
```bash
cd /var/www/html
sudo git clone https://github.com/leninobregon/blog_v2.git blog_responsivo
```

7. **Permisos**:
```bash
sudo chown -R apache:apache /var/www/html/blog_responsivo
sudo chmod -R 755 /var/www/html/blog_responsivo
sudo chmod 777 /var/www/html/blog_responsivo/uploads
sudo chmod 777 /var/www/html/blog_responsivo/db
```

8. **Configurar firewall**:
```bash
sudo firewall-cmd --permanent --add-service=http --add-service=https
sudo firewall-cmd --reload
```

9. **Permitir Apache en SELinux**:
```bash
sudo setsebool -P httpd_can_network_connect 1
sudo setsebool -P httpd_read_user_content 1
```

10. **Configurar VirtualHost**:
```bash
sudo nano /etc/httpd/conf.d/blog_responsivo.conf
```

```apache
<VirtualHost *:80>
    ServerName tu-servidor
    DocumentRoot /var/www/html/blog_responsivo

    <Directory /var/www/html/blog_responsivo>
        Options -Indexes +FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>

    ErrorLog /var/log/httpd/blog_error.log
    CustomLog /var/log/httpd/blog_access.log combined
</VirtualHost>
```

11. **Reiniciar Apache**:
```bash
sudo httpd -t
sudo systemctl restart httpd
```

12. **Instalar** (elige una opción):

   **Opción A - Importar SQL (con datos de ejemplo)**:
   ```bash
   sudo mysql -u bloguser -p blog_tutoriales < /var/www/html/blog_responsivo/db/blog_tutoriales.sql
   ```

   **Opción B - Importar SQL (vacío, solo admin)**:
   ```bash
   sudo mysql -u bloguser -p blog_tutoriales < /var/www/html/blog_responsivo/db/blog_tutoriales_empty.sql
   ```

13. **Configurar credenciales** en `config.php`:
```php
'db' => array (
  'host' => 'localhost',
  'user' => 'bloguser',
  'pass' => 'blogpass',
  'name' => 'blog_tutoriales',
),
```
```bash
sudo setsebool -P httpd_can_network_connect 1
sudo setsebool -P httpd_read_user_content 1
```

8. **Instalar** (elige una opción):
   - Opción A: Importar `db/blog_tutoriales.sql`
   - Opción B: Importar `db/blog_tutoriales_empty.sql`

9. **Configurar credenciales** en `config.php`

---

## 📊 Estructura de la Base de Datos

| Tabla | Descripción |
|-------|-------------|
| users | Usuarios del sistema (admin, autor, user) |
| posts | Publicaciones del blog |
| comments | Comentarios en posts |
| newsletter | Suscriptores al newsletter |
| visit_logs | Registro de visitas al sitio |
| audit_logs | Registro de acciones de usuarios |
| about | Página "Acerca de" (editable) |
| site_stats | Estadísticas globales del sitio |

### Notas sobre la Base de Datos
- No se utilizan **foreign keys** para mayor compatibilidad entre servidores
- La aplicación gestiona las relaciones lógicamente
- Charset: `utf8mb4` para soportar caracteres especiales y emojis

---

## 📂 Estructura de Archivos

```
blog_responsivo/
├── index.php                  # Página principal (MVC Entry Point)
├── autoload.php               # Carga automática de clases
├── config.php                 # Configuración del sitio
├── subscribe.php              # Suscripción al newsletter
├── db/
│   ├── blog_tutoriales.sql    # Script SQL con datos de ejemplo
│   └── blog_tutoriales_empty.sql  # Script SQL solo admin
├── core/                      # Clases base del MVC
│   ├── Database.php           # Conexión PDO (Singleton)
│   ├── Session.php            # Manejo de sesiones
│   ├── Controller.php         # Clase base controladores
│   ├── Model.php              # Clase base modelos
│   └── theme_colors.php       # Colores de los 20 temas
├── models/                    # Modelos de datos
├── controllers/               # Controladores
├── views/                     # Plantillas HTML
├── includes/                  # Funciones helper
├── languages/                 # Traducciones (es, en)
├── admin/                     # Panel de administración
├── user/                      # Panel de usuario
└── uploads/                   # Imágenes subidas
```

---

## 🔑 Credenciales de Acceso

| Campo | Valor |
|-------|-------|
| Admin URL | `/admin/` |
| Usuario | `admin` |
| Email | `admin@blog.com` |
| Contraseña | `blog$$` |

---

## 🛠️ Solución de Problemas

### 📌 Error 500 (Internal Server Error)

```bash
# Ver logs según el servidor
# XAMPP
tail -50 C:\xampp\apache\logs\error.log

# Apache (Linux)
sudo tail -50 /var/log/apache2/error.log

# httpd (Fedora/RHEL)
sudo tail -50 /var/log/httpd/error_log
```

### 📌 Error de Conexión a Base de Datos

```bash
# Verificar que MySQL/MariaDB está corriendo
sudo systemctl status mariadb

# Verificar credenciales en config.php
```

### 📌 Permisos incorrectos (Linux)

```bash
# Debian/Ubuntu (Apache)
sudo chown -R www-data:www-data /var/www/html/blog_responsivo

# Fedora/RHEL (Apache)
sudo chown -R apache:apache /var/www/html/blog_responsivo

# LEMP (Nginx)
sudo chown -R nginx:nginx /var/www/html/blog_responsivo
```

---

## 📄 Licencia

Este proyecto está bajo la Licencia MIT.

Copyright (c) 2026 Blog de Tutoriales - Lenin Obregón

---

## ✉️ Soporte

- **Backups**: Utiliza la opción "Respaldar DB" en el panel de administración
- **Actualizaciones**: Pull desde GitHub regularmente

---

<img width="1256" height="855" alt="Blog Preview" src="https://github.com/user-attachments/assets/bda325df-b58c-4179-b227-ab755fa3d52d" />
