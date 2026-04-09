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
    $host = $_SERVER['HTTP_HOST'];
    $port = '';
    if (isset($_SERVER['SERVER_PORT']) && !in_array($_SERVER['SERVER_PORT'], [80, 443])) {
        $port = ':' . $_SERVER['SERVER_PORT'];
    }
    $fullUrl = $scheme . '://' . $host . $port . $redir;
    header('Location: ' . $fullUrl);
    exit;
}

setlocale(LC_TIME, 'es_ES.UTF-8', 'es_ES', 'spanish');

// Get URI - handle both /path and /proyecto/blog_responsivo/path
$requestUri = $_SERVER['REQUEST_URI'];
$scriptName = $_SERVER['SCRIPT_NAME'];

// Get base path from script name (e.g., /proyecto/blog_responsivo/index.php -> /proyecto/blog_responsivo)
$basePath = rtrim(dirname($scriptName), '/');

// Remove base path from request URI
$uri = str_replace($basePath, '', $requestUri);
$uri = strtok($uri, '?'); // Remove query string
$uri = '/' . ltrim($uri, '/'); // Ensure starts with /

// Normalize: /index.php -> /
if ($uri === '/index.php') $uri = '/';
if ($uri === '') $uri = '/';

$method = $_SERVER['REQUEST_METHOD'];

// Routes
$routes = [
    'GET' => [
        '/' => ['HomeController', 'index'],
        '/index.php' => ['HomeController', 'index'],
        '/post.php' => ['PostController', 'show'],
        '/about.php' => ['AboutController', 'index'],
        '/auth.php' => ['AuthController', 'login'],
        '/recover.php' => ['AuthController', 'recover'],
        '/logout.php' => ['AuthController', 'logout'],
        '/profile.php' => ['ProfileController', 'index'],
    ],
    'POST' => [
        '/auth.php' => ['AuthController', 'login'],
        '/recover.php' => ['AuthController', 'recover'],
        '/subscribe.php' => ['SubscribeController', 'handle'],
        '/profile.php' => ['ProfileController', 'index'],
    ]
];

if (isset($routes[$method][$uri])) {
    [$controller, $action] = $routes[$method][$uri];
    $controllerInstance = new $controller();
    
    if ($action === 'show' && isset($_GET['id'])) {
        $controllerInstance->show((int)$_GET['id']);
    } else {
        $controllerInstance->$action();
    }
    exit;
}

// Handle POST to post.php for comments
if ($method === 'POST' && $uri === '/post.php' && isset($_GET['id'])) {
    require_once __DIR__ . '/autoload.php';
    $postController = new PostController();
    $postController->show((int)$_GET['id']);
    exit;
}

// 404
http_response_code(404);
require __DIR__ . '/views/errors/404.php';
