<?php
/**
 * Profile View
 */
$user = $user ?? [];
$msg = $msg ?? '';
$msgType = $msgType ?? '';
?>
<style>
    .profile-header {
        background: linear-gradient(135deg, var(--primary), var(--header-bg));
        border-radius: var(--radius-lg);
        padding: 2rem;
        text-align: center;
        color: white;
        margin-bottom: 2rem;
        max-width: 900px;
        margin-left: auto;
        margin-right: auto;
    }
    .avatar-container { width: 120px; height: 120px; margin: 0 auto 1rem; }
    .avatar-img { width: 100%; height: 100%; border-radius: 50%; object-fit: cover; border: 4px solid white; }
    .avatar-placeholder { width: 100%; height: 100%; border-radius: 50%; background: rgba(255,255,255,0.2); display: flex; align-items: center; justify-content: center; font-size: 3rem; border: 4px solid white; }
    .profile-name { font-size: 1.5rem; font-weight: 700; }
    .profile-username { opacity: 0.9; font-size: 0.9rem; }
    .profile-role { display: inline-block; padding: 0.25rem 1rem; background: rgba(255,255,255,0.2); border-radius: 50px; font-size: 0.8rem; margin-top: 0.5rem; }
    
    .card { background: var(--bg-secondary); border: 1px solid var(--border); border-radius: var(--radius-lg); padding: 2rem; margin-bottom: 1.5rem; max-width: 900px; margin-left: auto; margin-right: auto; }
    .card h2 { color: var(--primary); margin-bottom: 1.5rem; display: flex; align-items: center; gap: 0.5rem; font-size: 1.2rem; }
    .form-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 1rem; }
    .form-group { margin-bottom: 1rem; }
    .form-group label { display: block; margin-bottom: 0.5rem; font-weight: 600; font-size: 0.9rem; }
    .form-group input, .form-group textarea { width: 100%; padding: 0.8rem; border: 2px solid var(--border); border-radius: var(--radius-sm); background: var(--bg); color: var(--text); font-family: inherit; }
    .form-group textarea { min-height: 100px; resize: vertical; }
    .section-title { font-size: 0.9rem; font-weight: 600; color: var(--primary); margin: 1.5rem 0 1rem; padding-bottom: 0.5rem; border-bottom: 1px solid var(--border); }
    .social-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(180px, 1fr)); gap: 1rem; }
    .btn { display: inline-flex; align-items: center; gap: 0.5rem; padding: 0.8rem 1.5rem; background: var(--primary); color: white; border: none; border-radius: var(--radius-sm); cursor: pointer; font-weight: 600; }
    .btn-secondary { background: var(--secondary); }
    .msg { padding: 1rem; border-radius: var(--radius-sm); margin-bottom: 1.5rem; display: flex; align-items: center; gap: 0.5rem; }
    .msg.success { background: #d1fae5; color: #065f46; }
    .msg.error { background: #fee2e2; color: #991b1b; }
    .avatar-preview { width: 80px; height: 80px; border-radius: 50%; object-fit: cover; margin-top: 0.5rem; border: 2px solid var(--border); }
</style>

<?php if($msg): ?>
<div class="msg <?= $msgType ?>">
    <i class="fas fa-<?= $msgType === 'success' ? 'check-circle' : 'exclamation-circle' ?>"></i> <?= $msg ?>
</div>
<?php endif; ?>

<div class="profile-header">
    <div class="avatar-container">
        <?php if(!empty($user['avatar'])): ?>
        <img src="<?= $baseUrl ?>/<?= htmlspecialchars($user['avatar']) ?>" alt="Avatar" class="avatar-img">
        <?php else: ?>
        <div class="avatar-placeholder"><i class="fas fa-user"></i></div>
        <?php endif; ?>
    </div>
    <div class="profile-name"><?= htmlspecialchars(($user['first_name'] ?? '') . ' ' . ($user['last_name'] ?? '')) ?: $user['username'] ?></div>
    <div class="profile-username">@<?= htmlspecialchars($user['username']) ?></div>
    <div class="profile-role"><i class="fas fa-shield-alt"></i> <?= ucfirst($user['role']) ?></div>
</div>

<div class="card">
    <h2><i class="fas fa-user-edit"></i> <?= $currentLang === 'es' ? 'Editar Perfil' : 'Edit Profile' ?></h2>
    <form method="post" enctype="multipart/form-data">
        <input type="hidden" name="action" value="update_profile">
        
        <p class="section-title"><i class="fas fa-camera"></i> <?= $currentLang === 'es' ? 'Foto de Perfil' : 'Profile Photo' ?></p>
        <div class="form-group">
            <input type="file" name="avatar" accept="image/*" id="avatarInput">
            <img src="" alt="Preview" class="avatar-preview" id="avatarPreview" style="display:none;">
        </div>
        
        <p class="section-title"><i class="fas fa-id-card"></i> <?= $currentLang === 'es' ? 'Datos Personales' : 'Personal Info' ?></p>
        <div class="form-grid">
            <div class="form-group">
                <label><i class="fas fa-envelope"></i> Email</label>
                <input type="email" value="<?= htmlspecialchars($user['email'] ?? '') ?>" readonly style="background: var(--bg-secondary);">
            </div>
            <div class="form-group">
                <label><i class="fas fa-user"></i> <?= $currentLang === 'es' ? 'Nombre' : 'First Name' ?></label>
                <input type="text" name="first_name" value="<?= htmlspecialchars($user['first_name'] ?? '') ?>">
            </div>
            <div class="form-group">
                <label><i class="fas fa-user"></i> <?= $currentLang === 'es' ? 'Apellido' : 'Last Name' ?></label>
                <input type="text" name="last_name" value="<?= htmlspecialchars($user['last_name'] ?? '') ?>">
            </div>
            <div class="form-group">
                <label><i class="fas fa-phone"></i> <?= $currentLang === 'es' ? 'Teléfono' : 'Phone' ?></label>
                <input type="text" name="phone" value="<?= htmlspecialchars($user['phone'] ?? '') ?>">
            </div>
        </div>
        <div class="form-group">
            <label><i class="fas fa-align-left"></i> <?= $currentLang === 'es' ? 'Biografía' : 'Bio' ?></label>
            <textarea name="bio"><?= htmlspecialchars($user['bio'] ?? '') ?></textarea>
        </div>
        
        <p class="section-title"><i class="fas fa-share-alt"></i> <?= $lang['about_social'] ?? 'Redes Sociales' ?></p>
        <div class="social-grid">
            <div class="form-group">
                <label><i class="fab fa-facebook"></i> Facebook</label>
                <input type="text" name="facebook" value="<?= htmlspecialchars($user['facebook'] ?? '') ?>" placeholder="https://facebook.com/usuario">
            </div>
            <div class="form-group">
                <label><i class="fab fa-twitter"></i> Twitter/X</label>
                <input type="text" name="twitter" value="<?= htmlspecialchars($user['twitter'] ?? '') ?>" placeholder="https://twitter.com/usuario">
            </div>
            <div class="form-group">
                <label><i class="fab fa-telegram"></i> Telegram</label>
                <input type="text" name="telegram" value="<?= htmlspecialchars($user['telegram'] ?? '') ?>" placeholder="https://t.me/usuario">
            </div>
            <div class="form-group">
                <label><i class="fab fa-instagram"></i> Instagram</label>
                <input type="text" name="instagram" value="<?= htmlspecialchars($user['instagram'] ?? '') ?>" placeholder="https://instagram.com/usuario">
            </div>
            <div class="form-group">
                <label><i class="fab fa-youtube"></i> YouTube</label>
                <input type="text" name="youtube" value="<?= htmlspecialchars($user['youtube'] ?? '') ?>" placeholder="https://youtube.com/@canal">
            </div>
            <div class="form-group">
                <label><i class="fab fa-linkedin"></i> LinkedIn</label>
                <input type="text" name="linkedin" value="<?= htmlspecialchars($user['linkedin'] ?? '') ?>" placeholder="https://linkedin.com/in/usuario">
            </div>
            <div class="form-group">
                <label><i class="fas fa-globe"></i> Website</label>
                <input type="text" name="website" value="<?= htmlspecialchars($user['website'] ?? '') ?>" placeholder="https://miweb.com">
            </div>
        </div>
        
        <button type="submit" class="btn" style="margin-top: 1rem;"><i class="fas fa-save"></i> <?= $currentLang === 'es' ? 'Guardar Cambios' : 'Save Changes' ?></button>
    </form>
</div>

<div class="card">
    <h2><i class="fas fa-key"></i> <?= $currentLang === 'es' ? 'Cambiar Contraseña' : 'Change Password' ?></h2>
    <form method="post">
        <input type="hidden" name="action" value="change_password">
        <div class="form-group">
            <label><i class="fas fa-envelope"></i> <?= $currentLang === 'es' ? 'Usuario o Email' : 'Username or Email' ?></label>
            <input type="text" name="identifier" required>
        </div>
        <div class="form-grid">
            <div class="form-group">
                <label><i class="fas fa-lock"></i> <?= $currentLang === 'es' ? 'Contraseña Actual' : 'Current Password' ?></label>
                <input type="password" name="current_password" required>
            </div>
            <div class="form-group">
                <label><i class="fas fa-lock"></i> <?= $currentLang === 'es' ? 'Nueva Contraseña' : 'New Password' ?></label>
                <input type="password" name="new_password" required minlength="6">
            </div>
            <div class="form-group">
                <label><i class="fas fa-lock"></i> <?= $currentLang === 'es' ? 'Confirmar' : 'Confirm' ?></label>
                <input type="password" name="confirm_password" required>
            </div>
        </div>
        <button type="submit" class="btn btn-secondary" style="margin-top: 1rem;"><i class="fas fa-key"></i> <?= $currentLang === 'es' ? 'Cambiar Contraseña' : 'Change Password' ?></button>
    </form>
</div>
