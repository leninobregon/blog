<?php
/**
 * ContentService - Content formatting and metadata helpers
 */
class ContentService
{
    public function render(string $rawContent): string
    {
        return parseMarkdown($rawContent);
    }

    public function readingTime(string $rawContent, string $lang = 'es'): string
    {
        return readingTime($rawContent, $lang);
    }

    public function extractToc(string $rawContent): array
    {
        preg_match_all('/^#{1,3} (.+)$/m', $rawContent, $headings);
        $toc = [];

        if (empty($headings[0])) {
            return $toc;
        }

        foreach ($headings[1] as $i => $heading) {
            preg_match('/^#+/', $headings[0][$i], $matches);
            $prefix = $matches[0] ?? '#';
            $level = strlen($prefix);
            $toc[] = [
                'text' => $heading,
                'level' => $level,
                'slug' => $this->slugify($heading)
            ];
        }

        return $toc;
    }

    public function plainExcerpt(string $rawContent, int $limit = 160): string
    {
        $plain = trim(preg_replace('/\s+/', ' ', strip_tags($rawContent)));
        if (mb_strlen($plain) <= $limit) {
            return $plain;
        }
        return rtrim(mb_substr($plain, 0, $limit - 1)) . '…';
    }

    private function slugify(string $text): string
    {
        $normalized = str_replace(
            ['á', 'é', 'í', 'ó', 'ú', 'ñ', 'Á', 'É', 'Í', 'Ó', 'Ú', 'Ñ'],
            ['a', 'e', 'i', 'o', 'u', 'n', 'a', 'e', 'i', 'o', 'u', 'n'],
            $text
        );
        $normalized = mb_strtolower($normalized);
        $normalized = preg_replace('/[^a-z0-9\s-]/', '', $normalized);
        $normalized = preg_replace('/[\s-]+/', '-', trim($normalized));
        return trim($normalized, '-');
    }
}
