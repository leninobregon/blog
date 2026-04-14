<?php
/**
 * AboutController - Página Acerca de
 */
class AboutController extends Controller {
    
    public function index(): void {
        $aboutModel = new About();
        $about = $aboutModel->get();
        
        $this->view('about', [
            'about' => $about,
            'pageTitle' => ($about['title'] ?? 'Acerca de') . ' - ' . (CONFIG['site_name'] ?? 'Blog'),
            'metaDescription' => !empty($about['subtitle']) ? $about['subtitle'] : (CONFIG['description'] ?? 'Blog de tutoriales')
        ]);
    }
}
