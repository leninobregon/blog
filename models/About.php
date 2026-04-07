<?php
/**
 * About Model with Cache
 */
class About extends Model {
    protected string $table = 'about';
    
    public function get(): ?array {
        $cached = SimpleCache::get('about_data', 300);
        if (is_array($cached)) {
            return $cached;
        }
        
        $result = $this->findById(1);
        if (is_array($result)) {
            SimpleCache::set('about_data', $result, 300);
        }
        return $result;
    }
    
    public function saveAbout(array $data): bool {
        $result = $this->update(1, $data);
        SimpleCache::delete('about_data');
        return $result;
    }
}
