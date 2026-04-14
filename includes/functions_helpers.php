<?php
/**
 * Helper functions for MVC
 */

if (!function_exists('parseMarkdown')) {
function parseMarkdown($text) {
    $text = (string)$text;
    $text = str_replace('\\/', '/', $text);
    
    // If content already comes from visual editor (HTML) or encoded HTML,
    // render it directly (decode entities once to avoid showing raw tags/entities)
    if (
        preg_match('/<\s*(p|div|h1|h2|h3|h4|h5|h6|ul|ol|li|blockquote|pre|code|table|img|a|br|hr)\b/i', $text) ||
        preg_match('/&lt;\s*(p|div|h1|h2|h3|h4|h5|h6|ul|ol|li|blockquote|pre|code|table|img|a|br|hr)\b/i', $text)
    ) {
        return html_entity_decode($text, ENT_QUOTES | ENT_HTML5, 'UTF-8');
    }

    $text = htmlspecialchars($text, ENT_QUOTES, 'UTF-8');
    
    // YouTube URLs to embed
    $text = preg_replace('/https?:\/\/(www\.)?youtube\.com\/watch\?v=([a-zA-Z0-9_-]+)/', 'https://www.youtube.com/embed/$2', $text);
    $text = preg_replace('/https?:\/\/youtu\.be\/([a-zA-Z0-9_-]+)/', 'https://www.youtube.com/embed/$1', $text);
    
    // Video embed to iframe
    $text = preg_replace('/https:\/\/www\.youtube\.com\/embed\/([a-zA-Z0-9_-]+)/', '<div class="video-container"><iframe src="https://www.youtube.com/embed/$1" frameborder="0" allowfullscreen></iframe></div>', $text);
    
    $text = preg_replace('/```(.*?)```/s', '<pre><code>$1</code></pre>', $text);
    $text = preg_replace('/`([^`]+)`/', '<code class="inline">$1</code>', $text);
    $text = preg_replace('/\*\*([^*]+)\*\*/', '<strong>$1</strong>', $text);
    $text = preg_replace('/\*([^*]+)\*/', '<em>$1</em>', $text);
    $text = preg_replace('/^### (.+)$/m', '<h3>$1</h3>', $text);
    $text = preg_replace('/^## (.+)$/m', '<h2>$1</h2>', $text);
    $text = preg_replace('/^# (.+)$/m', '<h1>$1</h1>', $text);
    $text = preg_replace('/^\- (.+)$/m', '<li>$1</li>', $text);
    $text = preg_replace('/^> (.+)$/m', '<blockquote>$1</blockquote>', $text);
    $text = preg_replace('/\!\[([^\]]*)\]\(([^)]+)\)/', '<img src="$2" alt="$1" class="post-image">', $text);
    $text = preg_replace('/\[([^\]]+)\]\(([^)]+)\)/', '<a href="$2" target="_blank">$1</a>', $text);
    $text = preg_replace('/\[video\]([^[]+)\[\/video\]/', '<div class="video-container"><iframe src="$1" frameborder="0" allowfullscreen></iframe></div>', $text);
    
    return nl2br($text);
}
}

if (!function_exists('readingTime')) {
function readingTime($text, $lang = 'es') {
    $wordCount = str_word_count(strip_tags($text));
    $minutes = ceil($wordCount / 200);
    return $lang === 'es' ? "$minutes min de lectura" : "$minutes min read";
}
}
