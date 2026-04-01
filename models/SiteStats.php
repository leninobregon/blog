<?php
/**
 * SiteStats Model
 */
class SiteStats extends Model {
    protected string $table = 'site_stats';
    
    public function get(): ?array {
        return $this->findById(1);
    }
    
    public function getTotalHits(): int {
        $stats = $this->get();
        return $stats ? (int)$stats['total_hits'] : 0;
    }
    
    public function incrementHits(): void {
        $this->db->exec("UPDATE {$this->table} SET total_hits = total_hits + 1 WHERE id = 1");
    }
}
