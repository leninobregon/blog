<?php
if(session_status() === PHP_SESSION_NONE) session_start();
header('Cache-Control: no-cache, no-store, must-revalidate');
header('Pragma: no-cache');
header('Expires: 0');
setlocale(LC_TIME, 'es_ES.UTF-8', 'es_ES', 'spanish');
if(empty($_SESSION['logged'])) { header('Location: login.php'); exit; }
include '../includes/functions.php';

$currentTheme = getActiveTheme();
$colors = getThemeColors($currentTheme);

// Handle audit log actions
if($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['action'])) {
    $pdo = getDB();
    if($_POST['action'] === 'delete_old_logs') {
        $pdo->exec("DELETE FROM audit_logs WHERE created_at < DATE_SUB(NOW(), INTERVAL 3 MONTH)");
        $msg = 'Registros de más de 3 meses eliminados';
    } elseif($_POST['action'] === 'delete_all_logs') {
        $pdo->exec("DELETE FROM audit_logs");
        $msg = 'Todos los registros eliminados';
    } elseif($_POST['action'] === 'delete_log' && isset($_POST['log_id'])) {
        $stmt = $pdo->prepare("DELETE FROM audit_logs WHERE id = ?");
        $stmt->execute([$_POST['log_id']]);
        $msg = 'Registro eliminado';
    }
}

// Get filter
$filter = $_GET['filter'] ?? 'all';
$search = $_GET['search'] ?? '';

$where = '';
$params = [];
if($filter === 'login') {
    $where = "WHERE action IN ('admin_login', 'user_login', 'login_failed', 'user_logout')";
} elseif($filter === 'posts') {
    $where = "WHERE action IN ('post_create', 'post_update', 'post_delete')";
} elseif($filter === 'users') {
    $where = "WHERE action IN ('user_create', 'user_update', 'user_delete', 'password_change')";
}

if($search) {
    $where .= ($where ? ' AND ' : 'WHERE ') . "(username LIKE ? OR details LIKE ? OR ip_address LIKE ?)";
    $searchParam = "%{$search}%";
    $params = [$searchParam, $searchParam, $searchParam];
}

