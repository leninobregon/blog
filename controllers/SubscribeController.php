<?php
/**
 * SubscribeController - Newsletter subscription
 */
class SubscribeController extends Controller {
    
    public function handle(): void {
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            $email = $_POST['email'] ?? '';
            $name = $_POST['name'] ?? '';
            
            if ($email) {
                $newsletterModel = new Newsletter();
                $newsletterModel->subscribe($email, $name);
            }
        }
        
        $this->redirect('/');
    }
}
