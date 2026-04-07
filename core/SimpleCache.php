<?php
/**
 * Simple Cache - Optimización para alto tráfico
 * Compatible con XAMPP/LAMP/LEMP
 * Hasta 500+ usuarios simultáneos
 */

class SimpleCache {
    private static $cacheDir = __DIR__ . '/../cache/';
    private static $defaultTTL = 300; // 5 minutos
    private static $enabled = null;
    
    public static function init(): void {
        if (self::$enabled === null) {
            self::$enabled = is_dir(self::$cacheDir) && is_writable(self::$cacheDir);
        }
        if (self::$enabled && !is_dir(self::$cacheDir)) {
            mkdir(self::$cacheDir, 0777, true);
        }
    }
    
    public static function isEnabled(): bool {
        self::init();
        return self::$enabled;
    }
    
    public static function get(string $key, int $ttl = null): mixed {
        self::init();
        if (!self::$enabled) return null;
        
        $file = self::$cacheDir . md5($key) . '.cache';
        
        if (!file_exists($file)) {
            return null;
        }
        
        $ttl = $ttl ?? self::$defaultTTL;
        if (filemtime($file) < (time() - $ttl)) {
            @unlink($file);
            return null;
        }
        
        $content = file_get_contents($file);
        $data = @unserialize($content);
        if ($data === false) {
            return null;
        }
        return $data;
    }
    
    public static function set(string $key, mixed $data, int $ttl = null): bool {
        self::init();
        if (!self::$enabled) return false;
        
        $file = self::$cacheDir . md5($key) . '.cache';
        $content = serialize($data);
        
        // Compress if > 1KB
        if (strlen($content) > 1024) {
            $content = gzencode($content, 6);
        }
        
        return file_put_contents($file, $content) !== false;
    }
    
    public static function getHtml(string $key, int $ttl = 300): ?string {
        self::init();
        if (!self::$enabled) return null;
        
        $file = self::$cacheDir . md5($key) . '.html.cache';
        
        if (!file_exists($file)) {
            return null;
        }
        
        if (filemtime($file) < (time() - $ttl)) {
            @unlink($file);
            return null;
        }
        
        $content = file_get_contents($file);
        
        // Decompress if needed
        if (substr($content, 0, 2) === "\x1f\x8b") {
            $content = gzdecode($content);
        }
        
        return $content;
    }
    
    public static function setHtml(string $key, string $html, int $ttl = 300): bool {
        self::init();
        if (!self::$enabled) return false;
        
        $file = self::$cacheDir . md5($key) . '.html.cache';
        
        // Compress HTML
        $compressed = gzencode($html, 6);
        
        return file_put_contents($file, $compressed) !== false;
    }
    
    public static function delete(string $key): bool {
        $file = self::$cacheDir . md5($key) . '.cache';
        $htmlFile = self::$cacheDir . md5($key) . '.html.cache';
        @unlink($file);
        @unlink($htmlFile);
        return true;
    }
    
    public static function deletePrefix(string $prefix): bool {
        $files = glob(self::$cacheDir . md5($prefix) . '*.cache');
        foreach ($files as $file) {
            @unlink($file);
        }
        return true;
    }
    
    public static function clear(): bool {
        self::init();
        if (!self::$enabled) return false;
        
        $files = glob(self::$cacheDir . '*.cache');
        foreach ($files as $file) {
            @unlink($file);
        }
        return true;
    }
    
    public static function remember(string $key, callable $callback, int $ttl = null): mixed {
        $cached = self::get($key, $ttl);
        if ($cached !== null) {
            return $cached;
        }
        
        $data = $callback();
        self::set($key, $data, $ttl);
        return $data;
    }
    
    public static function rememberHtml(string $key, callable $callback, int $ttl = 300): string {
        $cached = self::getHtml($key, $ttl);
        if ($cached !== null) {
            return $cached;
        }
        
        ob_start();
        $callback();
        $html = ob_get_clean();
        
        self::setHtml($key, $html, $ttl);
        return $html;
    }
    
    public static function getStats(): array {
        self::init();
        if (!self::$enabled) {
            return ['enabled' => false, 'files' => 0, 'size' => 0];
        }
        
        $files = glob(self::$cacheDir . '*.cache');
        $size = 0;
        foreach ($files as $file) {
            $size += filesize($file);
        }
        
        return [
            'enabled' => true,
            'files' => count($files),
            'size' => round($size / 1024, 2) . ' KB'
        ];
    }
}
