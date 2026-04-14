<?php
/**
 * Autoload - Carga automática de clases + Cache
 */

spl_autoload_register(function (string $class) {
    $paths = [
        __DIR__ . '/core/',
        __DIR__ . '/models/',
        __DIR__ . '/controllers/',
        __DIR__ . '/services/',
    ];
    
    foreach ($paths as $path) {
        $file = $path . $class . '.php';
        if (file_exists($file)) {
            require_once $file;
            return;
        }
    }
});

// Load SimpleCache for query optimization
require_once __DIR__ . '/core/SimpleCache.php';

// Load theme colors (functions.php already loads it for admin/user)
if (!function_exists('getThemeColors')) {
    require_once __DIR__ . '/core/theme_colors.php';
}

// Load functions.php for helper functions (uploadImage, etc.)
// Only define CONFIG if not already defined
if (!defined('CONFIG')) {
    $config = require __DIR__ . '/config.php';
    define('CONFIG', $config);
}
// Load functions.php only if getDB doesn't exist (functions.php defines getDB first)
if (!function_exists('getDB')) {
    require_once __DIR__ . '/includes/functions.php';
}

// Ensure logAudit is available for controllers
if (!function_exists('logAudit')) {
    require_once __DIR__ . '/includes/functions.php';
}

// Load helpers only if not already loaded
if (!function_exists('parseMarkdown')) {
    require_once __DIR__ . '/includes/functions_helpers.php';
}
