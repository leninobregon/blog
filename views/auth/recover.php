<?php
/**
 * Password Recovery View
 */
if (session_status() === PHP_SESSION_NONE) session_start();
include __DIR__ . '/../../includes/functions.php';

$currentLang = getActiveLanguage();
$lang = getLanguageStrings($currentLang);
$currentTheme = getActiveTheme();
$colors = getThemeColors($currentTheme);
$config = require __DIR__ . '/../../config.php';

// Debug
error_log("Theme: " . $currentTheme);

$siteUrl = $config['site_url'] ?? '';
if (empty($siteUrl)) {
    $protocol = (!empty($_SERVER['HTTPS']) && $_SERVER['HTTPS'] !== 'off') ? 'https' : 'http';
    $host = $_SERVER['HTTP_HOST'] ?? 'localhost';
    $scriptDir = rtrim(dirname($_SERVER['SCRIPT_NAME'] ?? '/'), '/');
    $siteUrl = $protocol . '://' . $host . $scriptDir;
}
$baseUrl = rtrim($siteUrl, '/');

$error = $error ?? '';
$success = $success ?? '';
$showSuccess = $showSuccess ?? false;
$user = $user ?? null;
$showQuestion = $showQuestion ?? false;
?>
<!DOCTYPE html>
<html lang="<?= $currentLang ?>">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><?= $currentLang === 'es' ? 'Recuperar Contraseña' : 'Recover Password' ?> - <?= $config['site_name'] ?></title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="<?= $baseUrl ?>/assets/css/icon-pro.css?v=1">
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
        .auth-header i {
            font-size: 3rem;
            color: var(--primary);
        }
        .auth-header h1 {
            color: var(--text);
            font-size: 1.5rem;
            margin-top: 1rem;
        }
        .form-group {
            margin-bottom: 1rem;
        }
        .form-group label {
            display: block;
            color: var(--text);
            margin-bottom: 0.5rem;
            font-weight: 500;
        }
        .form-group input, .form-group select {
            width: 100%;
            padding: 0.9rem;
            border: 2px solid var(--border);
            border-radius: 10px;
            background: var(--bg);
            color: var(--text);
            font-size: 1rem;
            font-family: inherit;
        }
        .form-group input:focus, .form-group select:focus {
            outline: none;
            border-color: var(--primary);
        }
        .btn-auth {
            width: 100%;
            padding: 1rem;
            background: var(--primary);
            color: white;
            border: none;
            border-radius: 10px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            margin-top: 1rem;
        }
        .btn-auth:hover {
            opacity: 0.9;
        }
        .alert {
            padding: 1rem;
            border-radius: 10px;
            margin-bottom: 1rem;
        }
        .alert-error {
            background: #fee2e2;
            color: #dc2626;
            border: 1px solid #fca5a5;
        }
        .alert-success {
            background: #d1fae5;
            color: #059669;
            border: 1px solid #6ee7b7;
        }
        .back-link {
            display: block;
            text-align: center;
            margin-top: 1.5rem;
            color: var(--text);
            text-decoration: none;
            opacity: 0.8;
        }
        .back-link:hover {
            opacity: 1;
        }
    </style>
</head>
<body>
    <div class="auth-card">
        <div class="auth-header">
            <i class="fas fa-key"></i>
            <h1><?= $currentLang === 'es' ? 'Recuperar Contraseña' : 'Recover Password' ?></h1>
        </div>
        
        <?php if($error): ?>
        <div class="alert alert-error"><i class="fas fa-exclamation-circle"></i> <?= $error ?></div>
        <?php endif; ?>
        
        <?php if($showQuestion && $user): ?>
        <!-- Step 2: Show security question -->
        <form method="post">
            <input type="hidden" name="user_id" value="<?= $user['id'] ?? '' ?>">
            <div class="form-group">
                <label><i class="fas fa-user"></i> <?= $currentLang === 'es' ? 'Usuario' : 'Username' ?></label>
                <input type="text" value="<?= htmlspecialchars($user['username']) ?>" readonly style="background: var(--bg-secondary);">
            </div>
            <div class="form-group">
                <label><i class="fas fa-question-circle"></i> 
                <?php 
                $q = $user['recovery_question'] ?? '';
                $lang = $_COOKIE['language'] ?? 'es';
                
                // Debug
                // file_put_contents('debug.txt', "q=$q, lang=$lang\n", FILE_APPEND);
                
                if ($lang === 'en') {
                    switch($q) {
                        case 'first_pet': $q = 'Name of your first pet?'; break;
                        case 'hometown': $q = 'Your hometown?'; break;
                        case 'best_friend': $q = "Your best friend's name?"; break;
                        case 'favorite_food': $q = 'Your favorite food?'; break;
                    }
                } else {
                    switch($q) {
                        case 'first_pet': $q = '¿Nombre de tu primera mascota?'; break;
                        case 'hometown': $q = '¿Tu ciudad natal?'; break;
                        case 'best_friend': $q = '¿Nombre de tu mejor amigo?'; break;
                        case 'favorite_food': $q = '¿Tu comida favorita?'; break;
                    }
                }
                echo htmlspecialchars($q);
                ?>
                </label>
                <input type="text" name="recovery_answer" required placeholder="<?= $currentLang === 'es' ? 'Tu respuesta' : 'Your answer' ?>">
            </div>
            <div class="form-group">
                <label><i class="fas fa-lock"></i> <?= $currentLang === 'es' ? 'Nueva Contraseña' : 'New Password' ?></label>
                <input type="password" name="new_password" required minlength="6" placeholder="<?= $currentLang === 'es' ? 'Mínimo 6 caracteres' : 'At least 6 characters' ?>">
            </div>
            <div class="form-group">
                <label><i class="fas fa-lock"></i> <?= $currentLang === 'es' ? 'Confirmar Contraseña' : 'Confirm Password' ?></label>
                <input type="password" name="confirm_password" required>
            </div>
            <button type="submit" class="btn-auth">
                <i class="fas fa-save"></i> <?= $currentLang === 'es' ? 'Cambiar Contraseña' : 'Change Password' ?>
            </button>
        </form>
        <?php else: ?>
        <!-- Step 1: Search user -->
        <form method="post">
            <div class="form-group">
                <label><i class="fas fa-user"></i> <?= $currentLang === 'es' ? 'Usuario o Email' : 'Username or Email' ?></label>
                <input type="text" name="identifier" required placeholder="<?= $currentLang === 'es' ? 'Ingresa tu usuario o email' : 'Enter your username or email' ?>">
            </div>
            <button type="submit" class="btn-auth">
                <i class="fas fa-search"></i> <?= $currentLang === 'es' ? 'Buscar' : 'Search' ?>
            </button>
        </form>
        <?php endif; ?>
        
        <a href="auth.php" class="back-link">
            <i class="fas fa-arrow-left"></i> <?= $currentLang === 'es' ? 'Volver a Iniciar Sesión' : 'Back to Login' ?>
        </a>
    </div>
</body>
</html>
