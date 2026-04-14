<?php
$basePath = dirname(__DIR__);

// Only define CONFIG if not already defined (for MVC compatibility)
if (!defined('CONFIG')) {
    define('CONFIG', include $basePath . '/config.php');
}

// Load theme colors (shared with MVC core) - only if not already loaded
if (!function_exists('getThemeColors')) {
    require_once $basePath . '/core/theme_colors.php';
}

// ========== FUNCIONES DE SEGURIDAD ==========

// Sanitizar entrada de usuario
if (!function_exists('sanitize')) {
function sanitize($input, $type = 'string') {
    if (is_array($input)) {
        $result = [];
        foreach ($input as $k => $v) {
            $result[$k] = sanitize($v, $type);
        }
        return $result;
    }
    
    $input = trim($input);
    
    switch ($type) {
        case 'email':
            return filter_var($input, FILTER_SANITIZE_EMAIL);
        case 'url':
            return filter_var($input, FILTER_SANITIZE_URL);
        case 'int':
            return (int) preg_replace('/[^0-9]/', '', $input);
        case 'html':
            return htmlspecialchars($input, ENT_QUOTES, 'UTF-8');
        case 'username':
            return preg_replace('/[^a-zA-Z0-9_]/', '', $input);
        default:
            return htmlspecialchars($input, ENT_QUOTES, 'UTF-8');
    }
}
}

// CSRF Token functions
if (!function_exists('csrf_token')) {
function csrf_token() {
    if (session_status() === PHP_SESSION_NONE) {
        session_start();
    }
    if (!isset($_SESSION['csrf_token'])) {
        $_SESSION['csrf_token'] = bin2hex(random_bytes(32));
    }
    return $_SESSION['csrf_token'];
}
}

if (!function_exists('csrf_field')) {
function csrf_field() {
    return '<input type="hidden" name="csrf_token" value="' . csrf_token() . '">';
}
}

if (!function_exists('verify_csrf')) {
function verify_csrf($token) {
    if (session_status() === PHP_SESSION_NONE) {
        session_start();
    }
    return isset($_SESSION['csrf_token']) && hash_equals($_SESSION['csrf_token'], $token);
}
}

if (!function_exists('isAdminAuthenticated')) {
function isAdminAuthenticated(): bool {
    if (session_status() === PHP_SESSION_NONE) {
        session_start();
    }

    // Flujo legacy de admin
    if (!empty($_SESSION['logged'])) {
        if (!empty($_SESSION['role']) && $_SESSION['role'] !== 'admin') {
            return false;
        }
        if (empty($_SESSION['role'])) {
            $_SESSION['role'] = 'admin';
        }
        return true;
    }

    // Flujo MVC unificado
    if (!empty($_SESSION['user_id']) && (($_SESSION['role'] ?? '') === 'admin')) {
        // Compatibilidad hacia atrás para pantallas antiguas.
        $_SESSION['logged'] = true;
        return true;
    }

    return false;
}
}

if (!function_exists('getClientIpAddress')) {
function getClientIpAddress(): string {
    return $_SERVER['REMOTE_ADDR'] ?? 'unknown';
}
}

if (!function_exists('loginThrottleFilePath')) {
function loginThrottleFilePath(): string {
    return rtrim(sys_get_temp_dir(), DIRECTORY_SEPARATOR) . DIRECTORY_SEPARATOR . 'blog_login_throttle.json';
}
}

if (!function_exists('readLoginThrottleData')) {
function readLoginThrottleData(): array {
    $file = loginThrottleFilePath();
    if (!file_exists($file)) {
        return [];
    }
    $raw = @file_get_contents($file);
    if ($raw === false || $raw === '') {
        return [];
    }
    $data = json_decode($raw, true);
    return is_array($data) ? $data : [];
}
}

if (!function_exists('writeLoginThrottleData')) {
function writeLoginThrottleData(array $data): void {
    $file = loginThrottleFilePath();
    @file_put_contents($file, json_encode($data, JSON_UNESCAPED_UNICODE), LOCK_EX);
}
}

if (!function_exists('buildLoginThrottleKey')) {
function buildLoginThrottleKey(string $identifier, string $scope = 'global'): string {
    $ip = getClientIpAddress();
    $id = mb_strtolower(trim($identifier));
    if ($id === '') {
        $id = 'empty';
    }
    return $scope . '|' . $ip . '|' . $id;
}
}

if (!function_exists('resolveLoginThrottleSettings')) {
function resolveLoginThrottleSettings(?int $maxAttempts = null, ?int $windowSeconds = null, ?int $lockSeconds = null): array {
    $cfg = defined('CONFIG') ? CONFIG : [];
    $throttle = $cfg['login_throttle'] ?? [];

    $cfgMax = (int)($throttle['max_attempts'] ?? 5);
    $cfgWindowMin = (int)($throttle['window_minutes'] ?? 15);
    $cfgLockMin = (int)($throttle['lock_minutes'] ?? 15);

    $max = $maxAttempts ?? $cfgMax;
    $window = $windowSeconds ?? ($cfgWindowMin * 60);
    $lock = $lockSeconds ?? ($cfgLockMin * 60);

    return [
        'max_attempts' => max(1, (int)$max),
        'window_seconds' => max(60, (int)$window),
        'lock_seconds' => max(60, (int)$lock)
    ];
}
}

