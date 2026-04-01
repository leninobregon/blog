<?php
/**
 * Newsletter Model
 */
class Newsletter extends Model {
    protected string $table = 'newsletter';
    
    public function subscribe(string $email, string $name = ''): bool {
        try {
            $this->insert([
                'email' => $email,
                'name' => $name,
                'active' => 1
            ]);
            return true;
        } catch (\PDOException $e) {
            return false; // Email already exists
        }
    }
    
    public function getActive(): array {
        return $this->findAllWhere('active = ?', [1]);
    }
    
    public function getAll(): array {
        return $this->findAll(['order' => 'created_at DESC']);
    }
    
    public function toggle(int $id): void {
        $subscriber = $this->findById($id);
        if ($subscriber) {
            $this->update($id, ['active' => $subscriber['active'] ? 0 : 1]);
        }
    }
    
    public function countActive(): int {
        return $this->count('active = ?', [1]);
    }
}
