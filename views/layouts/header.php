<?php
/**
 * Header Layout - Mismo diseño original
 */
$config = require __DIR__ . '/../../config.php';
$currentLang = $currentLang ?? 'es';
$lang = $lang ?? [];
$currentTheme = $currentTheme ?? 'blue';
$colors = $colors ?? [];
$loggedUser = $loggedUser ?? null;
?>
<!DOCTYPE html>
<html lang="<?= $currentLang ?>">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><?= $config['site_name'] ?></title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&family=Fira+Code:wght@400;500&display=swap" rel="stylesheet">
    <style>
        :root {
            <?php foreach($colors as $k=>$v): ?>--<?= $k ?>: <?= $v ?>;<?php endforeach; ?>
            --shadow-sm: 0 2px 8px rgba(0,0,0,0.08);
            --shadow-md: 0 4px 20px rgba(0,0,0,0.12);
            --shadow-lg: 0 8px 40px rgba(0,0,0,0.15);
            --radius-sm: 8px;
            --radius-md: 12px;
            --radius-lg: 20px;
        }
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: var(--font-main); background: var(--bg); color: var(--text); line-height: 1.6; }
        a { color: var(--link); text-decoration: none; transition: all 0.3s; }
        a:hover { opacity: 0.8; }
        img { max-width: 100%; height: auto; }
        pre { background: var(--code-bg); color: var(--code-text); padding: 1rem; border-radius: var(--radius-sm); overflow-x: auto; font-family: var(--font-code); position: relative; }
        code { font-family: var(--font-code); background: var(--code-bg); color: var(--code-text); padding: 0.2rem 0.4rem; border-radius: 4px; font-size: 0.9em; }
        pre code { background: none; padding: 0; }
        .container { max-width: 1200px; margin: 0 auto; padding: 0 1rem; }
        
        /* Navbar */
        .navbar {
            background: var(--header-bg);
            padding: 0.8rem 2rem;
            position: sticky;
            top: 0;
            z-index: 1000;
            box-shadow: var(--shadow-md);
        }
        .navbar-content {
            max-width: 1200px;
            margin: 0 auto;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 1rem;
        }
        .navbar-brand {
            color: var(--header-text);
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 0.8rem;
        }
        .brand-icon {
            width: 50px;
            height: 50px;
            background: linear-gradient(135deg, var(--accent), var(--primary));
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5rem;
            color: white;
            box-shadow: 0 4px 15px rgba(0,0,0,0.2);
        }
        .brand-text { display: flex; flex-direction: column; }
        .brand-name { font-size: 1.3rem; font-weight: 700; color: var(--header-text); text-shadow: 1px 1px 2px rgba(0,0,0,0.2); }
        .brand-tagline { font-size: 0.8rem; color: rgba(255,255,255,0.95); font-weight: 600; letter-spacing: 0.5px; }
        
        .navbar-menu { display: flex; align-items: center; gap: 0.5rem; flex-wrap: wrap; }
        .nav-btn {
            color: var(--header-text);
            text-decoration: none;
            padding: 0.5rem 0.8rem;
            border-radius: var(--radius-sm);
            transition: all 0.3s;
            display: flex;
            align-items: center;
            gap: 0.3rem;
            font-size: 0.9rem;
        }
        .nav-btn:hover { background: rgba(255,255,255,0.2); }
        .nav-btn.active { background: var(--accent); }
        
        /* Categories */
        .categories {
            background: var(--bg-secondary);
            border-bottom: 1px solid var(--border);
            padding: 0.5rem 0;
            overflow-x: auto;
        }
        .categories-content {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 1rem;
            display: flex;
            gap: 0.5rem;
            white-space: nowrap;
        }
        .cat-btn {
            padding: 0.4rem 1rem;
            border-radius: 50px;
            font-size: 0.85rem;
            font-weight: 500;
            color: var(--text);
            text-decoration: none;
            border: 1px solid var(--border);
            transition: all 0.3s;
            flex-shrink: 0;
        }
        .cat-btn:hover, .cat-btn.active { background: var(--primary); color: white; border-color: var(--primary); }
        
        /* Footer */
        .newsletter-section {
            background: linear-gradient(135deg, var(--primary), var(--header-bg));
            color: white;
            padding: 3rem 1rem;
            text-align: center;
        }
        .newsletter-content { max-width: 600px; margin: 0 auto; }
        .newsletter-text h3 { font-size: 1.5rem; margin-bottom: 0.5rem; }
        .newsletter-form { display: flex; gap: 0.5rem; margin-top: 1rem; flex-wrap: wrap; justify-content: center; }
        .newsletter-form input { flex: 1; min-width: 200px; padding: 0.8rem 1rem; border: none; border-radius: var(--radius-sm); font-family: inherit; }
        .newsletter-form button { padding: 0.8rem 1.5rem; background: white; color: var(--primary); border: none; border-radius: var(--radius-sm); font-weight: 600; cursor: pointer; transition: all 0.3s; font-family: inherit; }
        .newsletter-form button:hover { transform: translateY(-2px); box-shadow: var(--shadow-md); }
        
        footer {
            background: #1a1a2e;
            color: rgba(255,255,255,0.8);
            padding: 2rem 1rem 1rem;
        }
        .footer-grid {
            max-width: 1100px;
            margin: 0 auto;
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 2rem;
        }
        .footer-section h4 { color: white; margin-bottom: 1rem; font-size: 1.1rem; }
        .footer-section a { display: block; color: rgba(255,255,255,0.7); padding: 0.3rem 0; transition: all 0.3s; }
        .footer-section a:hover { color: white; padding-left: 5px; }
        .footer-bottom { max-width: 1100px; margin: 2rem auto 0; padding-top: 1rem; border-top: 1px solid rgba(255,255,255,0.1); text-align: center; font-size: 0.9rem; }
        
        .lang-switcher { display: flex; gap: 0.3rem; }
        .lang-switcher .nav-btn { padding: 0.4rem 0.8rem; font-size: 0.85rem; }
        .lang-switcher .nav-btn.active { background: var(--accent); color: white; }
        
        .theme-float {
            position: fixed;
            bottom: 20px;
            right: 20px;
            display: flex;
            gap: 8px;
            background: var(--bg-secondary);
            padding: 8px 12px;
            border-radius: 50px;
            box-shadow: var(--shadow-lg);
            z-index: 999;
            flex-wrap: wrap;
            max-width: 320px;
            justify-content: center;
        }
        .theme-dot {
            width: 24px;
            height: 24px;
            border-radius: 50%;
            cursor: pointer;
            border: 2px solid transparent;
            transition: all 0.3s;
        }
        .theme-dot:hover, .theme-dot.active { transform: scale(1.2); border-color: var(--text); }
        
        @media (max-width: 768px) {
            .navbar { flex-direction: column; text-align: center; }
            .navbar-content { justify-content: center; }
            .footer-grid { grid-template-columns: 1fr; text-align: center; }
            .newsletter-form { flex-direction: column; }
        }
    </style>