if (!function_exists('getLoginThrottleStatus')) {
function getLoginThrottleStatus(string $identifier, string $scope = 'global', ?int $maxAttempts = null, ?int $windowSeconds = null): array {
    $settings = resolveLoginThrottleSettings($maxAttempts, $windowSeconds, null);
    $maxAttempts = $settings['max_attempts'];
    $windowSeconds = $settings['window_seconds'];
    $now = time();
    $key = buildLoginThrottleKey($identifier, $scope);
    $data = readLoginThrottleData();
    $entry = $data[$key] ?? ['attempts' => [], 'blocked_until' => 0];

    $attempts = array_values(array_filter((array)($entry['attempts'] ?? []), function ($ts) use ($now, $windowSeconds) {
        return is_int($ts) && $ts > ($now - $windowSeconds);
    }));
    $blockedUntil = (int)($entry['blocked_until'] ?? 0);

    if ($blockedUntil > $now) {
        return [
            'blocked' => true,
            'retry_after' => $blockedUntil - $now,
            'remaining' => 0
        ];
    }

    $remaining = max(0, $maxAttempts - count($attempts));
    return [
        'blocked' => false,
        'retry_after' => 0,
        'remaining' => $remaining
    ];
}
}

if (!function_exists('registerLoginFailure')) {
function registerLoginFailure(string $identifier, string $scope = 'global', ?int $maxAttempts = null, ?int $windowSeconds = null, ?int $lockSeconds = null): array {
    $settings = resolveLoginThrottleSettings($maxAttempts, $windowSeconds, $lockSeconds);
    $maxAttempts = $settings['max_attempts'];
    $windowSeconds = $settings['window_seconds'];
    $lockSeconds = $settings['lock_seconds'];
    $now = time();
    $key = buildLoginThrottleKey($identifier, $scope);
    $data = readLoginThrottleData();
    $entry = $data[$key] ?? ['attempts' => [], 'blocked_until' => 0];

    $attempts = array_values(array_filter((array)($entry['attempts'] ?? []), function ($ts) use ($now, $windowSeconds) {
        return is_int($ts) && $ts > ($now - $windowSeconds);
    }));
    $attempts[] = $now;

    $blockedUntil = 0;
    if (count($attempts) >= $maxAttempts) {
        $blockedUntil = $now + $lockSeconds;
        $attempts = [];
    }

    $data[$key] = [
        'attempts' => $attempts,
        'blocked_until' => $blockedUntil
    ];
    writeLoginThrottleData($data);

    return [
        'blocked' => $blockedUntil > $now,
        'retry_after' => $blockedUntil > $now ? ($blockedUntil - $now) : 0,
        'remaining' => max(0, $maxAttempts - count($attempts))
    ];
}
}

if (!function_exists('clearLoginFailures')) {
function clearLoginFailures(string $identifier, string $scope = 'global'): void {
    $key = buildLoginThrottleKey($identifier, $scope);
    $data = readLoginThrottleData();
    if (isset($data[$key])) {
        unset($data[$key]);
        writeLoginThrottleData($data);
    }
}
}

// Obtener URL del sitio automáticamente
if (!function_exists('getSiteURL')) {
function getSiteURL() {
    $scheme = (!empty($_SERVER['HTTPS']) && $_SERVER['HTTPS'] !== 'off') ? 'https' : 'http';
    $host = $_SERVER['HTTP_HOST'] ?? $_SERVER['SERVER_NAME'] ?? 'localhost';
    $port = $_SERVER['SERVER_PORT'] ?? 80;
    $basePath = dirname($_SERVER['SCRIPT_NAME'] ?? '');
    if ($basePath === '/' || $basePath === '\\') {
        $basePath = '';
    }
    
    $url = $scheme . '://' . $host;
    if ($port != 80 && $port != 443) {
        $url .= ':' . $port;
    }
    $url .= rtrim($basePath, '/');
    
    return rtrim($url, '/');
}
}

// Validar contraseña segura
if (!function_exists('validate_password')) {
function validate_password($password) {
    $errors = [];
    if (strlen($password) < 8) {
        $errors[] = 'Mínimo 8 caracteres';
    }
    if (!preg_match('/[A-Z]/', $password)) {
        $errors[] = 'Al menos una mayúscula';
    }
    if (!preg_match('/[a-z]/', $password)) {
        $errors[] = 'Al menos una minúscula';
    }
    if (!preg_match('/[0-9]/', $password)) {
        $errors[] = 'Al menos un número';
    }
    return $errors;
}
}

// ========== FIN FUNCIONES DE SEGURIDAD ==========

