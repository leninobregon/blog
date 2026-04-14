<?php
/**
 * Index View - Página principal del blog
 */
$posts = $posts ?? [];
$categories = $categories ?? [];
$archives = $archives ?? [];
$currentCategory = $currentCategory ?? null;
$currentSearch = $currentSearch ?? null;
$totalPosts = $totalPosts ?? 0;
$totalHits = $totalHits ?? 0;
$totalPostsCount = $totalPostsCount ?? 0;
$totalUsers = $totalUsers ?? 0;
$mesesEsp = ['', 'Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'];
$mesesEng = ['', 'January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
$meses = $currentLang === 'en' ? $mesesEng : $mesesEsp;
?>

<div class="blog-layout" style="display: flex; gap: 2rem;">
    <!-- Main Content -->
    <div class="main-content" style="flex: 1; min-width: 0;">
        <!-- Category Tabs -->
        <div class="category-tabs" style="display: flex; gap: 0.5rem; flex-wrap: wrap; margin-bottom: 1.5rem;">
            <?php foreach($categories as $cat): ?>
            <a href="<?= $baseUrl ?>/?cat=<?= urlencode($cat['category']) ?>" class="cat-tab <?= $currentCategory === $cat['category'] ? 'active' : '' ?>" style="padding: 0.5rem 1rem; border-radius: 50px; font-size: 0.85rem; background: <?= $currentCategory === $cat['category'] ? 'var(--primary)' : 'var(--bg-secondary)' ?>; color: <?= $currentCategory === $cat['category'] ? 'white' : 'var(--text)' ?>; border: 1px solid var(--border);">
                <?= htmlspecialchars($cat['category']) ?> <span style="opacity:0.7;">(<?= $cat['count'] ?>)</span>
            </a>
            <?php endforeach; ?>
        </div>
        
        <?php if($currentSearch || $currentCategory || $currentMes): ?>
        <div style="margin-bottom: 1rem; display: flex; align-items: center; gap: 1rem;">
            <span style="color: var(--text-secondary);">
                <?php if($currentSearch): ?>
                    <?= $currentLang === 'es' ? 'Resultados para' : 'Results for' ?>: <strong><?= htmlspecialchars($currentSearch) ?></strong>
                <?php elseif($currentCategory): ?>
                    <?= htmlspecialchars($currentCategory) ?>
                <?php elseif($currentMes): ?>
                    <?= $meses[(int)substr($currentMes, 5)] . ' ' . substr($currentMes, 0, 4) ?>
                <?php endif; ?>
            </span>
            <a href="<?= $baseUrl ?>/" style="color: var(--primary); font-size: 0.9rem;"><i class="fas fa-times"></i> <?= $currentLang === 'es' ? 'Limpiar' : 'Clear' ?></a>
        </div>
        <?php endif; ?>
        
        <?php if(empty($posts)): ?>
        <div style="text-align: center; padding: 3rem; color: var(--text-secondary);">
            <i class="fas fa-search" style="font-size: 3rem; margin-bottom: 1rem;"></i>
            <h3><?= $lang['no_results'] ?? 'No se encontraron resultados' ?></h3>
        </div>
        <?php else: ?>
            <?php foreach($posts as $post): ?>
            <article class="post-card" style="background: var(--bg-secondary); border: 1px solid var(--border); border-radius: var(--radius-lg); padding: 1.5rem; margin-bottom: 1.5rem; transition: all 0.3s;">
                <div style="display: flex; gap: 0.5rem; margin-bottom: 0.8rem; font-size: 0.85rem;">
                    <a href="<?= $baseUrl ?>/?cat=<?= urlencode($post['category']) ?>" style="background: var(--primary); color: white; padding: 0.2rem 0.8rem; border-radius: 50px;"><?= htmlspecialchars($post['category']) ?></a>
                    <span style="color: var(--text-secondary);"><i class="fas fa-calendar-alt"></i> <?= strftime('%d %b %Y', strtotime($post['created_at'])) ?></span>
                </div>
                <h2 style="margin-bottom: 0.8rem; font-size: 1.3rem;"><a href="<?= $baseUrl ?>/post.php?id=<?= $post['id'] ?>" style="color: var(--text);"><?= htmlspecialchars($post['title']) ?></a></h2>
                <p style="color: var(--text-secondary); margin-bottom: 1rem;"><?= htmlspecialchars(mb_substr(strip_tags($post['content']), 0, 200)) ?>...</p>
                <div style="display: flex; justify-content: space-between; align-items: center; padding-top: 1rem; border-top: 1px solid var(--border);">
                    <span style="color: var(--text-secondary); font-size: 0.85rem;"><i class="fas fa-user"></i> <?= htmlspecialchars($post['author_name'] ?? 'Anónimo') ?></span>
                    <a href="<?= $baseUrl ?>/post.php?id=<?= $post['id'] ?>" class="btn" style="background: var(--primary); color: white; padding: 0.5rem 1rem; border-radius: var(--radius-sm); font-size: 0.9rem;"><?= $lang['read_more'] ?? 'Leer más' ?> <i class="fas fa-arrow-right"></i></a>
                </div>
            </article>
            <?php endforeach; ?>
            
            <!-- Pagination -->
            <?php if(isset($totalPages) && $totalPages > 1): ?>
            <div class="pagination" style="display: flex; justify-content: center; gap: 0.5rem; margin-top: 2rem;">
                <?php if($page > 1): ?>
                <a href="<?= $baseUrl ?>/?page=<?= $page-1 ?><?= $currentCategory ? '&cat=' . urlencode($currentCategory) : '' ?>" style="padding: 0.5rem 1rem; background: var(--bg-secondary); border: 1px solid var(--border); border-radius: var(--radius-sm); color: var(--text);">
                    <i class="fas fa-chevron-left"></i> <?= $currentLang === 'es' ? 'Anterior' : 'Previous' ?>
                </a>
                <?php endif; ?>
                
                <?php 
                $startPage = max(1, $page - 2);
                $endPage = min($totalPages, $page + 2);
                for($i = $startPage; $i <= $endPage; $i++): 
                ?>
                <a href="<?= $baseUrl ?>/?page=<?= $i ?><?= $currentCategory ? '&cat=' . urlencode($currentCategory) : '' ?>" style="padding: 0.5rem 1rem; background: <?= $i === $page ? 'var(--primary)' : 'var(--bg-secondary)' ?>; border: 1px solid var(--border); border-radius: var(--radius-sm); color: <?= $i === $page ? 'white' : 'var(--text)' ?>;">
                    <?= $i ?>
                </a>
                <?php endfor; ?>
                
                <?php if($page < $totalPages): ?>
                <a href="<?= $baseUrl ?>/?page=<?= $page+1 ?><?= $currentCategory ? '&cat=' . urlencode($currentCategory) : '' ?>" style="padding: 0.5rem 1rem; background: var(--bg-secondary); border: 1px solid var(--border); border-radius: var(--radius-sm); color: var(--text);">
                    <?= $currentLang === 'es' ? 'Siguiente' : 'Next' ?> <i class="fas fa-chevron-right"></i>
                </a>
                <?php endif; ?>
            </div>
            <?php endif; ?>
        <?php endif; ?>
    </div>
    
    <!-- Sidebar -->
    <aside class="sidebar" style="width: 320px; flex-shrink: 0;">
        <!-- About -->
        <div class="sidebar-widget" style="background: var(--bg-secondary); border: 1px solid var(--border); border-radius: var(--radius-lg); padding: 1.2rem; margin-bottom: 1.5rem;">
            <h3 class="widget-title" style="color: var(--primary); font-size: 1rem; margin-bottom: 1rem; padding-bottom: 0.5rem; border-bottom: 2px solid var(--primary);"><i class="fas fa-user-circle"></i> <?= $lang['sidebar_about'] ?? 'Sobre el Autor' ?></h3>
            <p style="color: var(--text-secondary); font-size: 0.9rem;"><?= $currentLang === 'es' ? 'Ingeniero en Computación de Nicaragua' : 'Nicaraguan Computer Engineer' ?></p>
            <a href="<?= $baseUrl ?>/about.php" style="color: var(--primary); font-size: 0.9rem; display: inline-block; margin-top: 0.5rem;"><?= $currentLang === 'es' ? 'Ver perfil completo' : 'View full profile' ?> <i class="fas fa-arrow-right"></i></a>
        </div>
        
        <!-- Search -->
        <div class="sidebar-widget" style="background: var(--bg-secondary); border: 1px solid var(--border); border-radius: var(--radius-lg); padding: 1.2rem; margin-bottom: 1.5rem;">
            <h3 class="widget-title" style="color: var(--primary); font-size: 1rem; margin-bottom: 1rem; padding-bottom: 0.5rem; border-bottom: 2px solid var(--primary);"><i class="fas fa-search"></i> <?= $lang['nav_search'] ?? 'Buscar' ?></h3>
            <form method="get" action="<?= $baseUrl ?>/" style="display: flex; gap: 0.3rem;">
                <input type="text" name="search" placeholder="<?= $lang['nav_search'] ?? 'Buscar' ?>..." value="<?= htmlspecialchars($currentSearch ?? '') ?>" style="flex: 1; padding: 0.6rem; border: 1px solid var(--border); border-radius: var(--radius-sm); background: var(--bg); color: var(--text);">
                <button type="submit" style="padding: 0.6rem 0.8rem; background: var(--primary); color: white; border: none; border-radius: var(--radius-sm); cursor: pointer;"><i class="fas fa-search"></i></button>
            </form>
        </div>
        
        <!-- Categories -->
        <div class="sidebar-widget" style="background: var(--bg-secondary); border: 1px solid var(--border); border-radius: var(--radius-lg); padding: 1.2rem; margin-bottom: 1.5rem;">
            <h3 class="widget-title" style="color: var(--primary); font-size: 1rem; margin-bottom: 1rem; padding-bottom: 0.5rem; border-bottom: 2px solid var(--primary);"><i class="fas fa-folder"></i> <?= $lang['sidebar_categories'] ?? 'Categorías' ?></h3>
            <ul style="list-style: none;">
                <?php foreach($categories as $cat): ?>
                <li style="margin-bottom: 0.5rem;">
                    <a href="<?= $baseUrl ?>/?cat=<?= urlencode($cat['category']) ?>" style="display: flex; justify-content: space-between; padding: 0.5rem; border-radius: var(--radius-sm); color: var(--text); font-size: 0.9rem; <?= $currentCategory === $cat['category'] ? 'background: var(--primary); color: white;' : '' ?>">
                        <span><i class="fas fa-angle-right"></i> <?= htmlspecialchars($cat['category']) ?></span>
                        <span style="opacity: 0.7;"><?= $cat['count'] ?></span>
                    </a>
                </li>
                <?php endforeach; ?>
            </ul>
        </div>
        
        <!-- Archives -->
        <div class="sidebar-widget" style="background: var(--bg-secondary); border: 1px solid var(--border); border-radius: var(--radius-lg); padding: 1.2rem; margin-bottom: 1.5rem;">
            <h3 class="widget-title" style="color: var(--primary); font-size: 1rem; margin-bottom: 1rem; padding-bottom: 0.5rem; border-bottom: 2px solid var(--primary);"><i class="fas fa-calendar-alt"></i> <?= $lang['sidebar_archives'] ?? 'Archivos' ?></h3>
            <ul style="list-style: none;">
                <?php foreach($archives as $a): ?>
                <li style="margin-bottom: 0.5rem;">
                    <a href="<?= $baseUrl ?>/?mes=<?= $a['mes'] ?>" style="display: flex; justify-content: space-between; padding: 0.5rem; border-radius: var(--radius-sm); color: var(--text); font-size: 0.9rem;">
                        <span><i class="fas fa-chevron-right"></i> <?= $meses[(int)$a['mes_num']] . ' ' . $a['anio'] ?></span>
                        <span style="opacity: 0.7;"><?= $a['total'] ?></span>
                    </a>
                </li>
                <?php endforeach; ?>
            </ul>
        </div>
        
        <!-- Stats -->
        <div class="sidebar-widget" style="background: var(--bg-secondary); border: 1px solid var(--border); border-radius: var(--radius-lg); padding: 1.2rem;">
            <h3 class="widget-title" style="color: var(--primary); font-size: 1rem; margin-bottom: 1rem; padding-bottom: 0.5rem; border-bottom: 2px solid var(--primary);"><i class="fas fa-chart-line"></i> <?= $lang['sidebar_stats'] ?? 'Estadísticas' ?></h3>
            <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 0.8rem;">
                <div style="grid-column: span 2; background: linear-gradient(135deg, var(--primary), var(--header-bg)); border-radius: var(--radius-md); padding: 1rem; text-align: center; color: white;">
                    <div style="font-size: 1.5rem; font-weight: 700;"><?= number_format($totalHits) ?></div>
                    <div style="font-size: 0.75rem; opacity: 0.9;"><?= $currentLang === 'es' ? 'Visitas' : 'Visits' ?></div>
                </div>
                <div style="background: var(--bg); border-radius: var(--radius-md); padding: 0.8rem; text-align: center;">
                    <div style="font-size: 1.2rem; font-weight: 700; color: var(--primary);"><?= $totalPostsCount ?></div>
                    <div style="font-size: 0.75rem; color: var(--text-secondary);"><?= $currentLang === 'es' ? 'Posts' : 'Posts' ?></div>
                </div>
                <div style="background: var(--bg); border-radius: var(--radius-md); padding: 0.8rem; text-align: center;">
                    <div style="font-size: 1.2rem; font-weight: 700; color: var(--primary);"><?= count($categories) ?></div>
                    <div style="font-size: 0.75rem; color: var(--text-secondary);"><?= $lang['sidebar_categories'] ?? 'Categorías' ?></div>
                </div>
                <div style="background: var(--bg); border-radius: var(--radius-md); padding: 0.8rem; text-align: center; grid-column: span 2;">
                    <div style="font-size: 1.2rem; font-weight: 700; color: var(--primary);"><?= $totalUsers ?></div>
                    <div style="font-size: 0.75rem; color: var(--text-secondary);"><?= $currentLang === 'es' ? 'Usuarios' : 'Users' ?></div>
                </div>
            </div>
        </div>
    </aside>
</div>
