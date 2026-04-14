<?php
/**
 * PostController - Vista de publicación individual
 */
class PostController extends Controller {
    
    public function show(int $id): void {
        $postModel = new Post();
        $commentModel = new Comment();
        $siteStats = new SiteStats();
        $contentService = new ContentService();
        
        $post = $postModel->getWithAuthor($id);
        
        if (!$post) {
            http_response_code(404);
            require __DIR__ . '/../views/errors/404.php';
            return;
        }
        
        // Increment views - only for guests
        if (!Session::isLoggedIn()) {
            $postModel->incrementViews($id);
            $sessionKey = 'last_visit_post_' . $id;
            $lastVisit = Session::get($sessionKey);
            $now = time();
            
            // Only count once per hour per post
            if (!$lastVisit || ($now - $lastVisit) > 3600) {
                $siteStats->incrementHits();
                Session::set($sessionKey, $now);
            }
        }
        
        // Get comments
        $comments = $commentModel->getWithUser($id);
        
        // Get related posts
        $relatedPosts = $postModel->getRelated($id, $post['category'], 3);
        
        // Get most viewed
        $mostViewed = $postModel->getMostViewed(5);
        
        // Get archives
        $archives = $postModel->getArchives();
        $categories = $postModel->getCategoriesWithCount();
        
        // Parse content
        $content = $contentService->render($post['content']);
        $readingTime = $contentService->readingTime($post['content']);
        $toc = $contentService->extractToc($post['content']);
        
        // Share URLs
        $currentUrl = 'http://' . $_SERVER['HTTP_HOST'] . $_SERVER['REQUEST_URI'];
        $shareTitle = urlencode($post['title']);
        $shareUrl = urlencode($currentUrl);
        
        // Handle comment submission
        if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['comment']) && Session::isLoggedIn()) {
            $comment = trim($_POST['comment'] ?? '');
            if ($comment) {
                $commentModel->create($id, Session::get('user_id'), $comment);
                $baseUrl = (isset($_SERVER['HTTPS']) ? 'https' : 'http') . '://' . $_SERVER['HTTP_HOST'] . dirname($_SERVER['SCRIPT_NAME']);
                header("Location: {$baseUrl}/post.php?id={$id}");
                exit;
            }
        }
        
        $this->view('post', [
            'post' => $post,
            'content' => $content,
            'readingTime' => $readingTime,
            'comments' => $comments,
            'relatedPosts' => $relatedPosts,
            'mostViewed' => $mostViewed,
            'archives' => $archives,
            'categories' => $categories,
            'toc' => $toc,
            'shareTitle' => $shareTitle,
            'shareUrl' => $shareUrl,
            'categoriesCount' => count($categories),
            'pageTitle' => $post['title'] . ' - ' . (CONFIG['site_name'] ?? 'Blog'),
            'metaDescription' => $contentService->plainExcerpt($post['content'], 170),
            'metaImage' => !empty($post['image']) ? $post['image'] : null
        ]);
    }
}
