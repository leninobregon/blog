<?php
/**
 * INSTALADOR AUTOMÁTICO - BLOG DE TUTORIALES
 * Compatible con XAMPP, LAMP y LEMP
 */

error_reporting(E_ALL);
ini_set('display_errors', 1);

$site_name = "Mi Blog de Tutoriales";

echo "<!DOCTYPE html>
<html lang='es'>
<head>
    <meta charset='UTF-8'>
    <meta name='viewport' content='width=device-width, initial-scale=1.0'>
    <title>Instalador - $site_name</title>
    <link rel='stylesheet' href='https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css'>
    <link href='https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap' rel='stylesheet'>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { 
            font-family: 'Poppins', sans-serif; 
            background: linear-gradient(135deg, #1a1a2e 0%, #16213e 50%, #0f3460 100%); 
            min-height: 100vh; 
            display: flex; 
            align-items: center; 
            justify-content: center;
            padding: 20px;
        }
        .installer-container { width: 100%; max-width: 700px; background: rgba(255,255,255,0.05); backdrop-filter: blur(10px); border: 1px solid rgba(255,255,255,0.1); border-radius: 20px; padding: 40px; box-shadow: 0 25px 50px rgba(0,0,0,0.3); }
        .logo { text-align: center; margin-bottom: 30px; }
        .logo i { font-size: 4rem; background: linear-gradient(135deg, #667eea, #764ba2); -webkit-background-clip: text; -webkit-text-fill-color: transparent; margin-bottom: 15px; }
        .logo h1 { color: #fff; font-size: 1.8rem; font-weight: 700; }
        .logo p { color: rgba(255,255,255,0.6); font-size: 0.9rem; }
        .progress-steps { display: flex; justify-content: center; gap: 10px; margin-bottom: 30px; }
        .step { width: 40px; height: 40px; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-weight: 600; transition: all 0.3s; }
        .step.active { background: #667eea; color: #fff; }
        .step.pending { background: rgba(255,255,255,0.1); color: rgba(255,255,255,0.5); }
        .step.done { background: #10b981; color: #fff; }
        .step-line { width: 30px; height: 2px; background: rgba(255,255,255,0.2); align-self: center; }
        .form-group { margin-bottom: 15px; }
        .form-group label { display: block; color: rgba(255,255,255,0.8); margin-bottom: 5px; font-size: 0.9rem; }
        .form-group input { width: 100%; padding: 12px 15px; background: rgba(0,0,0,0.3); border: 1px solid rgba(255,255,255,0.2); border-radius: 8px; color: #fff; font-size: 1rem; font-family: inherit; }
        .form-group input:focus { outline: none; border-color: #667eea; box-shadow: 0 0 0 3px rgba(102,126,234,0.2); }
        .form-row { display: grid; grid-template-columns: 1fr 1fr; gap: 15px; }
        .log-container { background: rgba(0,0,0,0.3); border-radius: 12px; padding: 20px; margin: 20px 0; max-height: 300px; overflow-y: auto; }
        .log-item { padding: 8px 0; border-bottom: 1px solid rgba(255,255,255,0.05); display: flex; align-items: center; gap: 10px; font-size: 0.9rem; }
        .log-item:last-child { border-bottom: none; }
        .log-success { color: #10b981; }
        .log-error { color: #ef4444; }
        .log-info { color: #60a5fa; }
        .log-warning { color: #fbbf24; }
        .btn-install { display: block; width: 100%; padding: 15px; background: linear-gradient(135deg, #667eea, #764ba2); color: #fff; border: none; border-radius: 12px; font-size: 1.1rem; font-weight: 600; cursor: pointer; transition: all 0.3s; text-decoration: none; text-align: center; }
        .btn-install:hover { transform: translateY(-3px); box-shadow: 0 10px 30px rgba(102,126,234,0.4); }
        .btn-install:disabled { background: #4b5563; cursor: not-allowed; transform: none; box-shadow: none; }
        .config-info { background: rgba(102,126,234,0.1); border: 1px solid rgba(102,126,234,0.3); border-radius: 12px; padding: 20px; margin: 20px 0; }
        .config-info h3 { color: #667eea; margin-bottom: 15px; display: flex; align-items: center; gap: 10px; }
        .success-box { background: rgba(16,185,129,0.1); border: 1px solid rgba(16,185,129,0.3); border-radius: 12px; padding: 25px; text-align: center; margin: 20px 0; }
        .success-box h3 { color: #10b981; font-size: 1.5rem; margin-bottom: 15px; }
        .success-box .credentials { background: rgba(0,0,0,0.3); border-radius: 8px; padding: 15px; margin: 15px 0; }
        .success-box .credentials p { color: #fff; margin: 5px 0; }
        @keyframes spin { 0% { transform: rotate(0deg); } 100% { transform: rotate(360deg); } }
        .spinner { display: inline-block; width: 20px; height: 20px; border: 2px solid rgba(255,255,255,0.3); border-top-color: #fff; border-radius: 50%; animation: spin 1s linear infinite; margin-right: 10px; }
    </style>
</head>
<body>
    <div class='installer-container'>
        <div class='logo'>
            <i class='fas fa-blog'></i>
            <h1>$site_name</h1>
            <p>Asistente de Instalación</p>
        </div>
        
        <div class='progress-steps'>
            <div class='step active' id='step1'>1</div>
            <div class='step-line'></div>
            <div class='step pending' id='step2'>2</div>
            <div class='step-line'></div>
            <div class='step pending' id='step3'>3</div>
            <div class='step-line'></div>
            <div class='step pending' id='step4'>4</div>
        </div>
        
        <div id='install-content'>
            <div class='config-info'>
                <h3><i class='fas fa-database'></i> Configuración de la Base de Datos</h3>
                <div class='form-group'>
                    <label for='db_host'>Servidor MySQL:</label>
                    <input type='text' id='db_host' name='db_host' placeholder='localhost' required>
                </div>
                <div class='form-group'>
                    <label for='db_name'>Nombre de la base de datos:</label>
                    <input type='text' id='db_name' name='db_name' placeholder='blog_tutoriales' required>
                </div>
                <div class='form-row'>
                    <div class='form-group'>
                        <label for='db_user'>Usuario MySQL:</label>
                        <input type='text' id='db_user' name='db_user' placeholder='root' required>
                    </div>
                    <div class='form-group'>
                        <label for='db_pass'>Contraseña MySQL:</label>
                        <input type='password' id='db_pass' name='db_pass' placeholder='Sin contraseña'>
                    </div>
                </div>
            </div>
            
            <div class='config-info'>
                <h3><i class='fas fa-user-shield'></i> Credenciales de Administrador</h3>
                <p style='color:rgba(255,255,255,0.6);font-size:0.85rem;margin-bottom:15px;'>Ingresa tus propias credenciales:</p>
                <div class='form-group'>
                    <label for='admin_user'>Usuario:</label>
                    <input type='text' id='admin_user' name='admin_user' value='admin' required>
                </div>
                <div class='form-group'>
                    <label for='admin_email'>Email:</label>
                    <input type='email' id='admin_email' name='admin_email' value='admin@blog.com' required>
                </div>
                <div class='form-row'>
                    <div class='form-group'>
                        <label for='admin_pass'>Contraseña:</label>
                        <input type='password' id='admin_pass' name='admin_pass' placeholder='Ingresa una contraseña' required minlength='4'>
                    </div>
                    <div class='form-group'>
                        <label for='admin_pass_confirm'>Confirmar:</label>
                        <input type='password' id='admin_pass_confirm' name='admin_pass_confirm' placeholder='Repite la contraseña' required minlength='4'>
                    </div>
                </div>
            </div>
            
            <div class='log-container' id='log-container' style='display:none;'></div>
            <button class='btn-install' id='btn-install' onclick='startInstall()'>
                <i class='fas fa-download'></i> INICIAR INSTALACIÓN
            </button>
            <div id='result-container'></div>
        </div>
    </div>
    
    <script>
    function startInstall() {
        var dbHost = document.getElementById('db_host').value.trim();
        var dbName = document.getElementById('db_name').value.trim();
        var dbUser = document.getElementById('db_user').value.trim();
        var dbPass = document.getElementById('db_pass').value;
        var adminUser = document.getElementById('admin_user').value.trim();
        var adminEmail = document.getElementById('admin_email').value.trim();
        var adminPass = document.getElementById('admin_pass').value;
        var adminPassConfirm = document.getElementById('admin_pass_confirm').value;
        
        if (!dbHost || !dbName || !dbUser) {
            alert('Por favor completa los campos de la base de datos');
            return;
        }
        if (!adminUser || !adminEmail || !adminPass) {
            alert('Por favor completa todos los campos');
            return;
        }
        if (adminPass !== adminPassConfirm) {
            alert('Las contraseñas no coinciden');
            return;
        }
        if (adminPass.length < 4) {
            alert('La contraseña debe tener al menos 4 caracteres');
            return;
        }
        
        var btn = document.getElementById('btn-install');
        btn.disabled = true;
        btn.innerHTML = '<span class=\"spinner\"></span> Instalando...';
        
        var logContainer = document.getElementById('log-container');
        logContainer.style.display = 'block';
        logContainer.innerHTML = '';
        
        document.getElementById('step1').className = 'step done';
        document.getElementById('step2').className = 'step active';
        
        var formData = new FormData();
        formData.append('action', 'install');
        formData.append('db_host', dbHost);
        formData.append('db_name', dbName);
        formData.append('db_user', dbUser);
        formData.append('db_pass', dbPass);
        formData.append('admin_user', adminUser);
        formData.append('admin_email', adminEmail);
        formData.append('admin_pass', adminPass);
        
        fetch('instalar.php', { method: 'POST', body: formData })
            .then(function(response) { return response.json(); })
            .then(function(data) {
                data.logs.forEach(function(log) {
                    var item = document.createElement('div');
                    item.className = 'log-item log-' + log.type;
                    var icon = log.type === 'success' ? 'check-circle' : log.type === 'error' ? 'times-circle' : 'info-circle';
                    item.innerHTML = '<i class=\"fas fa-' + icon + '\"></i> ' + log.message;
                    logContainer.appendChild(item);
                    logContainer.scrollTop = logContainer.scrollHeight;
                });
                
                if (data.success) {
                    document.getElementById('step2').className = 'step done';
                    document.getElementById('step3').className = 'step done';
                    document.getElementById('step4').className = 'step done';
                    btn.style.display = 'none';
                    document.getElementById('result-container').innerHTML = data.html;
                } else {
                    document.getElementById('step2').className = 'step pending';
                    btn.disabled = false;
                    btn.innerHTML = '<i class=\"fas fa-redo\"></i> REINTENTAR';
                }
            })
            .catch(function(error) {
                var item = document.createElement('div');
                item.className = 'log-item log-error';
                item.innerHTML = '<i class=\"fas fa-times-circle\"></i> Error: ' + error.message;
                logContainer.appendChild(item);
                btn.disabled = false;
                btn.innerHTML = '<i class=\"fas fa-redo\"></i> REINTENTAR';
            });
    }
    </script>
</body>
</html>";

$db_host = $_POST['db_host'] ?? 'localhost';
$db_name = $_POST['db_name'] ?? 'blog_tutoriales';
$db_user = $_POST['db_user'] ?? 'root';
$db_pass = $_POST['db_pass'] ?? '';
$admin_user = $_POST['admin_user'] ?? 'admin';
$admin_email = $_POST['admin_email'] ?? 'admin@blog.com';
$admin_pass = $_POST['admin_pass'] ?? 'blog$$';

if (isset($_POST['action']) && $_POST['action'] === 'install') {
    header('Content-Type: application/json');
    $response = ['success' => false, 'logs' => [], 'html' => ''];
    
    try {
        $pdo = null;
        try {
            $dsn = "mysql:host={$db_host};charset=utf8mb4";
            $pdo = new PDO($dsn, $db_user, $db_pass);
            $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
            $response['logs'][] = ['type' => 'success', 'message' => 'Conexión a MySQL establecida'];
        } catch (PDOException $e) {
            $response['logs'][] = ['type' => 'error', 'message' => 'No se pudo conectar a MySQL/MariaDB'];
            $response['logs'][] = ['type' => 'info', 'message' => 'Verifica las credenciales de la base de datos'];
            echo json_encode($response);
            exit;
        }
        
        $pdo->exec("CREATE DATABASE IF NOT EXISTS `$db_name` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci");
        $pdo->exec("USE `$db_name`");
        $response['logs'][] = ['type' => 'success', 'message' => "Base de datos '$db_name' creada"];
        
        $pdo->exec("CREATE TABLE IF NOT EXISTS `users` (`id` INT AUTO_INCREMENT PRIMARY KEY, `username` VARCHAR(50) NOT NULL UNIQUE, `email` VARCHAR(100) NOT NULL UNIQUE, `password` VARCHAR(255) NOT NULL, `role` ENUM('admin','author','user') DEFAULT 'user', `first_name` VARCHAR(50), `last_name` VARCHAR(50), `phone` VARCHAR(20), `avatar` VARCHAR(255), `bio` TEXT, `facebook` VARCHAR(255), `twitter` VARCHAR(255), `telegram` VARCHAR(255), `instagram` VARCHAR(255), `youtube` VARCHAR(255), `linkedin` VARCHAR(255), `website` VARCHAR(255), `recovery_question` VARCHAR(255), `recovery_answer` VARCHAR(255), `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci");
        
        $pdo->exec("CREATE TABLE IF NOT EXISTS `posts` (`id` INT AUTO_INCREMENT PRIMARY KEY, `title` VARCHAR(255) NOT NULL, `category` VARCHAR(100) NOT NULL, `content` TEXT NOT NULL, `image` VARCHAR(255), `video` VARCHAR(255), `author_id` INT, `views` INT DEFAULT 0, `tags` VARCHAR(500), `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci");
        
        $pdo->exec("CREATE TABLE IF NOT EXISTS `comments` (`id` INT AUTO_INCREMENT PRIMARY KEY, `post_id` INT NOT NULL, `user_id` INT NOT NULL, `content` TEXT NOT NULL, `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP, FOREIGN KEY (`post_id`) REFERENCES `posts`(`id`) ON DELETE CASCADE, FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci");
        
        $pdo->exec("CREATE TABLE IF NOT EXISTS `newsletter` (`id` INT AUTO_INCREMENT PRIMARY KEY, `email` VARCHAR(100) NOT NULL UNIQUE, `name` VARCHAR(100), `active` TINYINT(1) DEFAULT 1, `token` VARCHAR(100), `last_sent` DATETIME NULL, `total_sent` INT DEFAULT 0, `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci");
        
        $pdo->exec("CREATE TABLE IF NOT EXISTS `visit_logs` (`id` INT AUTO_INCREMENT PRIMARY KEY, `page` VARCHAR(255), `ip` VARCHAR(45), `user_agent` TEXT, `referer` VARCHAR(255), `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci");
        
        $pdo->exec("CREATE TABLE IF NOT EXISTS `about` (`id` INT AUTO_INCREMENT PRIMARY KEY, `title` VARCHAR(255) DEFAULT 'Acerca de Mí', `subtitle` VARCHAR(255), `description` TEXT, `experience` TEXT, `goals` TEXT, `photo` VARCHAR(255), `youtube_url` VARCHAR(255), `facebook_url` VARCHAR(255), `twitter_url` VARCHAR(255), `telegram_url` VARCHAR(255), `email` VARCHAR(100), `updated_at` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci");
        
        $pdo->exec("CREATE TABLE IF NOT EXISTS `site_stats` (`id` INT AUTO_INCREMENT PRIMARY KEY, `total_hits` INT DEFAULT 0, `updated_at` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci");
        
        $response['logs'][] = ['type' => 'success', 'message' => 'Todas las tablas creadas correctamente'];
        
        $hash = password_hash($admin_pass, PASSWORD_BCRYPT);
        $stmt = $pdo->prepare("INSERT INTO users (username, email, password, role, first_name, last_name, bio, recovery_question, recovery_answer) VALUES (?, ?, ?, 'admin', 'Admin', 'Principal', 'Administrador del blog', '¿Cuál es el nombre de tu primera mascota?', 'admin123') ON DUPLICATE KEY UPDATE password = VALUES(password)");
        $stmt->execute([$admin_user, $admin_email, $hash]);
        $response['logs'][] = ['type' => 'success', 'message' => "Usuario administrador '$admin_user' creado"];
        
        $stmt = $pdo->prepare("INSERT INTO about (id, title, subtitle, description) VALUES (1, 'Acerca de Mí', 'Ingeniero en Computación', 'Escribe aquí tu descripción personal...') ON DUPLICATE KEY UPDATE id = id");
        $stmt->execute();
        $response['logs'][] = ['type' => 'success', 'message' => 'Datos iniciales insertados'];
        
        $pdo->exec("INSERT INTO site_stats (id, total_hits) VALUES (1, 0) ON DUPLICATE KEY UPDATE id = id");
        $response['logs'][] = ['type' => 'success', 'message' => 'Estadísticas inicializadas'];
        
        $config_content = "<?php return array (
  'site_name' => '$site_name',
  'site_url' => 'http://localhost/proyecto/blog_responsivo',
  'email' => '$admin_email',
  'author' => 'Tu Nombre',
  'description' => 'Tutoriales de Linux, Seguridad y más',
  'theme' => 'blue',
  'posts_per_page' => 10,
  'youtube' => '',
  'telegram' => '',
  'facebook' => '',
  'twitter' => '',
  'db' => array (
    'host' => '$db_host',
    'user' => '$db_user',
    'pass' => '$db_pass',
    'name' => '$db_name',
  ),
);";
        file_put_contents('config.php', $config_content);
        $response['logs'][] = ['type' => 'success', 'message' => 'config.php actualizado'];
        
        if (!is_dir('db')) { mkdir('db', 0777, true); }
        file_put_contents('db/.htaccess', "Order deny,allow\nDeny from all");
        
        $response['success'] = true;
        
        $installerFile = __FILE__;
        @unlink($installerFile);
        
        $response['html'] = "<div class='success-box'><i class='fas fa-check-circle' style='font-size:3rem;color:#10b981;margin-bottom:15px;'></i><h3>INSTALACIÓN COMPLETADA</h3><p style='color:rgba(255,255,255,0.7);'>El Blog ha sido instalado correctamente</p><div class='credentials'><p><i class='fas fa-user' style='color:#667eea;'></i> Usuario: <strong>$admin_user</strong></p><p><i class='fas fa-envelope' style='color:#667eea;'></i> Email: <strong>$admin_email</strong></p><p><i class='fas fa-lock' style='color:#667eea;'></i> Contraseña: <strong>$admin_pass</strong></p></div><a href='index.php' class='btn-install' style='margin-top:10px;'><i class='fas fa-home'></i> IR AL BLOG</a><a href='admin/' class='btn-install' style='margin-top:10px;background:linear-gradient(135deg,#10b981,#059669);'><i class='fas fa-cog'></i> IR AL ADMIN</a></div>";
        
    } catch (PDOException $e) {
        $response['logs'][] = ['type' => 'error', 'message' => 'Error: ' . $e->getMessage()];
    }
    
    echo json_encode($response);
    exit;
}
?>
