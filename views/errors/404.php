<?php
/**
 * 404 Error View - Self-contained (no depende de variables externas)
 */
http_response_code(404);

// Get language
$Lang = 'es';
if (isset($_COOKIE['language']) && in_array($_COOKIE['language'], ['es', 'en'])) {
    $Lang = $_COOKIE['language'];
} elseif (isset($_SESSION['language'])) {
    $Lang = $_SESSION['language'];
}

// Auto-detect base URL
$protocol = (!empty($_SERVER['HTTPS']) && $_SERVER['HTTPS'] !== 'off') ? 'https' : 'http';
$host = $_SERVER['HTTP_HOST'] ?? 'localhost';
$scriptDir = dirname($_SERVER['SCRIPT_NAME']);
$baseUrl = $protocol . '://' . $host . $scriptDir;
?>
<!DOCTYPE html>
<html lang="<?= $Lang ?>">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>404 - Página no encontrada</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { 
            font-family: 'Poppins', sans-serif; 
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }
        .error-container {
            background: white;
            border-radius: 20px;
            padding: 3rem;
            text-align: center;
            box-shadow: 0 25px 50px rgba(0,0,0,0.2);
            max-width: 500px;
        }
        .error-code { font-size: 8rem; font-weight: 700; color: #667eea; line-height: 1; }
        .error-title { font-size: 1.5rem; color: #333; margin: 1rem 0; }
        .error-text { color: #666; margin-bottom: 2rem; }
        .btn-home {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            padding: 1rem 2rem;
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            text-decoration: none;
            border-radius: 50px;
            font-weight: 600;
            transition: transform 0.3s;
        }
        .btn-home:hover { transform: scale(1.05); }
    </style>
</head>
<body>
    <div class="error-container">
        <div class="error-code">404</div>
        <h2 class="error-title"><?= $Lang === 'es' ? 'Página no encontrada' : 'Page not found' ?></h2>
        <p class="error-text"><?= $Lang === 'es' ? 'La página que buscas no existe o ha sido movida.' : 'The page you are looking for does not exist or has been moved.' ?></p>
        <a href="<?= $baseUrl ?? '' ?>/" class="btn-home"><i class="fas fa-home"></i> <?= $Lang === 'es' ? 'Volver al Inicio' : 'Back to Home' ?></a>
    </div>
</body>
</html>
