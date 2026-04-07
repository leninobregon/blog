<?php
/**
 * Database Upgrade Script
 */

error_reporting(E_ALL);
ini_set('display_errors', 1);

require_once __DIR__ . '/includes/functions.php';

$pdo = getDB();

echo "<!DOCTYPE html>
<html lang='es'>
<head>
    <meta charset='UTF-8'>
    <title>Actualizar Base de Datos</title>
    <style>
        body { font-family: system-ui; padding: 2rem; background: #f0f0f0; }
        .box { background: white; padding: 2rem; border-radius: 8px; max-width: 600px; margin: 0 auto; }
        h1 { color: #2563eb; }
        .success { color: #10b981; padding: 0.5rem; background: #d1fae5; border-radius: 4px; margin: 0.5rem 0; }
        .error { color: #ef4444; padding: 0.5rem; background: #fee2e2; border-radius: 4px; margin: 0.5rem 0; }
        .info { color: #2563eb; }
        .btn { display: inline-block; background: #2563eb; color: white; padding: 0.75rem 1.5rem; text-decoration: none; border-radius: 6px; margin-top: 1rem; }
    </style>
</head>
<body>
    <div class='box'>
        <h1>Actualizar Base de Datos</h1>";

$upgraded = false;
$errors = [];

// 1. Create audit_logs table
try {
    $pdo->exec("CREATE TABLE IF NOT EXISTS `audit_logs` (
        `id` INT AUTO_INCREMENT PRIMARY KEY,
        `action` VARCHAR(50) NOT NULL,
        `user_id` INT,
        `username` VARCHAR(50),
        `ip_address` VARCHAR(45),
        `user_agent` VARCHAR(255),
        `page` VARCHAR(255),
        `details` TEXT,
        `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP,
        INDEX idx_created_at (created_at)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci");
    echo "<p class='success'>✓ Tabla 'audit_logs' creada</p>";
    $upgraded = true;
} catch (PDOException $e) {
    $errors[] = "audit_logs: " . $e->getMessage();
}

// 2. Add newsletter columns
try {
    $stmt = $pdo->query("DESCRIBE newsletter");
    $columns = $stmt->fetchAll(PDO::FETCH_COLUMN);
    
    if (!in_array('last_sent', $columns)) {
        $pdo->exec("ALTER TABLE newsletter ADD COLUMN last_sent DATETIME NULL AFTER token");
        echo "<p class='success'>✓ Columna 'last_sent' agregada</p>";
        $upgraded = true;
    }
    
    if (!in_array('total_sent', $columns)) {
        $pdo->exec("ALTER TABLE newsletter ADD COLUMN total_sent INT DEFAULT 0 AFTER last_sent");
        echo "<p class='success'>✓ Columna 'total_sent' agregada</p>";
        $upgraded = true;
    }
} catch (PDOException $e) {
    $errors[] = "newsletter: " . $e->getMessage();
}

if ($upgraded && empty($errors)) {
    echo "<p class='success'>Base de datos actualizada</p>";
    echo "<a href='admin/dashboard.php' class='btn'>Ir al Dashboard</a>";
} elseif (empty($errors)) {
    echo "<p class='info'>Ya está actualizada</p>";
    echo "<a href='admin/dashboard.php' class='btn'>Ir al Dashboard</a>";
} else {
    echo "<p class='error'>Error: " . implode(', ', $errors) . "</p>";
}

echo "</div></body></html>";
