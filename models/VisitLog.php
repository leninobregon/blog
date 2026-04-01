<?php
/**
 * VisitLog Model
 */
class VisitLog extends Model {
    protected string $table = 'visit_logs';
    
    public function log(string $page, string $ip, string $userAgent, string $referer = ''): void {
        $this->insert([
            'page' => $page,
            'ip' => $ip,
            'user_agent' => $userAgent,
            'referer' => $referer
        ]);
    }
    
    public function getStats(int $days = 30): array {
        return $this->query("
            SELECT DATE(created_at) as date, COUNT(*) as visits 
            FROM {$this->table} 
            WHERE created_at >= DATE_SUB(NOW(), INTERVAL ? DAY) 
            GROUP BY DATE(created_at) 
            ORDER BY date
        ", [$days]);
    }
    
    public function getToday(): array {
        return $this->query("
            SELECT HOUR(created_at) as hour, COUNT(*) as visits 
            FROM {$this->table} 
            WHERE DATE(created_at) = CURDATE() 
            GROUP BY HOUR(created_at) 
            ORDER BY hour
        ");
    }
    
    public function getTopPages(int $limit = 10): array {
        return $this->query("
            SELECT page, COUNT(*) as visits 
            FROM {$this->table} 
            GROUP BY page 
            ORDER BY visits DESC 
            LIMIT {$limit}
        ");
    }
    
    public function getTotal(): int {
        return $this->count();
    }
}
