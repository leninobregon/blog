<?php
/**
 * Newsletter Model
 */
class Newsletter extends Model {
    protected string $table = 'newsletter';
    
    public function subscribe(string $email, string $name = ''): array {
        // Check if email already exists
        $existing = $this->findAllWhere('email = ?', [$email]);
        
        if (!empty($existing)) {
            if ($existing[0]['active'] == 1) {
                return ['success' => false, 'message' => 'already_subscribed'];
            } else {
                // Reactivate subscription
                $this->update($existing[0]['id'], ['active' => 1, 'name' => $name]);
                return ['success' => true, 'message' => 'reactivated'];
            }
        }
        
        try {
            $this->insert([
                'email' => $email,
                'name' => $name,
                'active' => 1
            ]);
            return ['success' => true, 'message' => 'subscribed'];
        } catch (\PDOException $e) {
            return ['success' => false, 'message' => 'error'];
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
