<?php
/**
 * Database - Clase para conexiones PDO
 */
class Database {
    private static $instance = null;
    private $pdo;
    
    private function __construct() {
        $config = require __DIR__ . '/../config.php';
        $db = $config['db'];
        
        $dsn = "mysql:host={$db['host']};dbname={$db['name']};charset=utf8mb4";
        
        $this->pdo = new PDO($dsn, $db['user'], $db['pass'], [
            PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
            PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
            PDO::ATTR_EMULATE_PREPARES => false
        ]);
    }
    
    public static function getInstance(): self {
        if (self::$instance === null) {
            self::$instance = new self();
        }
        return self::$instance;
    }
    
    public function getConnection(): PDO {
        return $this->pdo;
    }
    
    // Prevenir clonación
    private function __clone() {}
}
