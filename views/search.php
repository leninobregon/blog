<?php
/**
 * Search - Página de resultados de búsqueda
 */
require_once 'autoload.php';

$q = $_GET['q'] ?? '';
$q = trim($q);

if (empty($q)) {
    header('Location: /');
    exit;
}

$posts = searchPosts($q, 20, 0);
$pageTitle = 'Buscar: ' . htmlspecialchars($q);

require 'views/layouts/header.php';
?>

<main class="container">
    <h1 style="margin-bottom: 1rem;">
        <i class="fas fa-search"></i> Resultados para "<?= htmlspecialchars($q) ?>"
    </h1>
    
    <p style="color: var(--text-secondary); margin-bottom: 2rem;">
        <?= count($posts) ?> resultado(s) encontrado(s)
    </p>
    
    <?php if (empty($posts)): ?>
        <div class="empty-state">
            <i class="fas fa-search"></i>
            <p>No se encontraron resultados</p>
            <a href="/" class="btn">Volver al inicio</a>
        </div>
    <?php else: ?>
        <div class="posts-grid">
            <?php foreach ($posts as $post): ?>
                <article class="post-card">
                    <?php if (!empty($post['image'])): ?>
                        <a href="<?= $baseUrl ?>/post.php?id=<?= $post['id'] ?>" class="post-image">
                            <img src="<?= htmlspecialchars($post['image']) ?>" alt="<?= htmlspecialchars($post['title']) ?>">
                        </a>
                    <?php endif; ?>
                    <div class="post-content">
                        <span class="post-category"><?= htmlspecialchars($post['category']) ?></span>
                        <h2 class="post-title">
                            <a href="<?= $baseUrl ?>/post.php?id=<?= $post['id'] ?>">
                                <?= htmlspecialchars($post['title']) ?>
                            </a>
                        </h2>
                        <p class="post-excerpt"><?= htmlspecialchars(mb_substr(strip_tags($post['content']), 0, 150) ?>...</p>
                        <div class="post-meta">
                            <span><i class="fas fa-user"></i> <?= htmlspecialchars($post['author_name'] ?? 'admin') ?></span>
                            <span><i class="fas fa-calendar"></i> <?= strftime('%d %b %Y', strtotime($post['created_at'])) ?></span>
                            <span><i class="fas fa-eye"></i> <?= number_format($post['visits'] ?? 0) ?></span>
                        </div>
                    </div>
                </article>
            <?php endforeach; ?>
        </div>
    <?php endif; ?>
</main>

<?php require 'views/layouts/footer.php'; ?>