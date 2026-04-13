<?php
/**
 * Auth Login/Register View - Página completa
 */
if(session_status() === PHP_SESSION_NONE) session_start();
include __DIR__ . '/../../includes/functions.php';

$currentLang = getActiveLanguage();
$lang = getLanguageStrings($currentLang);
$currentTheme = getActiveTheme();
$colors = getThemeColors($currentTheme);
$config = require __DIR__ . '/../../config.php';

$protocol = (!empty($_SERVER['HTTPS']) && $_SERVER['HTTPS'] !== 'off') ? 'https' : 'http';
$host = $_SERVER['HTTP_HOST'] ?? 'localhost';
$scriptDir = dirname($_SERVER['SCRIPT_NAME']);
$baseUrl = $protocol . '://' . $host . $scriptDir;

$error = $error ?? '';
$success = $success ?? '';
$isLogin = $isLogin ?? true;
?>
<!DOCTYPE html>
<html lang="<?= $currentLang ?>">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><?= $isLogin ? ($currentLang === 'es' ? 'Iniciar Sesión' : 'Login') : ($currentLang === 'es' ? 'Registrarse' : 'Register') ?> - <?= $config['site_name'] ?></title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            <?php foreach($colors as $k=>$v): ?>--<?= $k ?>: <?= $v ?>;<?php endforeach; ?>
        }
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { 
            font-family: 'Poppins', sans-serif; 
            background: linear-gradient(135deg, var(--header-bg), var(--primary));
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }
        .auth-card {
            background: var(--bg-secondary);
            border: 3px solid var(--primary);
            border-radius: 20px;
            padding: 2.5rem;
            width: 100%;
            max-width: 420px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
        }
        .auth-header {
            text-align: center;
            margin-bottom: 2rem;
        }
        .auth-logo {
            width: 80px;
            height: 80px;
            background: linear-gradient(135deg, var(--accent), var(--primary));
            border-radius: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 1rem;
            font-size: 2rem;
            color: white;
            box-shadow: 0 4px 15px rgba(0,0,0,0.2);
        }
        .auth-header h1 { color: var(--primary); margin-bottom: 0.3rem; font-size: 1.6rem; }
        .auth-header p { color: var(--text-secondary); font-size: 0.9rem; }
        
        .auth-tabs { 
            display: flex; 
            margin-bottom: 1.5rem; 
            background: var(--bg); 
            border-radius: 12px; 
            padding: 4px; 
        }
        .auth-tabs a { 
            flex: 1; 
            padding: 0.8rem; 
            text-align: center; 
            color: var(--text-secondary); 
            text-decoration: none; 
            border-radius: 8px; 
            transition: all 0.3s ease; 
            font-weight: 500; 
        }
        .auth-tabs a.active { 
            background: var(--primary); 
            color: white; 
            box-shadow: 0 4px 15px rgba(0,0,0,0.2); 
        }
        .auth-tabs a:hover:not(.active) { background: var(--bg-secondary); }
        
        .form-group { margin-bottom: 1.2rem; }
        .form-group label { 
            display: block; 
            margin-bottom: 0.5rem; 
            font-weight: 500; 
            color: var(--text);
            font-size: 0.9rem;
        }
        .form-group input, .form-group select { 
            width: 100%; 
            padding: 0.9rem 1rem; 
            border: 2px solid var(--border); 
            border-radius: 10px; 
            background: var(--bg); 
            color: var(--text); 
            font-size: 1rem;
            font-family: inherit;
            transition: border-color 0.3s;
        }
        .form-group input:focus, .form-group select:focus { 
            outline: none; 
            border-color: var(--primary); 
            box-shadow: 0 0 0 3px rgba(99, 102, 241, 0.1);
        }
        .form-grid { 
            display: grid; 
            grid-template-columns: 1fr 1fr; 
            gap: 1rem; 
        }
        
        .btn-auth { 
            width: 100%; 
            padding: 1rem; 
            background: linear-gradient(135deg, var(--primary), var(--header-bg)); 
            color: white; 
            border: none; 
            border-radius: 10px; 
            cursor: pointer; 
            font-size: 1.1rem; 
            font-weight: 600; 
            transition: all 0.3s; 
            margin-top: 0.5rem;
        }
        .btn-auth:hover { 
            transform: translateY(-2px); 
            box-shadow: 0 8px 25px rgba(0,0,0,0.2); 
        }
        
        .alert {
            padding: 1rem;
            border-radius: 10px;
            margin-bottom: 1rem;
            text-align: center;
            font-size: 0.9rem;
        }
        .alert-error { 
            background: rgba(239, 68, 68, 0.1); 
            color: #dc2626; 
            border: 1px solid rgba(239, 68, 68, 0.2);
        }
        .alert-success { 
            background: rgba(34, 197, 94, 0.1); 
            color: #16a34a; 
            border: 1px solid rgba(34, 197, 94, 0.2);
        }
        
        .back-link { 
            display: block; 
            text-align: center; 
            margin-top: 1.5rem; 
            color: var(--primary); 
            text-decoration: none; 
            font-weight: 500;
        }
        .back-link:hover { text-decoration: underline; }
        
        @media (max-width: 480px) {
            .auth-card { padding: 1.5rem; }
            .form-grid { grid-template-columns: 1fr; }
        }
    </style>