</head>
<body>
    <nav class="navbar">
        <div class="navbar-content">
            <a href="<?= $baseUrl ?>/" class="navbar-brand">
                <div class="brand-icon"><i class="fas fa-blog"></i></div>
                <div class="brand-text">
                    <span class="brand-name"><?= $config['site_name'] ?></span>
                    <span class="brand-tagline"><?= $config['description'] ?></span>
                </div>
            </a>
            
            <!-- Buscador -->
            <form action="<?= $baseUrl ?>/search.php" method="GET" class="search-form" style="display: flex; align-items: center; gap: 0.5rem; margin: 0 1rem;">
                <input type="text" name="q" placeholder="<?= $lang['search'] ?? 'Buscar...' ?>" required style="padding: 0.5rem; border: 1px solid var(--border); border-radius: var(--radius-sm); background: var(--bg); color: var(--text);">
                <button type="submit" class="nav-btn" style="padding: 0.5rem 0.8rem;"><i class="fas fa-search"></i></button>
            </form>
            
            <div class="navbar-menu">
                <?php if($loggedUser): ?>
                    <a href="<?= $baseUrl ?>/profile.php" class="nav-btn">
                        <?php if(!empty($loggedUser['avatar'])): ?>
                        <img src="<?= $baseUrl ?>/<?= htmlspecialchars($loggedUser['avatar']) ?>" alt="" style="width:24px;height:24px;border-radius:50%;object-fit:cover;">
                        <?php else: ?>
                        <i class="fas fa-user"></i>
                        <?php endif; ?>
                        <?= htmlspecialchars($loggedUser['username']) ?>
                    </a>
                    <?php if(in_array($loggedUser['role'], ['admin', 'author'])): ?>
                    <a href="<?= $baseUrl ?>/user/index.php" class="nav-btn"><i class="fas fa-pen"></i> <?= $lang['nav_admin'] ?? 'Mi Panel' ?></a>
                    <?php endif; ?>
                    <?php if($loggedUser['role'] === 'admin'): ?>
                    <a href="<?= $baseUrl ?>/admin/" class="nav-btn" title="Admin"><i class="fas fa-cog"></i></a>
                    <?php endif; ?>
                    <a href="<?= $baseUrl ?>/logout.php" class="nav-btn"><i class="fas fa-sign-out-alt"></i></a>
                <?php else: ?>
                    <a href="auth.php" class="nav-btn"><i class="fas fa-sign-in-alt"></i> <?= $lang['nav_login'] ?? 'Login' ?></a>
                <?php endif; ?>
                
                <div class="lang-switcher">
                    <a href="?lang=es" class="nav-btn <?= $currentLang === 'es' ? 'active' : '' ?>" title="Español">ES</a>
                    <a href="?lang=en" class="nav-btn <?= $currentLang === 'en' ? 'active' : '' ?>" title="English">EN</a>
                </div>
                <a href="<?= $baseUrl ?>/about.php" class="nav-btn" title="<?= $lang['nav_about'] ?? 'Acerca de' ?>"><i class="fas fa-user-circle"></i></a>
                <a href="https://www.youtube.com/@leninobregonespinoza2160" target="_blank" class="nav-btn" title="YouTube"><i class="fab fa-youtube"></i></a>
            </div>
        </div>
    </nav>
    
    <div class="categories">
        <div class="categories-content">
            <a href="<?= $baseUrl ?>/" class="cat-btn"><?= $lang['nav_home'] ?? 'Inicio' ?></a>
            <?php if(isset($categories) && is_array($categories)): ?>
                <?php foreach($categories as $cat): ?>
                <a href="<?= $baseUrl ?>/?cat=<?= urlencode(is_array($cat) ? $cat['category'] : $cat) ?>" class="cat-btn <?= (isset($currentCategory) && $currentCategory === (is_array($cat) ? $cat['category'] : $cat)) ? 'active' : '' ?>">
                    <?= htmlspecialchars(is_array($cat) ? $cat['category'] : $cat) ?>
                </a>
                <?php endforeach; ?>
            <?php endif; ?>
        </div>
    </div>
    
    <!-- Theme Switcher - 20 Colors -->
    <div class="theme-float">
        <div class="theme-dot" onclick="setTheme('white')" title="Blanco" style="background: linear-gradient(135deg,#fff,#e2e8f0)"></div>
        <div class="theme-dot" onclick="setTheme('blue')" title="Azul" style="background: linear-gradient(135deg,#2563eb,#1e40af)"></div>
        <div class="theme-dot" onclick="setTheme('dark-blue')" title="Azul Oscuro" style="background: linear-gradient(135deg,#3b82f6,#1e3a8a)"></div>
        <div class="theme-dot" onclick="setTheme('black')" title="Negro" style="background: linear-gradient(135deg,#333,#000)"></div>
        <div class="theme-dot" onclick="setTheme('green')" title="Verde" style="background: linear-gradient(135deg,#38a169,#276749)"></div>
        <div class="theme-dot" onclick="setTheme('red')" title="Rojo" style="background: linear-gradient(135deg,#e53e3e,#c53030)"></div>
        <div class="theme-dot" onclick="setTheme('purple')" title="Morado" style="background: linear-gradient(135deg,#805ad5,#6b46c1)"></div>
        <div class="theme-dot" onclick="setTheme('orange')" title="Naranja" style="background: linear-gradient(135deg,#ea580c,#9a3412)"></div>
        <div class="theme-dot" onclick="setTheme('pink')" title="Rosa" style="background: linear-gradient(135deg,#d53f8c,#97266d)"></div>
        <div class="theme-dot" onclick="setTheme('teal')" title="Teal" style="background: linear-gradient(135deg,#0d9488,#0f766e)"></div>
        <div class="theme-dot" onclick="setTheme('yellow')" title="Amarillo" style="background: linear-gradient(135deg,#eab308,#a16207)"></div>
        <div class="theme-dot" onclick="setTheme('cyan')" title="Cian" style="background: linear-gradient(135deg,#06b6d4,#0e7490)"></div>
        <div class="theme-dot" onclick="setTheme('brown')" title="Marrón" style="background: linear-gradient(135deg,#d97706,#92400e)"></div>
        <div class="theme-dot" onclick="setTheme('indigo')" title="Índigo" style="background: linear-gradient(135deg,#6366f1,#4338ca)"></div>
        <div class="theme-dot" onclick="setTheme('lime')" title="Lima" style="background: linear-gradient(135deg,#84cc16,#4d7c0f)"></div>
        <div class="theme-dot" onclick="setTheme('amber')" title="Ámbar" style="background: linear-gradient(135deg,#f59e0b,#b45309)"></div>
        <div class="theme-dot" onclick="setTheme('rose')" title="Rojo Rosa" style="background: linear-gradient(135deg,#f43f5e,#be123c)"></div>
        <div class="theme-dot" onclick="setTheme('slate')" title="Pizarra" style="background: linear-gradient(135deg,#475569,#334155)"></div>
        <div class="theme-dot" onclick="setTheme('emerald')" title="Esmeralda" style="background: linear-gradient(135deg,#10b981,#047857)"></div>
        <div class="theme-dot" onclick="setTheme('sky')" title="Cielo" style="background: linear-gradient(135deg,#0ea5e9,#0369a1)"></div>
        <div class="theme-dot" onclick="setTheme('violet')" title="Violeta" style="background: linear-gradient(135deg,#8b5cf6,#6d28d9)"></div>
    </div>
    
    <script>
    function setTheme(theme) {
        document.cookie = 'theme=' + theme + '; path=/; max-age=31536000';
        location.reload();
    }
    var currentTheme = '<?= $currentTheme ?>';
    document.querySelectorAll('.theme-dot').forEach(function(el) {
        if(el.getAttribute('onclick').includes(currentTheme)) {
            el.classList.add('active');
        }
    });
    </script>
    
    <main class="container" style="padding-top: 1.5rem; padding-bottom: 2rem;">
