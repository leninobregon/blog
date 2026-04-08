<?php
/**
 * AuthController - Login, Registro, Recuperación
 */
class AuthController extends Controller {
    
    public function login(): void {
        if (Session::isLoggedIn()) {
            $this->redirect($this->getBaseUrl() . '/');
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
                    $this->redirect($this->getBaseUrl() . '/');
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
        // Handle password recovery - search user by username or email
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            $identifier = $_POST['identifier'] ?? '';
            
            $userModel = new User();
            $user = $userModel->findByUsername($identifier) ?: $userModel->findByEmail($identifier);
            
            if ($user && !empty($user['recovery_question'])) {
                // Show security question
                $this->view('auth/recover', [
                    'user' => $user,
                    'showQuestion' => true
                ]);
                return;
            } else {
                $error = 'Usuario no encontrado o sin pregunta de seguridad';
            }
        }
        
        $this->view('auth/recover', [
            'error' => $error ?? ''
        ]);
    }
    
    public function logout(): void {
        $userId = Session::get('user_id');
        $username = Session::get('username');
        logAudit('user_logout', $userId, $username ?? 'unknown', 'auth.php', "User logged out");
        Session::destroy();
        $this->redirect($this->getBaseUrl() . '/');
    }
}
