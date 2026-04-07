<?php
/**
 * Post Model with Cache
 */
class Post extends Model {
    protected string $table = 'posts';
    
    public function getWithAuthor(int $id): ?array {
        $cacheKey = "post_{$id}";
        $cached = SimpleCache::get($cacheKey, 60);
        if (is_array($cached)) {
            return $cached;
        }
        
        $sql = "SELECT p.*, u.username as author_name 
                FROM posts p 
                LEFT JOIN users u ON p.author_id = u.id 
                WHERE p.id = ?";
        $stmt = $this->db->prepare($sql);
        $stmt->execute([$id]);
        $result = $stmt->fetch();
        
        if (is_array($result)) {
            SimpleCache::set($cacheKey, $result, 60);
        }
        return $result ?: null;
    }
    
    public function getLatest(int $limit = 10, int $offset = 0, string $category = null, string $search = null): array {
        $cacheKey = "posts_latest_{$limit}_{$offset}_" . ($category ?? 'null') . "_" . ($search ?? 'null');
        $cached = SimpleCache::get($cacheKey, 120);
        if (is_array($cached)) {
            return $cached;
        }
        
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
        $result = $stmt->fetchAll();
        
        SimpleCache::set($cacheKey, $result, 120);
        return $result;
    }
    
    public function getCategories(): array {
        $cached = SimpleCache::get('categories', 300);
        if (is_array($cached)) {
            return $cached;
        }
        
        $result = $this->db->query("SELECT DISTINCT category FROM posts ORDER BY category")->fetchAll(PDO::FETCH_COLUMN);
        SimpleCache::set('categories', $result, 300);
        return $result;
    }
    
    public function getRelated(int $postId, string $category, int $limit = 3): array {
        $cacheKey = "related_{$category}_{$postId}_{$limit}";
        $cached = SimpleCache::get($cacheKey, 180);
        if (is_array($cached)) {
            return $cached;
        }
        
        $stmt = $this->db->prepare("SELECT id, title, category, created_at FROM posts WHERE category = ? AND id != ? ORDER BY created_at DESC LIMIT ?");
        $stmt->execute([$category, $postId, $limit]);
        $result = $stmt->fetchAll();
        
        SimpleCache::set($cacheKey, $result, 180);
        return $result;
    }
    
    public function getMostViewed(int $limit = 5): array {
        $cached = SimpleCache::get('most_viewed_' . $limit, 300);
        if (is_array($cached)) {
            return $cached;
        }
        
        $result = $this->db->query("SELECT id, title, views FROM posts ORDER BY views DESC LIMIT {$limit}")->fetchAll();
        SimpleCache::set('most_viewed_' . $limit, $result, 300);
        return $result;
    }
    
    public function getArchives(): array {
        $cached = SimpleCache::get('archives', 3600);
        if (is_array($cached)) {
            return $cached;
        }
        
        $result = $this->db->query("
            SELECT DATE_FORMAT(created_at, '%Y-%m') as mes, 
                   MONTH(created_at) as mes_num,
                   YEAR(created_at) as anio,
                   COUNT(*) as total 
            FROM posts 
            GROUP BY mes 
            ORDER BY mes DESC
            LIMIT 12
        ")->fetchAll();
        
        SimpleCache::set('archives', $result, 3600);
        return $result;
    }
    
    public function getByMonth(string $mes, int $limit = 10, int $offset = 0): array {
        $cacheKey = "posts_month_{$mes}_{$limit}_{$offset}";
        $cached = SimpleCache::get($cacheKey, 300);
        if (is_array($cached)) {
            return $cached;
        }
        
        $result = $this->db->query("
            SELECT p.*, u.username as author_name 
            FROM posts p 
            LEFT JOIN users u ON p.author_id = u.id 
            WHERE DATE_FORMAT(p.created_at, '%Y-%m') = '{$mes}' 
            ORDER BY p.created_at DESC 
            LIMIT {$limit} OFFSET {$offset}
        ")->fetchAll();
        
        SimpleCache::set($cacheKey, $result, 300);
        return $result;
    }
    
    public function incrementViews(int $id): void {
        $this->db->exec("UPDATE {$this->table} SET views = views + 1 WHERE id = {$id}");
        SimpleCache::delete("post_{$id}");
    }
    
    public function countAll(string $category = null): int {
        if ($category) {
            return $this->count('category = ?', [$category]);
        }
        return $this->count();
    }
    
    public function getCategoriesWithCount(): array {
        $cached = SimpleCache::get('categories_with_count', 300);
        if (is_array($cached)) {
            return $cached;
        }
        
        $result = $this->db->query("SELECT category, COUNT(*) as count FROM posts GROUP BY category ORDER BY count DESC")->fetchAll();
        SimpleCache::set('categories_with_count', $result, 300);
        return $result;
    }
    
    public function clearCache(): void {
        SimpleCache::clear();
    }
}
