<?php
/**
 * Subscribe Handler
 */
require_once __DIR__ . '/autoload.php';
Session::start();

$protocol = (!empty($_SERVER['HTTPS']) && $_SERVER['HTTPS'] !== 'off') ? 'https' : 'http';
$host = $_SERVER['HTTP_HOST'] ?? 'localhost';
$scriptDir = rtrim(dirname($_SERVER['SCRIPT_NAME']), '/');
$baseUrl = $protocol . '://' . $host . $scriptDir;

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $email = $_POST['email'] ?? '';
    $name = $_POST['name'] ?? '';
    
    if ($email) {
        $newsletterModel = new Newsletter();
        $result = $newsletterModel->subscribe($email, $name);
        
        // Store message for display
        if ($result['message'] === 'already_subscribed') {
            $_SESSION['subscribe_message'] = 'Este email ya está subscripto';
        } elseif ($result['message'] === 'reactivated') {
            $_SESSION['subscribe_message'] = 'Tu suscripción ha sido reactivada';
        } else {
            $_SESSION['subscribe_message'] = '¡Gracias por suscribirte!';
        }
    }
}

header('Location: ' . $baseUrl . '/');
exit;
