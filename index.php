<?php
/**
 * Blog de Tutoriales - MVC Entry Point (index.php)
 */

// Load autoloader
require_once __DIR__ . '/autoload.php';

// Start session
Session::start();

// Handle language switch
if (isset($_GET['lang'])) {
    setlocale(LC_TIME, 'es_ES.UTF-8', 'es_ES', 'spanish');
    if (in_array($_GET['lang'], ['es', 'en'])) {
        $_SESSION['language'] = $_GET['lang'];
        setcookie('language', $_GET['lang'], time() + 31536000, '/');
    }
    $redir = strtok($_SERVER['REQUEST_URI'], '?');
    $redir = rtrim($redir, '/');
    if (empty($redir)) $redir = '/';
    
    $scheme = isset($_SERVER['HTTPS']) && $_SERVER['HTTPS'] === 'on' ? 'https' : 'http';
    $host = $_SERVER['HTTP_HOST']; // Ya incluye el puerto si existe
    $fullUrl = $scheme . '://' . $host . $redir;
    header('Location: ' . $fullUrl);
    exit;
}

setlocale(LC_TIME, 'es_ES.UTF-8', 'es_ES', 'spanish');

// Normalize URI considering subdirectory installation
$requestUri = $_SERVER['REQUEST_URI'] ?? '/';
$scriptName = $_SERVER['SCRIPT_NAME'] ?? '/index.php';
$basePath = rtrim(str_replace('\\', '/', dirname($scriptName)), '/');
$path = parse_url($requestUri, PHP_URL_PATH) ?: '/';
$path = str_replace('\\', '/', $path);
if ($basePath !== '' && strpos($path, $basePath) === 0) {
    $path = substr($path, strlen($basePath));
}
$path = '/' . ltrim($path, '/');
if ($path === '/index.php' || $path === '') {
    $path = '/';
}

$method = $_SERVER['REQUEST_METHOD'] ?? 'GET';

// Normalize auxiliary HTTP methods
if ($method === 'HEAD') {
    // Reuse GET routing logic for HEAD
    $method = 'GET';
}

if ($method === 'OPTIONS') {
    http_response_code(204);
    exit;
}

$router = new Router();
$router->get('/', 'HomeController', 'index');
$router->get('/index.php', 'HomeController', 'index');
$router->get('/about.php', 'AboutController', 'index');
$router->get('/auth.php', 'AuthController', 'login');
$router->post('/auth.php', 'AuthController', 'login');
$router->get('/recover.php', 'AuthController', 'recover');
$router->post('/recover.php', 'AuthController', 'recover');
$router->get('/logout.php', 'AuthController', 'logout');
$router->get('/profile.php', 'ProfileController', 'index');
$router->post('/profile.php', 'ProfileController', 'index');
$router->get('/search.php', 'HomeController', 'search');
$router->post('/subscribe.php', 'SubscribeController', 'handle');

// Keep post.php compatibility (GET detail + POST comment submit)
$router->map('GET', '/post.php', function () {
    if (!isset($_GET['id'])) {
        header('Location: /');
        exit;
    }
    (new PostController())->show((int)$_GET['id']);
});
$router->map('POST', '/post.php', function () {
    if (!isset($_GET['id'])) {
        header('Location: /');
        exit;
    }
    (new PostController())->show((int)$_GET['id']);
});

$router->dispatch($path, $method);
