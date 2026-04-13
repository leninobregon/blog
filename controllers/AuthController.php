<?php
/**
 * AuthController - Login, Registro, Recuperación
 */
class AuthController extends Controller {
    
    public function login(): void {
        if (Session::isLoggedIn()) {
            $role = Session::get('role', 'user');
            if ($role === 'admin') {
                $this->redirect($this->getBaseUrl() . '/admin/dashboard.php');
            } else {
                $this->redirect($this->getBaseUrl() . '/');
            }
            return;
        }
        
        // Get language (must be before POST handling)
        $currentLang = 'es';
        if (isset($_COOKIE['language']) && in_array($_COOKIE['language'], ['es', 'en'])) {
            $currentLang = $_COOKIE['language'];
        }
        
        // Get theme
        $validThemes = ['white','blue','dark-blue','black','green','red','purple','orange','pink','teal','yellow','cyan','brown','indigo','lime','amber','rose','slate','emerald','sky','violet'];
        $currentTheme = (isset($_COOKIE['theme']) && in_array($_COOKIE['theme'], $validThemes)) ? $_COOKIE['theme'] : 'blue';
        $colors = getThemeColors($currentTheme);
        
        // Load language strings
        $langFile = __DIR__ . '/../languages/' . $currentLang . '.php';
        $lang = file_exists($langFile) ? require $langFile : require __DIR__ . '/../languages/es.php';
        
        $config = require __DIR__ . '/../config.php';
        
        // Base URL
        $baseUrl = $this->getBaseUrl();
        
        $error = '';
        $success = '';
        $isLogin = true;
        
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            if (isset($_POST['register'])) {
                // Handle registration
                $data = [
                    'username' => $_POST['username'] ?? '',
                    'email' => $_POST['email'] ?? '',
                    'password' => $_POST['password'] ?? '',
                    'first_name' => $_POST['first_name'] ?? '',
                    'last_name' => $_POST['last_name'] ?? '',
                    'phone' => $_POST['phone'] ?? '',
                    'recovery_question' => $_POST['recovery_question'] ?? '',
                    'recovery_answer' => $_POST['recovery_answer'] ?? ''
                ];
                
                $userModel = new User();
                
                if ($userModel->findByEmail($data['email']) || $userModel->findByUsername($data['username'])) {
                    $error = $currentLang === 'es' ? 'El usuario o email ya existe' : 'User or email already exists';
                } else {
                    $userModel->register($data);
                    logAudit('user_register', null, $data['username'], 'auth.php', "New user registered: " . $data['email']);
                    $success = $currentLang === 'es' ? 'Registro exitoso' : 'Registration successful';
                    $isLogin = false;
                }
            } else {
                // Handle login
                $email = $_POST['email'] ?? '';
                $password = $_POST['password'] ?? '';
                
                $userModel = new User();
                $user = $userModel->authenticate($email, $password);
                
                if ($user) {
                    Session::set('user_id', $user['id']);
                    Session::set('username', $user['username']);
                    Session::set('role', $user['role']);
                    logAudit('user_login', $user['id'], $user['username'], 'auth.php', "User logged in successfully");
                    $redirect = $_POST['redirect'] ?? $_GET['redirect'] ?? $this->getBaseUrl() . '/';
                    $this->redirect($redirect);
                    return;
                } else {
                    logAudit('login_failed', null, $email, 'auth.php', "Failed login attempt");
                    $error = $currentLang === 'es' ? 'Credenciales incorrectas' : 'Invalid credentials';
                }
            }
        }
        
        // Check if registering
        if (isset($_GET['action']) && $_GET['action'] === 'register') {
            $isLogin = false;
            $showRecover = false;
        } elseif (isset($_GET['action']) && $_GET['action'] === 'recover') {
            $isLogin = false;
            $showRecover = true;
        } else {
            $showRecover = false;
        }
        
        require __DIR__ . '/../views/auth/login.php';
    }
    
    public function recover(): void {
        error_reporting(E_ALL);
        ini_set('display_errors', 1);
        
        // Get language
        $currentLang = 'es';
        if (isset($_COOKIE['language']) && in_array($_COOKIE['language'], ['es', 'en'])) {
            $currentLang = $_COOKIE['language'];
        }
        
        // Get theme
        $validThemes = ['white','blue','dark-blue','black','green','red','purple','orange','pink','teal','yellow','cyan','brown','indigo','lime','amber','rose','slate','emerald','sky','violet'];
        $currentTheme = (isset($_COOKIE['theme']) && in_array($_COOKIE['theme'], $validThemes)) ? $_COOKIE['theme'] : 'blue';
        $colors = getThemeColors($currentTheme);
        
        // Load language strings
        $langFile = __DIR__ . '/../languages/' . $currentLang . '.php';
        $lang = file_exists($langFile) ? require $langFile : require __DIR__ . '/../languages/es.php';
        
        $config = require __DIR__ . '/../config.php';
        $baseUrl = $this->getBaseUrl();
        
        $error = '';
        $success = '';
        $user = null;
        $showQuestion = false;
        
        // Handle password recovery
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            if (isset($_POST['identifier'])) {
                // Step 1: Search user
                $identifier = $_POST['identifier'] ?? '';
                $userModel = new User();
                $user = $userModel->findByUsername($identifier) ?: $userModel->findByEmail($identifier);
                
                if ($user && !empty($user['recovery_question'])) {
                    $showQuestion = true;
                } else {
                    $error = $currentLang === 'es' ? 'Usuario no encontrado o sin pregunta de seguridad' : 'User not found or no security question';
                }
            } elseif (isset($_POST['recovery_answer'])) {
                // Step 2: Verify answer and change password
                $userId = $_POST['user_id'] ?? '';
                $answer = $_POST['recovery_answer'] ?? '';
                $newPassword = $_POST['new_password'] ?? '';
                $confirmPassword = $_POST['confirm_password'] ?? '';
                
                $userModel = new User();
                $user = $userModel->findById($userId);
                
                if (!$user || strcasecmp($user['recovery_answer'], $answer) !== 0) {
                    $error = $currentLang === 'es' ? 'Respuesta incorrecta' : 'Incorrect answer';
                    $showQuestion = true;
                } elseif ($newPassword !== $confirmPassword) {
                    $error = $currentLang === 'es' ? 'Las contraseñas no coinciden' : 'Passwords do not match';
                    $showQuestion = true;
                } elseif (strlen($newPassword) < 6) {
                    $error = $currentLang === 'es' ? 'La contraseña debe tener al menos 6 caracteres' : 'Password must be at least 6 characters';
                    $showQuestion = true;
                } else {
                    // Change password
                    $userModel->updatePassword($userId, $newPassword);
                    $success = $currentLang === 'es' ? 'Contraseña cambiada correctamente. Ya puedes iniciar sesión.' : 'Password changed successfully. You can now login.';
                    $showSuccess = true;
                }
            }
        }
        
        // Render standalone (without header/footer)
        include __DIR__ . '/../views/auth/recover.php';
    }
    
    public function logout(): void {
        $userId = Session::get('user_id');
        $username = Session::get('username');
        logAudit('user_logout', $userId, $username ?? 'unknown', 'auth.php', "User logged out");
        Session::destroy();
        $this->redirect($this->getBaseUrl() . '/');
    }
}
