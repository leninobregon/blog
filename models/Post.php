<?php
/**
 * Post Model
 */
class Post extends Model {
    protected string $table = 'posts';
    
    public function getWithAuthor(int $id): ?array {
        $sql = "SELECT p.*, u.username as author_name 
                FROM posts p 
                LEFT JOIN users u ON p.author_id = u.id 
                WHERE p.id = ?";
        $stmt = $this->db->prepare($sql);
        $stmt->execute([$id]);
        $result = $stmt->fetch();
        return $result ?: null;
    }
    
    public function getLatest(int $limit = 10, int $offset = 0, string $category = null, string $search = null): array {
        $sql = "SELECT p.*, u.username as author_name 
                FROM posts p 
                LEFT JOIN users u ON p.author_id = u.id";
        
        $params = [];
        $conditions = [];
        
        if ($category) {
            $conditions[] = "p.category = ?";
            $params[] = $category;
        }
        
        if ($search) {
            $conditions[] = "(p.title LIKE ? OR p.content LIKE ?)";
            $params[] = "%{$search}%";
            $params[] = "%{$search}%";
        }
        
        if ($conditions) {
            $sql .= " WHERE " . implode(' AND ', $conditions);
        }
        
        $sql .= " ORDER BY p.created_at DESC LIMIT {$limit} OFFSET {$offset}";
        
        $stmt = $this->db->prepare($sql);
        $stmt->execute($params);
        return $stmt->fetchAll();
    }
    
    public function getCategories(): array {
        return $this->db->query("SELECT DISTINCT category FROM posts ORDER BY category")->fetchAll(PDO::FETCH_COLUMN);
    }
    
    public function getRelated(int $postId, string $category, int $limit = 3): array {
        $stmt = $this->db->prepare("SELECT id, title, category, created_at FROM posts WHERE category = ? AND id != ? ORDER BY created_at DESC LIMIT ?");
        $stmt->execute([$category, $postId, $limit]);
        return $stmt->fetchAll();
    }
    
    public function getMostViewed(int $limit = 5): array {
        return $this->db->query("SELECT id, title, views FROM posts ORDER BY views DESC LIMIT {$limit}")->fetchAll();
    }
    
    public function getArchives(): array {
        return $this->db->query("
            SELECT DATE_FORMAT(created_at, '%Y-%m') as mes, 
                   MONTH(created_at) as mes_num,
                   YEAR(created_at) as anio,
                   COUNT(*) as total 
            FROM posts 
            GROUP BY mes 
            ORDER BY mes DESC
            LIMIT 12
        ")->fetchAll();
    }
    
    public function getByMonth(string $mes, int $limit = 10, int $offset = 0): array {
        return $this->db->query("
            SELECT p.*, u.username as author_name 
            FROM posts p 
            LEFT JOIN users u ON p.author_id = u.id 
            WHERE DATE_FORMAT(p.created_at, '%Y-%m') = '{$mes}' 
            ORDER BY p.created_at DESC 
            LIMIT {$limit} OFFSET {$offset}
        ")->fetchAll();
    }
    
    public function incrementViews(int $id): void {
        $this->db->exec("UPDATE {$this->table} SET views = views + 1 WHERE id = {$id}");
    }
    
    public function countAll(string $category = null): int {
        if ($category) {
            return $this->count('category = ?', [$category]);
        }
        return $this->count();
    }
    
    public function getCategoriesWithCount(): array {
        return $this->db->query("SELECT category, COUNT(*) as count FROM posts GROUP BY category ORDER BY count DESC")->fetchAll();
    }
}
