<?php
/**
 * AboutController - Página Acerca de
 */
class AboutController extends Controller {
    
    public function index(): void {
        $aboutModel = new About();
        $about = $aboutModel->get();
        
        $this->view('about', ['about' => $about]);
    }
}