$sql = "SELECT * FROM audit_logs {$where} ORDER BY created_at DESC LIMIT 100";
if($params) {
    $stmt = getDB()->prepare($sql);
    $stmt->execute($params);
    $auditLogs = $stmt->fetchAll(PDO::FETCH_ASSOC);
} else {
    $auditLogs = getDB()->query($sql)->fetchAll(PDO::FETCH_ASSOC);
}
?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Auditoría - <?= CONFIG['site_name'] ?></title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            <?php foreach($colors as $k=>$v): ?><?php echo "--$k: $v;"; ?><?php endforeach; ?>
            --shadow-sm: 0 2px 8px rgba(0,0,0,0.08);
            --shadow-md: 0 4px 20px rgba(0,0,0,0.12);
            --shadow-lg: 0 8px 40px rgba(0,0,0,0.15);
            --radius-sm: 8px;
            --radius-md: 12px;
            --radius-lg: 20px;
        }
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Poppins', sans-serif; background: var(--bg); color: var(--text); }
        
        /* Header */
        .header { background: var(--header-bg); padding: 1rem 2rem; display: flex; justify-content: space-between; align-items: center; }
        .header h1 { color: var(--header-text); font-size: 1.5rem; }
        .header a { color: var(--header-text); text-decoration: none; display: flex; align-items: center; gap: 0.5rem; }
        
        /* Container */
        .container { max-width: 1400px; margin: 0 auto; padding: 2rem; }
        
        /* Filters */
        .filters { display: flex; gap: 1rem; margin-bottom: 1.5rem; flex-wrap: wrap; align-items: center; }
        .filters a { padding: 0.5rem 1rem; background: var(--bg-secondary); border: 1px solid var(--border); border-radius: var(--radius-sm); color: var(--text); text-decoration: none; transition: all 0.3s; }
        .filters a:hover, .filters a.active { background: var(--primary); color: white; border-color: var(--primary); }
        .filters form { display: flex; gap: 0.5rem; }
        .filters input { padding: 0.5rem 1rem; border: 1px solid var(--border); border-radius: var(--radius-sm); background: var(--bg); color: var(--text); }
        .filters button { padding: 0.5rem 1rem; background: var(--primary); color: white; border: none; border-radius: var(--radius-sm); cursor: pointer; }
        
        /* Actions */
        .actions { display: flex; gap: 0.5rem; margin-bottom: 1.5rem; }
        .btn { padding: 0.5rem 1rem; border: none; border-radius: var(--radius-sm); cursor: pointer; font-weight: 500; display: inline-flex; align-items: center; gap: 0.3rem; text-decoration: none; }
        .btn-primary { background: var(--primary); color: white; }
        .btn-secondary { background: var(--bg-secondary); color: var(--text); border: 1px solid var(--border); }
        .btn-danger { background: #ef4444; color: white; }
        .btn:hover { opacity: 0.9; }
        
        /* Table */
        .table-container { background: var(--bg-secondary); border: 1px solid var(--border); border-radius: var(--radius-md); overflow: hidden; }
        table { width: 100%; border-collapse: collapse; }
        th { background: var(--bg); padding: 1rem; text-align: left; font-weight: 600; border-bottom: 2px solid var(--border); }
        td { padding: 0.75rem 1rem; border-bottom: 1px solid var(--border); vertical-align: middle; }
        tr:hover { background: var(--bg); }
        
        .action-badge { padding: 0.25rem 0.5rem; border-radius: 4px; font-size: 0.8rem; font-weight: 600; }
        .action-login { background: #d1fae5; color: #059669; }
        .action-failed { background: #fee2e2; color: #dc2626; }
        .action-post { background: #dbeafe; color: #2563eb; }
        .action-user { background: #f3e8ff; color: #7c3aed; }
        .action-password { background: #ffedd5; color: #ea580c; }
        
        .ip-address { font-family: monospace; font-size: 0.85rem; color: var(--text-secondary); }
        .details { font-size: 0.85rem; color: var(--text-secondary); max-width: 200px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap; }
        .date { font-size: 0.8rem; color: var(--text-secondary); }
        
        .empty { padding: 3rem; text-align: center; color: var(--text-secondary); }
        
        .delete-btn { padding: 0.3rem 0.6rem; background: #fee2e2; color: #dc2626; border: none; border-radius: 4px; cursor: pointer; }
        .delete-btn:hover { background: #fecaca; }
        
        /* Message */
        .msg { padding: 1rem; background: #d1fae5; color: #059669; border-radius: var(--radius-sm); margin-bottom: 1rem; }
        
        /* Theme switcher */
        .theme-float { position: fixed; bottom: 20px; right: 20px; display: flex; gap: 8px; background: var(--bg-secondary); padding: 8px 12px; border-radius: 50px; box-shadow: var(--shadow-lg); z-index: 999; }
        .theme-dot { width: 28px; height: 28px; border-radius: 50%; cursor: pointer; border: 2px solid transparent; transition: all 0.3s; }
        .theme-dot:hover, .theme-dot.active { transform: scale(1.2); border-color: var(--text); }
    </style>
</head>
<body>
    <div class="header">
        <h1><i class="fas fa-shield-alt"></i> Registro de Auditoría</h1>
        <a href="dashboard.php"><i class="fas fa-arrow-left"></i> Volver al Dashboard</a>
    </div>
    
    <div class="container">
        <?php if(isset($msg)): ?>
        <div class="msg"><i class="fas fa-check-circle"></i> <?= $msg ?></div>
        <?php endif; ?>
        
        <div class="filters">
            <a href="audit.php" class="<?= $filter === 'all' ? 'active' : '' ?>">Todos</a>
            <a href="audit.php?filter=login" class="<?= $filter === 'login' ? 'active' : '' ?>"><i class="fas fa-sign-in-alt"></i> Logins</a>
            <a href="audit.php?filter=posts" class="<?= $filter === 'posts' ? 'active' : '' ?>"><i class="fas fa-pen"></i> Publicaciones</a>
            <a href="audit.php?filter=users" class="<?= $filter === 'users' ? 'active' : '' ?>"><i class="fas fa-users"></i> Usuarios</a>
            
            <form method="GET" style="margin-left: auto;">
                <input type="hidden" name="filter" value="<?= $filter ?>">
                <input type="text" name="search" placeholder="Buscar..." value="<?= htmlspecialchars($search) ?>">
                <button type="submit"><i class="fas fa-search"></i></button>
            </form>
        </div>
        
        <div class="actions">
            <form method="POST">
                <input type="hidden" name="action" value="delete_old_logs">
                <button type="submit" class="btn btn-secondary" onclick="return confirm('¿Eliminar registros de más de 3 meses?')">
                    <i class="fas fa-trash"></i> Eliminar > 3 meses
                </button>
            </form>
            <form method="POST" onsubmit="return confirm('¿Eliminar TODOS los registros? Esta acción no se puede deshacer.')">
                <input type="hidden" name="action" value="delete_all_logs">
                <button type="submit" class="btn btn-danger">
                    <i class="fas fa-trash-alt"></i> Eliminar Todo
                </button>
            </form>
        </div>
        
        <div class="table-container">
            <?php if(empty($auditLogs)): ?>
            <div class="empty">
                <i class="fas fa-inbox" style="font-size: 2rem; margin-bottom: 1rem;"></i>
                <p>No hay registros de auditoría</p>
            </div>
            <?php else: ?>
            <table>
                <thead>
                    <tr>
                        <th>Acción</th>
                        <th>Usuario</th>
                        <th>IP</th>
                        <th>Detalles</th>
                        <th>Fecha</th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>
                    <?php foreach($auditLogs as $log): ?>
                    <tr>
                        <td>
                            <?php 
                            $actionClass = 'action-user';
                            if(in_array($log['action'], ['admin_login'])) $actionClass = 'action-login';
                            elseif($log['action'] === 'login_failed') $actionClass = 'action-failed';
                            elseif(in_array($log['action'], ['post_create', 'post_update', 'post_delete'])) $actionClass = 'action-post';
                            elseif(in_array($log['action'], ['password_change'])) $actionClass = 'action-password';
                            ?>
                            <span class="action-badge <?= $actionClass ?>"><?= htmlspecialchars($log['action']) ?></span>
                        </td>
                        <td><?= htmlspecialchars($log['username']) ?></td>
                        <td class="ip-address"><?= htmlspecialchars($log['ip_address']) ?></td>
                        <td class="details" title="<?= htmlspecialchars($log['details'] ?? '') ?>"><?= htmlspecialchars($log['details'] ?? '-') ?></td>
                        <td class="date"><?= strftime('%d/%b/%Y %H:%M', strtotime($log['created_at'])) ?></td>
                        <td>
                            <form method="POST">
                                <input type="hidden" name="action" value="delete_log">
                                <input type="hidden" name="log_id" value="<?= $log['id'] ?>">
                                <button type="submit" class="delete-btn" onclick="return confirm('¿Eliminar este registro?')">
                                    <i class="fas fa-times"></i>
                                </button>
                            </form>
                        </td>
                    </tr>
                    <?php endforeach; ?>
                </tbody>
            </table>
            <?php endif; ?>
        </div>
    </div>
    
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
    </div>
    
    <script>
    function setTheme(theme) {
        document.cookie = 'theme=' + theme + '; path=/; max-age=31536000';
        location.reload();
    }
    </script>
</body>
</html>