if (!function_exists('getDB')) {
function getDB() {
    static $pdo = null;
    if ($pdo === null) {
        $db = CONFIG['db'];
        $dsn = "mysql:host={$db['host']};dbname={$db['name']};charset=utf8mb4";
        $pdo = new PDO($dsn, $db['user'], $db['pass']);
        $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    }
    return $pdo;
}
}

if (!function_exists('getActiveTheme')) {
function getActiveTheme() {
    $validThemes = ['white','blue','dark-blue','black','green','red','purple','orange','pink','teal','yellow','cyan','brown','indigo','lime','amber','rose','slate','emerald','sky','violet'];
    if(isset($_COOKIE['theme']) && in_array($_COOKIE['theme'], $validThemes)) return $_COOKIE['theme'];
    return CONFIG['theme'] ?? 'blue';
}
}

if (!function_exists('renderStyles')) {
function renderStyles() {
    $theme = getActiveTheme();
    $colors = getThemeColors($theme);
    $css = ":root {";
    foreach ($colors as $key => $val) $css .= "--$key: $val;";
    $css .= "}";
    return $css;
}
}

if (!function_exists('getPosts')) {
function getPosts($category = null, $limit = 10, $offset = 0) {
    $pdo = getDB();
    $limit = (int)$limit;
    $offset = (int)$offset;
    if ($category) {
        $sql = "SELECT p.*, u.username as author_name FROM posts p LEFT JOIN users u ON p.author_id = u.id WHERE p.category = ? ORDER BY p.created_at DESC LIMIT $limit OFFSET $offset";
        $stmt = $pdo->prepare($sql);
        $stmt->execute([$category]);
    } else {
        $sql = "SELECT p.*, u.username as author_name FROM posts p LEFT JOIN users u ON p.author_id = u.id ORDER BY p.created_at DESC LIMIT $limit OFFSET $offset";
        $stmt = $pdo->prepare($sql);
        $stmt->execute([]);
    }
    return $stmt->fetchAll(PDO::FETCH_ASSOC);
}
}

if (!function_exists('searchPosts')) {
function searchPosts($query, $limit = 10, $offset = 0) {
    $pdo = getDB();
    $limit = (int)$limit;
    $offset = (int)$offset;
    $query = trim($query);
    
    // Si la consulta esta vacia, no retornar nada
    if (empty($query)) {
        return [];
    }
    
    // Separar palabras por espacios o +
    $palabras = preg_split('/[\s\+]+/', $query);
    $palabras = array_filter($palabras, function($p) { return trim($p) !== ''; });
    $palabras = array_values($palabras);
    
    // SI hay 2 o mas palabras: buscar posts con TODAS las palabras (AND)
    if (count($palabras) >= 2) {
        $conditions = [];
        $params = [];
        foreach ($palabras as $palabra) {
            $palabra = trim($palabra);
            if (empty($palabra)) continue;
            // Buscar solo en titulo y contenido (no en category)
            $conditions[] = "(p.title LIKE ? OR p.content LIKE ?)";
            $params[] = "%$palabra%";
            $params[] = "%$palabra%";
        }
        if (!empty($conditions)) {
            $whereClause = implode(' AND ', $conditions);
            $sql = "SELECT p.*, u.username as author_name FROM posts p LEFT JOIN users u ON p.author_id = u.id WHERE $whereClause ORDER BY p.created_at DESC LIMIT $limit OFFSET $offset";
            $stmt = $pdo->prepare($sql);
            $stmt->execute($params);
            return $stmt->fetchAll(PDO::FETCH_ASSOC);
        }
    }
    
    // 1 palabra: buscar solo en titulo y contenido
    $search = "%$query%";
    $sql = "SELECT p.*, u.username as author_name FROM posts p LEFT JOIN users u ON p.author_id = u.id WHERE p.title LIKE ? OR p.content LIKE ? ORDER BY p.created_at DESC LIMIT $limit OFFSET $offset";
    $stmt = $pdo->prepare($sql);
    $stmt->execute([$search, $search]);
    return $stmt->fetchAll(PDO::FETCH_ASSOC);
}
}

if (!function_exists('searchPostsAdvanced')) {
function searchPostsAdvanced($query, $limit = 10, $offset = 0) {
    $pdo = getDB();
    $limit = (int)$limit;
    $offset = (int)$offset;
    $query = trim($query);
    
    // Si esta vacio, no retornar nada
    if (empty($query)) {
        return [];
    }
    
    $palabras = preg_split('/[\s\+]+/', $query);
    $palabras = array_filter($palabras, function($p) { return trim($p) !== ''; });
    $palabras = array_values($palabras);
    
    // Busqueda avanzada: TODAS las palabras deben estar (AND)
    if (count($palabras) >= 1) {
        $conditions = [];
        $params = [];
        foreach ($palabras as $palabra) {
            $palabra = trim($palabra);
            if (empty($palabra)) continue;
            // Solo buscar en titulo y contenido
            $conditions[] = "(p.title LIKE ? OR p.content LIKE ?)";
            $params[] = "%$palabra%";
            $params[] = "%$palabra%";
        }
        if (!empty($conditions)) {
            $whereClause = implode(' AND ', $conditions);
            $sql = "SELECT p.*, u.username as author_name FROM posts p LEFT JOIN users u ON p.author_id = u.id WHERE $whereClause ORDER BY p.created_at DESC LIMIT $limit OFFSET $offset";
            $stmt = $pdo->prepare($sql);
            $stmt->execute($params);
            return $stmt->fetchAll(PDO::FETCH_ASSOC);
        }
    }
    
    return [];
}
}

