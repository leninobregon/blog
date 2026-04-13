<?php
/**
 * Post View
 */
$post = $post ?? [];
$content = $content ?? '';
$readingTime = $readingTime ?? 1;
$comments = $comments ?? [];
$relatedPosts = $relatedPosts ?? [];
$mostViewed = $mostViewed ?? [];
$toc = $toc ?? [];
$shareTitle = $shareTitle ?? '';
$shareUrl = $shareUrl ?? '';
$currentUrl = 'http://' . $_SERVER['HTTP_HOST'] . $_SERVER['REQUEST_URI'];
?>
<style>
    .blog-layout { display: flex; gap: 2rem; }
    .post-card { flex: 1; min-width: 0; background: var(--bg-secondary); border: 1px solid var(--border); border-radius: var(--radius-lg); padding: 2rem; }
    .post-sidebar { width: 320px; flex-shrink: 0; }
    .post-meta { display: flex; gap: 1rem; flex-wrap: wrap; margin-bottom: 1.5rem; padding-bottom: 1rem; border-bottom: 1px solid var(--border); font-size: 0.9rem; color: var(--text-secondary); }
    .post-content { line-height: 1.8; font-size: 1.05rem; }
    .post-content h1, .post-content h2, .post-content h3 { margin-top: 1.5rem; margin-bottom: 1rem; color: var(--primary); }
    .post-content ul, .post-content ol { margin: 1rem 0; padding-left: 2rem; }
    .post-content li { margin-bottom: 0.5rem; }
    .post-content p { margin-bottom: 1rem; }
    .toc-box { background: var(--bg); border: 1px solid var(--border); border-radius: var(--radius-md); padding: 1rem; margin-bottom: 1.5rem; }
    .toc-header { display: flex; justify-content: space-between; align-items: center; cursor: pointer; font-weight: 600; }
    .toc-list { margin-top: 1rem; padding-left: 1rem; }
    .toc-list li { margin-bottom: 0.5rem; }
    .toc-list a { color: var(--text); font-size: 0.9rem; }
    .share-box { background: var(--bg); border: 1px solid var(--border); border-radius: var(--radius-md); padding: 1.5rem; margin-top: 2rem; text-align: center; }
    .share-title { font-weight: 600; margin-bottom: 1rem; }
    .share-buttons { display: flex; justify-content: center; gap: 0.5rem; flex-wrap: wrap; }
    .share-btn { padding: 0.6rem 1rem; border-radius: var(--radius-sm); color: white; text-decoration: none; font-size: 0.9rem; display: flex; align-items: center; gap: 0.3rem; transition: all 0.3s; }
    .share-btn:hover { transform: translateY(-2px); }
    .share-btn.whatsapp { background: #25d366; }
    .share-btn.telegram { background: #0088cc; }
    .share-btn.facebook { background: #1877f2; }
    .share-btn.twitter { background: #1da1f2; }
    .sidebar-widget { background: var(--bg-secondary); border: 1px solid var(--border); border-radius: var(--radius-lg); padding: 1.2rem; margin-bottom: 1.5rem; }
    .widget-title { color: var(--primary); font-size: 1rem; margin-bottom: 1rem; padding-bottom: 0.5rem; border-bottom: 2px solid var(--primary); }
    .related-item, .popular-item { display: block; padding: 0.8rem 0; border-bottom: 1px solid var(--border); text-decoration: none; color: var(--text); transition: all 0.3s; }
    .related-item:hover, .popular-item:hover { color: var(--primary); }
    .related-item:last-child, .popular-item:last-child { border-bottom: none; }
    .related-title { display: block; font-weight: 500; }
    .related-date { font-size: 0.8rem; color: var(--text-secondary); }
    .popular-item { display: flex; align-items: center; gap: 0.8rem; }
    .popular-views { background: var(--primary); color: white; padding: 0.3rem 0.6rem; border-radius: var(--radius-sm); font-size: 0.8rem; font-weight: 600; }
    .comments-section { background: var(--bg-secondary); border: 1px solid var(--border); border-radius: var(--radius-lg); padding: 2rem; margin-top: 2rem; }
    .comment { padding: 1rem; border-bottom: 1px solid var(--border); }
    .comment:last-child { border-bottom: none; }
    .comment-header { display: flex; justify-content: space-between; margin-bottom: 0.5rem; font-size: 0.9rem; }
    .comment-header span:first-child { font-weight: 600; }
    .comment-date { color: var(--text-secondary); font-size: 0.8rem; }
    .comment-form textarea { width: 100%; padding: 1rem; border: 1px solid var(--border); border-radius: var(--radius-sm); background: var(--bg); color: var(--text); font-family: inherit; resize: vertical; min-height: 100px; margin-bottom: 1rem; }
    .login-prompt { background: var(--bg); padding: 1rem; border-radius: var(--radius-sm); text-align: center; color: var(--text-secondary); }
    .copy-code-btn { position: absolute; top: 0.5rem; right: 0.5rem; background: var(--primary); color: white; border: none; padding: 0.3rem 0.6rem; border-radius: var(--radius-sm); cursor: pointer; font-size: 0.8rem; }
    .back-to-top { position: fixed; bottom: 80px; right: 30px; width: 45px; height: 45px; background: var(--primary); color: white; border: none; border-radius: 50%; cursor: pointer; font-size: 1.2rem; box-shadow: var(--shadow-md); opacity: 0; visibility: hidden; transition: all 0.3s; }
    .back-to-top.visible { opacity: 1; visibility: visible; }
    .reading-progress { position: fixed; top: 0; left: 0; height: 4px; background: var(--primary); z-index: 9999; transition: width 0.1s; }
    .visit-counter { position: fixed; top: 70px; left: 20px; background: var(--primary); color: white; padding: 0.5rem 1rem; border-radius: 50px; font-size: 0.85rem; font-weight: 600; box-shadow: var(--shadow-md); z-index: 998; }
    @media (max-width: 768px) { .blog-layout { flex-direction: column; } .post-sidebar { width: 100%; } }
</style>

<div class="reading-progress" id="readingProgress"></div>
<div class="visit-counter"><i class="fas fa-eye"></i> <?= number_format((new SiteStats())->getTotalHits()) ?></div>

<div class="blog-layout">
    <article class="post-card">
        <h1 style="font-size: 1.8rem; margin-bottom: 1rem;"><?= htmlspecialchars($post['title']) ?></h1>
        
        <div class="post-meta">
            <span><i class="fas fa-folder"></i> <?= htmlspecialchars($post['category']) ?></span>
            <?php if(!empty($post['author_name'])): ?>
            <span><i class="fas fa-user"></i> <?= htmlspecialchars($post['author_name']) ?></span>
            <?php endif; ?>
            <span><i class="fas fa-calendar-alt"></i> <?= strftime('%d %b, %Y', strtotime($post['created_at'])) ?></span>
            <span><i class="fas fa-clock"></i> <?= $readingTime ?> <?= $lang['post_reading_time'] ?? 'min lectura' ?></span>
            <span><i class="fas fa-eye"></i> <?= number_format($post['views']) ?></span>
        </div>
        
        <?php if(!empty($toc) && count($toc) > 2): ?>
        <div class="toc-box">
            <div class="toc-header" onclick="document.getElementById('tocList').style.display = document.getElementById('tocList').style.display === 'none' ? 'block' : 'none'">
                <span><i class="fas fa-list"></i> <?= $lang['post_contents'] ?? 'Contenido' ?></span>
                <i class="fas fa-chevron-down"></i>
            </div>
            <ul class="toc-list" id="tocList">
                <?php foreach($toc as $item): ?>
                <li><a href="#<?= $item['slug'] ?>"><?= htmlspecialchars($item['text']) ?></a></li>
                <?php endforeach; ?>
            </ul>
        </div>
        <?php endif; ?>
        
        <div class="post-content">
            <?= $content ?>
        </div>
        
        <div class="share-box">
            <p class="share-title"><i class="fas fa-share-alt"></i> <?= $lang['post_share'] ?? 'Compartir' ?></p>
            <div class="share-buttons">
                <a href="https://wa.me/?text=<?= $shareTitle ?>%20<?= $shareUrl ?>" target="_blank" class="share-btn whatsapp"><i class="fab fa-whatsapp"></i> WhatsApp</a>
                <a href="https://t.me/share/url?url=<?= $shareUrl ?>" target="_blank" class="share-btn telegram"><i class="fab fa-telegram"></i> Telegram</a>
                <a href="https://www.facebook.com/sharer/sharer.php?u=<?= $shareUrl ?>" target="_blank" class="share-btn facebook"><i class="fab fa-facebook"></i> Facebook</a>
                <a href="https://twitter.com/intent/tweet?text=<?= $shareTitle ?>&url=<?= $shareUrl ?>" target="_blank" class="share-btn twitter"><i class="fab fa-twitter"></i> Twitter</a>
                <button class="share-btn" style="background: var(--secondary);" onclick="navigator.clipboard.writeText('<?= $currentUrl ?>'); this.innerHTML='<i class=\'fas fa-check\'></i> <?= $currentLang === 'es' ? 'Copiado' : 'Copied' ?>'"><i class="fas fa-link"></i> <?= $currentLang === 'es' ? 'Copiar' : 'Copy' ?></button>
            </div>
        </div>
        
        <a href="<?= $baseUrl ?>/" class="btn" style="display: inline-flex; align-items: center; gap: 0.5rem; padding: 0.7rem 1.2rem; background: var(--primary); color: white; border-radius: var(--radius-sm); margin-top: 1.5rem; text-decoration: none;">
            <i class="fas fa-arrow-left"></i> <?= $currentLang === 'es' ? 'Volver' : 'Back' ?>
        </a>
    </article>
    
    <aside class="post-sidebar">
        <div class="sidebar-widget">
            <h3 class="widget-title"><i class="fas fa-search"></i> <?= $lang['nav_search'] ?? 'Buscar' ?></h3>
            <form method="get" action="<?= $baseUrl ?>/" style="display: flex; gap: 0.3rem;">
                <input type="text" name="search" placeholder="<?= $lang['nav_search'] ?? 'Buscar' ?>..." style="flex: 1; padding: 0.6rem; border: 1px solid var(--border); border-radius: var(--radius-sm); background: var(--bg); color: var(--text);">
                <button type="submit" style="padding: 0.6rem 0.8rem; background: var(--primary); color: white; border: none; border-radius: var(--radius-sm);"><i class="fas fa-search"></i></button>
            </form>
        </div>
        
        <?php if(!empty($relatedPosts)): ?>
        <div class="sidebar-widget">
            <h3 class="widget-title"><i class="fas fa-bookmark"></i> <?= $lang['post_related'] ?? 'Relacionados' ?></h3>
            <?php foreach($relatedPosts as $rp): ?>
            <a href="<?= $baseUrl ?>/post.php?id=<?= $rp['id'] ?>" class="related-item">
                <span class="related-title"><?= htmlspecialchars($rp['title']) ?></span>
                <span class="related-date"><?= strftime('%d %b %Y', strtotime($rp['created_at'])) ?></span>
            </a>
            <?php endforeach; ?>
        </div>
        <?php endif; ?>
        
        <div class="sidebar-widget">
            <h3 class="widget-title"><i class="fas fa-fire"></i> <?= $currentLang === 'es' ? 'Más Vistos' : 'Most Viewed' ?></h3>
            <?php foreach($mostViewed as $mv): ?>
            <a href="<?= $baseUrl ?>/post.php?id=<?= $mv['id'] ?>" class="popular-item">
                <span class="popular-views"><?= number_format($mv['views']) ?></span>
                <span class="popular-title"><?= htmlspecialchars(mb_substr($mv['title'], 0, 40)) ?>...</span>
            </a>
            <?php endforeach; ?>
        </div>
        
        <div class="sidebar-widget">
            <h3 class="widget-title"><i class="fas fa-share-alt"></i> <?= $lang['post_share'] ?? 'Compartir' ?></h3>
            <div style="display: flex; gap: 0.5rem; flex-wrap: wrap;">
                <a href="https://wa.me/?text=<?= $shareUrl ?>" target="_blank" class="share-btn whatsapp"><i class="fab fa-whatsapp"></i></a>
                <a href="https://t.me/share/url?url=<?= $shareUrl ?>" target="_blank" class="share-btn telegram"><i class="fab fa-telegram"></i></a>
                <a href="https://www.facebook.com/sharer/sharer.php?u=<?= $shareUrl ?>" target="_blank" class="share-btn facebook"><i class="fab fa-facebook"></i></a>
                <a href="https://twitter.com/intent/tweet?text=<?= $shareTitle ?>&url=<?= $shareUrl ?>" target="_blank" class="share-btn twitter"><i class="fab fa-twitter"></i></a>
            </div>
        </div>
    </aside>
</div>

<div class="comments-section">
    <h3 style="margin-bottom: 1.5rem;"><i class="fas fa-comments"></i> <?= $lang['comments_title'] ?? 'Comentarios' ?> (<?= count($comments) ?>)</h3>
    
    <?php if(Session::isLoggedIn()): ?>
    <form method="post" class="comment-form">
        <textarea name="comment" placeholder="<?= $lang['comments_write'] ?? 'Escribe tu comentario...' ?>" required></textarea>
        <button type="submit" class="btn" style="background: var(--primary); color: white; padding: 0.8rem 1.5rem; border: none; border-radius: var(--radius-sm); cursor: pointer; font-weight: 600;">
            <i class="fas fa-paper-plane"></i> <?= $lang['send'] ?? 'Enviar' ?>
        </button>
    </form>
    <?php else: ?>
    <div class="login-prompt">
        <i class="fas fa-info-circle"></i> <a href="auth.php?redirect=<?= urlencode($baseUrl . '/post.php?id=' . $post['id']) ?>"><?= $currentLang === 'es' ? 'Inicia sesión' : 'Login' ?></a> <?= $currentLang === 'es' ? 'para comentar' : 'to comment' ?>
    </div>
    <?php endif; ?>
    
    <div style="margin-top: 1.5rem;">
        <?php if(empty($comments)): ?>
        <p style="text-align: center; color: var(--text-secondary); padding: 2rem;"><?= $lang['comments_empty'] ?? 'No hay comentarios' ?></p>
        <?php else: ?>
            <?php foreach($comments as $comment): ?>
            <div class="comment">
                <div class="comment-header">
                    <span><i class="fas fa-user"></i> <?= htmlspecialchars($comment['username']) ?></span>
                    <span class="comment-date"><?= strftime('%d %b, %Y %H:%M', strtotime($comment['created_at'])) ?></span>
                </div>
                <div style="margin-top: 0.5rem;"><?= nl2br(htmlspecialchars($comment['content'])) ?></div>
            </div>
            <?php endforeach; ?>
        <?php endif; ?>
    </div>
</div>

<button class="back-to-top" id="backToTop" onclick="window.scrollTo({top:0,behavior:'smooth'})">
    <i class="fas fa-arrow-up"></i>
</button>

<script>
// Reading progress
window.addEventListener('scroll', function() {
    const docHeight = document.documentElement.scrollHeight - window.innerHeight;
    const scrolled = (window.scrollY / docHeight) * 100;
    document.getElementById('readingProgress').style.width = scrolled + '%';
    
    // Back to top
    const btn = document.getElementById('backToTop');
    if(window.scrollY > 300) btn.classList.add('visible');
    else btn.classList.remove('visible');
});

// Copy code buttons
document.addEventListener('DOMContentLoaded', function() {
    document.querySelectorAll('.post-content pre').forEach(function(pre) {
        const btn = document.createElement('button');
        btn.className = 'copy-code-btn';
        btn.innerHTML = '<i class="fas fa-copy"></i> <?= $currentLang === 'es' ? 'Copiar' : 'Copy' ?>';
        btn.onclick = function() {
            const code = pre.querySelector('code') ? pre.querySelector('code').innerText : pre.innerText;
            navigator.clipboard.writeText(code);
            btn.innerHTML = '<i class="fas fa-check"></i> <?= $currentLang === 'es' ? 'Copiado' : 'Copied' ?>';
            setTimeout(() => btn.innerHTML = '<i class="fas fa-copy"></i> <?= $currentLang === 'es' ? 'Copiar' : 'Copy' ?>', 2000);
        };
        pre.style.position = 'relative';
        pre.appendChild(btn);
    });
});
</script>
