<?php
declare(strict_types=1);

/**
 * Automatic DB backup runner.
 * Usage: php scripts/auto_backup.php
 */

require_once __DIR__ . '/../includes/functions.php';

$settings = CONFIG['backup_automation'] ?? [];
$enabled = (bool)($settings['enabled'] ?? true);

if (!$enabled) {
    fwrite(STDOUT, "[backup] disabled by config\n");
    exit(0);
}

$relativeDir = (string)($settings['directory'] ?? 'db/backups');
$retentionDays = max(1, (int)($settings['retention_days'] ?? 30));
$backupDir = dirname(__DIR__) . DIRECTORY_SEPARATOR . str_replace(['/', '\\'], DIRECTORY_SEPARATOR, $relativeDir);
$backupDir = rtrim($backupDir, DIRECTORY_SEPARATOR);

try {
    $result = backupDatabase($backupDir);
    $dbName = CONFIG['db']['name'] ?? 'database';
    $deleted = cleanupOldBackups($backupDir, $retentionDays, $dbName . '_');

    $filename = is_array($result) ? ($result['filename'] ?? 'unknown.sql') : 'unknown.sql';
    fwrite(STDOUT, "[backup] created: {$filename}\n");
    fwrite(STDOUT, "[backup] directory: {$backupDir}\n");
    fwrite(STDOUT, "[backup] retention_days: {$retentionDays}, deleted_old: {$deleted}\n");
    exit(0);
} catch (Throwable $e) {
    fwrite(STDERR, "[backup] error: " . $e->getMessage() . "\n");
    exit(1);
}