if (!function_exists('getPostsByMonth')) {
function getPostsByMonth($yearMonth, $limit = 10, $offset = 0) {
    $pdo = getDB();
    $limit = (int)$limit;
    $offset = (int)$offset;
    $sql = "SELECT p.*, u.username as author_name FROM posts p LEFT JOIN users u ON p.author_id = u.id WHERE DATE_FORMAT(p.created_at, '%Y-%m') = ? ORDER BY p.created_at DESC LIMIT $limit OFFSET $offset";
    $stmt = $pdo->prepare($sql);
    $stmt->execute([$yearMonth]);
    return $stmt->fetchAll(PDO::FETCH_ASSOC);
}
}

if (!function_exists('getPost')) {
function getPost($id) {
    $pdo = getDB();
    $stmt = $pdo->prepare("SELECT p.*, u.username as author_name FROM posts p LEFT JOIN users u ON p.author_id = u.id WHERE p.id = ?");
    $stmt->execute([$id]);
    return $stmt->fetch(PDO::FETCH_ASSOC);
}
}

if (!function_exists('getAllPostsList')) {
function getAllPostsList() {
    $pdo = getDB();
    $stmt = $pdo->query("SELECT p.*, u.username as author_name FROM posts p LEFT JOIN users u ON p.author_id = u.id ORDER BY p.created_at DESC");
    return $stmt->fetchAll(PDO::FETCH_ASSOC);
}
}

if (!function_exists('getCategories')) {
function getCategories() {
    $pdo = getDB();
    return $pdo->query("SELECT DISTINCT category FROM posts ORDER BY category")->fetchAll(PDO::FETCH_COLUMN);
}
}

if (!function_exists('getAbout')) {
function getAbout() {
    $pdo = getDB();
    $stmt = $pdo->query("SELECT * FROM about WHERE id = 1");
    return $stmt->fetch(PDO::FETCH_ASSOC);
}
}

if (!function_exists('updateAbout')) {
function updateAbout($title, $subtitle, $description, $experience, $goals, $youtube, $facebook, $twitter, $telegram, $email, $photo = null) {
    $pdo = getDB();
    if($photo) {
        $stmt = $pdo->prepare("UPDATE about SET title=?, subtitle=?, description=?, experience=?, goals=?, youtube_url=?, facebook_url=?, twitter_url=?, telegram_url=?, email=?, photo=? WHERE id=1");
        return $stmt->execute([$title, $subtitle, $description, $experience, $goals, $youtube, $facebook, $twitter, $telegram, $email, $photo]);
    } else {
        $stmt = $pdo->prepare("UPDATE about SET title=?, subtitle=?, description=?, experience=?, goals=?, youtube_url=?, facebook_url=?, twitter_url=?, telegram_url=?, email=? WHERE id=1");
        return $stmt->execute([$title, $subtitle, $description, $experience, $goals, $youtube, $facebook, $twitter, $telegram, $email]);
    }
}
}

if (!function_exists('incrementViews')) {
function incrementViews($postId) {
    $pdo = getDB();
    $stmt = $pdo->prepare("UPDATE posts SET views = views + 1 WHERE id = ?");
    return $stmt->execute([$postId]);
}
}

if (!function_exists('incrementTotalHits')) {
function incrementTotalHits() {
    $pdo = getDB();
    $pdo->exec("UPDATE site_stats SET total_hits = total_hits + 1 WHERE id = 1");
}
}

if (!function_exists('getTotalHits')) {
function getTotalHits() {
    $pdo = getDB();
    return $pdo->query("SELECT total_hits FROM site_stats WHERE id = 1")->fetchColumn();
}
}

if (!function_exists('savePost')) {
function savePost($title, $category, $content, $image = null, $video = null, $authorId = null) {
    $pdo = getDB();
    $stmt = $pdo->prepare("INSERT INTO posts (title, category, content, image, video, author_id, created_at) VALUES (?, ?, ?, ?, ?, ?, NOW())");
    $ok = $stmt->execute([$title, $category, $content, $image, $video, $authorId]);
    if (!$ok) {
        return false;
    }
    return (int)$pdo->lastInsertId();
}
}

if (!function_exists('updatePost')) {
function updatePost($id, $title, $category, $content, $image = null, $video = null) {
    $pdo = getDB();
    $stmt = $pdo->prepare("UPDATE posts SET title = ?, category = ?, content = ?, image = COALESCE(?, image), video = COALESCE(?, video) WHERE id = ?");
    return $stmt->execute([$title, $category, $content, $image, $video, $id]);
}
}

