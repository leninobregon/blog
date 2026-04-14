<?php
/**
 * Search - Página de resultados de búsqueda (Versión Final Corregida)
 */
require_once 'autoload.php';

// 1. Lógica de entrada y configuración de Temas
$q = $_GET['q'] ?? '';
$q = trim($q);
$searchType = $_GET['type'] ?? 'avanzada'; // 'avanzada' para que sea más preciso

if (empty($q)) {
    header('Location: /');
    exit;
}

// Carga de configuración de apariencia del blog
$currentTheme = getActiveTheme();
$colors = getThemeColors($currentTheme);
$currentLang = getActiveLanguage();

// Configuración de URLs para que funcionen los enlaces
$protocol = (!empty($_SERVER['HTTPS']) && $_SERVER['HTTPS'] !== 'off') ? 'https' : 'http';
$host = $_SERVER['HTTP_HOST'] ?? 'localhost';
$scriptDir = rtrim(dirname($_SERVER['SCRIPT_NAME']), '/');
$baseUrl = $protocol . '://' . $host . $scriptDir;

$loggedUser = null;
if (!empty($_SESSION['user_id'])) {
    $loggedUser = getUser($_SESSION['user_id']);
}

// 2. Obtener datos (Categorías y Posts)
$postModel = new Post();
$categories = $postModel->getCategoriesWithCount();

// Ejecutar búsqueda avanzada (AND) o normal (OR)
if ($searchType === 'avanzada') {
    $posts = searchPostsAdvanced($q, 100, 0);
} else {
    $posts = searchPosts($q, 100, 0);
}

// 3. Función para resaltar la palabra que el usuario busca
$palabrasBusqueda = array_filter(preg_split('/[\s\+]+/', $q), function($p) { return trim($p) !== ''; });

function highlightText($text, $palabras) {
    if (empty($palabras) || empty($text)) return $text;
    
    // Escapamos el texto original para seguridad
    $text = htmlspecialchars($text, ENT_QUOTES, 'UTF-8');
    
    foreach ($palabras as $palabra) {
        $palabra = trim($palabra);
        if (empty($palabra)) continue;
        
        // Aplicamos el resaltado con la etiqueta <mark>
        $quoted = preg_quote($palabra, '/');
        $text = preg_replace('/(' . $quoted . ')/i', '<mark style="background: #ffeb3b; color: #000; padding: 0 2px; border-radius: 2px; font-weight: bold;">$1</mark>', $text);
    }
    return $text;
}

$pageTitle = 'Buscar: ' . htmlspecialchars($q);

require 'views/layouts/header.php';
?>

<main class="blog-layout" style="display: flex; gap: 2rem; max-width: 1200px; margin: 0 auto; padding: 2rem; min-height: 80vh;">
    <div class="main-content" style="flex: 1; min-width: 0;">
        <h1 style="margin-bottom: 1rem; color: var(--text); font-size: 2rem;">
            <i class="fas fa-search"></i> Resultados para "<?= htmlspecialchars($q) ?>"
        </h1>
        
        <p style="color: var(--text-secondary); margin-bottom: 2rem;">
            Se encontraron <strong><?= count($posts) ?></strong> resultado(s).
        </p>
        
        <?php if (empty($posts)): ?>
            <div class="empty-state" style="text-align: center; padding: 4rem; background: var(--bg-secondary); border-radius: var(--radius-lg);">
                <i class="fas fa-search-minus" style="font-size: 3rem; opacity: 0.3; margin-bottom: 1rem; display: block;"></i>
                <p style="font-size: 1.2rem; color: var(--text-secondary);">No encontramos nada que coincida exactamente con tu búsqueda.</p>
                <a href="<?= $baseUrl ?>/" class="btn" style="display: inline-block; margin-top: 1.5rem; background: var(--primary); color: white; padding: 0.7rem 1.5rem; border-radius: 5px; text-decoration: none;">Ir al Inicio</a>
            </div>
        <?php else: ?>
            <div class="posts-grid" style="display: grid; grid-template-columns: 1fr; gap: 1.5rem;">
                <?php foreach ($posts as $post): ?>
                    <article class="post-card" style="background: var(--bg-secondary); border: 1px solid var(--border); border-radius: var(--radius-lg); padding: 1.5rem; transition: transform 0.2s;">
                        
                        <div style="display: flex; gap: 1rem; align-items: center; font-size: 0.85rem; margin-bottom: 1rem;">
                            <span style="background: var(--primary); color: white; padding: 0.2rem 0.8rem; border-radius: 50px; font-weight: 500;">
                                <?= htmlspecialchars($post['category']) ?>
                            </span>
                            <span style="color: var(--text-secondary);">
                                <i class="fas fa-calendar-alt"></i> <?= date('d M, Y', strtotime($post['created_at'])) ?>
                            </span>
                        </div>

                        <h2 style="font-size: 1.5rem; margin: 0 0 1rem 0;">
                            <a href="<?= $baseUrl ?>/post.php?id=<?= $post['id'] ?>" style="color: var(--text); text-decoration: none;">
                                <?= highlightText($post['title'], $palabrasBusqueda) ?>
                            </a>
                        </h2>

                        <p style="color: var(--text-secondary); line-height: 1.6; margin-bottom: 1.5rem;">
                            <?= highlightText(mb_substr(strip_tags($post['content']), 0, 200), $palabrasBusqueda) ?>...
                        </p>

                        <div style="display: flex; justify-content: space-between; align-items: center; padding-top: 1rem; border-top: 1px solid var(--border);">
                            <span style="color: var(--text-secondary); font-size: 0.85rem;">
                                <i class="fas fa-user"></i> <?= htmlspecialchars($post['author_name'] ?? 'admin') ?>
                            </span>
                            <a href="<?= $baseUrl ?>/post.php?id=<?= $post['id'] ?>" style="color: var(--primary); font-weight: bold; text-decoration: none; display: flex; align-items: center; gap: 0.5rem;">
                                Leer más <i class="fas fa-arrow-right"></i>
                            </a>
                        </div>
                    </article>
                <?php endforeach; ?>
            </div>
        <?php endif; ?>
    </div>
    
    <aside class="sidebar" style="width: 280px; flex-shrink: 0;">
        <div style="background: var(--bg-secondary); border: 1px solid var(--border); border-radius: var(--radius-lg); padding: 1.5rem; position: sticky; top: 2rem;">
            <h3 style="margin-top: 0; margin-bottom: 1.5rem; border-bottom: 2px solid var(--primary); padding-bottom: 0.5rem; font-size: 1.1rem; color: var(--text);">
                <i class="fas fa-folder-open"></i> Categorías
            </h3>
            <ul style="list-style: none; padding: 0; margin: 0;">
                <?php foreach($categories as $cat): ?>
                <li style="margin-bottom: 0.7rem;">
                    <a href="<?= $baseUrl ?>/?cat=<?= urlencode($cat['category']) ?>" style="color: var(--text); text-decoration: none; display: flex; justify-content: space-between; padding: 0.5rem; border-radius: 5px; transition: background 0.2s;">
                        <span><?= htmlspecialchars($cat['category']) ?></span>
                        <span style="background: var(--border); padding: 0 8px; border-radius: 10px; font-size: 0.8rem; opacity: 0.8;"><?= $cat['count'] ?></span>
                    </a>
                </li>
                <?php endforeach; ?>
            </ul>
        </div>
    </aside>
</main>

<?php require 'views/layouts/footer.php'; ?>