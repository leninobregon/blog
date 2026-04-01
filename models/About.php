<?php
/**
 * About Model
 */
class About extends Model {
    protected string $table = 'about';
    
    public function get(): ?array {
        return $this->findById(1);
    }
    
    public function saveAbout(array $data): bool {
        return $this->update(1, $data);
    }
}
