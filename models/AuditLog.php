<?php
/**
 * Audit Log Model
 */
class AuditLog extends Model {
    protected string $table = 'audit_logs';
    
    public function log(array $data): bool {
        return $this->insert([
            'action' => $data['action'] ?? 'unknown',
            'user_id' => $data['user_id'] ?? null,
            'username' => $data['username'] ?? 'guest',
            'ip_address' => $data['ip_address'] ?? $_SERVER['REMOTE_ADDR'] ?? 'unknown',
            'user_agent' => $data['user_agent'] ?? $_SERVER['HTTP_USER_AGENT'] ?? '',
            'page' => $data['page'] ?? '',
            'details' => $data['details'] ?? '',
            'created_at' => date('Y-m-d H:i:s')
        ]);
    }
    
    public function getRecent(int $limit = 50): array {
        return $this->findAll([
            'order' => 'created_at DESC',
            'limit' => $limit
        ]);
    }
    
    public function getByUser(int $userId, int $limit = 20): array {
        return $this->findAllWhere('user_id = ?', [$userId], [
            'order' => 'created_at DESC',
            'limit' => $limit
        ]);
    }
    
    public function getByAction(string $action, int $limit = 20): array {
        return $this->findAllWhere('action = ?', [$action], [
            'order' => 'created_at DESC',
            'limit' => $limit
        ]);
    }
    
    public function getByIp(string $ip, int $limit = 20): array {
        return $this->findAllWhere('ip_address LIKE ?', ["%{$ip}%"], [
            'order' => 'created_at DESC',
            'limit' => $limit
        ]);
    }
    
    public function search(string $query, int $limit = 50): array {
        return $this->findAllWhere(
            'details LIKE ? OR username LIKE ? OR page LIKE ?', 
            ["%{$query}%", "%{$query}%", "%{$query}%"],
            ['order' => 'created_at DESC', 'limit' => $limit]
        );
    }
    
    public function countByUser(int $userId): int {
        return $this->count('user_id = ?', [$userId]);
    }
    
    public function countByAction(string $action): int {
        return $this->count('action = ?', [$action]);
    }
}
