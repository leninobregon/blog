<?php
/**
 * Comment Model
 */
class Comment extends Model {
    protected string $table = 'comments';
    
    public function getWithUser(int $postId): array {
        $sql = "SELECT c.*, u.username, u.first_name, u.last_name, p.title as post_title 
                FROM comments c 
                JOIN users u ON c.user_id = u.id 
                JOIN posts p ON c.post_id = p.id 
                WHERE c.post_id = ? 
                ORDER BY c.created_at DESC";
        $stmt = $this->db->prepare($sql);
        $stmt->execute([$postId]);
        return $stmt->fetchAll();
    }
    
    public function getRecent(int $limit = 5): array {
        $sql = "SELECT c.*, u.username, u.first_name, u.last_name, p.title as post_title 
                FROM comments c 
                JOIN users u ON c.user_id = u.id 
                JOIN posts p ON c.post_id = p.id 
                ORDER BY c.created_at DESC 
                LIMIT ?";
        $stmt = $this->db->prepare($sql);
        $stmt->execute([$limit]);
        return $stmt->fetchAll();
    }
    
    public function countAll(): int {
        return $this->count();
    }
    
    public function create(int $postId, int $userId, string $content): int {
        return $this->insert([
            'post_id' => $postId,
            'user_id' => $userId,
            'content' => $content
        ]);
    }
}
