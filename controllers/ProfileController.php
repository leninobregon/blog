<?php
/**
 * ProfileController - Perfil de usuario
 */
class ProfileController extends Controller {
    
    public function index(): void {
        $this->requireLogin();
        
        $userModel = new User();
        $user = $userModel->findById(Session::get('user_id'));
        
        $msg = '';
        $msgType = '';
        
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            $action = $_POST['action'] ?? '';
            
            if ($action === 'update_profile') {
                $data = [
                    'first_name' => $_POST['first_name'] ?? '',
                    'last_name' => $_POST['last_name'] ?? '',
                    'bio' => $_POST['bio'] ?? '',
                    'phone' => $_POST['phone'] ?? '',
                    'facebook' => $_POST['facebook'] ?? '',
                    'twitter' => $_POST['twitter'] ?? '',
                    'telegram' => $_POST['telegram'] ?? '',
                    'instagram' => $_POST['instagram'] ?? '',
                    'youtube' => $_POST['youtube'] ?? '',
                    'linkedin' => $_POST['linkedin'] ?? '',
                    'website' => $_POST['website'] ?? ''
                ];
                
                if (!empty($_FILES['avatar']['name'])) {
                    $avatar = uploadImage($_FILES['avatar']);
                    if ($avatar) {
                        $data['avatar'] = $avatar;
                    }
                }
                
                $userModel->update(Session::get('user_id'), $data);
                $user = $userModel->findById(Session::get('user_id'));
                $msg = $this->getLanguage() === 'es' ? 'Perfil actualizado correctamente' : 'Profile updated successfully';
                $msgType = 'success';
            }
            
            if ($action === 'change_password') {
                $currentPassword = $_POST['current_password'] ?? '';
                $newPassword = $_POST['new_password'] ?? '';
                $confirmPassword = $_POST['confirm_password'] ?? '';
                
                if (!password_verify($currentPassword, $user['password'])) {
                    $msg = $this->getLanguage() === 'es' ? 'La contraseña actual es incorrecta' : 'Current password is incorrect';
                    $msgType = 'error';
                } elseif ($newPassword !== $confirmPassword) {
                    $msg = $this->getLanguage() === 'es' ? 'Las contraseñas no coinciden' : 'Passwords do not match';
                    $msgType = 'error';
                } elseif (strlen($newPassword) < 6) {
                    $msg = $this->getLanguage() === 'es' ? 'La contraseña debe tener al menos 6 caracteres' : 'Password must be at least 6 characters';
                    $msgType = 'error';
                } else {
                    $userModel->updatePassword(Session::get('user_id'), $newPassword);
                    $user = $userModel->findById(Session::get('user_id'));
                    $msg = $this->getLanguage() === 'es' ? 'Contraseña cambiada correctamente' : 'Password changed successfully';
                    $msgType = 'success';
                }
            }
        }
        
        $this->view('profile', [
            'user' => $user,
            'msg' => $msg,
            'msgType' => $msgType
        ]);
    }
    
    private function getLanguage(): string {
        $validLangs = ['es', 'en'];
        if (isset($_COOKIE['language']) && in_array($_COOKIE['language'], $validLangs)) {
            return $_COOKIE['language'];
        }
        if (Session::has('language')) {
            return Session::get('language');
        }
        return 'es';
    }
}
