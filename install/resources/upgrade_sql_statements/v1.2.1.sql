INSERT INTO `site_config` (`config_key`, `config_value`, `config_description`, `availableValues`, `config_type`,
                           `config_group`)
VALUES ('captcha_secret_key', 'REPLACE_ME', 'Secret key for captcha. Register at https://www.google.com/recaptcha', '',
        'string', 'Captcha');
INSERT INTO `site_config` (`config_key`, `config_value`, `config_description`, `availableValues`, `config_type`,
                           `config_group`)
VALUES ('captcha_public_key', 'REPLACE_ME', 'Public key for captcha. Register at https://www.google.com/recaptcha', '',
        'string', 'Captcha');
