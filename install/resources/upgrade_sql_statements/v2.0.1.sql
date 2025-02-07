DELETE
FROM `site_config`
WHERE `config_key` = 'script_version_number' LIMIT 1;
UPDATE `site_config`
SET `config_description` = 'Secret key for reCaptcha v2. Register at https://www.google.com/recaptcha'
WHERE config_key = 'captcha_secret_key';
UPDATE `site_config`
SET `config_description` = 'Public key for reCaptcha v2. Register at https://www.google.com/recaptcha'
WHERE config_key = 'captcha_public_key';