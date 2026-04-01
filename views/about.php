<?php
/**
 * About View
 */
$about = $about ?? [];
$mesesEsp = ['', 'Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'];
?>
<style>
    .about-card { background: var(--bg-secondary); border: 1px solid var(--border); border-radius: var(--radius-lg); padding: 2rem; max-width: 900px; margin: 0 auto; }
    .about-header { text-align: center; margin-bottom: 2rem; }
    .about-photo { width: 150px; height: 150px; border-radius: 50%; object-fit: cover; border: 4px solid var(--primary); margin-bottom: 1rem; }
    .about-title { font-size: 1.8rem; color: var(--primary); }
    .about-subtitle { color: var(--text-secondary); margin-top: 0.5rem; }
    .about-section { margin-bottom: 2rem; }
    .about-section h3 { color: var(--primary); margin-bottom: 1rem; display: flex; align-items: center; gap: 0.5rem; }
    .about-section p, .about-section ul { line-height: 1.8; }
    .experience-list { list-style: none; }
    .experience-list li { padding: 0.8rem; background: var(--bg); border-radius: var(--radius-sm); margin-bottom: 0.5rem; display: flex; align-items: center; gap: 0.5rem; }
    .experience-list i { color: var(--primary); }
    .social-links { display: flex; gap: 1rem; flex-wrap: wrap; }
    .social-link { display: flex; align-items: center; gap: 0.5rem; padding: 0.8rem 1.5rem; background: var(--bg); border-radius: var(--radius-sm); color: var(--text); text-decoration: none; transition: all 0.3s; }
    .social-link:hover { background: var(--primary); color: white; }
</style>

<div class="about-card">
    <div class="about-header">
        <?php if(!empty($about['photo'])): ?>
        <img src="<?= $baseUrl ?>/<?= htmlspecialchars($about['photo']) ?>" alt="Foto" class="about-photo">
        <?php else: ?>
        <div class="about-photo" style="background: linear-gradient(135deg, var(--primary), var(--secondary)); display: flex; align-items: center; justify-content: center; font-size: 3rem; color: white; margin: 0 auto 1rem;"><i class="fas fa-user"></i></div>
        <?php endif; ?>
        <h1 class="about-title"><?= htmlspecialchars($about['title'] ?? 'Acerca de Mí') ?></h1>
        <p class="about-subtitle"><?= htmlspecialchars($about['subtitle'] ?? 'Ingeniero en Computación') ?></p>
    </div>
    
    <?php if(!empty($about['description'])): ?>
    <div class="about-section">
        <h3><i class="fas fa-user"></i> <?= $currentLang === 'es' ? 'Descripción' : 'Description' ?></h3>
        <p><?= nl2br(htmlspecialchars($about['description'])) ?></p>
    </div>
    <?php endif; ?>
    
    <?php if(!empty($about['experience'])): ?>
    <div class="about-section">
        <h3><i class="fas fa-briefcase"></i> <?= $lang['about_experience'] ?? 'Experiencia' ?></h3>
        <ul class="experience-list">
            <?php foreach(explode('|', $about['experience']) as $exp): ?>
            <li><i class="fas fa-check-circle"></i> <?= htmlspecialchars(trim($exp)) ?></li>
            <?php endforeach; ?>
        </ul>
    </div>
    <?php endif; ?>
    
    <?php if(!empty($about['goals'])): ?>
    <div class="about-section">
        <h3><i class="fas fa-bullseye"></i> <?= $lang['about_goals'] ?? 'Metas' ?></h3>
        <ul class="experience-list">
            <?php foreach(explode('|', $about['goals']) as $goal): ?>
            <li><i class="fas fa-star"></i> <?= htmlspecialchars(trim($goal)) ?></li>
            <?php endforeach; ?>
        </ul>
    </div>
    <?php endif; ?>
    
    <?php 
    $socialLinks = [
        ['url' => $about['youtube_url'] ?? '', 'icon' => 'fab fa-youtube', 'name' => 'YouTube', 'color' => '#ff0000'],
        ['url' => $about['facebook_url'] ?? '', 'icon' => 'fab fa-facebook', 'name' => 'Facebook', 'color' => '#1877f2'],
        ['url' => $about['twitter_url'] ?? '', 'icon' => 'fab fa-twitter', 'name' => 'Twitter', 'color' => '#1da1f2'],
        ['url' => $about['telegram_url'] ?? '', 'icon' => 'fab fa-telegram', 'name' => 'Telegram', 'color' => '#0088cc'],
        ['url' => $about['email'] ?? '', 'icon' => 'fas fa-envelope', 'name' => 'Email', 'color' => '#ea4335'],
    ];
    $hasSocial = array_filter($socialLinks, fn($s) => !empty($s['url']));
    ?>
    
    <?php if($hasSocial): ?>
    <div class="about-section">
        <h3><i class="fas fa-share-alt"></i> <?= $lang['about_social'] ?? 'Redes Sociales' ?></h3>
        <div class="social-links">
            <?php foreach($socialLinks as $social): ?>
            <?php if(!empty($social['url'])): ?>
            <a href="<?= htmlspecialchars($social['url']) ?>" target="_blank" class="social-link">
                <i class="<?= $social['icon'] ?>" style="color: <?= $social['color'] ?>;"></i> <?= $social['name'] ?>
            </a>
            <?php endif; ?>
            <?php endforeach; ?>
        </div>
    </div>
    <?php endif; ?>
</div>
