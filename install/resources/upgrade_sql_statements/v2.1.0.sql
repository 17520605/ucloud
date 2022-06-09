UPDATE language_content
SET content = REPLACE(content, 'contact.html', 'contact')
WHERE content LIKE '%contact.html%';
UPDATE language_key
SET defaultContent = REPLACE(defaultContent, 'contact.html', 'contact')
WHERE defaultContent LIKE '%contact.html%';

ALTER TABLE `users` CHANGE `title` `title` varchar (10) COLLATE 'utf8_unicode_ci' NULL AFTER `status`;

ALTER TABLE `premium_order`
    CHANGE `upgrade_file_id` `upgrade_file_id` int (11) NULL AFTER `date_created`,
    CHANGE `upgrade_user_id` `upgrade_user_id` int (11) NULL AFTER `upgrade_file_id`;

UPDATE `premium_order`
SET upgrade_file_id = NULL
WHERE upgrade_file_id = 0;
UPDATE `premium_order`
SET upgrade_user_id = NULL
WHERE upgrade_user_id = 0;

ALTER TABLE `plugin_filepreviewer_watermark`
    ADD `category` varchar(20) NOT NULL DEFAULT 'images';

DROP TABLE IF EXISTS `plugin_filepreviewer_background_thumb`;
CREATE TABLE `plugin_filepreviewer_background_thumb`
(
    `id`              int(11) NOT NULL AUTO_INCREMENT,
    `file_id`         int(11) NOT NULL,
    `thumb_status`    enum('processing','failed','created','nonimage') CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
    `date_added`      datetime NOT NULL,
    `processing_time` decimal(5, 2) DEFAULT NULL,
    PRIMARY KEY (`id`),
    KEY               `file_id` (`file_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

UPDATE `banned_ip`
SET `banType` = 'Uploading',
    banNotes  = CONCAT('Originally banned whole site. ', banNotes)
WHERE banType = 'Whole Site';
ALTER TABLE `banned_ip`
    ADD INDEX `banExpiry` (`banExpiry`);
ALTER TABLE `language`
    ADD INDEX `languageName` (`languageName`);

DELETE
FROM `site_config`
WHERE config_key = 'security_account_lock' LIMIT 1;
INSERT INTO `site_config` (`label`, `config_key`, `config_value`, `config_description`, `availableValues`,
                           `config_type`, `config_group`, `display_order`)
VALUES ('Enable 2FA', 'enable_2fa', 'no', 'Whether 2FA is available to your users.', '[\"yes\",\"no\"]', 'select',
        'Security', '50');
ALTER TABLE `users`
    ADD `login_2fa_enabled` int(1) NOT NULL DEFAULT '0';
ALTER TABLE `users`
    ADD `login_2fa_salt` varchar(32) NULL;

ALTER TABLE `users` DROP `userGroupId`;

ALTER TABLE `file_block_hash`
    ADD `file_size` bigint(15) NULL AFTER `file_hash`;
INSERT INTO `file_block_hash` (SELECT null, fileHash, fileSize, NOW()
                               FROM banned_files
                               WHERE fileHash NOT IN (SELECT file_hash FROM file_block_hash));
DROP TABLE `banned_files`;

ALTER TABLE `download_page`
    ADD `file_type_limit` text NULL AFTER `page_order`;

UPDATE `site_config`
SET `config_value` = ''
WHERE `config_key` = 'system_plugin_config_cache';

UPDATE `site_config`
SET config_value       = REPLACE(config_value, '[[[SITE_IMAGE_PATH]]]/logo/logo-whitebg.png', '[[[EMAIL_LOGO_URL]]]'),
    config_description = REPLACE(config_description, 'Test using the \'admin/_test_scripts/test_email.php\' script', 'Test via the \'test tools\' within the script admin area')
WHERE config_key = 'email_template_header';
UPDATE `site_config`
SET config_description = REPLACE(config_description, 'Test using the \'admin/_test_scripts/test_email.php\' script', 'Test via the \'test tools\' within the script admin area')
WHERE config_key = 'email_template_footer';

INSERT INTO `site_config` (`label`, `config_key`, `config_value`, `config_description`, `availableValues`,
                           `config_type`, `config_group`, `display_order`)
VALUES ('File Hashing Max Filesize (GB)', 'file_hashing_max_filesize_gb', '',
        'Optional. Some low resource web hosts may take a long time generating file hashes on upload. This would be noticed by a long delay at the 100% uploaded point. Set a numeric value here to not calculate these file hashes for files bigger than this GB in size (example value: 4). Leave empty to ignore.',
        '', 'integer', 'File Uploads', '101');

DROP TABLE IF EXISTS `file_status`;
CREATE TABLE `file_status_reason`
(
    `id`    int(11) NOT NULL AUTO_INCREMENT,
    `label` varchar(30) CHARACTER SET utf8 DEFAULT NULL,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `file_status_reason` (`id`, `label`)
VALUES (1, 'removed'),
       (2, 'user removed'),
       (3, 'admin removed'),
       (4, 'copyright removed'),
       (5, 'system expired');

ALTER TABLE `file`
    ADD `status_reason_id` int(3) NULL AFTER `status`;

DELETE
FROM background_task_log
WHERE task_id IN (SELECT id FROM background_task WHERE task = 'plugin_tasks.cron.php');
DELETE
FROM background_task
WHERE task = 'plugin_tasks.cron.php';

ALTER TABLE `user_level`
    ADD `upload_url_slug` varchar(150) NOT NULL DEFAULT '' AFTER `max_storage_bytes`;
ALTER TABLE `user_level`
    ADD `download_url_slug` varchar(150) NOT NULL DEFAULT '' AFTER `max_download_filesize_allowed`;

ALTER TABLE `file_server`
    ADD `accountUploadTypes` varchar(1000) COLLATE 'utf8_general_ci' NULL;

ALTER TABLE `download_token`
    ADD `limit_by_ip` int(1) NOT NULL DEFAULT '0';

ALTER TABLE `users`
    ADD `never_expire` tinyint(1) NULL DEFAULT '0' AFTER `paidExpiryDate`;

ALTER TABLE `login_failure` CHANGE `ip_address` `ip_address` varchar (45) COLLATE 'utf8_general_ci' NOT NULL AFTER `id`;
ALTER TABLE `login_success` CHANGE `ip_address` `ip_address` varchar (45) COLLATE 'utf8_general_ci' NOT NULL AFTER `id`;

ALTER TABLE `site_config`
    ADD `site_settings_hidden` int(1) NULL DEFAULT '0';

INSERT INTO site_config (label, config_key, config_value, config_description, availableValues, config_type,
                         config_group, display_order, site_settings_hidden)
VALUES ("Enable Chunked Uploads", "chunked_uploading_enabled", "yes",
        "Whether chunked uploading is enabled. Recommended to keep as 'yes'.", '["yes","no"]', "select", "File Uploads",
        101, 0);
INSERT INTO site_config (label, config_key, config_value, config_description, availableValues, config_type,
                         config_group, display_order, site_settings_hidden)
VALUES ("Chunked Upload Size", "chunked_upload_size_mb", "100",
        "If 'Enable Chunked Uploads' is set to 'yes', this is the size of the chunks in MB. Recommended to use '100'.",
        '', "integer", "File Uploads", 102, 0);

UPDATE `banned_ip`
SET `banType` = 'Uploading',
    banNotes  = CONCAT('Originally banned whole site. ', banNotes)
WHERE banType = 'Whole Site';

ALTER TABLE `file_server`
    ADD `geoUploadCountries` varchar(1000) COLLATE 'utf8_general_ci' NULL;