if (!function_exists('deletePost')) {
function deletePost($id) {
    $pdo = getDB();
    $stmt = $pdo->prepare("DELETE FROM posts WHERE id = ?");
    return $stmt->execute([$id]);
}
}

if (!function_exists('uploadImage')) {
function uploadImage($file) {
    if (!isset($file['error']) || $file['error'] !== UPLOAD_ERR_OK) {
        return null;
    }

    $maxBytes = 5 * 1024 * 1024; // 5MB
    if (!isset($file['size']) || (int)$file['size'] <= 0 || (int)$file['size'] > $maxBytes) {
        return null;
    }

    $tmp = $file['tmp_name'] ?? '';
    if (!is_uploaded_file($tmp)) {
        return null;
    }

    $finfo = finfo_open(FILEINFO_MIME_TYPE);
    $mime = $finfo ? finfo_file($finfo, $tmp) : '';
    if ($finfo) {
        finfo_close($finfo);
    }

    $allowedMimes = [
        'image/jpeg' => 'jpg',
        'image/png' => 'png',
        'image/gif' => 'gif',
        'image/webp' => 'webp'
    ];

    if (!isset($allowedMimes[$mime])) {
        return null;
    }

    $ext = $allowedMimes[$mime];
    $name = uniqid('img_', true) . '.' . $ext;
    $uploadDir = dirname(__DIR__) . '/uploads/';

    if (!is_dir($uploadDir) && !mkdir($uploadDir, 0777, true) && !is_dir($uploadDir)) {
        return null;
    }

    if (!move_uploaded_file($tmp, $uploadDir . $name)) {
        return null;
    }
    return 'uploads/' . $name;
}
}

if (!function_exists('registerUser')) {
function registerUser($username, $email, $password, $firstName = '', $lastName = '', $phone = '', $recoveryQuestion = '', $recoveryAnswer = '') {
    $pdo = getDB();
    $hash = password_hash($password, PASSWORD_DEFAULT);
    try {
        $stmt = $pdo->prepare("INSERT INTO users (username, email, password, role, first_name, last_name, phone, recovery_question, recovery_answer) VALUES (?, ?, ?, 'user', ?, ?, ?, ?, ?)");
        return $stmt->execute([$username, $email, $hash, $firstName, $lastName, $phone, $recoveryQuestion, $recoveryAnswer]);
    } catch (Exception $e) { return false; }
}
}

if (!function_exists('loginUser')) {
function loginUser($emailOrUsername, $password) {
    $pdo = getDB();
    $stmt = $pdo->prepare("SELECT * FROM users WHERE email = ? OR username = ?");
    $stmt->execute([$emailOrUsername, $emailOrUsername]);
    $user = $stmt->fetch(PDO::FETCH_ASSOC);
    if ($user && password_verify($password, $user['password'])) return $user;
    return null;
}
}

if (!function_exists('getUser')) {
function getUser($id) {
    $pdo = getDB();
    $stmt = $pdo->prepare("SELECT * FROM users WHERE id = ?");
    $stmt->execute([$id]);
    return $stmt->fetch(PDO::FETCH_ASSOC);
}
}

if (!function_exists('getComments')) {
function getComments($postId) {
    $pdo = getDB();
    $stmt = $pdo->prepare("SELECT c.*, u.username, u.avatar, u.first_name, u.last_name FROM comments c JOIN users u ON c.user_id = u.id WHERE c.post_id = ? ORDER BY c.created_at DESC");
    $stmt->execute([$postId]);
    return $stmt->fetchAll(PDO::FETCH_ASSOC);
}
}

if (!function_exists('addComment')) {
function addComment($postId, $userId, $content) {
    $pdo = getDB();
    $stmt = $pdo->prepare("INSERT INTO comments (post_id, user_id, content) VALUES (?, ?, ?)");
    $result = $stmt->execute([$postId, $userId, $content]);
    
    // Get user info for audit
    $userStmt = $pdo->prepare("SELECT username FROM users WHERE id = ?");
    $userStmt->execute([$userId]);
    $user = $userStmt->fetch(PDO::FETCH_ASSOC);
    
    // Log comment
    logAudit('comment_create', $userId, $user['username'] ?? 'unknown', 'post.php', "Comment added to post ID: $postId");
    
    return $result;
}
}

if (!function_exists('getCommentById')) {
function getCommentById($commentId) {
    $pdo = getDB();
    $stmt = $pdo->prepare("SELECT * FROM comments WHERE id = ?");
    $stmt->execute([$commentId]);
    return $stmt->fetch(PDO::FETCH_ASSOC);
}
}

