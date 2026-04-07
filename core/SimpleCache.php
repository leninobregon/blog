<?php
/**
 * Simple Cache - Optimización para alto tráfico
 * Compatible con XAMPP/LAMP/LEMP
 */

class SimpleCache {
    private static $cacheDir = __DIR__ . '/../cache/';
    private static $defaultTTL = 300; // 5 minutos
    
    public static function init(): void {
        if (!is_dir(self::$cacheDir)) {
            mkdir(self::$cacheDir, 0777, true);
        }
    }
    
    public static function get(string $key, int $ttl = null): ?array {
        self::init();
        $file = self::$cacheDir . md5($key) . '.cache';
        
        if (!file_exists($file)) {
            return null;
        }
        
        $ttl = $ttl ?? self::$defaultTTL;
        if (filemtime($file) < (time() - $ttl)) {
            @unlink($file);
            return null;
        }
        
        $data = file_get_contents($file);
        return unserialize($data);
    }
    
    public static function set(string $key, $data, int $ttl = null): bool {
        self::init();
        $file = self::$cacheDir . md5($key) . '.cache';
        return file_put_contents($file, serialize($data)) !== false;
    }
    
    public static function delete(string $key): bool {
        $file = self::$cacheDir . md5($key) . '.cache';
        return @unlink($file);
    }
    
    public static function clear(): bool {
        self::init();
        $files = glob(self::$cacheDir . '*.cache');
        foreach ($files as $file) {
            @unlink($file);
        }
        return true;
    }
    
    public static function remember(string $key, callable $callback, int $ttl = null) {
        $cached = self::get($key, $ttl);
        if ($cached !== null) {
            return $cached;
        }
        
        $data = $callback();
        self::set($key, $data, $ttl);
        return $data;
    }
}
