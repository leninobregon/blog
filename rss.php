<?php
/**
 * RSS Feed - Para suscriptores y lectores RSS
 */
require_once 'includes/functions.php';

header('Content-Type: application/rss+xml; charset=utf-8');
$posts = getPosts(20, 0);
$siteName = CONFIG['site_name'] ?? 'Mi Blog';
$siteUrl = function_exists('getSiteURL') ? getSiteURL() : (CONFIG['site_url'] ?? 'http://localhost');

echo '<?xml version="1.0" encoding="UTF-8"?>
<rss version="2.0" xmlns:atom="http://www.w3.org/2005/Atom">
<channel>
    <title>' . htmlspecialchars($siteName) . '</title>
    <link>' . htmlspecialchars($siteUrl) . '</link>
    <description>' . htmlspecialchars(CONFIG['description'] ?? '') . '</description>
    <language>es</language>
    <lastBuildDate>' . date('r') . '</lastBuildDate>
    <atom:link href="' . htmlspecialchars($siteUrl) . '/rss.php" rel="self" type="application/rss+xml"/>
';

foreach ($posts as $post) {
    $postUrl = $siteUrl . '/post.php?id=' . $post['id'];
    $pubDate = date('r', strtotime($post['created_at']));
    
    echo '
    <item>
        <title>' . htmlspecialchars($post['title']) . '</title>
        <link>' . htmlspecialchars($postUrl) . '</link>
        <guid isPermaLink="true">' . htmlspecialchars($postUrl) . '</guid>
        <pubDate>' . $pubDate . '</pubDate>
        <description>' . htmlspecialchars(mb_substr(strip_tags($post['content']), 0, 200) . '...') . '</description>
        <category>' . htmlspecialchars($post['category']) . '</category>
    </item>';
}

echo '
</channel>
</rss>';