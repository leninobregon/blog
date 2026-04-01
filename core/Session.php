<?php
/**
 * Session - Gestión de sesiones
 */
class Session {
    public static function start(): void {
        if (session_status() === PHP_SESSION_NONE) {
            session_start();
        }
    }
    
    public static function set(string $key, $value): void {
        $_SESSION[$key] = $value;
    }
    
    public static function get(string $key, $default = null) {
        return $_SESSION[$key] ?? $default;
    }
    
    public static function has(string $key): bool {
        return isset($_SESSION[$key]);
    }
    
    public static function remove(string $key): void {
        unset($_SESSION[$key]);
    }
    
    public static function destroy(): void {
        session_destroy();
        $_SESSION = [];
    }
    
    public static function isLoggedIn(): bool {
        return self::has('user_id');
    }
    
    public static function flash(string $key, $value = null): mixed {
        if ($value !== null) {
            $_SESSION['flash'][$key] = $value;
            return null;
        }
        $value = $_SESSION['flash'][$key] ?? null;
        unset($_SESSION['flash'][$key]);
        return $value;
    }
}
