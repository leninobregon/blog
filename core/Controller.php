<?php
/**
 * Controller - Clase base para controladores
 */
abstract class Controller {
    protected function view(string $view, array $data = []): void {
        extract($data);
        
        // Load config
        $config = require __DIR__ . '/../config.php';
        
        // Base URL (for links to work in subdirectories)
        $baseUrl = $this->getBaseUrl();
        
        // Language
        $currentLang = $this->getLanguage();
        $lang = $this->getLanguageStrings($currentLang);
        
        // Theme
        $currentTheme = $this->getTheme();
        $colors = $this->getThemeColors($currentTheme);
        
        // Logged user
        $loggedUser = $this->getCurrentUser();
        
        require __DIR__ . '/../views/layouts/header.php';
        require __DIR__ . "/../views/{$view}.php";
        require __DIR__ . '/../views/layouts/footer.php';
    }
    
    protected function getBaseUrl(): string {
        $protocol = (!empty($_SERVER['HTTPS']) && $_SERVER['HTTPS'] !== 'off') ? 'https' : 'http';
        $host = $_SERVER['HTTP_HOST'] ?? 'localhost';
        $scriptDir = rtrim(dirname($_SERVER['SCRIPT_NAME']), '/');
        return $protocol . '://' . $host . $scriptDir;
    }
    
    protected function json(array $data, int $code = 200): void {
        http_response_code($code);
        header('Content-Type: application/json');
        echo json_encode($data);
        exit;
    }
    
    protected function redirect(string $url): void {
        header("Location: {$url}");
        exit;
    }
    
    protected function back(): void {
        $url = $_SERVER['HTTP_REFERER'] ?? '/';
        $this->redirect($url);
    }
    
    protected function currentUser(): ?array {
        if (!Session::isLoggedIn()) {
            return null;
        }
        $userModel = new User();
        return $userModel->findById(Session::get('user_id'));
    }
    
    protected function requireLogin(): void {
        if (!Session::isLoggedIn()) {
            $this->redirect($this->getBaseUrl() . '/auth.php');
        }
    }
    
    protected function requireAdmin(): void {
        $this->requireLogin();
        $user = $this->currentUser();
        if (!$user || $user['role'] !== 'admin') {
            $this->redirect('/');
        }
    }
    
    private function getLanguage(): string {
        $validLangs = ['es', 'en'];
        if (isset($_COOKIE['language']) && in_array($_COOKIE['language'], $validLangs)) {
            return $_COOKIE['language'];
        }
        if (Session::has('language') && in_array(Session::get('language'), $validLangs)) {
            return Session::get('language');
        }
        return 'es';
    }
    
    private function getLanguageStrings(string $lang): array {
        $file = __DIR__ . "/../languages/{$lang}.php";
        if (file_exists($file)) {
            return require $file;
        }
        return require __DIR__ . '/../languages/es.php';
    }
    
    private function getTheme(): string {
        $validThemes = ['white','blue','dark-blue','black','green','red','purple','orange','pink','teal','yellow','cyan','brown','indigo','lime','amber','rose','slate','emerald','sky','violet'];
        if (isset($_COOKIE['theme']) && in_array($_COOKIE['theme'], $validThemes)) {
            return $_COOKIE['theme'];
        }
        $config = require __DIR__ . '/../config.php';
        return $config['theme'] ?? 'blue';
    }
    
    private function getThemeColors(string $theme): array {
        require_once __DIR__ . '/theme_colors.php';
        return getThemeColors($theme);
    }
    
    private function getCurrentUser(): ?array {
        if (!Session::isLoggedIn()) {
            return null;
        }
        static $user = null;
        if ($user === null) {
            $userModel = new User();
            $user = $userModel->findById(Session::get('user_id'));
        }
        return $user;
    }
    
    protected function t(string $key): string {
        static $strings = null;
        if ($strings === null) {
            $strings = $this->getLanguageStrings($this->getLanguage());
        }
        return $strings[$key] ?? $key;
    }
}
