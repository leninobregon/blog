<?php
/**
 * Subscribe Handler - Compatibilidad
 * Redirige al controlador MVC
 */
require_once __DIR__ . '/autoload.php';
Session::start();

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $email = $_POST['email'] ?? '';
    $name = $_POST['name'] ?? '';
    
    if ($email) {
        $newsletterModel = new Newsletter();
        $newsletterModel->subscribe($email, $name);
    }
}

header('Location: /');
exit;