if (!function_exists('updateComment')) {
function updateComment($commentId, $userId, $content, $isAdmin = false) {
    $pdo = getDB();
    if ($isAdmin) {
        $stmt = $pdo->prepare("UPDATE comments SET content = ? WHERE id = ?");
        $result = $stmt->execute([$content, $commentId]);
    } else {
        $stmt = $pdo->prepare("UPDATE comments SET content = ? WHERE id = ? AND user_id = ?");
        $result = $stmt->execute([$content, $commentId, $userId]);
    }
    if ($result) {
        logAudit('comment_update', $userId, $_SESSION['username'] ?? 'unknown', 'post.php', "Comment updated (ID: $commentId)");
    }
    return $result;
}
}

if (!function_exists('deleteCommentById')) {
function deleteCommentById($commentId, $userId, $isAdmin = false) {
    $pdo = getDB();
    if ($isAdmin) {
        $stmt = $pdo->prepare("DELETE FROM comments WHERE id = ?");
        $result = $stmt->execute([$commentId]);
    } else {
        $stmt = $pdo->prepare("DELETE FROM comments WHERE id = ? AND user_id = ?");
        $result = $stmt->execute([$commentId, $userId]);
    }
    if ($result) {
        logAudit('comment_delete', $userId, $_SESSION['username'] ?? 'unknown', 'post.php', "Comment deleted (ID: $commentId)");
    }
    return $result;
}
}

if (!function_exists('canPost')) {
function canPost($user) {
    return in_array($user['role'], ['admin', 'author']);
}
}

if (!function_exists('getAllUsers')) {
function getAllUsers() {
    $pdo = getDB();
    return $pdo->query("SELECT * FROM users ORDER BY created_at DESC")->fetchAll(PDO::FETCH_ASSOC);
}
}

if (!function_exists('updateUser')) {
function updateUser($id, $username, $email, $role, $firstName = '', $lastName = '', $bio = '', $facebook = '', $twitter = '', $telegram = '', $instagram = '', $youtube = '', $linkedin = '', $website = '') {
    $pdo = getDB();
    $stmt = $pdo->prepare("UPDATE users SET username = ?, email = ?, role = ?, first_name = ?, last_name = ?, bio = ?, facebook = ?, twitter = ?, telegram = ?, instagram = ?, youtube = ?, linkedin = ?, website = ? WHERE id = ?");
    return $stmt->execute([$username, $email, $role, $firstName, $lastName, $bio, $facebook, $twitter, $telegram, $instagram, $youtube, $linkedin, $website, $id]);
}
}

if (!function_exists('updateUserProfile')) {
function updateUserProfile($id, $firstName, $lastName, $bio, $facebook, $twitter, $telegram, $instagram, $youtube, $linkedin, $website) {
    $pdo = getDB();
    $stmt = $pdo->prepare("UPDATE users SET first_name = ?, last_name = ?, bio = ?, facebook = ?, twitter = ?, telegram = ?, instagram = ?, youtube = ?, linkedin = ?, website = ? WHERE id = ?");
    return $stmt->execute([$firstName, $lastName, $bio, $facebook, $twitter, $telegram, $instagram, $youtube, $linkedin, $website, $id]);
}
}

if (!function_exists('updateUserPassword')) {
function updateUserPassword($id, $newPassword) {
    $pdo = getDB();
    $hash = password_hash($newPassword, PASSWORD_DEFAULT);
    $stmt = $pdo->prepare("UPDATE users SET password = ? WHERE id = ?");
    return $stmt->execute([$hash, $id]);
}
}

if (!function_exists('deleteUser')) {
function deleteUser($id) {
    $pdo = getDB();
    $stmt = $pdo->prepare("DELETE FROM users WHERE id = ?");
    return $stmt->execute([$id]);
}
}

// Newsletter functions
if (!function_exists('subscribeNewsletter')) {
function subscribeNewsletter($email, $name = '') {
    $pdo = getDB();
    $token = bin2hex(random_bytes(32));
    try {
        $stmt = $pdo->prepare("INSERT INTO newsletter (email, name, token) VALUES (?, ?, ?) ON DUPLICATE KEY UPDATE active=1, name=VALUES(name)");
        return $stmt->execute([$email, $name, $token]);
    } catch (Exception $e) { return false; }
}
}

if (!function_exists('unsubscribeNewsletter')) {
function unsubscribeNewsletter($email) {
    $pdo = getDB();
    $stmt = $pdo->prepare("UPDATE newsletter SET active = 0 WHERE email = ?");
    return $stmt->execute([$email]);
}
}

if (!function_exists('getNewsletterSubscribers')) {
function getNewsletterSubscribers($activeOnly = true) {
    $pdo = getDB();
    if ($activeOnly) {
        return $pdo->query("SELECT * FROM newsletter WHERE active = 1 ORDER BY created_at DESC")->fetchAll(PDO::FETCH_ASSOC);
    }
    return $pdo->query("SELECT * FROM newsletter ORDER BY created_at DESC")->fetchAll(PDO::FETCH_ASSOC);
}
}

if (!function_exists('logVisit')) {
function logVisit($page, $ip, $userAgent, $referer = '') {
    $pdo = getDB();
    $stmt = $pdo->prepare("INSERT INTO visit_logs (page, ip, user_agent, referer) VALUES (?, ?, ?, ?)");
    $stmt->execute([$page, $ip, $userAgent, $referer]);
}
}

