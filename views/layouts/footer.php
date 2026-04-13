    </main>
    
    <!-- Newsletter Section -->
    <section class="newsletter-section">
        <div class="newsletter-content">
            <div class="newsletter-text">
                <h3><i class="fas fa-envelope"></i> Newsletter</h3>
                <p><?= $lang['sidebar_newsletter_desc'] ?? 'Suscríbete para recibir actualizaciones' ?></p>
                <?php if(isset($_SESSION['subscribe_message'])): ?>
                <p style="margin-top:10px;font-weight:600;color:<?= strpos($_SESSION['subscribe_message'], '¡Gracias') !== false ? '#10b981' : '#fbbf24' ?>;">
                    <i class="fas fa-<?= strpos($_SESSION['subscribe_message'], '¡Gracias') !== false ? 'check-circle' : 'info-circle' ?>"></i> 
                    <?= $_SESSION['subscribe_message'] ?>
                </p>
                <?php unset($_SESSION['subscribe_message']); endif; ?>
            </div>
            <form method="post" action="<?= $baseUrl ?>/subscribe.php" class="newsletter-form">
                <input type="email" name="email" placeholder="<?= $lang['sidebar_email_placeholder'] ?? 'Tu correo...' ?>" required>
                <input type="text" name="name" placeholder="<?= $currentLang === 'es' ? 'Tu nombre (opcional)' : 'Your name (optional)' ?>">
                <button type="submit"><i class="fas fa-paper-plane"></i> <?= $lang['sidebar_subscribe'] ?? 'Suscribir' ?></button>
            </form>
        </div>
    </section>
    
    <footer>
        <div class="footer-grid">
            <div class="footer-section">
                <h4><i class="fas fa-blog"></i> <?= $config['site_name'] ?></h4>
                <p style="color:rgba(255,255,255,0.95);font-weight:600;font-size:1rem;"><?= $config['description'] ?></p>
            </div>
            <div class="footer-section">
                <h4><i class="fas fa-link"></i> <?= $lang['footer_links'] ?? 'Enlaces' ?></h4>
                <a href="<?= $baseUrl ?>/"><i class="fas fa-home"></i> <?= $lang['nav_home'] ?? 'Inicio' ?></a>
                <a href="<?= $baseUrl ?>/about.php"><i class="fas fa-user"></i> <?= $lang['nav_about'] ?? 'Acerca de' ?></a>
                <a href="<?= $baseUrl ?>/?cat=Linux"><i class="fab fa-linux"></i> Linux</a>
                <a href="<?= $baseUrl ?>/?cat=Programaci%C3%B3n"><i class="fas fa-code"></i> Programación</a>
                <a href="<?= $baseUrl ?>/admin/login.php"><i class="fas fa-cog"></i> Admin</a>
            </div>
            <div class="footer-section">
                <h4><i class="fas fa-share-alt"></i> <?= $currentLang === 'es' ? 'Redes' : 'Social' ?></h4>
                <?php if(!empty($config['youtube'])): ?>
                <a href="<?= $config['youtube'] ?>" target="_blank"><i class="fab fa-youtube"></i> YouTube</a>
                <?php endif; ?>
                <?php if(!empty($config['telegram'])): ?>
                <a href="<?= $config['telegram'] ?>" target="_blank"><i class="fab fa-telegram"></i> Telegram</a>
                <?php endif; ?>
                <?php if(!empty($config['facebook'])): ?>
                <a href="<?= $config['facebook'] ?>" target="_blank"><i class="fab fa-facebook"></i> Facebook</a>
                <?php endif; ?>
                <?php if(!empty($config['twitter'])): ?>
                <a href="<?= $config['twitter'] ?>" target="_blank"><i class="fab fa-twitter"></i> Twitter</a>
                <?php endif; ?>
            </div>
        </div>
        <div class="footer-bottom">
            <p>&copy; <?= date('Y') ?> <?= $config['author'] ?>. <?= $lang['footer_rights'] ?? 'Todos los derechos reservados' ?>.</p>
        </div>
    </footer>
    
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
    </script>
</body>
</html>
