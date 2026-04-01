<?php
/**
 * User Model
 */
class User extends Model {
    protected string $table = 'users';
    
    public function findByEmail(string $email): ?array {
        return $this->find('email = ?', [$email]);
    }
    
    public function findByUsername(string $username): ?array {
        return $this->find('username = ?', [$username]);
    }
    
    public function authenticate(string $email, string $password): ?array {
        $user = $this->find('(email = ? OR username = ?)', [$email, $email]);
        
        if ($user && password_verify($password, $user['password'])) {
            return $user;
        }
        return null;
    }
    
    public function register(array $data): int {
        $data['password'] = password_hash($data['password'], PASSWORD_BCRYPT);
        return $this->insert($data);
    }
    
    public function updatePassword(int $id, string $password): bool {
        $hash = password_hash($password, PASSWORD_BCRYPT);
        $stmt = $this->db->prepare("UPDATE {$this->table} SET password = ? WHERE id = ?");
        return $stmt->execute([$hash, $id]);
    }
    
    public function getAll(): array {
        return $this->db->query("SELECT * FROM {$this->table} ORDER BY created_at DESC")->fetchAll();
    }
    
    public function getAdmins(): array {
        return $this->findAllWhere('role = ?', ['admin']);
    }
    
    public function countAll(): int {
        return $this->count();
    }
}
