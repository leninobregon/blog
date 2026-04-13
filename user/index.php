<?php
if(session_status() === PHP_SESSION_NONE) {
    session_start();
}
header('Cache-Control: no-cache, no-store, must-revalidate');
header('Pragma: no-cache');
header('Expires: 0');

$userId = isset($_SESSION['user_id']) ? $_SESSION['user_id'] : 0;
if($userId == 0) {
    header('Location: ../auth.php');
    exit;
}
include '../includes/functions.php';

$currentLang = getActiveLanguage();
if(isset($_GET['lang']) && in_array($_GET['lang'], ['es', 'en'])) {
    setLanguage($_GET['lang']);
    $currentLang = $_GET['lang'];
}

$currentTheme = getActiveTheme();
$colors = getThemeColors($currentTheme);
$user = getUser($userId);
