<?php
/**
 * HomeController - Página principal del blog
 */
class HomeController extends Controller {
    
    public function index(): void {
        $postModel = new Post();
        $siteStats = new SiteStats();
        
        // Get filters
        $category = $_GET['cat'] ?? null;
        $search = $_GET['search'] ?? null;
        $mes = $_GET['mes'] ?? null;
        $page = max(1, (int)($_GET['page'] ?? 1));
        $perPage = 10;
        $offset = ($page - 1) * $perPage;
        
        // Log visit
        $visitLog = new VisitLog();
        $visitLog->log(
            $_SERVER['REQUEST_URI'] ?? '',
            $_SERVER['REMOTE_ADDR'] ?? '',
            $_SERVER['HTTP_USER_AGENT'] ?? '',
            $_SERVER['HTTP_REFERER'] ?? ''
        );
        $siteStats->incrementHits();
        
        // Get posts
        if ($mes) {
            $posts = $postModel->getByMonth($mes, $perPage, $offset);
            $totalPosts = $postModel->query("SELECT COUNT(*) as c FROM posts WHERE DATE_FORMAT(created_at, '%Y-%m') = ?", [$mes])[0]['c'];
        } else {
            $posts = $postModel->getLatest($perPage, $offset, $category, $search);
            $totalPosts = $postModel->countAll($category);
        }
        
        // Sidebar data
        $categories = $postModel->getCategoriesWithCount();
        $archives = $postModel->getArchives();
        $totalHits = $siteStats->getTotalHits();
        $totalPostsCount = $postModel->countAll();
        $totalUsers = (new User())->countAll();
        
        $this->view('index', [
            'posts' => $posts,
            'categories' => $categories,
            'archives' => $archives,
            'currentCategory' => $category,
            'currentSearch' => $search,
            'currentMes' => $mes,
            'totalPosts' => $totalPosts,
            'totalHits' => $totalHits,
            'totalPostsCount' => $totalPostsCount,
            'totalUsers' => $totalUsers,
            'page' => $page,
            'totalPages' => ceil($totalPosts / $perPage)
        ]);
    }
}
