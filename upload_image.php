<?php
if (session_status() === PHP_SESSION_NONE) {
    session_start();
}

header('Content-Type: application/json; charset=utf-8');

require_once __DIR__ . '/includes/functions.php';

if (empty($_SESSION['user_id'])) {
    http_response_code(401);
    echo json_encode(['error' => 'No autorizado']);
    exit;
}

$user = getUser((int)$_SESSION['user_id']);
if (!$user || !canPost($user)) {
    http_response_code(403);
    echo json_encode(['error' => 'Sin permisos']);
    exit;
}

if ($_SERVER['REQUEST_METHOD'] !== 'POST' || empty($_FILES['file'])) {
    http_response_code(400);
    echo json_encode(['error' => 'Archivo no recibido']);
    exit;
}

$file = $_FILES['file'];
if (!isset($file['error']) || $file['error'] !== UPLOAD_ERR_OK) {
    http_response_code(400);
    echo json_encode(['error' => 'Error al subir archivo']);
    exit;
}

$allowed = ['jpg', 'jpeg', 'png', 'gif', 'webp'];
$ext = strtolower(pathinfo($file['name'] ?? '', PATHINFO_EXTENSION));
if (!in_array($ext, $allowed, true)) {
    http_response_code(415);
    echo json_encode(['error' => 'Formato no permitido']);
    exit;
}

$relativePath = uploadImage($file); // returns uploads/filename.ext
if (!$relativePath) {
    http_response_code(500);
    echo json_encode(['error' => 'No se pudo guardar la imagen']);
    exit;
}

// Build project-root-relative URL, e.g. /proyecto/blog_responsivo/uploads/xxx.png
$basePath = rtrim(dirname($_SERVER['SCRIPT_NAME'] ?? ''), '/');
$location = $basePath . '/' . ltrim($relativePath, '/');

echo json_encode(['location' => $location]);