if (!function_exists('logAudit')) {
function logAudit($action, $userId = null, $username = 'guest', $page = '', $details = '') {
    $pdo = getDB();
    $ip = $_SERVER['REMOTE_ADDR'] ?? 'unknown';
    $userAgent = $_SERVER['HTTP_USER_AGENT'] ?? '';
    $stmt = $pdo->prepare("INSERT INTO audit_logs (action, user_id, username, ip_address, user_agent, page, details) VALUES (?, ?, ?, ?, ?, ?, ?)");
    $stmt->execute([$action, $userId, $username, $ip, $userAgent, $page, $details]);
}
}

if (!function_exists('getAuditLogs')) {
function getAuditLogs($limit = 50) {
    $pdo = getDB();
    return $pdo->query("SELECT * FROM audit_logs ORDER BY created_at DESC LIMIT $limit")->fetchAll(PDO::FETCH_ASSOC);
}
}

if (!function_exists('getVisitStats')) {
function getVisitStats($days = 30) {
    $pdo = getDB();
    $sql = "SELECT DATE(created_at) as date, COUNT(*) as visits FROM visit_logs WHERE created_at >= DATE_SUB(NOW(), INTERVAL ? DAY) GROUP BY DATE(created_at) ORDER BY date";
    $stmt = $pdo->prepare($sql);
    $stmt->execute([$days]);
    return $stmt->fetchAll(PDO::FETCH_ASSOC);
}
}

if (!function_exists('getTotalVisits')) {
function getTotalVisits() {
    $pdo = getDB();
    return $pdo->query("SELECT COUNT(*) FROM visit_logs")->fetchColumn();
}
}

if (!function_exists('getTopPages')) {
function getTopPages($limit = 10) {
    $pdo = getDB();
    return $pdo->query("SELECT page, COUNT(*) as visits FROM visit_logs GROUP BY page ORDER BY visits DESC LIMIT $limit")->fetchAll(PDO::FETCH_ASSOC);
}
}

if (!function_exists('getTotalPosts')) {
function getTotalPosts() {
    $pdo = getDB();
    return $pdo->query("SELECT COUNT(*) FROM posts")->fetchColumn();
}
}

if (!function_exists('getTotalUsers')) {
function getTotalUsers() {
    $pdo = getDB();
    return $pdo->query("SELECT COUNT(*) FROM users")->fetchColumn();
}
}

if (!function_exists('getTotalComments')) {
function getTotalComments() {
    $pdo = getDB();
    return $pdo->query("SELECT COUNT(*) FROM comments")->fetchColumn();
}
}

if (!function_exists('getPostsByCategory')) {
function getPostsByCategory() {
    $pdo = getDB();
    return $pdo->query("SELECT category, COUNT(*) as count FROM posts GROUP BY category ORDER BY count DESC")->fetchAll(PDO::FETCH_ASSOC);
}
}

if (!function_exists('getUsersByRole')) {
function getUsersByRole() {
    $pdo = getDB();
    return $pdo->query("SELECT role, COUNT(*) as count FROM users GROUP BY role")->fetchAll(PDO::FETCH_ASSOC);
}
}

if (!function_exists('getRecentPosts')) {
function getRecentPosts($limit = 5) {
    $pdo = getDB();
    return $pdo->query("SELECT p.*, u.username as author_name FROM posts p LEFT JOIN users u ON p.author_id = u.id ORDER BY p.created_at DESC LIMIT $limit")->fetchAll(PDO::FETCH_ASSOC);
}
}

if (!function_exists('getRecentUsers')) {
function getRecentUsers($limit = 5) {
    $pdo = getDB();
    return $pdo->query("SELECT * FROM users ORDER BY created_at DESC LIMIT $limit")->fetchAll(PDO::FETCH_ASSOC);
}
}

if (!function_exists('getRecentComments')) {
function getRecentComments($limit = 5) {
    $pdo = getDB();
    return $pdo->query("SELECT c.*, u.username, p.title as post_title FROM comments c JOIN users u ON c.user_id = u.id JOIN posts p ON c.post_id = p.id ORDER BY c.created_at DESC LIMIT $limit")->fetchAll(PDO::FETCH_ASSOC);
}
}

if (!function_exists('getVisitStatsByHour')) {
function getVisitStatsByHour() {
    $pdo = getDB();
    return $pdo->query("SELECT HOUR(created_at) as hour, COUNT(*) as visits FROM visit_logs WHERE DATE(created_at) = CURDATE() GROUP BY HOUR(created_at) ORDER BY hour")->fetchAll(PDO::FETCH_ASSOC);
}
}

if (!function_exists('getReferrerStats')) {
function getReferrerStats($limit = 10) {
    $pdo = getDB();
    return $pdo->query("SELECT referer, COUNT(*) as visits FROM visit_logs WHERE referer != '' GROUP BY referer ORDER BY visits DESC LIMIT $limit")->fetchAll(PDO::FETCH_ASSOC);
}
}