</head>
<body>
    <div class="auth-card">
        <div class="auth-header">
            <div class="auth-logo"><i class="fas fa-blog"></i></div>
            <h1><?= $isLogin ? ($currentLang === 'es' ? 'Bienvenido' : 'Welcome') : ($currentLang === 'es' ? 'Crear Cuenta' : 'Create Account') ?></h1>
            <p><?= $config['site_name'] ?></p>
        </div>
        
        <div class="auth-tabs">
            <a href="?action=login" class="<?= $isLogin ? 'active' : '' ?>">
                <i class="fas fa-sign-in-alt"></i> <?= $lang['nav_login'] ?? 'Login' ?>
            </a>
            <a href="?action=register" class="<?= !$isLogin ? 'active' : '' ?>">
                <i class="fas fa-user-plus"></i> <?= $currentLang === 'es' ? 'Registro' : 'Register' ?>
            </a>
        </div>
        
        <?php if($error): ?>
        <div class="alert alert-error"><i class="fas fa-exclamation-circle"></i> <?= $error ?></div>
        <?php endif; ?>
        <?php if($success): ?>
        <div class="alert alert-success"><i class="fas fa-check-circle"></i> <?= $success ?></div>
        <?php endif; ?>
        
        <form method="post">
            <?php if(!$isLogin): ?>
            <div class="form-grid">
                <div class="form-group">
                    <label><i class="fas fa-user"></i> <?= $currentLang === 'es' ? 'Nombre' : 'First Name' ?></label>
                    <input type="text" name="first_name">
                </div>
                <div class="form-group">
                    <label><i class="fas fa-user"></i> <?= $currentLang === 'es' ? 'Apellido' : 'Last Name' ?></label>
                    <input type="text" name="last_name">
                </div>
            </div>
            <div class="form-group">
                <label><i class="fas fa-at"></i> <?= $lang['register_username'] ?? 'Usuario' ?></label>
                <input type="text" name="username" required>
            </div>
            <div class="form-group">
                <label><i class="fas fa-phone"></i> <?= $currentLang === 'es' ? 'Teléfono' : 'Phone' ?></label>
                <input type="text" name="phone">
            </div>
            <?php endif; ?>
            <div class="form-group">
                <label><i class="fas fa-envelope"></i> <?= $currentLang === 'es' ? 'Email o Usuario' : 'Email or Username' ?></label>
                <input type="text" name="email" required>
            </div>
            <div class="form-group">
                <label><i class="fas fa-lock"></i> <?= $lang['login_password'] ?? 'Contraseña' ?></label>
                <input type="password" name="password" required>
            </div>
            <?php if(!$isLogin): ?>
            <div class="form-group">
                <label><i class="fas fa-question-circle"></i> <?= $lang['register_question'] ?? 'Pregunta de seguridad' ?></label>
                <select name="recovery_question" style="width:100%;padding:0.9rem;border:2px solid var(--border);border-radius:10px;background:var(--bg);color:var(--text);">
                    <option value=""><?= $currentLang === 'es' ? 'Selecciona una pregunta' : 'Select a question' ?></option>
                    <option value="first_pet"><?= $_COOKIE['language'] === 'en' ? 'Name of your first pet?' : '¿Nombre de tu primera mascota?' ?></option>
                    <option value="hometown"><?= $_COOKIE['language'] === 'en' ? 'Your hometown?' : '¿Tu ciudad natal?' ?></option>
                    <option value="best_friend"><?= $_COOKIE['language'] === 'en' ? "Your best friend's name?" : '¿Nombre de tu mejor amigo?' ?></option>
                    <option value="favorite_food"><?= $_COOKIE['language'] === 'en' ? 'Your favorite food?' : '¿Tu comida favorita?' ?></option>
                </select>
            </div>
            <div class="form-group">
                <label><i class="fas fa-key"></i> <?= $lang['register_answer'] ?? 'Respuesta' ?></label>
                <input type="text" name="recovery_answer">
            </div>
            <?php endif; ?>
            <button type="submit" name="<?= $isLogin ? 'login' : 'register' ?>" class="btn-auth">
                <i class="fas fa-<?= $isLogin ? 'sign-in-alt' : 'user-plus' ?>"></i> 
                <?= $isLogin ? ($lang['login_submit'] ?? 'Ingresar') : ($lang['register_submit'] ?? 'Registrarse') ?>
            </button>
        </form>
        
        <?php if($isLogin): ?>
        <div style="text-align:center;margin-top:1rem;">
            <a href="<?= $baseUrl ?>/recover.php" style="color:var(--primary);text-decoration:none;">
                <i class="fas fa-question-circle"></i> <?= $currentLang === 'es' ? '¿Olvidaste tu contraseña?' : 'Forgot your password?' ?>
            </a>
        </div>
        <?php endif; ?>
        
        <a href="<?= $baseUrl ?>/" class="back-link"><i class="fas fa-arrow-left"></i> <?= $currentLang === 'es' ? 'Volver al Blog' : 'Back to Blog' ?></a>
    </div>
    
    <script>
        function setTheme(theme) {
            document.cookie = 'theme=' + theme + '; path=/; max-age=31536000';
            location.reload();
        }
    </script>
</body>
</html>
