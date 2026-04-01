<?php
/**
 * Model - Clase base para modelos
 */
abstract class Model {
    protected PDO $db;
    protected string $table = '';
    
    public function __construct() {
        $this->db = Database::getInstance()->getConnection();
    }
    
    public function findAll(array $options = []): array {
        $sql = "SELECT * FROM {$this->table}";
        
        if (isset($options['where'])) {
            $sql .= " WHERE {$options['where']}";
        }
        if (isset($options['order'])) {
            $sql .= " ORDER BY {$options['order']}";
        }
        if (isset($options['limit'])) {
            $sql .= " LIMIT {$options['limit']}";
        }
        
        $stmt = $this->db->query($sql);
        return $stmt->fetchAll();
    }
    
    public function findById(int $id): ?array {
        $stmt = $this->db->prepare("SELECT * FROM {$this->table} WHERE id = ?");
        $stmt->execute([$id]);
        $result = $stmt->fetch();
        return $result ?: null;
    }
    
    public function find(string $where, array $params = []): ?array {
        $stmt = $this->db->prepare("SELECT * FROM {$this->table} WHERE {$where}");
        $stmt->execute($params);
        $result = $stmt->fetch();
        return $result ?: null;
    }
    
    public function findAllWhere(string $where, array $params = []): array {
        $stmt = $this->db->prepare("SELECT * FROM {$this->table} WHERE {$where}");
        $stmt->execute($params);
        return $stmt->fetchAll();
    }
    
    public function count(string $where = '1', array $params = []): int {
        $stmt = $this->db->prepare("SELECT COUNT(*) FROM {$this->table} WHERE {$where}");
        $stmt->execute($params);
        return (int)$stmt->fetchColumn();
    }
    
    public function insert(array $data): int {
        $columns = implode(', ', array_keys($data));
        $placeholders = implode(', ', array_fill(0, count($data), '?'));
        
        $stmt = $this->db->prepare("INSERT INTO {$this->table} ({$columns}) VALUES ({$placeholders})");
        $stmt->execute(array_values($data));
        
        return (int)$this->db->lastInsertId();
    }
    
    public function update(int $id, array $data): bool {
        $sets = implode(', ', array_map(fn($k) => "{$k} = ?", array_keys($data)));
        
        $stmt = $this->db->prepare("UPDATE {$this->table} SET {$sets} WHERE id = ?");
        return $stmt->execute([...array_values($data), $id]);
    }
    
    public function delete(int $id): bool {
        $stmt = $this->db->prepare("DELETE FROM {$this->table} WHERE id = ?");
        return $stmt->execute([$id]);
    }
    
    public function query(string $sql, array $params = []): array {
        $stmt = $this->db->prepare($sql);
        $stmt->execute($params);
        return $stmt->fetchAll();
    }
    
    public function execute(string $sql, array $params = []): bool {
        $stmt = $this->db->prepare($sql);
        return $stmt->execute($params);
    }
}