if (!function_exists('backupDatabase')) {
function backupDatabase($targetDir = null) {
    $pdo = getDB();
    $dbName = CONFIG['db']['name'];
    $backupDir = $targetDir ?: (dirname(__DIR__) . '/db/');
    $backupDir = rtrim($backupDir, '/\\') . DIRECTORY_SEPARATOR;
    
    if (!is_dir($backupDir)) {
        mkdir($backupDir, 0777, true);
    }
    
    $filename = $dbName . '_' . date('Y-m-d_H-i-s') . '.sql';
    $filepath = $backupDir . $filename;
    
    $sql = "-- ============================================\n";
    $sql .= "-- BACKUP: $dbName\n";
    $sql .= "-- Fecha: " . date('Y-m-d H:i:s') . "\n";
    $sql .= "-- ============================================\n\n";
    $sql .= "CREATE DATABASE IF NOT EXISTS `$dbName` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;\n";
    $sql .= "USE `$dbName`;\n\n";
    
    // Get all tables
    $tables = $pdo->query("SHOW TABLES")->fetchAll(PDO::FETCH_COLUMN);
    
    foreach ($tables as $table) {
        // Get create table statement
        $createTable = $pdo->query("SHOW CREATE TABLE `$table`")->fetch(PDO::FETCH_ASSOC);
        $sql .= "-- Table: $table\n";
        $sql .= "DROP TABLE IF EXISTS `$table`;\n";
        $sql .= $createTable['Create Table'] . ";\n\n";
        
        // Get data
        $rows = $pdo->query("SELECT * FROM `$table`")->fetchAll(PDO::FETCH_ASSOC);
        if (!empty($rows)) {
            $columns = implode('`, `', array_keys($rows[0]));
            foreach ($rows as $row) {
                $values = [];
                foreach ($row as $val) {
                    if ($val === null) {
                        $values[] = 'NULL';
                    } else {
                        $values[] = $pdo->quote($val);
                    }
                }
                $sql .= "INSERT INTO `$table` (`$columns`) VALUES (" . implode(', ', $values) . ");\n";
            }
            $sql .= "\n";
        }
    }
    
    $sql .= "-- ============================================\n";
    $sql .= "-- FIN DEL BACKUP\n";
    $sql .= "-- ============================================\n";
    
    file_put_contents($filepath, $sql);
    
    return [
        'filename' => $filename,
        'filepath' => $filepath,
        'message' => "Backup creado: <strong>$filename</strong>",
    ];
}
}

if (!function_exists('cleanupOldBackups')) {
function cleanupOldBackups($directory, $retentionDays = 30, $prefix = '') {
    $dir = rtrim((string)$directory, '/\\');
    $retentionDays = max(1, (int)$retentionDays);
    if ($dir === '' || !is_dir($dir)) {
        return 0;
    }

    $deleted = 0;
    $threshold = time() - ($retentionDays * 86400);
    $files = @scandir($dir);
    if (!is_array($files)) {
        return 0;
    }

    foreach ($files as $file) {
        if ($file === '.' || $file === '..') {
            continue;
        }
        if (pathinfo($file, PATHINFO_EXTENSION) !== 'sql') {
            continue;
        }
        if ($prefix !== '' && strpos($file, $prefix) !== 0) {
            continue;
        }
        $path = $dir . DIRECTORY_SEPARATOR . $file;
        if (!is_file($path)) {
            continue;
        }
        $mtime = @filemtime($path);
        if ($mtime !== false && $mtime < $threshold) {
            if (@unlink($path)) {
                $deleted++;
            }
        }
    }
    return $deleted;
}
}

// Language functions
if (!function_exists('getActiveLanguage')) {
function getActiveLanguage() {
    $validLangs = ['es', 'en'];
    if(isset($_COOKIE['language']) && in_array($_COOKIE['language'], $validLangs)) return $_COOKIE['language'];
    if(isset($_SESSION['language']) && in_array($_SESSION['language'], $validLangs)) return $_SESSION['language'];
    return 'es'; // Default Spanish
}
}

if (!function_exists('getLanguageStrings')) {
function getLanguageStrings($lang = null) {
    if(!$lang) $lang = getActiveLanguage();
    $file = dirname(__DIR__) . "/languages/$lang.php";
    if(file_exists($file)) return include $file;
    return include dirname(__DIR__) . "/languages/es.php";
}
}

if (!function_exists('setLanguage')) {
function setLanguage($lang) {
    $validLangs = ['es', 'en'];
    if(in_array($lang, $validLangs)) {
        $_SESSION['language'] = $lang;
        setcookie('language', $lang, time() + 31536000, '/');
        return true;
    }
    return false;
}
}

if (!function_exists('t')) {
function t($key, $lang = null) {
    static $strings = null;
    if($strings === null) $strings = getLanguageStrings($lang);
    return $strings[$key] ?? $key;
}
}
