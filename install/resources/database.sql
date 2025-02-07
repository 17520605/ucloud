-- phpMyAdmin SQL Dump
-- version 3.2.5
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Dec 31, 2015 at 01:51 PM
-- Server version: 5.5.24
-- PHP Version: 5.4.45-1+deb.sury.org~precise+1

SET
SQL_MODE="";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `mfscripts_cloudable`
--

-- --------------------------------------------------------

--
-- Table structure for table `background_task`
--

CREATE TABLE IF NOT EXISTS `background_task`
(
    `id` int
(
    11
) NOT NULL AUTO_INCREMENT,
    `task` varchar
(
    255
) COLLATE utf8_bin NOT NULL,
    `last_update` datetime DEFAULT NULL,
    `status` enum
(
    'running',
    'finished',
    'not_run'
) COLLATE utf8_bin NOT NULL,
    PRIMARY KEY
(
    `id`
),
    UNIQUE KEY `task`
(
    `task`
)
    ) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE =utf8_bin AUTO_INCREMENT=9;

--
-- Dumping data for table `background_task`
--

INSERT INTO `background_task` (`id`, `task`, `last_update`, `status`)
VALUES (1, 'auto_prune.cron.php', NULL, 'not_run'),
       (3, 'create_internal_notifications.cron.php', NULL, 'not_run'),
       (4, 'downgrade_accounts.cron.php', NULL, 'not_run'),
       (5, 'plugin_tasks.cron.php', NULL, 'not_run'),
       (6, 'delete_redundant_files.cron.php', NULL, 'not_run'),
       (7, 'process_file_queue.cron.php', NULL, 'not_run'),
       (8, 'process_remote_file_downloads.cron.php', NULL, 'not_run');

-- --------------------------------------------------------

--
-- Table structure for table `background_task_log`
--

CREATE TABLE IF NOT EXISTS `background_task_log`
(
    `id` int
(
    11
) NOT NULL AUTO_INCREMENT,
    `task_id` int
(
    11
) NOT NULL,
    `start_time` datetime NOT NULL,
    `end_time` datetime NOT NULL,
    `status` enum
(
    'started',
    'finished'
) COLLATE utf8_bin NOT NULL DEFAULT 'started',
    `server_name` varchar
(
    255
) COLLATE utf8_bin NOT NULL,
    `log_message` text COLLATE utf8_bin NOT NULL,
    PRIMARY KEY
(
    `id`
),
    KEY `task_id`
(
    `task_id`
),
    KEY `start_time`
(
    `start_time`
),
    KEY `end_time`
(
    `end_time`
),
    KEY `server_name`
(
    `server_name`
)
    ) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE =utf8_bin AUTO_INCREMENT=1;

--
-- Dumping data for table `background_task_log`
--


-- --------------------------------------------------------

--
-- Table structure for table `banned_ips`
--

CREATE TABLE IF NOT EXISTS `banned_ips`
(
    `id` int
(
    11
) NOT NULL AUTO_INCREMENT,
    `ipAddress` varchar
(
    45
) NOT NULL,
    `dateBanned` datetime NOT NULL,
    `banType` varchar
(
    30
) NOT NULL,
    `banNotes` text NOT NULL,
    `banExpiry` datetime DEFAULT NULL,
    PRIMARY KEY
(
    `id`
),
    KEY `ipAddress`
(
    `ipAddress`
)
    ) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=16;

--
-- Dumping data for table `banned_ips`
--


-- --------------------------------------------------------

--
-- Table structure for table `country_info`
--

CREATE TABLE IF NOT EXISTS `country_info`
(
    `id` int
(
    11
) NOT NULL AUTO_INCREMENT,
    `iso_alpha2` varchar
(
    2
) DEFAULT NULL,
    `iso_alpha3` varchar
(
    3
) DEFAULT NULL,
    `name` varchar
(
    200
) DEFAULT NULL,
    `currency_code` char
(
    3
) DEFAULT NULL,
    `currency_name` varchar
(
    32
) DEFAULT NULL,
    `currrency_symbol` varchar
(
    3
) DEFAULT NULL,
    PRIMARY KEY
(
    `id`
)
    ) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=248;

--
-- Dumping data for table `country_info`
--

INSERT INTO `country_info` (`id`, `iso_alpha2`, `iso_alpha3`, `name`, `currency_code`, `currency_name`,
                            `currrency_symbol`)
VALUES (1, 'AD', 'AND', 'Andorra', 'EUR', 'Euro', '€'),
       (2, 'AE', 'ARE', 'United Arab Emirates', 'AED', 'Dirham', NULL),
       (3, 'AF', 'AFG', 'Afghanistan', 'AFN', 'Afghani', '؋'),
       (4, 'AG', 'ATG', 'Antigua and Barbuda', 'XCD', 'Dollar', '$'),
       (5, 'AI', 'AIA', 'Anguilla', 'XCD', 'Dollar', '$'),
       (6, 'AL', 'ALB', 'Albania', 'ALL', 'Lek', 'Lek'),
       (7, 'AM', 'ARM', 'Armenia', 'AMD', 'Dram', NULL),
       (8, 'AN', 'ANT', 'Netherlands Antilles', 'ANG', 'Guilder', 'ƒ'),
       (9, 'AO', 'AGO', 'Angola', 'AOA', 'Kwanza', 'Kz'),
       (10, 'AQ', 'ATA', 'Antarctica', '', '', NULL),
       (11, 'AR', 'ARG', 'Argentina', 'ARS', 'Peso', '$'),
       (12, 'AS', 'ASM', 'American Samoa', 'USD', 'Dollar', '$'),
       (13, 'AT', 'AUT', 'Austria', 'EUR', 'Euro', '€'),
       (14, 'AU', 'AUS', 'Australia', 'AUD', 'Dollar', '$'),
       (15, 'AW', 'ABW', 'Aruba', 'AWG', 'Guilder', 'ƒ'),
       (16, 'AX', 'ALA', 'Aland Islands', 'EUR', 'Euro', '€'),
       (17, 'AZ', 'AZE', 'Azerbaijan', 'AZN', 'Manat', 'ман'),
       (18, 'BA', 'BIH', 'Bosnia and Herzegovina', 'BAM', 'Marka', 'KM'),
       (19, 'BB', 'BRB', 'Barbados', 'BBD', 'Dollar', '$'),
       (20, 'BD', 'BGD', 'Bangladesh', 'BDT', 'Taka', NULL),
       (21, 'BE', 'BEL', 'Belgium', 'EUR', 'Euro', '€'),
       (22, 'BF', 'BFA', 'Burkina Faso', 'XOF', 'Franc', NULL),
       (23, 'BG', 'BGR', 'Bulgaria', 'BGN', 'Lev', 'лв'),
       (24, 'BH', 'BHR', 'Bahrain', 'BHD', 'Dinar', NULL),
       (25, 'BI', 'BDI', 'Burundi', 'BIF', 'Franc', NULL),
       (26, 'BJ', 'BEN', 'Benin', 'XOF', 'Franc', NULL),
       (27, 'BL', 'BLM', 'Saint Barthélemy', 'EUR', 'Euro', '€'),
       (28, 'BM', 'BMU', 'Bermuda', 'BMD', 'Dollar', '$'),
       (29, 'BN', 'BRN', 'Brunei', 'BND', 'Dollar', '$'),
       (30, 'BO', 'BOL', 'Bolivia', 'BOB', 'Boliviano', '$b'),
       (31, 'BR', 'BRA', 'Brazil', 'BRL', 'Real', 'R$'),
       (32, 'BS', 'BHS', 'Bahamas', 'BSD', 'Dollar', '$'),
       (33, 'BT', 'BTN', 'Bhutan', 'BTN', 'Ngultrum', NULL),
       (34, 'BV', 'BVT', 'Bouvet Island', 'NOK', 'Krone', 'kr'),
       (35, 'BW', 'BWA', 'Botswana', 'BWP', 'Pula', 'P'),
       (36, 'BY', 'BLR', 'Belarus', 'BYR', 'Ruble', 'p.'),
       (37, 'BZ', 'BLZ', 'Belize', 'BZD', 'Dollar', 'BZ$'),
       (38, 'CA', 'CAN', 'Canada', 'CAD', 'Dollar', '$'),
       (39, 'CC', 'CCK', 'Cocos Islands', 'AUD', 'Dollar', '$'),
       (40, 'CD', 'COD', 'Democratic Republic of the Congo', 'CDF', 'Franc', NULL),
       (41, 'CF', 'CAF', 'Central African Republic', 'XAF', 'Franc', 'FCF'),
       (42, 'CG', 'COG', 'Republic of the Congo', 'XAF', 'Franc', 'FCF'),
       (43, 'CH', 'CHE', 'Switzerland', 'CHF', 'Franc', 'CHF'),
       (44, 'CI', 'CIV', 'Ivory Coast', 'XOF', 'Franc', NULL),
       (45, 'CK', 'COK', 'Cook Islands', 'NZD', 'Dollar', '$'),
       (46, 'CL', 'CHL', 'Chile', 'CLP', 'Peso', NULL),
       (47, 'CM', 'CMR', 'Cameroon', 'XAF', 'Franc', 'FCF'),
       (48, 'CN', 'CHN', 'China', 'CNY', 'Yuan Renminbi', '¥'),
       (49, 'CO', 'COL', 'Colombia', 'COP', 'Peso', '$'),
       (50, 'CR', 'CRI', 'Costa Rica', 'CRC', 'Colon', '₡'),
       (51, 'CU', 'CUB', 'Cuba', 'CUP', 'Peso', '₱'),
       (52, 'CV', 'CPV', 'Cape Verde', 'CVE', 'Escudo', NULL),
       (53, 'CX', 'CXR', 'Christmas Island', 'AUD', 'Dollar', '$'),
       (54, 'CY', 'CYP', 'Cyprus', 'CYP', 'Pound', NULL),
       (55, 'CZ', 'CZE', 'Czech Republic', 'CZK', 'Koruna', 'Kč'),
       (56, 'DE', 'DEU', 'Germany', 'EUR', 'Euro', '€'),
       (57, 'DJ', 'DJI', 'Djibouti', 'DJF', 'Franc', NULL),
       (58, 'DK', 'DNK', 'Denmark', 'DKK', 'Krone', 'kr'),
       (59, 'DM', 'DMA', 'Dominica', 'XCD', 'Dollar', '$'),
       (60, 'DO', 'DOM', 'Dominican Republic', 'DOP', 'Peso', 'RD$'),
       (61, 'DZ', 'DZA', 'Algeria', 'DZD', 'Dinar', NULL),
       (62, 'EC', 'ECU', 'Ecuador', 'USD', 'Dollar', '$'),
       (63, 'EE', 'EST', 'Estonia', 'EEK', 'Kroon', 'kr'),
       (64, 'EG', 'EGY', 'Egypt', 'EGP', 'Pound', '£'),
       (65, 'EH', 'ESH', 'Western Sahara', 'MAD', 'Dirham', NULL),
       (66, 'ER', 'ERI', 'Eritrea', 'ERN', 'Nakfa', 'Nfk'),
       (67, 'ES', 'ESP', 'Spain', 'EUR', 'Euro', '€'),
       (68, 'ET', 'ETH', 'Ethiopia', 'ETB', 'Birr', NULL),
       (69, 'FI', 'FIN', 'Finland', 'EUR', 'Euro', '€'),
       (70, 'FJ', 'FJI', 'Fiji', 'FJD', 'Dollar', '$'),
       (71, 'FK', 'FLK', 'Falkland Islands', 'FKP', 'Pound', '£'),
       (72, 'FM', 'FSM', 'Micronesia', 'USD', 'Dollar', '$'),
       (73, 'FO', 'FRO', 'Faroe Islands', 'DKK', 'Krone', 'kr'),
       (74, 'FR', 'FRA', 'France', 'EUR', 'Euro', '€'),
       (75, 'GA', 'GAB', 'Gabon', 'XAF', 'Franc', 'FCF'),
       (76, 'GB', 'GBR', 'United Kingdom', 'GBP', 'Pound', '£'),
       (77, 'GD', 'GRD', 'Grenada', 'XCD', 'Dollar', '$'),
       (78, 'GE', 'GEO', 'Georgia', 'GEL', 'Lari', NULL),
       (79, 'GF', 'GUF', 'French Guiana', 'EUR', 'Euro', '€'),
       (80, 'GG', 'GGY', 'Guernsey', 'GGP', 'Pound', '£'),
       (81, 'GH', 'GHA', 'Ghana', 'GHC', 'Cedi', '¢'),
       (82, 'GI', 'GIB', 'Gibraltar', 'GIP', 'Pound', '£'),
       (83, 'GL', 'GRL', 'Greenland', 'DKK', 'Krone', 'kr'),
       (84, 'GM', 'GMB', 'Gambia', 'GMD', 'Dalasi', 'D'),
       (85, 'GN', 'GIN', 'Guinea', 'GNF', 'Franc', NULL),
       (86, 'GP', 'GLP', 'Guadeloupe', 'EUR', 'Euro', '€'),
       (87, 'GQ', 'GNQ', 'Equatorial Guinea', 'XAF', 'Franc', 'FCF'),
       (88, 'GR', 'GRC', 'Greece', 'EUR', 'Euro', '€'),
       (89, 'GS', 'SGS', 'South Georgia and the South Sandwich Islands', 'GBP', 'Pound', '£'),
       (90, 'GT', 'GTM', 'Guatemala', 'GTQ', 'Quetzal', 'Q'),
       (91, 'GU', 'GUM', 'Guam', 'USD', 'Dollar', '$'),
       (92, 'GW', 'GNB', 'Guinea-Bissau', 'XOF', 'Franc', NULL),
       (93, 'GY', 'GUY', 'Guyana', 'GYD', 'Dollar', '$'),
       (94, 'HK', 'HKG', 'Hong Kong', 'HKD', 'Dollar', '$'),
       (95, 'HM', 'HMD', 'Heard Island and McDonald Islands', 'AUD', 'Dollar', '$'),
       (96, 'HN', 'HND', 'Honduras', 'HNL', 'Lempira', 'L'),
       (97, 'HR', 'HRV', 'Croatia', 'HRK', 'Kuna', 'kn'),
       (98, 'HT', 'HTI', 'Haiti', 'HTG', 'Gourde', 'G'),
       (99, 'HU', 'HUN', 'Hungary', 'HUF', 'Forint', 'Ft'),
       (100, 'ID', 'IDN', 'Indonesia', 'IDR', 'Rupiah', 'Rp'),
       (101, 'IE', 'IRL', 'Ireland', 'EUR', 'Euro', '€'),
       (102, 'IL', 'ISR', 'Israel', 'ILS', 'Shekel', '₪'),
       (103, 'IM', 'IMN', 'Isle of Man', 'GPD', 'Pound', '£'),
       (104, 'IN', 'IND', 'India', 'INR', 'Rupee', '₨'),
       (105, 'IO', 'IOT', 'British Indian Ocean Territory', 'USD', 'Dollar', '$'),
       (106, 'IQ', 'IRQ', 'Iraq', 'IQD', 'Dinar', NULL),
       (107, 'IR', 'IRN', 'Iran', 'IRR', 'Rial', '﷼'),
       (108, 'IS', 'ISL', 'Iceland', 'ISK', 'Krona', 'kr'),
       (109, 'IT', 'ITA', 'Italy', 'EUR', 'Euro', '€'),
       (110, 'JE', 'JEY', 'Jersey', 'JEP', 'Pound', '£'),
       (111, 'JM', 'JAM', 'Jamaica', 'JMD', 'Dollar', '$'),
       (112, 'JO', 'JOR', 'Jordan', 'JOD', 'Dinar', NULL),
       (113, 'JP', 'JPN', 'Japan', 'JPY', 'Yen', '¥'),
       (114, 'KE', 'KEN', 'Kenya', 'KES', 'Shilling', NULL),
       (115, 'KG', 'KGZ', 'Kyrgyzstan', 'KGS', 'Som', 'лв'),
       (116, 'KH', 'KHM', 'Cambodia', 'KHR', 'Riels', '៛'),
       (117, 'KI', 'KIR', 'Kiribati', 'AUD', 'Dollar', '$'),
       (118, 'KM', 'COM', 'Comoros', 'KMF', 'Franc', NULL),
       (119, 'KN', 'KNA', 'Saint Kitts and Nevis', 'XCD', 'Dollar', '$'),
       (120, 'KP', 'PRK', 'North Korea', 'KPW', 'Won', '₩'),
       (121, 'KR', 'KOR', 'South Korea', 'KRW', 'Won', '₩'),
       (122, 'KW', 'KWT', 'Kuwait', 'KWD', 'Dinar', NULL),
       (123, 'KY', 'CYM', 'Cayman Islands', 'KYD', 'Dollar', '$'),
       (124, 'KZ', 'KAZ', 'Kazakhstan', 'KZT', 'Tenge', 'лв'),
       (125, 'LA', 'LAO', 'Laos', 'LAK', 'Kip', '₭'),
       (126, 'LB', 'LBN', 'Lebanon', 'LBP', 'Pound', '£'),
       (127, 'LC', 'LCA', 'Saint Lucia', 'XCD', 'Dollar', '$'),
       (128, 'LI', 'LIE', 'Liechtenstein', 'CHF', 'Franc', 'CHF'),
       (129, 'LK', 'LKA', 'Sri Lanka', 'LKR', 'Rupee', '₨'),
       (130, 'LR', 'LBR', 'Liberia', 'LRD', 'Dollar', '$'),
       (131, 'LS', 'LSO', 'Lesotho', 'LSL', 'Loti', 'L'),
       (132, 'LT', 'LTU', 'Lithuania', 'LTL', 'Litas', 'Lt'),
       (133, 'LU', 'LUX', 'Luxembourg', 'EUR', 'Euro', '€'),
       (134, 'LV', 'LVA', 'Latvia', 'LVL', 'Lat', 'Ls'),
       (135, 'LY', 'LBY', 'Libya', 'LYD', 'Dinar', NULL),
       (136, 'MA', 'MAR', 'Morocco', 'MAD', 'Dirham', NULL),
       (137, 'MC', 'MCO', 'Monaco', 'EUR', 'Euro', '€'),
       (138, 'MD', 'MDA', 'Moldova', 'MDL', 'Leu', NULL),
       (139, 'ME', 'MNE', 'Montenegro', 'EUR', 'Euro', '€'),
       (140, 'MF', 'MAF', 'Saint Martin', 'EUR', 'Euro', '€'),
       (141, 'MG', 'MDG', 'Madagascar', 'MGA', 'Ariary', NULL),
       (142, 'MH', 'MHL', 'Marshall Islands', 'USD', 'Dollar', '$'),
       (143, 'MK', 'MKD', 'Macedonia', 'MKD', 'Denar', 'ден'),
       (144, 'ML', 'MLI', 'Mali', 'XOF', 'Franc', NULL),
       (145, 'MM', 'MMR', 'Myanmar', 'MMK', 'Kyat', 'K'),
       (146, 'MN', 'MNG', 'Mongolia', 'MNT', 'Tugrik', '₮'),
       (147, 'MO', 'MAC', 'Macao', 'MOP', 'Pataca', 'MOP'),
       (148, 'MP', 'MNP', 'Northern Mariana Islands', 'USD', 'Dollar', '$'),
       (149, 'MQ', 'MTQ', 'Martinique', 'EUR', 'Euro', '€'),
       (150, 'MR', 'MRT', 'Mauritania', 'MRO', 'Ouguiya', 'UM'),
       (151, 'MS', 'MSR', 'Montserrat', 'XCD', 'Dollar', '$'),
       (152, 'MT', 'MLT', 'Malta', 'MTL', 'Lira', NULL),
       (153, 'MU', 'MUS', 'Mauritius', 'MUR', 'Rupee', '₨'),
       (154, 'MV', 'MDV', 'Maldives', 'MVR', 'Rufiyaa', 'Rf'),
       (155, 'MW', 'MWI', 'Malawi', 'MWK', 'Kwacha', 'MK'),
       (156, 'MX', 'MEX', 'Mexico', 'MXN', 'Peso', '$'),
       (157, 'MY', 'MYS', 'Malaysia', 'MYR', 'Ringgit', 'RM'),
       (158, 'MZ', 'MOZ', 'Mozambique', 'MZN', 'Meticail', 'MT'),
       (159, 'NA', 'NAM', 'Namibia', 'NAD', 'Dollar', '$'),
       (160, 'NC', 'NCL', 'New Caledonia', 'XPF', 'Franc', NULL),
       (161, 'NE', 'NER', 'Niger', 'XOF', 'Franc', NULL),
       (162, 'NF', 'NFK', 'Norfolk Island', 'AUD', 'Dollar', '$'),
       (163, 'NG', 'NGA', 'Nigeria', 'NGN', 'Naira', '₦'),
       (164, 'NI', 'NIC', 'Nicaragua', 'NIO', 'Cordoba', 'C$'),
       (165, 'NL', 'NLD', 'Netherlands', 'EUR', 'Euro', '€'),
       (166, 'NO', 'NOR', 'Norway', 'NOK', 'Krone', 'kr'),
       (167, 'NP', 'NPL', 'Nepal', 'NPR', 'Rupee', '₨'),
       (168, 'NR', 'NRU', 'Nauru', 'AUD', 'Dollar', '$'),
       (169, 'NU', 'NIU', 'Niue', 'NZD', 'Dollar', '$'),
       (170, 'NZ', 'NZL', 'New Zealand', 'NZD', 'Dollar', '$'),
       (171, 'OM', 'OMN', 'Oman', 'OMR', 'Rial', '﷼'),
       (172, 'PA', 'PAN', 'Panama', 'PAB', 'Balboa', 'B/.'),
       (173, 'PE', 'PER', 'Peru', 'PEN', 'Sol', 'S/.'),
       (174, 'PF', 'PYF', 'French Polynesia', 'XPF', 'Franc', NULL),
       (175, 'PG', 'PNG', 'Papua New Guinea', 'PGK', 'Kina', NULL),
       (176, 'PH', 'PHL', 'Philippines', 'PHP', 'Peso', 'Php'),
       (177, 'PK', 'PAK', 'Pakistan', 'PKR', 'Rupee', '₨'),
       (178, 'PL', 'POL', 'Poland', 'PLN', 'Zloty', 'zł'),
       (179, 'PM', 'SPM', 'Saint Pierre and Miquelon', 'EUR', 'Euro', '€'),
       (180, 'PN', 'PCN', 'Pitcairn', 'NZD', 'Dollar', '$'),
       (181, 'PR', 'PRI', 'Puerto Rico', 'USD', 'Dollar', '$'),
       (182, 'PS', 'PSE', 'Palestinian Territory', 'ILS', 'Shekel', '₪'),
       (183, 'PT', 'PRT', 'Portugal', 'EUR', 'Euro', '€'),
       (184, 'PW', 'PLW', 'Palau', 'USD', 'Dollar', '$'),
       (185, 'PY', 'PRY', 'Paraguay', 'PYG', 'Guarani', 'Gs'),
       (186, 'QA', 'QAT', 'Qatar', 'QAR', 'Rial', '﷼'),
       (187, 'RE', 'REU', 'Reunion', 'EUR', 'Euro', '€'),
       (188, 'RO', 'ROU', 'Romania', 'RON', 'Leu', 'lei'),
       (189, 'RS', 'SRB', 'Serbia', 'RSD', 'Dinar', 'Дин'),
       (190, 'RU', 'RUS', 'Russia', 'RUB', 'Ruble', 'руб'),
       (191, 'RW', 'RWA', 'Rwanda', 'RWF', 'Franc', NULL),
       (192, 'SA', 'SAU', 'Saudi Arabia', 'SAR', 'Rial', '﷼'),
       (193, 'SB', 'SLB', 'Solomon Islands', 'SBD', 'Dollar', '$'),
       (194, 'SC', 'SYC', 'Seychelles', 'SCR', 'Rupee', '₨'),
       (195, 'SD', 'SDN', 'Sudan', 'SDD', 'Dinar', NULL),
       (196, 'SE', 'SWE', 'Sweden', 'SEK', 'Krona', 'kr'),
       (197, 'SG', 'SGP', 'Singapore', 'SGD', 'Dollar', '$'),
       (198, 'SH', 'SHN', 'Saint Helena', 'SHP', 'Pound', '£'),
       (199, 'SI', 'SVN', 'Slovenia', 'EUR', 'Euro', '€'),
       (200, 'SJ', 'SJM', 'Svalbard and Jan Mayen', 'NOK', 'Krone', 'kr'),
       (201, 'SK', 'SVK', 'Slovakia', 'SKK', 'Koruna', 'Sk'),
       (202, 'SL', 'SLE', 'Sierra Leone', 'SLL', 'Leone', 'Le'),
       (203, 'SM', 'SMR', 'San Marino', 'EUR', 'Euro', '€'),
       (204, 'SN', 'SEN', 'Senegal', 'XOF', 'Franc', NULL),
       (205, 'SO', 'SOM', 'Somalia', 'SOS', 'Shilling', 'S'),
       (206, 'SR', 'SUR', 'Suriname', 'SRD', 'Dollar', '$'),
       (207, 'ST', 'STP', 'Sao Tome and Principe', 'STD', 'Dobra', 'Db'),
       (208, 'SV', 'SLV', 'El Salvador', 'SVC', 'Colone', '$'),
       (209, 'SY', 'SYR', 'Syria', 'SYP', 'Pound', '£'),
       (210, 'SZ', 'SWZ', 'Swaziland', 'SZL', 'Lilangeni', NULL),
       (211, 'TC', 'TCA', 'Turks and Caicos Islands', 'USD', 'Dollar', '$'),
       (212, 'TD', 'TCD', 'Chad', 'XAF', 'Franc', NULL),
       (213, 'TF', 'ATF', 'French Southern Territories', 'EUR', 'Euro  ', '€'),
       (214, 'TG', 'TGO', 'Togo', 'XOF', 'Franc', NULL),
       (215, 'TH', 'THA', 'Thailand', 'THB', 'Baht', '฿'),
       (216, 'TJ', 'TJK', 'Tajikistan', 'TJS', 'Somoni', NULL),
       (217, 'TK', 'TKL', 'Tokelau', 'NZD', 'Dollar', '$'),
       (218, 'TL', 'TLS', 'East Timor', 'USD', 'Dollar', '$'),
       (219, 'TM', 'TKM', 'Turkmenistan', 'TMM', 'Manat', 'm'),
       (220, 'TN', 'TUN', 'Tunisia', 'TND', 'Dinar', NULL),
       (221, 'TO', 'TON', 'Tonga', 'TOP', 'Pa''anga', 'T$'),
       (222, 'TR', 'TUR', 'Turkey', 'TRY', 'Lira', 'YTL'),
       (223, 'TT', 'TTO', 'Trinidad and Tobago', 'TTD', 'Dollar', 'TT$'),
       (224, 'TV', 'TUV', 'Tuvalu', 'AUD', 'Dollar', '$'),
       (225, 'TW', 'TWN', 'Taiwan', 'TWD', 'Dollar', 'NT$'),
       (226, 'TZ', 'TZA', 'Tanzania', 'TZS', 'Shilling', NULL),
       (227, 'UA', 'UKR', 'Ukraine', 'UAH', 'Hryvnia', '₴'),
       (228, 'UG', 'UGA', 'Uganda', 'UGX', 'Shilling', NULL),
       (229, 'UM', 'UMI', 'United States Minor Outlying Islands', 'USD', 'Dollar ', '$'),
       (230, 'US', 'USA', 'United States', 'USD', 'Dollar', '$'),
       (231, 'UY', 'URY', 'Uruguay', 'UYU', 'Peso', '$U'),
       (232, 'UZ', 'UZB', 'Uzbekistan', 'UZS', 'Som', 'лв'),
       (233, 'VA', 'VAT', 'Vatican', 'EUR', 'Euro', '€'),
       (234, 'VC', 'VCT', 'Saint Vincent and the Grenadines', 'XCD', 'Dollar', '$'),
       (235, 'VE', 'VEN', 'Venezuela', 'VEF', 'Bolivar', 'Bs'),
       (236, 'VG', 'VGB', 'British Virgin Islands', 'USD', 'Dollar', '$'),
       (237, 'VI', 'VIR', 'U.S. Virgin Islands', 'USD', 'Dollar', '$'),
       (238, 'VN', 'VNM', 'Vietnam', 'VND', 'Dong', '₫'),
       (239, 'VU', 'VUT', 'Vanuatu', 'VUV', 'Vatu', 'Vt'),
       (240, 'WF', 'WLF', 'Wallis and Futuna', 'XPF', 'Franc', NULL),
       (241, 'WS', 'WSM', 'Samoa', 'WST', 'Tala', 'WS$'),
       (242, 'YE', 'YEM', 'Yemen', 'YER', 'Rial', '﷼'),
       (243, 'YT', 'MYT', 'Mayotte', 'EUR', 'Euro', '€'),
       (244, 'ZA', 'ZAF', 'South Africa', 'ZAR', 'Rand', 'R'),
       (245, 'ZM', 'ZMB', 'Zambia', 'ZMK', 'Kwacha', 'ZK'),
       (246, 'ZW', 'ZWE', 'Zimbabwe', 'ZWD', 'Dollar', 'Z$'),
       (247, 'CS', 'SCG', 'Serbia and Montenegro', 'RSD', 'Dinar', 'Дин');

-- --------------------------------------------------------

--
-- Table structure for table `cross_site_action`
--

CREATE TABLE IF NOT EXISTS `cross_site_action`
(
    `id` int
(
    11
) NOT NULL AUTO_INCREMENT,
    `key1` varchar
(
    64
) COLLATE utf8_bin NOT NULL,
    `key2` varchar
(
    64
) COLLATE utf8_bin NOT NULL,
    `data` text COLLATE utf8_bin,
    `date_added` datetime NOT NULL,
    PRIMARY KEY
(
    `id`
),
    UNIQUE KEY `key1`
(
    `key1`,
    `key2`
),
    KEY `date_added`
(
    `date_added`
)
    ) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE =utf8_bin AUTO_INCREMENT=9;

--
-- Dumping data for table `cross_site_action`
--

INSERT INTO `cross_site_action` (`id`, `key1`, `key2`, `data`, `date_added`)
VALUES (1, '222c27b6b453fd9d59cc8fcd80022078cc6b68ac0d5bb9854470715e6813b4e6',
        '6eaba993c2ccc969dbe57aed8d808ed011a669e9cef88f2de0f376322227918e',
        0x7b225f73657373696f6e5f6964223a22716e6b73686673356e7136743669766839726766706a6a733231222c225f6c6f676765645f696e5f757365725f6964223a2231227d,
        '2015-12-31 13:38:05'),
       (2, 'b62fe5071c96b055258f54346004aa32e6380b321116a5285482657888945da6',
        'e27e51dd17b85601ab7fc480fcc920e110a28c111b4f35fa3236b380eea58640',
        0x7b225f73657373696f6e5f6964223a22716e6b73686673356e7136743669766839726766706a6a733231222c225f6c6f676765645f696e5f757365725f6964223a2231227d,
        '2015-12-31 13:38:05'),
       (3, 'c009d7c2c6665bee2ce74cc7aa9fb7228f68155378db261c2c10755e67ea0dc4',
        '7806d229b37178d8cf94d49dfaea6f266a38685e6b7b4301f2345d23c60133cf',
        0x7b225f73657373696f6e5f6964223a22716e6b73686673356e7136743669766839726766706a6a733231222c225f6c6f676765645f696e5f757365725f6964223a2231227d,
        '2015-12-31 13:38:36'),
       (4, 'fce920575939f4a251fa9472dfba2cc044e2a1ed29fb89a9dec521b6fe7e7ab3',
        '14a7c99e3bcace168bdc38650d72aad0b5e3817adde038a2fb4985ff9e5ac7f0',
        0x7b225f73657373696f6e5f6964223a22716e6b73686673356e7136743669766839726766706a6a733231222c225f6c6f676765645f696e5f757365725f6964223a2231227d,
        '2015-12-31 13:38:36'),
       (5, '7e33477b8bb2e3fa82e1c01732e2c43fd5f50624f7195caf5de47159a0a412d3',
        '27ebc9963e2ce8dc93d0f0f545de0570a5f7b592a218404afb48a2344aff23d5',
        0x7b225f73657373696f6e5f6964223a22716e6b73686673356e7136743669766839726766706a6a733231222c225f6c6f676765645f696e5f757365725f6964223a2231227d,
        '2015-12-31 13:49:16'),
       (6, '2d062c060bcca6d8d56a9fe7c300d64b4add49a26fa9f2ceb271edda60b6a446',
        '42cb484c01fe6f496f6ae8ddc3cdb3c1fbaef0c6d7dcad67b05463c5d7b543ad',
        0x7b225f73657373696f6e5f6964223a22716e6b73686673356e7136743669766839726766706a6a733231222c225f6c6f676765645f696e5f757365725f6964223a2231227d,
        '2015-12-31 13:49:16'),
       (7, '3433e4bb6c482fe1f24bfc3e54a378262f5258b5483f148966f060b85ae4b4c2',
        'ac9d326751b283ad08ae0fb432690e39c9a31ef32d4a4b822c31c5da56d89be0',
        0x7b225f73657373696f6e5f6964223a22716e6b73686673356e7136743669766839726766706a6a733231222c225f6c6f676765645f696e5f757365725f6964223a2231227d,
        '2015-12-31 13:49:18'),
       (8, '6f1045d243471822baed08df928f4b7459ffdb9f2ea86f93c83fd65cd6557ac3',
        '34c2cffefab58e840f90cca4756160dd7d64129be069a8e830c1e6ff47f39c61',
        0x7b225f73657373696f6e5f6964223a22716e6b73686673356e7136743669766839726766706a6a733231222c225f6c6f676765645f696e5f757365725f6964223a2231227d,
        '2015-12-31 13:49:18');

-- --------------------------------------------------------

--
-- Table structure for table `download_page`
--

CREATE TABLE IF NOT EXISTS `download_page`
(
    `id` int
(
    11
) NOT NULL AUTO_INCREMENT,
    `download_page` varchar
(
    100
) COLLATE utf8_bin NOT NULL,
    `user_level_id` int
(
    11
) NOT NULL,
    `page_order` int
(
    5
) NOT NULL DEFAULT '0',
    `additional_javascript_code` text COLLATE utf8_bin NOT NULL,
    `additional_settings` text COLLATE utf8_bin NOT NULL,
    PRIMARY KEY
(
    `id`
)
    ) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE =utf8_bin AUTO_INCREMENT=73;

--
-- Dumping data for table `download_page`
--


-- --------------------------------------------------------

--
-- Table structure for table `download_token`
--

CREATE TABLE IF NOT EXISTS `download_token`
(
    `id` int
(
    11
) NOT NULL AUTO_INCREMENT,
    `token` varchar
(
    64
) COLLATE utf8_bin NOT NULL,
    `user_id` int
(
    11
) DEFAULT NULL,
    `ip_address` varchar
(
    45
) COLLATE utf8_bin NOT NULL,
    `file_id` int
(
    11
) NOT NULL,
    `created` datetime NOT NULL,
    `expiry` datetime NOT NULL,
    `download_speed` int
(
    11
) NOT NULL DEFAULT '0',
    `max_threads` int
(
    3
) NOT NULL DEFAULT '0',
    PRIMARY KEY
(
    `id`
),
    UNIQUE KEY `token`
(
    `token`
),
    KEY `expiry`
(
    `expiry`
)
    ) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE =utf8_bin AUTO_INCREMENT=1;

--
-- Dumping data for table `download_token`
--


-- --------------------------------------------------------

--
-- Table structure for table `download_tracker`
--

CREATE TABLE IF NOT EXISTS `download_tracker`
(
    `id` int
(
    11
) NOT NULL AUTO_INCREMENT,
    `file_id` int
(
    11
) NOT NULL,
    `ip_address` varchar
(
    45
) COLLATE utf8_bin NOT NULL,
    `download_username` varchar
(
    65
) COLLATE utf8_bin DEFAULT NULL,
    `date_started` datetime NOT NULL,
    `date_updated` datetime NOT NULL,
    `date_finished` datetime NOT NULL,
    `status` enum
(
    'downloading',
    'finished',
    'error',
    'cancelled'
) COLLATE utf8_bin NOT NULL,
    `start_offset` bigint
(
    20
) NOT NULL,
    `seek_end` bigint
(
    20
) NOT NULL,
    PRIMARY KEY
(
    `id`
),
    KEY `ip_address`
(
    `ip_address`
),
    KEY `date_updated`
(
    `date_updated`
),
    KEY `status`
(
    `status`
),
    KEY `file_id`
(
    `file_id`
),
    KEY `download_username`
(
    `download_username`
),
    KEY `date_started`
(
    `date_started`
)
    ) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE =utf8_bin AUTO_INCREMENT=1;

--
-- Dumping data for table `download_tracker`
--


-- --------------------------------------------------------

--
-- Table structure for table `file`
--

CREATE TABLE IF NOT EXISTS `file`
(
    `id` int
(
    11
) NOT NULL AUTO_INCREMENT,
    `originalFilename` varchar
(
    255
) NOT NULL,
    `shortUrl` varchar
(
    255
) DEFAULT NULL,
    `fileType` varchar
(
    140
) DEFAULT NULL,
    `extension` varchar
(
    10
) DEFAULT NULL,
    `fileSize` bigint
(
    15
) DEFAULT NULL,
    `localFilePath` varchar
(
    255
) DEFAULT NULL,
    `userId` int
(
    11
) DEFAULT NULL,
    `totalDownload` int
(
    11
) DEFAULT NULL,
    `uploadedIP` varchar
(
    45
) DEFAULT NULL,
    `uploadedDate` timestamp NULL DEFAULT NULL,
    `statusId` int
(
    2
) DEFAULT NULL,
    `visits` int
(
    11
) DEFAULT '0',
    `lastAccessed` timestamp NULL DEFAULT NULL,
    `deleteHash` varchar
(
    32
) DEFAULT NULL,
    `folderId` int
(
    11
) DEFAULT NULL,
    `serverId` int
(
    11
) DEFAULT '1',
    `adminNotes` text,
    `fileLevel` enum
(
    'free',
    'premium'
) NOT NULL DEFAULT 'free',
    `accessPassword` varchar
(
    32
) DEFAULT NULL,
    `fileHash` varchar
(
    32
) DEFAULT NULL,
    `originalFileHash` varchar
(
    32
) DEFAULT NULL,
    `apikey` varchar
(
    32
) NOT NULL,
    `minUserLevel` int
(
    3
) DEFAULT NULL,
    `linkedFileId` int
(
    11
) DEFAULT NULL,
    `keywords` varchar
(
    255
) DEFAULT NULL,
    `isPublic` int
(
    1
) NOT NULL DEFAULT '1',
    `total_likes` int
(
    11
) NOT NULL DEFAULT '0',
    `uploadSource` enum
(
    'direct',
    'remote',
    'ftp',
    'torrent',
    'leech',
    'webdav',
    'api',
    'other'
) NOT NULL DEFAULT 'direct',
    `unique_hash` varchar
(
    64
) DEFAULT NULL,
    PRIMARY KEY
(
    `id`
),
    UNIQUE KEY `unique_hash`
(
    `unique_hash`
),
    KEY `shortUrl`
(
    `shortUrl`
),
    KEY `fileSize`
(
    `fileSize`
),
    KEY `visits`
(
    `visits`
),
    KEY `lastAccessed`
(
    `lastAccessed`
),
    KEY `extension`
(
    `extension`
),
    KEY `originalFilename`
(
    `originalFilename`
),
    KEY `userId`
(
    `userId`
),
    KEY `uploadedDate`
(
    `uploadedDate`
),
    KEY `serverId`
(
    `serverId`
),
    KEY `fileHash`
(
    `fileHash`
),
    KEY `originalFileHash`
(
    `originalFileHash`
),
    KEY `linkedFileId`
(
    `linkedFileId`
),
    KEY `statusId`
(
    `statusId`
),
    FULLTEXT KEY `keywords`
(
    `keywords`
)
    ) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

--
-- Dumping data for table `file`
--


-- --------------------------------------------------------

--
-- Table structure for table `file_action`
--

CREATE TABLE IF NOT EXISTS `file_action`
(
    `id` int
(
    11
) NOT NULL AUTO_INCREMENT,
    `file_id` int
(
    11
) DEFAULT NULL,
    `server_id` int
(
    11
) NOT NULL,
    `file_path` text COLLATE utf8_bin NOT NULL,
    `file_action` enum
(
    'delete',
    'move',
    'restore'
) COLLATE utf8_bin NOT NULL,
    `status` enum
(
    'pending',
    'processing',
    'complete',
    'failed',
    'cancelled'
) COLLATE utf8_bin NOT NULL,
    `action_data` varchar
(
    255
) COLLATE utf8_bin DEFAULT NULL,
    `status_msg` varchar
(
    255
) COLLATE utf8_bin DEFAULT NULL,
    `date_created` datetime NOT NULL,
    `last_updated` datetime DEFAULT NULL,
    `action_date` datetime DEFAULT NULL,
    PRIMARY KEY
(
    `id`
),
    KEY `file_action`
(
    `file_action`
),
    KEY `status`
(
    `status`
),
    KEY `file_id`
(
    `file_id`
),
    KEY `server_id`
(
    `server_id`
),
    KEY `date_created`
(
    `date_created`
),
    KEY `action_date`
(
    `action_date`
)
    ) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE =utf8_bin AUTO_INCREMENT=1;

--
-- Dumping data for table `file_action`
--


-- --------------------------------------------------------

--
-- Table structure for table `file_folder`
--

CREATE TABLE IF NOT EXISTS `file_folder`
(
    `id` int
(
    11
) NOT NULL AUTO_INCREMENT,
    `userId` int
(
    11
) NOT NULL,
    `parentId` int
(
    11
) DEFAULT NULL,
    `folderName` varchar
(
    255
) NOT NULL,
    `isPublic` int
(
    1
) NOT NULL DEFAULT '0',
    `accessPassword` varchar
(
    32
) DEFAULT NULL,
    `coverImageId` int
(
    11
) DEFAULT NULL,
    `date_added` datetime DEFAULT NULL,
    `date_updated` datetime DEFAULT NULL,
    PRIMARY KEY
(
    `id`
)
    ) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

--
-- Dumping data for table `file_folder`
--


-- --------------------------------------------------------

--
-- Table structure for table `file_folder_share`
--

CREATE TABLE IF NOT EXISTS `file_folder_share`
(
    `id` int
(
    11
) NOT NULL AUTO_INCREMENT,
    `folder_id` int
(
    11
) NOT NULL,
    `access_key` varchar
(
    64
) COLLATE utf8_bin NOT NULL,
    `date_created` datetime NOT NULL,
    `last_accessed` datetime NOT NULL,
    `created_by_user_id` int
(
    11
) NOT NULL,
    PRIMARY KEY
(
    `id`
),
    UNIQUE KEY `access_key`
(
    `access_key`
),
    KEY `folder_id`
(
    `folder_id`,
    `created_by_user_id`
)
    ) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE =utf8_bin AUTO_INCREMENT=1;

--
-- Dumping data for table `file_folder_share`
--


-- --------------------------------------------------------

--
-- Table structure for table `file_report`
--

CREATE TABLE IF NOT EXISTS `file_report`
(
    `id` int
(
    11
) NOT NULL AUTO_INCREMENT,
    `file_id` int
(
    11
) NOT NULL,
    `report_date` datetime NOT NULL,
    `reported_by_name` varchar
(
    150
) COLLATE utf8_bin NOT NULL,
    `reported_by_email` varchar
(
    255
) COLLATE utf8_bin NOT NULL,
    `reported_by_address` text COLLATE utf8_bin NOT NULL,
    `reported_by_telephone_number` varchar
(
    30
) COLLATE utf8_bin NOT NULL,
    `digital_signature` varchar
(
    150
) COLLATE utf8_bin NOT NULL,
    `report_status` enum
(
    'pending',
    'cancelled',
    'accepted'
) COLLATE utf8_bin NOT NULL,
    `reported_by_ip` varchar
(
    45
) COLLATE utf8_bin NOT NULL,
    `other_information` text COLLATE utf8_bin NOT NULL,
    PRIMARY KEY
(
    `id`
),
    KEY `file_id`
(
    `file_id`
)
    ) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE =utf8_bin AUTO_INCREMENT=12;

--
-- Dumping data for table `file_report`
--


-- --------------------------------------------------------

--
-- Table structure for table `file_server`
--

CREATE TABLE IF NOT EXISTS `file_server`
(
    `id` int
(
    11
) NOT NULL AUTO_INCREMENT,
    `serverLabel` varchar
(
    100
) NOT NULL,
    `serverType` enum
(
    'remote',
    'local',
    'ftp',
    'sftp',
    'direct',
    'amazon_s3'
) DEFAULT NULL,
    `ipAddress` varchar
(
    255
) NOT NULL,
    `ftpPort` int
(
    11
) NOT NULL DEFAULT '21',
    `ftpUsername` varchar
(
    50
) NOT NULL,
    `ftpPassword` varchar
(
    50
) DEFAULT NULL,
    `statusId` int
(
    11
) NOT NULL DEFAULT '1',
    `storagePath` varchar
(
    255
) DEFAULT NULL,
    `fileServerDomainName` varchar
(
    255
) DEFAULT NULL,
    `scriptPath` varchar
(
    150
) DEFAULT NULL,
    `totalSpaceUsed` float
(
    18,
    0
) NOT NULL DEFAULT '0',
    `totalFiles` int
(
    11
) NOT NULL DEFAULT '0',
    `maximumStorageBytes` bigint
(
    20
) NOT NULL DEFAULT '0',
    `priority` int
(
    11
) NOT NULL DEFAULT '0',
    `routeViaMainSite` int
(
    1
) NOT NULL DEFAULT '0',
    `lastFileActionQueueProcess` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
    `serverConfig` text,
    `dlAccelerator` int
(
    1
) NOT NULL DEFAULT '0',
    PRIMARY KEY
(
    `id`
),
    KEY `statusId`
(
    `statusId`
),
    KEY `lastFileActionQueueProcess`
(
    `lastFileActionQueueProcess`
),
    KEY `totalFiles`
(
    `totalFiles`
)
    ) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=37;

--
-- Dumping data for table `file_server`
--

INSERT INTO `file_server` (`id`, `serverLabel`, `serverType`, `ipAddress`, `ftpPort`, `ftpUsername`, `ftpPassword`,
                           `statusId`, `storagePath`, `fileServerDomainName`, `scriptPath`, `totalSpaceUsed`,
                           `totalFiles`, `maximumStorageBytes`, `priority`, `routeViaMainSite`,
                           `lastFileActionQueueProcess`, `serverConfig`, `dlAccelerator`)
VALUES (1, 'Local Default', 'local', '', 0, '', '', 2, '', '', '', 0, 0, 0, 0, 0, '0000-00-00 00:00:00',
        '{"ftp_server_type":"","ftp_passive_mode":""}', 0);

-- --------------------------------------------------------

--
-- Table structure for table `file_server_status`
--

CREATE TABLE IF NOT EXISTS `file_server_status`
(
    `id` int
(
    11
) NOT NULL AUTO_INCREMENT,
    `label` varchar
(
    30
) DEFAULT NULL,
    PRIMARY KEY
(
    `id`
)
    ) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=4;

--
-- Dumping data for table `file_server_status`
--

INSERT INTO `file_server_status` (`id`, `label`)
VALUES (1, 'disabled'),
       (2, 'active'),
       (3, 'read only');

-- --------------------------------------------------------

--
-- Table structure for table `file_status`
--

CREATE TABLE IF NOT EXISTS `file_status`
(
    `id` int
(
    11
) NOT NULL AUTO_INCREMENT,
    `label` varchar
(
    30
) DEFAULT NULL,
    PRIMARY KEY
(
    `id`
)
    ) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=6;

--
-- Dumping data for table `file_status`
--

INSERT INTO `file_status` (`id`, `label`)
VALUES (1, 'active'),
       (2, 'user removed'),
       (3, 'admin removed'),
       (4, 'copyright removed'),
       (5, 'system expired');

-- --------------------------------------------------------

--
-- Table structure for table `internal_notification`
--

CREATE TABLE IF NOT EXISTS `internal_notification`
(
    `id` int
(
    11
) NOT NULL AUTO_INCREMENT,
    `to_user_id` int
(
    11
) NOT NULL,
    `date_added` datetime NOT NULL,
    `content` varchar
(
    255
) COLLATE utf8_bin NOT NULL,
    `notification_icon` varchar
(
    30
) COLLATE utf8_bin NOT NULL DEFAULT 'entypo-info',
    `href_url` varchar
(
    255
) COLLATE utf8_bin DEFAULT NULL,
    `onclick` varchar
(
    255
) COLLATE utf8_bin DEFAULT NULL,
    `is_read` int
(
    1
) NOT NULL DEFAULT '0',
    PRIMARY KEY
(
    `id`
),
    KEY `to_user_id`
(
    `to_user_id`
)
    ) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE =utf8_bin AUTO_INCREMENT=1;

--
-- Dumping data for table `internal_notification`
--


-- --------------------------------------------------------

--
-- Table structure for table `language`
--

CREATE TABLE IF NOT EXISTS `language`
(
    `id` int
(
    11
) NOT NULL AUTO_INCREMENT,
    `languageName` varchar
(
    255
) NOT NULL,
    `isLocked` int
(
    1
) NOT NULL,
    `isActive` int
(
    1
) NOT NULL DEFAULT '1',
    `flag` varchar
(
    20
) NOT NULL,
    `direction` varchar
(
    3
) NOT NULL DEFAULT 'LTR',
    PRIMARY KEY
(
    `id`
)
    ) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=37;

--
-- Dumping data for table `language`
--

INSERT INTO `language` (`id`, `languageName`, `isLocked`, `isActive`, `flag`, `direction`)
VALUES (1, 'English (en)', 1, 1, 'us', 'LTR');

-- --------------------------------------------------------

--
-- Table structure for table `language_content`
--

CREATE TABLE IF NOT EXISTS `language_content`
(
    `id` int
(
    11
) NOT NULL AUTO_INCREMENT,
    `languageKeyId` int
(
    11
) NOT NULL,
    `languageId` int
(
    11
) NOT NULL,
    `content` text NOT NULL,
    PRIMARY KEY
(
    `id`
),
    KEY `languageKeyId`
(
    `languageKeyId`
),
    KEY `languageId`
(
    `languageId`
)
    ) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=2316;

--
-- Dumping data for table `language_content`
--

INSERT INTO `language_content` (`id`, `languageKeyId`, `languageId`, `content`)
VALUES (1, 1, 1, 'home'),
       (2, 3, 1, 'banned words / urls'),
       (3, 4, 1, 'admin users'),
       (4, 5, 1, 'banned ips'),
       (5, 6, 1, 'site settings'),
       (6, 7, 1, 'languages'),
       (7, 8, 1, 'logout'),
       (8, 9, 1, 'Language Details'),
       (9, 10, 1, 'Are you sure you want to remove this IP ban?'),
       (10, 11, 1, 'Are you sure you want to update the status of this user?'),
       (11, 12, 1, 'view'),
       (12, 13, 1, 'disable'),
       (13, 14, 1, 'enable'),
       (14, 15, 1, 'Are you sure you want to remove this banned word?'),
       (15, 16, 1, 'IP address appears to be invalid, please try again.'),
       (16, 17, 1, 'IP address is already in the blocked list.'),
       (17, 18, 1, 'There was a problem inserting/updating the record, please try again later.'),
       (18, 19, 1, 'Banned word is already in the list.'),
       (19, 20, 1, 'Language already in the system.'),
       (20, 21, 1, 'Username must be between 6-16 characters long.'),
       (21, 22, 1, 'Password must be between 6-16 characters long.'),
       (22, 23, 1, 'Please enter the firstname.'),
       (23, 24, 1, 'Please enter the lastname.'),
       (24, 25, 1, 'Please enter the email address.'),
       (25, 26, 1, 'The email address you entered appears to be invalid.'),
       (26, 17482, 1, 'copyright'),
       (27, 28, 1, 'Support'),
       (28, 30, 1, 'Admin Panel'),
       (29, 31, 1, 'Logged in as'),
       (30, 32, 1,
        'To ban an IP Address <a href="#" onClick="displayBannedIpPopup(); return false;">click here</a> or delete any existing ones below'),
       (31, 33, 1, 'Add banned IP address'),
       (32, 34, 1, 'remove'),
       (33, 35, 1, 'IP Address'),
       (34, 36, 1, 'Ban From'),
       (35, 37, 1, 'Notes'),
       (36, 38, 1, 'Add Banned IP'),
       (37, 39, 1, 'There was an error submitting the form, please try again later.'),
       (38, 40, 1, 'Enter IP Address details'),
       (39, 41, 1,
        'To ban an word within the original url <a href="#" onClick="displayBannedWordsPopup(); return false;">click here</a> or delete any existing ones below'),
       (40, 42, 1, 'Add banned word'),
       (41, 43, 1, 'Banned Word'),
       (42, 44, 1, 'Date Banned'),
       (43, 45, 1, 'Ban Notes'),
       (44, 46, 1, 'Action'),
       (45, 47, 1, 'Enter Banned Word details'),
       (46, 48, 1, 'Use the main navigation above to manage this site. A quick overview of the site can be seen below'),
       (47, 49, 1, 'New Files (last 14 days)'),
       (48, 50, 1, 'New Files (last 12 months)'),
       (49, 51, 1, 'Urls'),
       (50, 52, 1, 'active'),
       (51, 53, 1, 'disabled'),
       (52, 54, 1, 'spam'),
       (53, 55, 1, 'expired'),
       (54, 56, 1, 'Total active files'),
       (55, 57, 1, 'Total disabled files'),
       (56, 58, 1, 'Total downloads to all files'),
       (57, 59, 1, 'Item Name'),
       (58, 60, 1, 'Value'),
       (59, 61, 1,
        'Manage the available content for the selected language. Click on any of the ''Translated Content'' cells to edit the value.'),
       (60, 62, 1,
        'Select a language to manage or <a href=''#'' onClick=''displayAddLanguagePopup(); return false;''>add a new one here</a>. NOTE Once translated, to set the site default language go to the <a href=''settings.php''>site settings</a> area.'),
       (61, 63, 1, 'Language Key'),
       (62, 64, 1, 'Default Content'),
       (63, 65, 1, 'Translated Content'),
       (64, 66, 1, 'Error Changes to this section can not be made within demo mode.'),
       (65, 67, 1, 'Manage other languages'),
       (66, 68, 1, 'There is no available content.'),
       (67, 69, 1, 'select language'),
       (68, 70, 1, 'Add Language'),
       (69, 71, 1, 'Language Name'),
       (70, 72, 1, 'Click on any of the items within the "Config Value" column below to edit'),
       (71, 73, 1, 'Group'),
       (72, 74, 1, 'Config Description'),
       (73, 75, 1, 'Config Value'),
       (74, 76, 1, 'Filter results'),
       (75, 77, 1,
        'Double click on any of the users below to edit the account information or <a href="#" onClick="displayUserPopup(); return false;">click here to add a new user</a>'),
       (76, 78, 1, 'Add new user'),
       (77, 79, 1, 'Username'),
       (78, 19498, 1, 'Email Address'),
       (79, 17447, 1, 'account type'),
       (80, 82, 1, 'Last Login'),
       (81, 17446, 1, 'account status'),
       (82, 84, 1, 'Password'),
       (83, 85, 1, 'Title'),
       (84, 86, 1, 'Firstname'),
       (85, 87, 1, 'Lastname'),
       (86, 88, 1, 'Enter user details'),
       (87, 17487, 1, 'test'),
       (88, 515, 1, 'Main Navigation'),
       (89, 19411, 1, 'hour'),
       (90, 1427, 1, 'dat'),
       (91, 617, 1, 'Fast and instant downloading!'),
       (92, 618, 1,
        'Our premium members benefit from no waiting time and direct downloads for all of their files. Unlike other file hosts we don''t limit the transfer speed of our downloads.'),
       (93, 616, 1,
        'We supply you with all the tools necessary to easily share your files. Use our pre-generated html code to link from your website or post directly to Facebook or Twitter.'),
       (94, 1429, 1, 'Publicly Accessible (using ~s on url)'),
       (95, 108, 1, 'please wait'),
       (96, 109, 1, 'There was a general site error, please try again later.'),
       (97, 110, 1, 'Error'),
       (98, 615, 1, 'Share your files with everyone!'),
       (99, 603, 1, 'Could not load server details.'),
       (100, 604, 1, 'FTP Host'),
       (101, 605, 1, 'FTP Port'),
       (102, 606, 1, 'Please specify the server ftp host.'),
       (103, 607, 1, 'By File Server'),
       (104, 608, 1, 'view files'),
       (105, 609, 1, 'By User'),
       (106, 19364, 1, 'ADMIN AREA'),
       (107, 611, 1, 'system expired'),
       (108, 612, 1, 'Upload, share and manage your files for free.'),
       (109, 613, 1, 'Store and manage all your files!'),
       (110, 614, 1,
        'Upload multiple files at once and keep them forever on this site. If you''re using FireFox or Chrome, you can simply drag &amp; drop your files to begin uploading.'),
       (111, 567, 1, 'error, file, upload, script'),
       (112, 568, 1, 'Choose free or premium download'),
       (113, 569, 1, 'slow download'),
       (114, 570, 1, 'wait'),
       (115, 571, 1, 'sec'),
       (116, 572, 1, 'FAST INSTANT DOWNLOAD'),
       (117, 573, 1, 'download type'),
       (118, 575, 1, 'download speed'),
       (119, 576, 1, 'maximum'),
       (120, 577, 1, 'waiting time'),
       (121, 578, 1, 'seconds'),
       (122, 579, 1, 'instant'),
       (123, 580, 1, 'site advertising'),
       (124, 581, 1, 'yes'),
       (125, 582, 1, 'none'),
       (126, 583, 1, 'how long to keep files'),
       (127, 584, 1, 'forever'),
       (128, 585, 1, 'Maximum file upload size'),
       (129, 586, 1, 'interface to manage uploaded files'),
       (130, 587, 1, 'not available'),
       (131, 588, 1, 'available'),
       (132, 589, 1, 'fast download even when servers are busy'),
       (133, 1849, 1, ''),
       (134, 561, 1, 'Uploaded file statistics'),
       (135, 562, 1, 'stats, statistics, unique, visitors, hits, file, upload'),
       (136, 563, 1, 'upgrade now for instant access'),
       (137, 564, 1, 'downloading'),
       (138, 565, 1, 'Error'),
       (139, 566, 1, 'Error'),
       (140, 552, 1, 'Please enter your lastname'),
       (141, 553, 1, 'Report Abuse'),
       (142, 554, 1, 'Report Abuse or Copyright Infringement'),
       (143, 555, 1, 'report, abuse, copyright, infringement, file, hosting'),
       (144, 556, 1,
        'Please use the following form to report any copyright infringements ensuring you supply all the following information<br/><br/>\n<ul class=''formattedList''>\n<li>A physical or electronic signature of the copyright owner or the person authorized to act on its behalf;</li>\n<li>A description of the copyrighted work claimed to have been infringed;</li>\n<li>A description of the infringing material and information reasonably sufficient to permit File Upload Script to locate the material;</li>\n<li>Your contact information, including your address, telephone number, and email;</li>\n<li>A statement by you that you have a good faith belief that use of the material in the manner complained of is not authorized by the copyright owner, its agent, or the law; and</li>\n<li>A statement that the information in the notification is accurate, and, under the pains and penalties of perjury, that you are authorized to act on behalf of the copyright owner.</li>\n</ul>'),
       (145, 557, 1, 'submit report'),
       (146, 558, 1, 'Paid Expiry Y-m-d (optional)'),
       (147, 559, 1, 'Account expiry date is invalid. It should be in the format YYYY-mm-dd'),
       (148, 153, 1, 'visits'),
       (149, 154, 1, 'created'),
       (150, 155, 1, 'Visitors'),
       (151, 156, 1, 'Countries'),
       (152, 157, 1, 'Top Referrers'),
       (153, 158, 1, 'Browsers'),
       (154, 159, 1, 'Operating Systems'),
       (155, 160, 1, 'last 24 hours'),
       (156, 161, 1, 'last 7 days'),
       (157, 162, 1, 'last 30 days'),
       (158, 163, 1, 'last 12 months'),
       (159, 164, 1, 'Hour'),
       (160, 165, 1, 'Visits'),
       (161, 166, 1, 'Date'),
       (162, 167, 1, 'Total visits'),
       (163, 168, 1, 'Percentage'),
       (164, 169, 1, 'Day'),
       (165, 170, 1, 'Month'),
       (166, 171, 1, 'Country'),
       (167, 172, 1, 'Site'),
       (168, 173, 1, 'Browser'),
       (169, 174, 1, 'Operating System'),
       (170, 175, 1, 'Andorra'),
       (171, 176, 1, 'United Arab Emirates'),
       (172, 177, 1, 'Afghanistan'),
       (173, 178, 1, 'Antigua And Barbuda'),
       (174, 179, 1, 'Anguilla'),
       (175, 180, 1, 'Albania'),
       (176, 181, 1, 'Armenia'),
       (177, 182, 1, 'Netherlands Antilles'),
       (178, 183, 1, 'Angola'),
       (179, 184, 1, 'Antarctica'),
       (180, 185, 1, 'Argentina'),
       (181, 186, 1, 'American Samoa'),
       (182, 187, 1, 'Austria'),
       (183, 188, 1, 'Australia'),
       (184, 189, 1, 'Aruba'),
       (185, 190, 1, 'Azerbaijan'),
       (186, 191, 1, 'Bosnia And Herzegovina'),
       (187, 192, 1, 'Barbados'),
       (188, 193, 1, 'Bangladesh'),
       (189, 194, 1, 'Belgium'),
       (190, 195, 1, 'Burkina Faso'),
       (191, 196, 1, 'Bulgaria'),
       (192, 197, 1, 'Bahrain'),
       (193, 198, 1, 'Burundi'),
       (194, 199, 1, 'Benin'),
       (195, 200, 1, 'Bermuda'),
       (196, 201, 1, 'Brunei Darussalam'),
       (197, 202, 1, 'Bolivia'),
       (198, 203, 1, 'Brazil'),
       (199, 204, 1, 'Bahamas'),
       (200, 205, 1, 'Bhutan'),
       (201, 206, 1, 'Botswana'),
       (202, 207, 1, 'Belarus'),
       (203, 208, 1, 'Belize'),
       (204, 209, 1, 'Canada'),
       (205, 210, 1, 'The Democratic Republic Of The Congo'),
       (206, 211, 1, 'Central African Republic'),
       (207, 212, 1, 'Congo'),
       (208, 213, 1, 'Switzerland'),
       (209, 214, 1, 'Cote Divoire'),
       (210, 215, 1, 'Cook Islands'),
       (211, 216, 1, 'Chile'),
       (212, 217, 1, 'Cameroon'),
       (213, 218, 1, 'China'),
       (214, 219, 1, 'Colombia'),
       (215, 220, 1, 'Costa Rica'),
       (216, 221, 1, 'Serbia And Montenegro'),
       (217, 222, 1, 'Cuba'),
       (218, 223, 1, 'Cape Verde'),
       (219, 224, 1, 'Cyprus'),
       (220, 225, 1, 'Czech Republic'),
       (221, 226, 1, 'Germany'),
       (222, 227, 1, 'Djibouti'),
       (223, 228, 1, 'Denmark'),
       (224, 229, 1, 'Dominica'),
       (225, 230, 1, 'Dominican Republic'),
       (226, 231, 1, 'Algeria'),
       (227, 232, 1, 'Ecuador'),
       (228, 233, 1, 'Estonia'),
       (229, 234, 1, 'Egypt'),
       (230, 235, 1, 'Eritrea'),
       (231, 236, 1, 'Spain'),
       (232, 237, 1, 'Ethiopia'),
       (233, 238, 1, 'European Union'),
       (234, 239, 1, 'Finland'),
       (235, 240, 1, 'Fiji'),
       (236, 241, 1, 'Falkland Islands (Malvinas)'),
       (237, 242, 1, 'Federated States Of Micronesia'),
       (238, 243, 1, 'Faroe Islands'),
       (239, 244, 1, 'France'),
       (240, 245, 1, 'Gabon'),
       (241, 246, 1, 'United Kingdom'),
       (242, 247, 1, 'Grenada'),
       (243, 248, 1, 'Georgia'),
       (244, 249, 1, 'French Guiana'),
       (245, 250, 1, 'Ghana'),
       (246, 251, 1, 'Gibraltar'),
       (247, 252, 1, 'Greenland'),
       (248, 253, 1, 'Gambia'),
       (249, 254, 1, 'Guinea'),
       (250, 255, 1, 'Guadeloupe'),
       (251, 256, 1, 'Equatorial Guinea'),
       (252, 257, 1, 'Greece'),
       (253, 258, 1, 'South Georgia And The South Sandwich Islands'),
       (254, 259, 1, 'Guatemala'),
       (255, 260, 1, 'Guam'),
       (256, 261, 1, 'Guinea-Bissau'),
       (257, 262, 1, 'Guyana'),
       (258, 263, 1, 'Hong Kong'),
       (259, 264, 1, 'Honduras'),
       (260, 265, 1, 'Croatia'),
       (261, 266, 1, 'Haiti'),
       (262, 267, 1, 'Hungary'),
       (263, 268, 1, 'Indonesia'),
       (264, 269, 1, 'Ireland'),
       (265, 270, 1, 'Israel'),
       (266, 271, 1, 'India'),
       (267, 272, 1, 'British Indian Ocean Territory'),
       (268, 273, 1, 'Iraq'),
       (269, 274, 1, 'Islamic Republic Of Iran'),
       (270, 275, 1, 'Iceland'),
       (271, 276, 1, 'Italy'),
       (272, 277, 1, 'Jamaica'),
       (273, 278, 1, 'Jordan'),
       (274, 279, 1, 'Japan'),
       (275, 280, 1, 'Kenya'),
       (276, 281, 1, 'Kyrgyzstan'),
       (277, 282, 1, 'Cambodia'),
       (278, 283, 1, 'Kiribati'),
       (279, 284, 1, 'Comoros'),
       (280, 285, 1, 'Saint Kitts And Nevis'),
       (281, 286, 1, 'Republic Of Korea'),
       (282, 287, 1, 'Kuwait'),
       (283, 288, 1, 'Cayman Islands'),
       (284, 289, 1, 'Kazakhstan'),
       (285, 290, 1, 'Lao Peoples Democratic Republic'),
       (286, 291, 1, 'Lebanon'),
       (287, 292, 1, 'Saint Lucia'),
       (288, 293, 1, 'Liechtenstein'),
       (289, 294, 1, 'Sri Lanka'),
       (290, 295, 1, 'Liberia'),
       (291, 296, 1, 'Lesotho'),
       (292, 297, 1, 'Lithuania'),
       (293, 298, 1, 'Luxembourg'),
       (294, 299, 1, 'Latvia'),
       (295, 300, 1, 'Libyan Arab Jamahiriya'),
       (296, 301, 1, 'Morocco'),
       (297, 302, 1, 'Monaco'),
       (298, 303, 1, 'Republic Of Moldova'),
       (299, 304, 1, 'Madagascar'),
       (300, 305, 1, 'Marshall Islands'),
       (301, 306, 1, 'The Former Yugoslav Republic Of Macedonia'),
       (302, 307, 1, 'Mali'),
       (303, 308, 1, 'Myanmar'),
       (304, 309, 1, 'Mongolia'),
       (305, 310, 1, 'Macao'),
       (306, 311, 1, 'Northern Mariana Islands'),
       (307, 312, 1, 'Martinique'),
       (308, 313, 1, 'Mauritania'),
       (309, 314, 1, 'Malta'),
       (310, 315, 1, 'Mauritius'),
       (311, 316, 1, 'Maldives'),
       (312, 317, 1, 'Malawi'),
       (313, 318, 1, 'Mexico'),
       (314, 319, 1, 'Malaysia'),
       (315, 320, 1, 'Mozambique'),
       (316, 321, 1, 'Namibia'),
       (317, 322, 1, 'New Caledonia'),
       (318, 323, 1, 'Niger'),
       (319, 324, 1, 'Norfolk Island'),
       (320, 325, 1, 'Nigeria'),
       (321, 326, 1, 'Nicaragua'),
       (322, 327, 1, 'Netherlands'),
       (323, 328, 1, 'Norway'),
       (324, 329, 1, 'Nepal'),
       (325, 330, 1, 'Nauru'),
       (326, 331, 1, 'Niue'),
       (327, 332, 1, 'New Zealand'),
       (328, 333, 1, 'Oman'),
       (329, 334, 1, 'Panama'),
       (330, 335, 1, 'Peru'),
       (331, 336, 1, 'French Polynesia'),
       (332, 337, 1, 'Papua New Guinea'),
       (333, 338, 1, 'Philippines'),
       (334, 339, 1, 'Pakistan'),
       (335, 340, 1, 'Poland'),
       (336, 341, 1, 'Puerto Rico'),
       (337, 342, 1, 'Palestinian Territory'),
       (338, 343, 1, 'Portugal'),
       (339, 344, 1, 'Palau'),
       (340, 345, 1, 'Paraguay'),
       (341, 346, 1, 'Qatar'),
       (342, 347, 1, 'Reunion'),
       (343, 348, 1, 'Romania'),
       (344, 349, 1, 'Russian Federation'),
       (345, 350, 1, 'Rwanda'),
       (346, 351, 1, 'Saudi Arabia'),
       (347, 352, 1, 'Solomon Islands'),
       (348, 353, 1, 'Seychelles'),
       (349, 354, 1, 'Sudan'),
       (350, 355, 1, 'Sweden'),
       (351, 356, 1, 'Singapore'),
       (352, 357, 1, 'Slovenia'),
       (353, 358, 1, 'Slovakia (Slovak Republic)'),
       (354, 359, 1, 'Sierra Leone'),
       (355, 360, 1, 'San Marino'),
       (356, 361, 1, 'Senegal'),
       (357, 362, 1, 'Somalia'),
       (358, 363, 1, 'Suriname'),
       (359, 364, 1, 'Sao Tome And Principe'),
       (360, 365, 1, 'El Salvador'),
       (361, 366, 1, 'Syrian Arab Republic'),
       (362, 367, 1, 'Swaziland'),
       (363, 368, 1, 'Chad'),
       (364, 369, 1, 'French Southern Territories'),
       (365, 370, 1, 'Togo'),
       (366, 371, 1, 'Thailand'),
       (367, 372, 1, 'Tajikistan'),
       (368, 373, 1, 'Tokelau'),
       (369, 374, 1, 'Timor-Leste'),
       (370, 375, 1, 'Turkmenistan'),
       (371, 376, 1, 'Tunisia'),
       (372, 377, 1, 'Tonga'),
       (373, 378, 1, 'Turkey'),
       (374, 379, 1, 'Trinidad And Tobago'),
       (375, 380, 1, 'Tuvalu'),
       (376, 381, 1, 'Taiwan Province Of China'),
       (377, 382, 1, 'United Republic Of Tanzania'),
       (378, 383, 1, 'Ukraine'),
       (379, 384, 1, 'Uganda'),
       (380, 385, 1, 'United States'),
       (381, 386, 1, 'Uruguay'),
       (382, 387, 1, 'Uzbekistan'),
       (383, 388, 1, 'Holy See (Vatican City State)'),
       (384, 389, 1, 'Saint Vincent And The Grenadines'),
       (385, 390, 1, 'Venezuela'),
       (386, 391, 1, 'Virgin Islands'),
       (387, 392, 1, 'Virgin Islands'),
       (388, 393, 1, 'Viet Nam'),
       (389, 394, 1, 'Vanuatu'),
       (390, 395, 1, 'Samoa'),
       (391, 396, 1, 'Yemen'),
       (392, 397, 1, 'Mayotte'),
       (393, 398, 1, 'Serbia And Montenegro (Formally Yugoslavia)'),
       (394, 399, 1, 'South Africa'),
       (395, 400, 1, 'Zambia'),
       (396, 401, 1, 'Zimbabwe'),
       (397, 402, 1, 'Unknown'),
       (398, 17403, 1, 'Art'),
       (399, 410, 1, 'Registration completed'),
       (400, 411, 1, 'Your registration has been completed.'),
       (401, 412, 1, 'registration, completed, file, hosting, site'),
       (402, 413, 1, 'Thank you for registering!'),
       (403, 414, 1,
        'We''ve sent an email to your registered email address with your access password. Please check your spam filters to ensure emails from this site get through. '),
       (404, 415, 1, 'Emails from this site are sent from '),
       (405, 416, 1, 'Login'),
       (406, 417, 1, 'Login to your account'),
       (407, 418, 1, 'login, register, short url'),
       (408, 419, 1, 'Your username and password are invalid'),
       (409, 420, 1, 'Account Login'),
       (410, 421, 1, 'Please enter your username and password below to login.'),
       (411, 422, 1, 'Your account username. 6 characters or more and alpha numeric.'),
       (412, 423, 1, 'Your account password. Min 6 characters, alpha numeric, no spaces.'),
       (413, 551, 1, 'Click here to browse your files...'),
       (414, 16601, 1, 'share, track, image, picture, pic, img, hosting, sharing, upload, storage, site, website'),
       (415, 550, 1, 'Please enter your firstname'),
       (416, 428, 1, 'Please enter your username'),
       (417, 17594, 1, 'Account Home'),
       (418, 17595, 1, 'Your Account Home'),
       (419, 20578, 1, 'next'),
       (420, 434, 1, 'FAQ'),
       (421, 435, 1, 'Frequently Asked Questions'),
       (422, 436, 1, 'faq, frequently, asked, questions, file, hosting, site'),
       (423, 437, 1, 'Please enter your password'),
       (424, 590, 1, 'estimated Download time'),
       (425, 511, 1, 'Report Abuse'),
       (426, 441, 1, 'Register Account'),
       (427, 19369, 1, 'Account Settings'),
       (428, 16599, 1, 'Upload, share, track, manage your images in one simple to use image host.'),
       (429, 1428, 1, 'File Statistics'),
       (430, 446, 1, 'info'),
       (431, 447, 1, 'Email Confirm'),
       (432, 19413, 1, 'minute'),
       (433, 449, 1, 'Created/Last Visited'),
       (434, 450, 1, 'Status'),
       (435, 19478, 1, 'options'),
       (436, 17472, 1, 'upload file'),
       (437, 453, 1, 'Register'),
       (438, 454, 1, 'Register for an account'),
       (439, 455, 1, 'register, account, short, url, user'),
       (440, 17483, 1, 'created by '),
       (441, 457, 1, 'File has been removed.'),
       (442, 18639, 1, 'uploaded'),
       (443, 459, 1, 'downloads'),
       (444, 460, 1, 'download now'),
       (445, 461, 1, 'loading file, please wait'),
       (446, 462, 1, 'Download File'),
       (447, 463, 1, 'Download file'),
       (448, 464, 1, 'download, file, upload, mp3, avi, zip'),
       (449, 465, 1, 'Your Files'),
       (450, 466, 1, 'Download Url'),
       (451, 467, 1, 'Uploaded/Last Visited'),
       (452, 468, 1, 'Download Url/Filename'),
       (453, 469, 1, 'Total Active Files'),
       (454, 470, 1, 'Total Inactive Files'),
       (455, 471, 1, 'Total Downloads'),
       (456, 472, 1, 'user removed'),
       (457, 473, 1, 'files'),
       (458, 474, 1, 'Manage Files'),
       (459, 475, 1, 'Filter Results'),
       (460, 476, 1, 'Show Disabled'),
       (461, 477, 1, 'Export File Data'),
       (462, 478, 1, 'File has been removed by the site administrator.'),
       (463, 479, 1, 'Show Removed'),
       (464, 480, 1, 'admin removed'),
       (465, 481, 1, 'Delete File'),
       (466, 482, 1, 'Delete File'),
       (467, 483, 1, 'delete, remove, file'),
       (468, 484, 1, 'Delete File'),
       (469, 485, 1, 'Please confirm whether to delete the file below.'),
       (470, 486, 1, 'Cancel'),
       (471, 17488, 1, 'Switch site language to'),
       (472, 20574, 1, 'Download'),
       (473, 489, 1, 'Terms and Conditions'),
       (474, 490, 1, 'Terms and Conditions'),
       (475, 491, 1, 'terms, and, conditions, file, hosting, site'),
       (476, 19374, 1, 'Image Manager'),
       (477, 493, 1, 'Extend Account'),
       (478, 494, 1, 'Extend Your Account'),
       (479, 496, 1, 'Payment Complete'),
       (480, 497, 1, 'Payment Complete'),
       (481, 498, 1, 'payment, complete, file, hosting, site'),
       (482, 499, 1, 'premium account benefits'),
       (483, 17451, 1, 'account benefits'),
       (484, 501, 1, ' Information'),
       (485, 502, 1, 'Information about '),
       (486, 503, 1, ', share, information, file, upload, download, site'),
       (487, 504, 1, 'download urls'),
       (488, 505, 1, 'statistics'),
       (489, 506, 1, 'share'),
       (490, 507, 1, 'other options'),
       (491, 508, 1, 'Enter the details of the file (as above) you wish to report.'),
       (492, 591, 1, 'File can not be located, please try again later.'),
       (493, 592, 1, 'File Servers'),
       (494, 593, 1, 'Double click on any of the servers below to edit.'),
       (495, 594, 1, 'Add new server'),
       (496, 595, 1, 'server label'),
       (497, 596, 1, 'server type'),
       (498, 597, 1, 'storage path'),
       (499, 598, 1, 'Enter Server Details'),
       (500, 599, 1, 'total space used'),
       (501, 600, 1, 'total files'),
       (502, 601, 1, 'Testing connection to file server... (via ftp)'),
       (503, 602, 1, 'Back to Server Management'),
       (504, 510, 1, 'Please enter the details of the reported file.'),
       (505, 516, 1, 'Legal Bits'),
       (506, 19532, 1, 'Double click to view/hide subfolders'),
       (507, 518, 1, 'days'),
       (508, 17398, 1, 'Powerful Features'),
       (509, 520, 1, 'Pay via PayPal'),
       (510, 17443, 1, 'Secure Payment'),
       (511, 17444, 1, '100% Safe & Anonymous'),
       (512, 523, 1, 'Add files...'),
       (513, 19438, 1, 'Start upload'),
       (514, 19439, 1, 'Cancel upload'),
       (515, 526, 1, 'Select files'),
       (516, 527, 1, 'Drag &amp; drop files here or click to browse...'),
       (517, 19445, 1, 'Max file size'),
       (518, 529, 1, 'add file'),
       (519, 530, 1, 'copy all links'),
       (520, 531, 1, 'File uploads completed.'),
       (521, 532, 1, 'Delete Url'),
       (522, 533, 1, 'Stats Url'),
       (523, 18655, 1, 'HTML Code'),
       (524, 18659, 1, 'forum code'),
       (525, 536, 1, 'Full Info'),
       (526, 537, 1, 'click here'),
       (527, 17383, 1, 'extend'),
       (528, 17449, 1, 'reverts to free account'),
       (529, 17450, 1, 'never'),
       (530, 541, 1, 'filename'),
       (531, 542, 1, 'download'),
       (532, 18640, 1, 'filesize'),
       (533, 544, 1, 'url'),
       (534, 19343, 1, 'register'),
       (535, 546, 1, 'share file'),
       (536, 619, 1, 'Email large attachments!'),
       (537, 620, 1,
        'No longer do you have to risk a large file being bounced by a mail server. Upload and send your recipient a link to download the file. You can even track when it''s been downloaded.'),
       (538, 621, 1, 'Server Info'),
       (539, 622, 1, 'Edit'),
       (540, 623, 1, 'Edit existing item'),
       (541, 624, 1, 'edit, existing, item'),
       (542, 625, 1, 'Edit Existing Item'),
       (543, 626, 1, 'Use the form below to amend the selected item.'),
       (544, 627, 1, 'new long url'),
       (545, 628, 1, 'reset stats'),
       (546, 629, 1, 'update url'),
       (547, 630, 1, 'No (keep existing stats)'),
       (548, 631, 1, 'Yes (remove existing stats)'),
       (549, 632, 1, 'Whether to reset the statistics or not'),
       (550, 633, 1, 'No, keep stats'),
       (551, 634, 1, 'Yes, remove stats'),
       (552, 635, 1, 'update item'),
       (553, 636, 1, 'folder'),
       (554, 637, 1, 'The items folder'),
       (555, 19506, 1, '- None -'),
       (556, 639, 1, 'The filename on download'),
       (557, 640, 1, 'folders'),
       (558, 641, 1, 'File Folders'),
       (559, 642, 1, 'Your File Folders'),
       (560, 643, 1, 'file, folders, home, file, your, interface, upload, download, site'),
       (561, 644, 1, 'Folder Name'),
       (562, 645, 1, 'Public'),
       (563, 646, 1, 'no'),
       (564, 647, 1, 'Total Active Files'),
       (565, 648, 1, 'Active Files'),
       (566, 649, 1, 'Add'),
       (567, 650, 1, 'Add existing item'),
       (568, 651, 1, 'add, existing, item'),
       (569, 652, 1, 'Add Folder'),
       (570, 653, 1, 'Use the form below to add a new folder to your account.'),
       (571, 654, 1, 'The folder name'),
       (572, 655, 1, 'No, keep private'),
       (573, 656, 1, 'Yes, allow sharing'),
       (574, 657, 1, 'Whether to allow public access to the folder or not'),
       (575, 658, 1, 'add item'),
       (576, 659, 1, 'Edit Existing Folder'),
       (577, 660, 1, 'Use the form below to amend the selected folder.'),
       (578, 661, 1, 'yes'),
       (579, 662, 1, 'folder password'),
       (580, 663, 1, 'The folder password. (must be a public folder)'),
       (581, 664, 1, 'Please enter the folder name'),
       (582, 665, 1, 'You already have a folder with that name, please use another'),
       (583, 666, 1, 'Listing Url'),
       (584, 667, 1, 'Files Within Folder'),
       (585, 668, 1, 'There are no files within this folder.'),
       (586, 669, 1, 'Sharing Url'),
       (587, 670, 1, 'public link'),
       (588, 671, 1, 'Folder Login'),
       (589, 672, 1, 'Please enter the password below to access this folder.'),
       (590, 673, 1, 'The folder password.'),
       (591, 674, 1, 'continue'),
       (592, 675, 1, 'Folder Restricted'),
       (593, 676, 1, 'Please enter the folder password'),
       (594, 677, 1, 'The folder password is invalid'),
       (595, 678, 1, 'Save To Folder'),
       (596, 679, 1, 'forgot password'),
       (597, 680, 1, 'Forgot Password'),
       (598, 681, 1, 'Forgot account password'),
       (599, 682, 1, 'forgot, password, account, short, url, user'),
       (600, 683, 1,
        'Enter your email address below to receive further instructions on how to reset your account password.'),
       (601, 684, 1, 'reset'),
       (602, 685, 1, 'Please enter the account email address'),
       (603, 686, 1, 'Account with that email address not found'),
       (604, 687, 1,
        'An email has been sent to [[[EMAIL_ADDRESS]]] with further instructions on how to reset your password.'),
       (605, 688, 1,
        'An email has been sent to [[[EMAIL_ADDRESS]]] with further instructions on how to reset your password.'),
       (606, 689, 1, 'request reset'),
       (607, 690, 1, 'Set your new password below to access your account.'),
       (608, 691, 1, 'confirm password'),
       (609, 692, 1, 'update password'),
       (610, 693, 1, 'Password should be between 6 - 20 characters in length'),
       (611, 694, 1, 'Your password confirmation does not match'),
       (612, 695, 1, 'Your password has been reset. You can now login to the site above.'),
       (613, 696, 1, 'Your username must be between 6 and 20 characters'),
       (614, 697, 1, 'Account Details'),
       (615, 698, 1, 'Account details'),
       (616, 699, 1, 'details, account, short, url, user'),
       (617, 700, 1, 'Account Details'),
       (618, 701, 1, 'Change Password'),
       (619, 702, 1, 'update account'),
       (620, 703, 1, 'Email address already exists'),
       (621, 704, 1, 'Account details successfully updated'),
       (622, 705, 1, 'admin'),
       (623, 17384, 1, 'account'),
       (624, 707, 1, 'settings'),
       (625, 708, 1, 'Captcha Confirmation'),
       (626, 709, 1,
        'In order to prevent abuse of this service, please copy the words into the text box on the right.'),
       (627, 710, 1, 'Captcha confirmation text is invalid.'),
       (628, 711, 1, 'process to payment'),
       (629, 712, 1, 'Register Account - Complete'),
       (630, 713, 1, 'Your username can only contact alpha numeric and underscores.'),
       (631, 714, 1, 'upgrade'),
       (632, 715, 1, 'Username already exists on another account'),
       (633, 716, 1, 'Login to the admin area below'),
       (634, 717, 1, 'admin login'),
       (635, 718, 1, 'submit'),
       (636, 719, 1, 'manage file servers'),
       (637, 720, 1, 'file servers'),
       (638, 721, 1, 'manage users'),
       (639, 722, 1, 'users'),
       (640, 723, 1, 'payments'),
       (641, 724, 1, 'translations'),
       (642, 725, 1, 'Short Url'),
       (643, 726, 1, 'Date Uploaded'),
       (644, 727, 1, 'Total Downloads'),
       (645, 728, 1, 'Upload IP'),
       (646, 729, 1, 'Last Downloaded'),
       (647, 730, 1, 'Actions'),
       (648, 731, 1, 'Date Uploaded/IP'),
       (649, 732, 1, 'HD Used'),
       (650, 733, 1, 'Type'),
       (651, 734, 1, 'server information'),
       (652, 735, 1, 'Account expiry date invalid, it should be in the format dd/mm/yyyy'),
       (653, 736, 1, 'Description'),
       (654, 737, 1, 'Ban Type'),
       (655, 738, 1, 'Please enter the IP address.'),
       (656, 739, 1, 'Please enter the language name.'),
       (657, 740, 1, 'A language with that name already exists in the database.'),
       (658, 741, 1, 'English Content'),
       (659, 742, 1, 'Default'),
       (660, 743, 1, 'File Status'),
       (661, 744, 1, 'Last 14 days user registrations'),
       (662, 745, 1, 'free user'),
       (663, 746, 1, 'File Type'),
       (664, 747, 1, 'paid user'),
       (665, 748, 1, 'dll'),
       (666, 749, 1, 'doc'),
       (667, 750, 1, 'exe'),
       (668, 751, 1, 'ini'),
       (669, 752, 1, 'jpg'),
       (670, 753, 1, 'mp3'),
       (671, 754, 1, 'php'),
       (672, 755, 1, 'png'),
       (673, 756, 1, 'sql'),
       (674, 757, 1, 'txt'),
       (675, 758, 1, 'ftp username'),
       (676, 759, 1, 'ftp password'),
       (677, 760, 1, 'Please specify the server label.'),
       (678, 761, 1, 'That server label has already been used, please choose another.'),
       (679, 762, 1, 'Please specify the server ftp username.'),
       (680, 763, 1, 'Owner'),
       (681, 764, 1, 'other'),
       (682, 765, 1, 'wmv'),
       (683, 766, 1, 'date started'),
       (684, 767, 1, 'file name'),
       (685, 768, 1, 'file size'),
       (686, 769, 1, 'total threads'),
       (687, 770, 1, 'threads'),
       (688, 771, 1, 'Username is reserved and can not be used, please choose another'),
       (689, 19412, 1, 'hours'),
       (690, 19843, 1, 'Total Comments'),
       (691, 774, 1, 'French'),
       (692, 775, 1, 'German'),
       (693, 776, 1, 'Spanish'),
       (694, 19452, 1, 'delete'),
       (695, 778, 1, 'File is too big'),
       (696, 779, 1, 'File is too small'),
       (697, 780, 1, 'Filetype not allowed'),
       (698, 781, 1, 'Max number of files exceeded'),
       (699, 782, 1, 'File exceeds upload_max_filesize (php.ini directive)'),
       (700, 783, 1, 'File exceeds MAX_FILE_SIZE (HTML form directive)'),
       (701, 784, 1, 'File was only partially uploaded'),
       (702, 785, 1, 'No File was uploaded'),
       (703, 786, 1, 'Missing a temporary folder'),
       (704, 787, 1, 'Failed to write file to disk'),
       (705, 788, 1, 'File upload stopped by extension'),
       (706, 789, 1, 'Uploaded bytes exceed file size'),
       (707, 790, 1, 'Empty file upload result'),
       (708, 791, 1, 'from'),
       (709, 792, 1, 'Quick Overview'),
       (710, 793, 1,
        'Please enter your information below to register for an account. Your new account password will be sent to your email address.'),
       (711, 794, 1, 'Mrs'),
       (712, 795, 1, 'Miss'),
       (713, 796, 1, 'Dr'),
       (714, 797, 1, 'Pro'),
       (715, 798, 1, 'Your title'),
       (716, 799, 1, 'Your firstname'),
       (717, 800, 1, 'Your lastname'),
       (718, 801, 1, 'Your email address'),
       (719, 802, 1, 'Confirm your email address'),
       (720, 803, 1, 'Your account username. 6 characters or more and alpha numeric.'),
       (721, 805, 1, 'By clicking ''register'', you agree to our <a href=''terms.html''>Terms of service</a>.'),
       (722, 806, 1, 'Mr'),
       (723, 807, 1, 'Mrs'),
       (724, 808, 1, 'Miss'),
       (725, 809, 1, 'Dr'),
       (726, 810, 1, 'Pro'),
       (727, 811, 1, 'Download From'),
       (728, 812, 1,
        '<strong>Basic TOS</strong><br/>\n<br/>\nAll users must be of at least the age of 13, and agree to not use the [[[SITE_NAME]]] service for any illegal or unauthorized purposes. All users must agree to comply with local laws regarding online conduct, and copyright laws. [[[SITE_NAME]]] is intended for personal use, and any business use is strictly prohibited. All users must not use [[[SITE_NAME]]]''s services to violate any laws which include but are not limited to copyright laws. Any violations will result in immediate deletion of all files [[[SITE_NAME]]] has on record for your IP Address.<br/>\n<br/>\nAll users use [[[SITE_NAME]]] at their own risk, users understand that files uploaded on [[[SITE_NAME]]] are not private, they may be displayed for others to view, and [[[SITE_NAME]]] users understand and agree that [[[SITE_NAME]]] cannot be responsible for the content posted on its web site and you nonetheless may be exposed to such materials and that you use [[[SITE_NAME]]]''s service at your own risk.<br/>\n<br/>\n<strong>Conditions</strong><br/>\n<br/>\n- We reserve the right to modify or terminate the [[[SITE_NAME]]] service for any reason, without notice at any time.<br/>\n- We reserve the right to alter these Terms of Use at any time.<br/>\n- We reserve the right to refuse service to anyone for any reason at any time.<br/>\n- We may, but have no obligation to, remove Content and accounts containing Content that we determine in our sole discretion are unlawful, offensive, threatening, libelous, defamatory, obscene or otherwise objectionable or violates any party''s intellectual property or these Terms of Use.<br/>\n- If a user is found to be using [[[SITE_NAME]]] to host icons, smileys, buddy icons, forum avatars, forum badges, forum signature images, or any other graphic for website design all your images will be removed.<br/>\n<br/>\n<strong>Copyright Information</strong><br/>\n<br/>\n[[[SITE_NAME]]] claims no intellectual property rights over the images uploaded by its'' users.<br/>\n<br/>\n[[[SITE_NAME]]] will review all copyright &copy; infringement claims received and remove files found to have been upload or distributed in violation of any such laws. To make a valid claim you must provide [[[SITE_NAME]]] with the following information:<br/>\n<br/>\n- A physical or electronic signature of the copyright owner or the person authorized to act on its behalf;<br/>\n- A description of the copyrighted work claimed to have been infringed;<br/>\n- A description of the infringing material and information reasonably sufficient to permit [[[SITE_NAME]]] to locate the material;<br/>\n- Your contact information, including your address, telephone number, and email;<br/>\n- A statement by you that you have a good faith belief that use of the material in the manner complained of is not authorized by the copyright owner, its agent, or the law; and<br/>\n- A statement that the information in the notification is accurate, and, under the pains and penalties of perjury, that you are authorized to act on behalf of the copyright owner.<br/>\n<br/>\nClaims can be sent to us via the <a href="report_file.[[[PAGE_EXTENSION]]]">report abuse</a> page.'),
       (729, 813, 1, 'Account details for [[[SITE_NAME]]]'),
       (730, 814, 1,
        'Dear [[[FIRST_NAME]]],<br/><br/>Your account on [[[SITE_NAME]]] has been created. Use the details below to login to your new account:<br/><br/><strong>Url:</strong> <a href=''[[[WEB_ROOT]]]''>[[[WEB_ROOT]]]</a><br/><strong>Username:</strong> [[[USERNAME]]]<br/><strong>Password:</strong> [[[PASSWORD]]]<br/><br/>Feel free to contact us if you need any support with your account.<br/><br/>Regards,<br/>[[[SITE_NAME]]] Admin'),
       (731, 815, 1, 'sftp host'),
       (732, 816, 1, 'sftp port'),
       (733, 817, 1, 'sftp username'),
       (734, 818, 1, 'sftp password'),
       (735, 819, 1, 'manage plugins'),
       (736, 820, 1, 'add plugin'),
       (737, 822, 1, 'directory name'),
       (738, 823, 1, 'is installed'),
       (739, 824, 1, 'installed?'),
       (740, 825, 1, 'No file found, please try again.'),
       (741, 826, 1, 'The uploaded file does not appear to be a zip file.'),
       (742, 827, 1,
        'There was a problem creating the plugin folder. Please ensure the following folder has CHMOD 777 permissions: /var/www/php_site_scripts/file_hosting/plugins/'),
       (743, 828, 1, 'Could not read the plugin settings file ''_plugin_config.inc.php''.'),
       (744, 829, 1,
        'There was a problem unzipping the file, please try and manually upload the zip files contents into the plugins directory or contact support.'),
       (745, 831, 1, 'User Earnings'),
       (746, 832, 1, 'Detailed Referrals'),
       (747, 833, 1, 'Payment Requests'),
       (748, 834, 1, 'Keep your account details up to date below.'),
       (749, 835, 1, 'Your new email address'),
       (750, 836, 1, 'Optional. A new account password, leave this blank to keep your existing.'),
       (751, 837, 1, 'active downloads'),
       (752, 17452, 1, 'Direct downloads. No waiting.'),
       (753, 17453, 1, 'No advertising.'),
       (754, 17454, 1, 'Unlimited simultaneous downloads.'),
       (755, 17455, 1, 'Maximum download speeds possible.'),
       (756, 17456, 1, 'Download manager support.'),
       (757, 17457, 1, 'Unlimited storage.'),
       (758, 17247, 1, 'Files kept for [[[DAYS]]] days.'),
       (759, 17248, 1, 'Upload files up to [[[MAX_UPLOAD_FILESIZE]]] in size.'),
       (760, 17460, 1, 'No limits on the amount of downloads.'),
       (761, 17461, 1, 'Low price per day.'),
       (762, 17462, 1, 'No subscriptions.'),
       (763, 849, 1, 'Rewards'),
       (764, 850, 1, 'earn, money, rewards, cash, sales, affiliate, file, hosting, site'),
       (765, 851, 1, 'overview'),
       (766, 852, 1, 'total rewards'),
       (767, 853, 1, 'cleared rewards'),
       (768, 854, 1, 'available for withdrawal'),
       (769, 856, 1, 'this months rewards'),
       (770, 857, 1,
        '- You have not uploaded any files recently. <a href="[[[WEB_ROOT]]]/index.[[[PAGE_EXTENSION]]]">Click here</a> to upload some now.'),
       (771, 858, 1,
        'If you have an account, <a href="[[[WEB_ROOT]]]/login.[[[PAGE_EXTENSION]]]">click here</a> to login and manage your files.'),
       (772, 859, 1, 'detailed rewards'),
       (773, 860, 1, 'how to start earning'),
       (774, 861, 1, 'Reward Date'),
       (775, 862, 1, 'Amount'),
       (776, 863, 1, 'recent rewards'),
       (777, 864, 1, 'copyright removed'),
       (778, 865, 1, 'User Status'),
       (779, 866, 1, 'free user'),
       (780, 867, 1, 'paid user'),
       (781, 868, 1, 'Amount'),
       (782, 869, 1, 'Original Order #'),
       (783, 870, 1, 'Upgrade Source'),
       (784, 871, 1, 'User'),
       (785, 872, 1, 'Filter Results'),
       (786, 873, 1, 'By Folder'),
       (787, 874, 1, 'all'),
       (788, 875, 1, 'By Status'),
       (789, 877, 1, 'Aggregated Earnings'),
       (790, 878, 1, 'monthly totals'),
       (791, 879, 1, 'Rewards withdrawal request for [[[AMOUNT]]]'),
       (792, 880, 1,
        'Dear Admin,<br/><br/>A rewards withdrawal request has been received. Please login to [[[SITE_NAME]]] and process the request:<br/><br/><a href=''[[[ADMIN_WEB_ROOT]]]''>[[[ADMIN_WEB_ROOT]]]</a><br/><br/>Regards,<br/>[[[SITE_NAME]]] Admin'),
       (793, 881, 1, 'Date Requested'),
       (794, 882, 1, 'Русский'),
       (795, 883, 1, 'File'),
       (796, 884, 1, 'File permanently removed.'),
       (797, 885, 1, 'zip'),
       (798, 886, 1, 'Please enter your Skrill account email address.'),
       (799, 887, 1,
        'You must register for a premium account for files of this size. Please use the links above to register or login.'),
       (800, 888, 1,
        'You have reached the maximum concurrent downloads. Please wait for your existing downloads to complete or register for a premium account above.'),
       (801, 889, 1, 'Newsletters'),
       (802, 890, 1, 'Create Newsletter'),
       (803, 891, 1, 'Manage Newsletters'),
       (804, 892, 1, 'Export User Data'),
       (805, 893, 1, 'date'),
       (806, 894, 1, 'title'),
       (807, 895, 1, 'subject'),
       (808, 896, 1, 'status'),
       (809, 897, 1, 'send to'),
       (810, 898, 1, 'newsletter content (html)'),
       (811, 899, 1, 'upload'),
       (812, 900, 1, 'file upload'),
       (813, 19433, 1, 'remote url upload'),
       (814, 19463, 1, 'FTP Upload'),
       (815, 903, 1, 'Enter Urls'),
       (816, 19479, 1, 'Enter up to [[[MAX_REMOTE_URL_FILES]]] file urls. Separate each url on it''s own line.'),
       (817, 19462, 1, 'processing'),
       (818, 906, 1, 'File transfers completed.'),
       (819, 907, 1, 'html'),
       (820, 908, 1, 'ico'),
       (821, 909, 1, 'MPG'),
       (822, 19471, 1, 'Please enter the urls to start.'),
       (823, 19472, 1, 'No valid urls found, please make sure any start with http or https and try again.'),
       (824, 913, 1,
        'Could not rename plugin folder, it may be that the plugin is already installed or a permissions issue.'),
       (825, 914, 1, 'com:8080/p'),
       (826, 915, 1, 'created'),
       (827, 916, 1, 'newsletter unsubscribe'),
       (828, 917, 1, 'Unsubscribe'),
       (829, 918, 1, 'newsletter, unsubscribe, file, hosting, site'),
       (830, 919, 1, 'newsletter unsubscribe'),
       (831, 920, 1, 'Enter your email address below to be removed from future newsletters from our site.'),
       (832, 921, 1, 'Your registered email address.'),
       (833, 922, 1, 'unsubscribe'),
       (834, 923, 1,
        'There was a problem unsubscribing your from our mailing list. Please contact us and we''ll manually remove you'),
       (835, 924, 1, 'The email address you''ve provided has already been unsubscribed'),
       (836, 925, 1, 'Your email address has been sucessfully removed from our mailing lists'),
       (837, 928, 1, 'newsletter subscribe'),
       (838, 929, 1, 'Subscribe'),
       (839, 930, 1, 'newsletter, subscribe, file, hosting, site'),
       (840, 931, 1, 'newsletter subscribe'),
       (841, 932, 1,
        'Enter your email address below to be added to future newsletters from our site. Note, you must have a registered account to be added to the mailing list.'),
       (842, 933, 1, 'Your registered email address.'),
       (843, 17468, 1, 'Subscribe'),
       (844, 935, 1, 'Your email address is invalid'),
       (845, 936, 1, 'Could not find an account with that email address'),
       (846, 937, 1, 'Your email address has been sucessfully added to our mailing lists'),
       (847, 939, 1, 'Thanks for your payment!'),
       (848, 940, 1,
        'Once we receive notification from the payment gateway, your account will be upgraded/extended. Please allow up to an hour for this to complete.'),
       (849, 941, 1, 'You can check your account status by going '),
       (850, 942, 1, 'here'),
       (851, 943, 1, 'download/view now'),
       (852, 944, 1, 'mp4'),
       (853, 945, 1, 'Watch'),
       (854, 946, 1, 'Watch or listen to '),
       (855, 947, 1, ', watch, listen, file, upload, download, site'),
       (856, 948, 1, 'ogv'),
       (857, 949, 1, 'limited'),
       (858, 950, 1, 'file details'),
       (859, 951, 1, 'Please enter your Tranzila account id.'),
       (860, 952, 1, 'get plugins'),
       (861, 953, 1, 'The ftp path you''ve set does not exist.'),
       (862, 954, 1, 'Please set the path to store ftp accounts.'),
       (863, 958, 1, 'Error message'),
       (864, 959, 1, 'FTP Details'),
       (865, 969, 1, 'Please enter your PaymentWall application key. This can be found in Application Settings.'),
       (866, 970, 1, 'Please enter your OKPay wallet number.'),
       (867, 971, 1, 'Please enter the filename'),
       (868, 972, 1, 'Please enter your First Data transaction key.'),
       (869, 973, 1, 'downloader'),
       (870, 974, 1, 'Watch'),
       (871, 975, 1, 'Watch or listen to '),
       (872, 976, 1, ', view, picture, file, upload, download, site'),
       (873, 978, 1, 'HTML Thumbnail Code'),
       (874, 979, 1, 'Forum Thumbnail Code'),
       (875, 980, 1, 'Full Url'),
       (876, 981, 1, 'embed code'),
       (877, 982, 1, 'Thumbnail Url'),
       (878, 983, 1, 'Full Image Url'),
       (879, 984, 1, 'Confirmation Text'),
       (880, 985, 1, 'First'),
       (881, 986, 1, 'Last'),
       (882, 987, 1, 'Next'),
       (883, 988, 1, 'Previous'),
       (884, 989, 1, 'No data found.'),
       (885, 990, 1, 'Showing _START_ to _END_ of _TOTAL_ entries'),
       (886, 991, 1, 'Show _MENU_ entries'),
       (887, 992, 1, 'dfdf'),
       (888, 993, 1,
        'You must wait [[[WAITING_TIME_LABEL]]] between downloads. Please try again later or register for a premium account above to remove the restriction.'),
       (889, 994, 1, 'Max uploads reached.'),
       (890, 995, 1, 'You have reached the maximum permitted uploads for today.'),
       (891, 996, 1, 'AVI'),
       (892, 997, 1, '3gp'),
       (893, 998, 1, 'Embed Video'),
       (894, 1002, 1, 'Plugin Settings'),
       (895, 1003, 1, 'Plugin State'),
       (896, 1004, 1, 'Whether the search system is enabled'),
       (897, 1005, 1, 'Plugin Enabled'),
       (898, 1006, 1, 'Users which have access'),
       (899, 1007, 1, 'Select from the drop down who you want to have access to the search feature'),
       (900, 1008, 1, 'Who has access'),
       (901, 1009, 1, 'Search Files'),
       (902, 1010, 1, 'webmaster'),
       (903, 1011, 1, 'Level'),
       (904, 1012, 1, 'Status/Level:'),
       (905, 1013, 1, 'file level'),
       (906, 1014, 1, 'By Level'),
       (907, 1015, 1, 'file server domain name'),
       (908, 1016, 1, 'script path'),
       (909, 1017, 1, 'upload script path'),
       (910, 1018, 1, 'code setup'),
       (911, 1019, 1, 'server storage path'),
       (912, 1020, 1, 'Please specify the file server domain name.'),
       (913, 1021, 1, 'The file server domain name you''ve entered is invalid.'),
       (914, 1022, 1, 'set password:'),
       (915, 1023, 1,
        'When downloading these files, users will be prompted for a password, if set. Download managers will not work if a password is set.'),
       (916, 1024, 1, 'Set Password'),
       (917, 19496, 1, 'send via email:'),
       (918, 1026, 1, 'Enter an email address below to send the list of urls via email once they''re uploaded.'),
       (919, 19422, 1, 'Links copied to clipboard:\\n\\n'),
       (920, 1028, 1, 'File Password'),
       (921, 1029, 1, 'Enter file password'),
       (922, 1030, 1, 'file, password, account, short, url, user'),
       (923, 1031, 1, 'file password'),
       (924, 1032, 1, 'A password is required to access this file, please enter it below.'),
       (925, 1033, 1, 'The file password'),
       (926, 1034, 1, 'access file'),
       (927, 1035, 1, 'File password is invalid.'),
       (928, 1036, 1, 'Image Url'),
       (929, 1037, 1, 'Size'),
       (930, 1038, 1, 'Your url links from [[[SITE_NAME]]]'),
       (931, 1039, 1,
        'Copies of your urls, which completed uploading on [[[UPDATE_COMPLETED_DATE_TIME]]] are below:<br/><br/>[[[FILE_URLS]]]<br/><br/>Regards,<br/>[[[SITE_NAME]]] Admin'),
       (932, 1040, 1, 'You have reached the maximum permitted downloads in the last 24 hours.'),
       (933, 1041, 1, 'resize image'),
       (934, 1042, 1, 'fixed size'),
       (935, 1043, 1, 'keep proportion'),
       (936, 1044, 1, 'custom size'),
       (937, 1045, 1, 'resize'),
       (938, 1046, 1, 'Please enter the width'),
       (939, 1047, 1, 'Please enter the height'),
       (940, 1048, 1, 'Please enter a valid number for the width'),
       (941, 1049, 1, 'Please enter a valid number for the height'),
       (942, 1050, 1, 'Detailed Referrals (PPS)'),
       (943, 1051, 1, 'Detailed Downloads (PPD)'),
       (944, 1052, 1, 'Detailed Referrals PPS'),
       (945, 1053, 1, 'Detailed PPD'),
       (946, 1054, 1, 'Detailed Referrals P.P.S'),
       (947, 1055, 1, 'Detailed P.P.D'),
       (948, 1056, 1, 'Detailed Referrals P P S'),
       (949, 1057, 1, 'Detailed P P D'),
       (950, 1058, 1, 'Detailed (ppd)'),
       (951, 1059, 1, 'Referrals (pps)'),
       (952, 1060, 1, 'Downloads (ppd)'),
       (953, 1061, 1, 'Please select at least 1 country for row [[[ROW_NUMBER]]]'),
       (954, 1062, 1, 'Please enter the payout rate for row [[[ROW_NUMBER]]]'),
       (955, 1063, 1, 'Download Date'),
       (956, 1064, 1, 'Reward Group'),
       (957, 1065, 1, 'Reward User'),
       (958, 1066, 1, 'Pay Per Download (PPD) Rates'),
       (959, 1067, 1, 'recent downloads'),
       (960, 1068, 1, 'Upload your files and you''ll be paid for every file downloaded on your account.'),
       (961, 1069, 1, 'Files above [[[FILE_SIZE]]]MB will count.'),
       (962, 1070, 1, 'Group Name'),
       (963, 1071, 1, 'Paid Per 1,000 Downloads'),
       (964, 1072, 1, 'Downloading Country'),
       (965, 1073, 1, 'See the payment rates below:'),
       (966, 1074, 1, 'ppd recent downloads'),
       (967, 1075, 1, 'uncleared ppd downloads'),
       (968, 1076, 1, 'total rewards pps'),
       (969, 1077, 1, 'total rewards (pps)'),
       (970, 1078, 1, 'uncleared downloads (ppd)'),
       (971, 1079, 1, '(mixed groups)'),
       (972, 1080, 1, 'New abuse report on [[[SITE_NAME]]]'),
       (973, 1081, 1,
        'There is a new abuse report on [[[SITE_NAME]]] with the following details:<br/><br/>***************************************<br/>[[[FILE_DETAILS]]]<br/>***************************************<br/>Submitted IP: [[[USERS_IP]]]<br/>***************************************<br/><br/>Please login via [[[WEB_ROOT]]]/admin/ to investigate further.'),
       (974, 1098, 1, 'view logs'),
       (975, 1100, 1, 'system tools'),
       (976, 1101, 1, 'database browser'),
       (977, 1102, 1, 'system logs'),
       (978, 1103, 1,
        'You have [[[ACTIVE_FILES]]] active file(s) within your account. Use the table below to navigate or search for files you''ve previously uploaded. <a href="index.[[[SITE_CONFIG_PAGE_EXTENSION]]]">Click here</a> to upload a file.'),
       (979, 1104, 1, 'add user'),
       (980, 1105, 1, 'view payments'),
       (981, 1106, 1, 'payment date'),
       (982, 1107, 1, 'user name'),
       (983, 1108, 1, 'received payments'),
       (984, 1109, 1,
        'Please use the following form to report any copyright infringements ensuring you supply all the following information:'),
       (985, 1110, 1, 'Please enter the url of the reported file.'),
       (986, 1111, 1, 'Please enter the url of the file you\\''re reporting.'),
       (987, 1112, 1,
        'Please confirm you have a good faith belief that use of the material in the manner complained of is not authorized by the copyright owner, its agent, or the law.'),
       (988, 1113, 1, 'Could not find a file with that url, please check and try again.'),
       (989, 1114, 1, 'The file url you''ve set is not active.'),
       (990, 1115, 1, 'Key'),
       (991, 1116, 1,
        'You have no active files within your account. <a href="index.[[[SITE_CONFIG_PAGE_EXTENSION]]]">Click here</a> to upload a file.'),
       (992, 1117, 1, 'File upload space full.'),
       (993, 1118, 1,
        'You have reached the maximum permitted storage within your account, please delete some active files and try again.'),
       (994, 1119, 1, 'Please enter the description and support information of the reported file.'),
       (995, 1120, 1,
        'Thanks for submitted the information needed to report a file on our servers. We''ll review the file as soon as possible and remove if required.'),
       (996, 1121, 1, 'abuse reports'),
       (997, 1122, 1, 'Report Date'),
       (998, 1123, 1, 'Reported Name'),
       (999, 1124, 1, 'Reported By IP'),
       (1000, 1125, 1, 'File has been removed due to copyright issues.'),
       (1001, 1126, 1, 'By Upload Date'),
       (1002, 1127, 1, 'Parent Folder:'),
       (1003, 1128, 1, 'Base Folder'),
       (1004, 1129, 1, '- root -'),
       (1005, 1130, 1, 'The parent folder to create this within'),
       (1006, 1131, 1, 'folder name'),
       (1007, 1132, 1, 'Parent Folder:'),
       (1008, 1133, 1, 'Public:'),
       (1009, 1134, 1, 'Password:'),
       (1010, 1135, 1, 'Folder Name:'),
       (1011, 1136, 1, 'Sharing Url:'),
       (1012, 1137, 1, 'update folder'),
       (1013, 19510, 1, 'Filter'),
       (1014, 19514, 1, 'Upload Date'),
       (1015, 1140, 1, 'You can share this page with other users who do not have access to your account.'),
       (1016, 1141, 1,
        'You can share this page with other users who do not have access to your account. Just copy the website url in the url bar and provide this via email or other sharing method.'),
       (1017, 1142, 1,
        'Note: As you''ve set a password on this folder, users will need to correctly enter this before they gain access to this page.'),
       (1018, 1143, 1, 'This folder can not be shared as it is not set to a publicly accessible folder.'),
       (1019, 1144, 1,
        'This folder can not be shared as it is not set to a publicly accessible folder. Only users with access to your account can see this listing.'),
       (1020, 1145, 1, 'Testing file server... (direct file server)'),
       (1021, 1146, 1, 'Language'),
       (1022, 1147, 1, 'The language to use on the site.'),
       (1023, 1148, 1, 'Please select the username.'),
       (1024, 1149, 1, 'Please enter the payment amount.'),
       (1025, 1150, 1,
        'Plugin folder is not writable. Ensure you set the following folder to CHMOD 755 or 777: [[[PLUGIN_FOLDER]]]'),
       (1026, 1151, 1, 'moderator area'),
       (1027, 1152, 1, 'ogg'),
       (1028, 1153, 1, 'Page'),
       (1029, 19366, 1, 'of'),
       (1030, 1155, 1, 'last accessed'),
       (1031, 1156, 1, 'added'),
       (1032, 1157, 1, 'statistics url'),
       (1033, 1158, 1, 'delete file url'),
       (1034, 1159, 1, 'store in folder:'),
       (1035, 1160, 1, 'Select a folder below to store these uploaded files in.'),
       (1036, 1161, 1,
        'Select a folder below to store these files in. All uploads files will be available within these folders.'),
       (1037, 1162, 1, '- Default -'),
       (1038, 1163, 1, 'Order By'),
       (1039, 1164, 1, 'Filename ASC'),
       (1040, 1165, 1, 'Filename DESC'),
       (1041, 1166, 1, 'Uploaded Date ASC'),
       (1042, 1167, 1, 'Uploaded Date DESC'),
       (1043, 1168, 1, 'Downloads ASC'),
       (1044, 1169, 1, 'Downloads DESC'),
       (1045, 1170, 1, 'Filesize ASC'),
       (1046, 1171, 1, 'Filesize DESC'),
       (1047, 1172, 1, 'Last Access Date ASC'),
       (1048, 1173, 1, 'Last Access Date DESC'),
       (1049, 1174, 1, 'File updated.'),
       (1050, 1175, 1, 'Your Uploads'),
       (1051, 1176, 1, 'Recent Uploads'),
       (1052, 19380, 1, 'Trash Can'),
       (1053, 19530, 1, 'Close'),
       (1054, 1179, 1, 'Upload Files'),
       (1055, 1180, 1, 'Edit'),
       (1056, 1181, 1, 'Share Folder'),
       (1057, 19385, 1, 'Edit'),
       (1058, 19386, 1, 'Delete'),
       (1059, 1184, 1,
        'Are you sure you want to remove this folder? Any files within the folder will be moved into your default root folder and remain active.'),
       (1060, 19391, 1,
        'Are you sure you want to empty the trash can? Any statistics and other file information will be permanently deleted.'),
       (1061, 1186, 1, 'selected files'),
       (1062, 1187, 1, 'Close Fullscreen'),
       (1063, 1188, 1, 'Fullscreen'),
       (1064, 1189, 1, 'List View'),
       (1065, 1190, 1, 'Icon View'),
       (1066, 1191, 1, 'Show Tree'),
       (1067, 1192, 1, 'Hide Tree'),
       (1068, 1193, 1, 'File Url'),
       (1069, 19526, 1, 'File Urls'),
       (1070, 1195, 1, 'Error: No files selected.'),
       (1071, 1196, 1, 'Refresh'),
       (1072, 1197, 1, 'Show Links'),
       (1073, 1198, 1, 'Update'),
       (1074, 1201, 1, 'Status Text'),
       (1075, 19362, 1, 'Upload'),
       (1076, 1203, 1, 'No files found.'),
       (1077, 1204, 1, 'File Urls'),
       (1078, 19523, 1, 'HTML Code'),
       (1079, 19524, 1, 'Forum BBCode'),
       (1080, 1207, 1, 'Forum BBCode'),
       (1081, 1208, 1, 'This video is awaiting conversion, please check back again later.'),
       (1082, 1209, 1, 'This video is in the process of being converted, please check back again soon.'),
       (1083, 19381, 1, 'Empty Trash'),
       (1084, 1211, 1, 'copy file'),
       (1085, 1212, 1, 'File copied into your account. [[[FILE_LINK]]]'),
       (1086, 1213, 1, 'public info page'),
       (1087, 1214, 1, 'There was a problem copying the file, please try again later.'),
       (1088, 1215, 1, 'maxiumum storage space'),
       (1089, 1216, 1, 'maxiumum storage'),
       (1090, 1217, 1, 'max storage (bytes)'),
       (1091, 1218, 1, 'server priority'),
       (1092, 1219, 1, 'unpaid earnings'),
       (1093, 1220, 1, 'estimated PPS earnings'),
       (1094, 1221, 1, 'PPD estimated earnings'),
       (1095, 1222, 1, '(from all PPD rate groups)'),
       (1096, 1223, 1, 'total unpaid earnings'),
       (1097, 1224, 1, 'pps recent rewards'),
       (1098, 1225, 1, '(from [[[ITEMS]]] items accross all PPD rate groups)'),
       (1099, 1226, 1, 'PPD recent earnings'),
       (1100, 1227, 1, 'Period'),
       (1101, 1228, 1, 'Links'),
       (1102, 1229, 1, 'removed'),
       (1103, 1230, 1, 'Preview'),
       (1104, 1231, 1, 'Preview '),
       (1105, 1232, 1, ', preview, file, upload, download, site'),
       (1106, 1233, 1, 'Embed Document'),
       (1107, 1235, 1, 'pdf'),
       (1108, 1236, 1, 'docx'),
       (1109, 1237, 1, 'xls'),
       (1110, 1240, 1, 'site path'),
       (1111, 1241, 1, 'file storage path'),
       (1112, 1242, 1, 'gdoc'),
       (1113, 1243, 1, 'Select File (max: [[[MAX_SIZE]]])'),
       (1114, 1244, 1, 'Delete <span class="fileCount"></span>Files'),
       (1115, 1245, 1, 'Move <span class="fileCount"></span>Files'),
       (1116, 1246, 1, 'Delete Files[[[fileCount]]]'),
       (1117, 1247, 1, 'Move Files[[[fileCount]]]'),
       (1118, 1248, 1, 'Delete Files[[[FILE_COUNT]]]'),
       (1119, 1249, 1, 'Move Files[[[FILE_COUNT]]]'),
       (1120, 19396, 1, 'Links'),
       (1121, 1251, 1, 'Delete'),
       (1122, 1252, 1, 'Are you sure you want to remove the selected files?'),
       (1123, 1253, 1, 'Are you sure you want to remove the selected [[[TOTAL_FILES]]] file(s)?'),
       (1124, 1254, 1, 'Full file url'),
       (1125, 1255, 1, 'Description of the copyrighted works and supporting information');
INSERT INTO `language_content` (`id`, `languageKeyId`, `languageId`, `content`)
VALUES (1126, 1256, 1, 'Your name'),
       (1127, 1257, 1, 'Email address'),
       (1128, 1258, 1, 'Postal address'),
       (1129, 1259, 1, 'Phone number'),
       (1130, 1260, 1, 'Signature'),
       (1131, 1261, 1, 'Electronic signature of the copyright owner or the person authorized to act on its behalf'),
       (1132, 1262, 1, 'Confirm 1'),
       (1133, 1263, 1,
        'You have a good faith belief that use of the material in the manner complained of is not authorized by the copyright owner, its agent, or the law.'),
       (1134, 1264, 1,
        'The information in the notification is accurate, and, under the pains and penalties of perjury, that you are authorized to act on behalf of the copyright owner.'),
       (1135, 1265, 1, 'unlimited'),
       (1136, 1266, 1, 'Q: Is this free?'),
       (1137, 1267, 1,
        'A: Yes, uploading and downloading is 100% Free for all users. We offer premium accounts which allows for greater flexibility with uploading/downloading.'),
       (1138, 1268, 1, 'Q: Will my files be removed?'),
       (1139, 1269, 1,
        'A: Free/non accounts files are kept for [[[KEPT_FOR_DAYS_FREE]]] days. Premium accounts files are kept for [[[KEPT_FOR_DAYS_PAID]]] days.'),
       (1140, 1270, 1, 'Q: How many files can I upload?'),
       (1141, 1271, 1,
        'A: You can upload as many files as you want, as long as each one adheres to the Terms of Service and the maximum file upload size.'),
       (1142, 1272, 1, 'Q: Which files types am I allowed to upload?'),
       (1143, 1273, 1, 'Any'),
       (1144, 1274, 1, 'A: You may upload the following types of files: [[[FILE_TYPES]]].'),
       (1145, 1275, 1, 'Q: Are there any restrictions to the size of my uploaded files?'),
       (1146, 1276, 1,
        'A: Each file you upload must be less than [[[MAX_UPLOAD_SIZE_FREE]]] in size for free/non accounts or less than [[[MAX_UPLOAD_SIZE_PAID]]] in size for premium accounts. If it is greater than that amount, your file will be rejected.'),
       (1147, 1277, 1, 'Q: Can I upload music or videos?'),
       (1148, 1278, 1,
        'A: Yes. Music and video hosting is permitted as long as you own the copyright on the content and it adheres to the terms and conditions.'),
       (1149, 1279, 1,
        'Q: There are some files on our servers which may have been subject to copyright protection, how can I notify you of them?'),
       (1150, 1280, 1, 'A: Via our <a href="report_file.[[[SITE_CONFIG_PAGE_EXTENSION]]]">report abuse</a> pages.'),
       (1151, 1281, 1, 'use main site url'),
       (1152, 1282, 1, 'no'),
       (1153, 1283, 1, 'yes'),
       (1154, 1284, 1, 'Test Trans'),
       (1155, 1285, 1, 'File has been removed due to inactivity.'),
       (1156, 17489, 1, 'Arabic'),
       (1157, 1287, 1, 'Contact Us'),
       (1158, 1288, 1, 'Contact us'),
       (1159, 1289, 1, 'contact, us, questions, queries, file, hosting'),
       (1160, 1290, 1, 'Contact Us'),
       (1161, 1962, 1, 'Please fill out the following contact form to contact us'),
       (1162, 1963, 1,
        'If you wish to contact us regarding a copyright claim then please submit an abuse report. Abuse reports should be sent via our <a href="[[[ABUSE_URL]]]">abuse pages</a>.'),
       (1163, 1292, 1, 'Your full name'),
       (1164, 1293, 1, 'Your email address'),
       (1165, 1294, 1, 'Your query'),
       (1166, 1295, 1, 'submit query'),
       (1167, 1296, 1, 'submit form'),
       (1168, 1297, 1, 'Please enter your query.'),
       (1169, 20594, 1,
        'Please submit all abuse reports via our dedicated abuse report page. Click OK to continue to it now.'),
       (1170, 20595, 1, '"[[[QUERY_TYPE]]]" contact from [[[SITE_NAME]]] by "[[[LOGGED_IN_USERNAME]]]" user.'),
       (1171, 20596, 1,
        'There has been a contact form submission from [[[SITE_NAME]]] with the following details:<br/><br/>***************************************<br/>Full Name: [[[FULL_NAME]]]<br/>Email Address: [[[EMAIL_ADDRESS]]]<br/>Query Type: [[[QUERY_TYPE]]]<br/><br/>[[[QUERY]]]<br/>***************************************<br/>Logged In: [[[LOGGED_IN]]]<br/>Username: [[[LOGGED_IN_USERNAME]]]<br/>Submitted IP: [[[USERS_IP]]]<br/>***************************************<br/><br/>'),
       (1172, 1300, 1,
        'Thanks for submitting the contact form on our site. We''ll review the query as soon as possible and get back to your within the nexr 48 hours.'),
       (1173, 1301, 1, 'Please enter your name.'),
       (1174, 1302, 1, 'Please enter your email.'),
       (1175, 1303, 1, 'Please enter a valid email address.'),
       (1176, 1304, 1, 'js'),
       (1177, 1305, 1, 'Remove Files[[[FILE_COUNT]]] (keep stats)'),
       (1178, 1306, 1, 'Delete Files And Data[[[FILE_COUNT]]]'),
       (1179, 1307, 1, 'All Files'),
       (1180, 1308, 1, 'Allowed file types'),
       (1181, 1310, 1, '20'),
       (1182, 1311, 1, '2'),
       (1183, 1312, 1, '10'),
       (1184, 1313, 1, 'moderator'),
       (1185, 1315, 1, 'pls'),
       (1186, 1316, 1, 'time'),
       (1187, 1317, 1, 'No data'),
       (1188, 1318, 1, 'dev.mellowfish.com:8080'),
       (1189, 1319, 1, 'firefox'),
       (1190, 1320, 1, 'windows'),
       (1191, 1321, 1, 'Your registered account email address'),
       (1192, 1322, 1, 'login form'),
       (1193, 1323, 1, 'm4v'),
       (1194, 1324, 1, 'chrome'),
       (1195, 1325, 1, 'Line [[[LINE]]] should have [[[COLUMNS]]] columns.'),
       (1196, 1326, 1, 'No file selected, please try again.'),
       (1197, 1327, 1,
        'Line [[[LINE]]] should have [[[COLUMNS]]] columns. Please check there''s not a double quote in the text content causing the error. Any double quotes in text should be escaped with a backslash. i.e. \\"'),
       (1198, 1328, 1, '<a href="[[[WEB_ROOT]]]">Click here</a> to upload more files.'),
       (1199, 1329, 1, 'Per Page:'),
       (1200, 20792, 1, 'First'),
       (1201, 20793, 1, 'Previous'),
       (1202, 20794, 1, 'Next'),
       (1203, 20795, 1, 'Last'),
       (1204, 19484, 1, 'No data available in table'),
       (1205, 19485, 1, 'Showing _START_ to _END_ of _TOTAL_ entries'),
       (1206, 19486, 1, 'No data'),
       (1207, 19487, 1, 'Show _MENU_ entries'),
       (1208, 19488, 1, 'Loading, please wait...'),
       (1209, 19489, 1, ' (filtered)'),
       (1210, 19490, 1, 'Search:'),
       (1211, 19491, 1, 'No matching records found'),
       (1212, 17404, 1, 'Cars'),
       (1213, 17405, 1, 'Colorful'),
       (1214, 1344, 1, 'Edit File'),
       (1215, 19395, 1, 'Delete'),
       (1216, 19393, 1, 'Download'),
       (1217, 1377, 1, 'Your new password. Min 6 characters, alpha numeric and hypens only.'),
       (1218, 1378, 1, 'Confirm your new password.'),
       (1219, 1379, 1, 'ERROR: There was a server problem when attempting the upload, please try again later.'),
       (1220, 19423, 1, 'Progress'),
       (1221, 19424, 1, 'Speed'),
       (1222, 19426, 1, 'Remaining'),
       (1223, 1383, 1, 'Error'),
       (1224, 1384, 1, 'file details'),
       (1225, 1385, 1, 'Please register for an account to upload.'),
       (1226, 1386, 1, 'Uploading has been disabled.'),
       (1227, 19451, 1, 'Error'),
       (1228, 1388, 1, '- login to enable -'),
       (1229, 19569, 1, '- default -'),
       (1230, 1390, 1, 'Error'),
       (1231, 1391, 1, 'Filename not found.'),
       (1232, 1392, 1,
        'File received has zero size. This is likely an issue with the maximum permitted size within PHP'),
       (1233, 1393, 1, 'File received has zero size.'),
       (1234, 1394, 1, 'Could not move the file into storage, possibly a permissions issue.'),
       (1235, 1395, 1, 'Search Results'),
       (1236, 1396, 1, '[Download File]'),
       (1237, 1397, 1, '<p>You didn\\''t enter anything to search for.</p>'),
       (1238, 1398, 1, '<p>Your search query is too short, minimum is '),
       (1239, 1399, 1, ' characters.</p>'),
       (1240, 1400, 1, 'No Files Found'),
       (1241, 1405, 1, 'Torrent Url'),
       (1242, 1406, 1, 'Please enter your name.'),
       (1243, 1407, 1, 'Please enter your email.'),
       (1244, 1408, 1, 'Please provide the electronic signature of yourself or the copyright owner.'),
       (1245, 1409, 1,
        'Please confirm the information in the notification is accurate, and, under the pains and penalties of perjury, that you are authorized to act on behalf of the copyright owner.'),
       (1246, 1410, 1, 'Failed reporting file, please try again later'),
       (1247, 1411, 1, 'There was a problem updating the item, please try again later.'),
       (1248, 1412, 1, 'Password contains invalid characters, please choose another.'),
       (1249, 19397, 1, 'Stats'),
       (1250, 1414, 1, 'Please enter your title'),
       (1251, 1415, 1, 'There was a problem creating your account, please try again later'),
       (1252, 1416, 1, 'Your email address confirmation does not match'),
       (1253, 1417, 1, 'Please enter your preferred username'),
       (1254, 19367, 1, 'unlimited'),
       (1255, 1419, 1, 'Registration required.'),
       (1256, 1420, 1, 'Unavailable.'),
       (1257, 1421, 1, 'PHP Upload Limit.'),
       (1258, 1422, 1, 'Please enter the file password.'),
       (1259, 1423, 1, 'per day'),
       (1260, 1424, 1, 'Curl module not found. Please enable within PHP to enable remote uploads.'),
       (1261, 19436, 1, 'torrent'),
       (1262, 1426, 1, 'Could not find an account with that email address'),
       (1263, 1430, 1, 'Private (only via your account)'),
       (1264, 1431, 1, 'Whether to keep all file stats private or allow public access.'),
       (1265, 1432, 1, 'Statistics for this file are not publicly viewable.'),
       (1266, 1433, 1, 'Error: Uploading has been disabled.'),
       (1267, 1434, 1, 'registered'),
       (1268, 1435, 1, 'yes'),
       (1269, 1436, 1, 'none'),
       (1270, 1437, 1, 'PREMIUM'),
       (1271, 1438, 1, 'slow download'),
       (1272, 1439, 1, 'high speed download'),
       (1273, 1440, 1, 'upgrade to premium'),
       (1274, 1441, 1, 'File'),
       (1275, 1442, 1, 'Size'),
       (1276, 1443, 1, 'download pages'),
       (1277, 1444, 1, 'manage download pages'),
       (1278, 1445, 1, 'User Level'),
       (1279, 1446, 1, 'Download Page'),
       (1280, 1447, 1, 'View Order'),
       (1281, 1448, 1, 'User Level / Page'),
       (1282, 20568, 1, 'Rotate Right'),
       (1283, 20572, 1, 'Join Files'),
       (1284, 19414, 1, 'minutes'),
       (1285, 20569, 1, 'Rotate Left'),
       (1286, 1455, 1, 'Please enter your Payload Mercant Key.'),
       (1287, 1456, 1, 'Page order can not be zero or less.'),
       (1288, 1457, 1, 'ftp server type'),
       (1289, 1458, 1, 'enable passive mode'),
       (1290, 1459, 1, 'gif'),
       (1291, 1460, 1, 'access password'),
       (1292, 1461, 1, 'The password to access the file'),
       (1293, 17448, 1, 'Admin'),
       (1294, 1463, 1, 'system expired'),
       (1295, 1464, 1, 'minute'),
       (1296, 1465, 1, 'minutes'),
       (1297, 1466, 1, 'second'),
       (1298, 1467, 1, 'Moving'),
       (1299, 1468, 1, 'file(s)'),
       (1300, 1469, 1, 'Free User'),
       (1301, 1470, 1, 'Download'),
       (1302, 1471, 1, 'Edit'),
       (1303, 1472, 1, 'unknown'),
       (1304, 1473, 1, 'Select All'),
       (1305, 1474, 1, 'Select All Files'),
       (1306, 1476, 1, 'Could not get remote file. [[[FILE_URL]]]'),
       (1307, 1477, 1, 'Error: Please enter your PayPal email address for the payment.'),
       (1308, 1478, 1, 'There was a problem requesting the withdrawal, please try again later.'),
       (1309, 1479, 1, 'PPD recent earnings are added to your unpaid earnings each night.'),
       (1310, 1480, 1, 'Earnings can be withdrawn when balance is over [[[SYMBOL]]][[[PAYMENT_THRESHOLD]]].'),
       (1311, 1832, 1,
        'Please confirm your withdrawal of [[[SITE_CONFIG_COST_CURRENCY_SYMBOL]]][[[AVAILABLE_FOR_WITHDRAWAL]]]:'),
       (1312, 1482, 1, 'Your PayPal Email Address:'),
       (1313, 1483, 1,
        '\n                Once you''ve completed your registration just start uploading your files and sharing the download links with your family and friends.<br/><br/>You''ll be paid for any downloads outside of your account. Note: We only count completed downloads and downloads from unique IP addresses.\n                '),
       (1314, 1484, 1,
        '<p class="rewardsTopPadding"><strong>How can I claim my rewards?</strong></p>\n            <p>\n                Any rewards will take [[[PAYMENT_LEAD_TIME]]] days to clear within your account. Once your cleared rewards are over [[[SITE_CONFIG_COST_CURRENCY_SYMBOL]]][[[PAYMENT_THRESHOLD]]] you can request a payment via your account. Payments are made on the [[[PAYMENT_DATE]]] of every month via PayPal.\n            </p>\n            <p class="rewardsTopPadding"><strong>How do I get started?</strong></p>\n            <p>\n                Signup for an account on our <a href="[[[WEB_ROOT]]]/register.[[[SITE_CONFIG_PAGE_EXTENSION]]]">registration page</a>.\n                [[[ADDITIONAL_TEXT]]]\n            </p>'),
       (1315, 1485, 1, 'Password must be more than #VALUE# characters long'),
       (1316, 1486, 1, 'Password must be less than #VALUE# characters long'),
       (1317, 1487, 1, 'Password must contain at least #VALUE# uppercase characters'),
       (1318, 1488, 1, 'Password must contain at least #VALUE# numbers'),
       (1319, 1489, 1, 'Password must contain at least #VALUE# non-aplhanumeric characters'),
       (1320, 1490, 1, 'Confirm Password'),
       (1321, 1491, 1, 'Your password confirmation does not match'),
       (1322, 1492, 1, 'Optional. Confirm the password entered above, leave this blank to keep your existing.'),
       (1323, 1493, 1, 'webm'),
       (1324, 1494, 1, 'Please enter your PaySafeCard application key. This can be found in Application Settings.'),
       (1325, 1495, 1, 'Please enter your PaySafeCard password.'),
       (1326, 1496, 1, 'Plugin Settings'),
       (1327, 1497, 1, 'Plugin State'),
       (1328, 1498, 1, 'Whether the Micropayment payment option for upgrades is enabled'),
       (1329, 1499, 1, 'Plugin Enabled'),
       (1330, 1500, 1, 'Your Micropayment account number.'),
       (1331, 1501, 1, 'Account number'),
       (1332, 1502, 1, 'Project Name'),
       (1333, 1503, 1, 'Campaign Name'),
       (1334, 1504, 1, 'Theme Name'),
       (1335, 1505, 1, 'Gfx Name'),
       (1336, 1506, 1, 'Currency'),
       (1337, 1507, 1, 'Credit Card Enabled?'),
       (1338, 1508, 1, 'Direct Debit Enabled?'),
       (1339, 1509, 1, 'Telephone Payment Enabled?'),
       (1340, 1510, 1, 'SMS Payment Enabled?'),
       (1341, 1511, 1,
        'Your Micropayment account number. Signup via <a href="http://micropayment.ch" target="_blank">micropayment.ch</a>'),
       (1342, 1512, 1, 'Please enter your Micropayment Account.'),
       (1343, 1513, 1, 'Please enter your Micropayment Project Name.'),
       (1344, 1514, 1, 'Please enter your Micropayment Theme.'),
       (1345, 1515, 1, 'Please enter your Micropayment Gfx Name.'),
       (1346, 1516, 1, 'Please enter your Micropayment Currency.'),
       (1347, 1517, 1, 'html?'),
       (1348, 17386, 1,
        ', account, paid, membership, download,  image, picture, pic, img, hosting, sharing, upload, storage, site, website'),
       (1349, 1540, 1, 'com'),
       (1350, 1541, 1, '7e0ov'),
       (1351, 1542, 1, 'Download All Files (Zip)'),
       (1352, 19398, 1,
        'Are you sure you want to download all the files in this folder? This may take some time to complete.'),
       (1353, 1544, 1, '- Getting '),
       (1354, 1545, 1, 'Download Zip File'),
       (1355, 1546, 1, 'Confirm 2'),
       (1356, 1547, 1, '- Added folder '),
       (1357, 1548, 1, 'File received is larger than permitted. (max [[[MAX_FILESIZE]]])'),
       (1358, 1550, 1, 'srt'),
       (1359, 1551, 1, '- select page -'),
       (1360, 19417, 1, 'Maximum number of files exceeded'),
       (1361, 19418, 1, 'File type not allowed'),
       (1362, 19419, 1, 'File is too large'),
       (1363, 19420, 1, 'File is too small'),
       (1364, 1556, 1, 'user removed'),
       (1365, 1557, 1, 'hours'),
       (1366, 1558, 1, 'mkv'),
       (1367, 1559, 1, '[[[DAYS]]] day clearing period on all PPS rewards. Next update [[[NEXT_UPDATE]]].'),
       (1368, 1560, 1,
        '<p>\n                    Earn [[[PERCENTAGE]]]% of each sale you refer to this site! You can earn money from upgrading users in 2 ways:\n                </p>\n                <ol class="rewardsTextList">\n                    <li>Using your unique affiliate id, simply link to the site via your existing website. You''ll earn [[[PERCENTAGE]]]% for any users which register for an account and subsequently upgrade.</li>\n                    <li>From users which upgrade to download files within your account.</li>\n                </ol>\n                <p>\n                    Begin by uploading and sharing your files or by linking from your existing site using your affiliate id like this:\n                </p>\n                <ul>\n                    <li><a href="[[[WEB_ROOT]]]/?aff=[[[AFFILIATE_KEY]]]">[[[WEB_ROOT]]]/?aff=[[[AFFILIATE_KEY]]]</a></li>\n                </ul>'),
       (1369, 1561, 1,
        '<p>\n                    Earn [[[PERCENTAGE]]]% of each sale you refer to this site! You can earn money from upgrading users in 2 ways:\n                </p>\n                <ol class="rewardsTextList">\n                    <li>Using your unique affiliate id, simply link to the site via your existing website. You''ll earn [[[PERCENTAGE]]]% for any users which register for an account and subsequently upgrade.</li>\n                    <li>From users which upgrade to download files within your account.</li>\n                </ol>\n                <p><strong>How much can you earn?</strong></p>\n                \n                <p>Based on [[[MONTHLY_UPGRADE_EXAMPLE]]] upgrades and each upgrade costing [[[SITE_CONFIG_COST_CURRENCY_SYMBOL]]][[[SITE_CONFIG_COST_FOR_30_DAYS_PREMIUM]]] per month, you could earn the following:</p>'),
       (1370, 1562, 1, 'Month:'),
       (1371, 1563, 1, 'Referrals:'),
       (1372, 1564, 1, 'Total Referrals: (inc renewals)'),
       (1373, 1565, 1, 'Monthly Total:'),
       (1374, 1566, 1, 'Total:'),
       (1375, 1567, 1,
        '\n                Once you''ve completed your registration you''ll find your affiliate id in the ''rewards'' section of your account. Begin by uploading and sharing your files or by linking from your existing site using your affiliate id like this:\n                <ul>\n                    <li><a href="[[[WEB_ROOT]]]/?aff=[AFFILIATE_ID]">[[[WEB_ROOT]]]/?aff=[AFFILIATE_ID]</a></li>\n                </ul>'),
       (1376, 19425, 1, 'ps'),
       (1377, 19427, 1, 'Uploaded'),
       (1378, 1570, 1, 'Active file with same name found in the same folder. Please ensure the file name is unique.'),
       (1379, 1571, 1,
        'There are already [[[TOTAL_SAME]]] file(s) with the same filename in that folder. Files can not be removed.'),
       (1380, 19517, 1, 'Clear Filter'),
       (1381, 19518, 1, 'Apply Filter'),
       (1382, 1574, 1, 'Filter Your Files'),
       (1383, 1575, 1, 'Error: No active files in folder.'),
       (1384, 1576, 1, 'Optional Password:'),
       (1385, 1577, 1, 'Folder created.'),
       (1386, 1578, 1,
        'You have a good faith belief that use of the material in the manner complained of is not authorized by the copyright owner, its agent, or the law.</span>'),
       (1387, 1579, 1,
        'You have a good faith belief that use of the material in the manner complained of is not authorized by the copyright owner, its agent, or the law.</strong>'),
       (1388, 1580, 1,
        'You have a good faith belief that use of the material in the manner complained of is not authorized by the copyright owner, its agent, or the law.</li>'),
       (1389, 1581, 1, 'Folder updated.'),
       (1390, 1582, 1, 'rdp'),
       (1391, 1583, 1, 'Loading...'),
       (1392, 1584, 1, 'Success'),
       (1393, 1585, 1, 'Available Storage'),
       (1394, 1586, 1, 'Used Storage'),
       (1395, 1587, 1, 'Upload Files'),
       (1396, 1588, 1, 'Click to <a href="#" onClick="uploadFiles(); return false;">Upload</a>'),
       (1397, 1589, 1, 'Sort By'),
       (1398, 1590, 1, 'Welcome, to, the,File Upload Scriptterms, of, service. Please, read, them, fully'),
       (1399, 1991, 1,
        'Please use the following form to report any copyright infringements ensuring you supply all the following information'),
       (1400, 1592, 1, 'Enter Text or something.... '),
       (1401, 19529, 1, 'Loading, please wait...'),
       (1402, 1875, 1, 'A password is required to access this file, please enter it below.'),
       (1403, 1594, 1, 'Enter Text or something.... '),
       (1404, 1857, 1,
        'Please check your spam filters to ensure emails from this site get through. Emails from this site are sent from [[[SITE_CONFIG_DEFAULT_EMAIL_ADDRESS_FROM]]]'),
       (1405, 1869, 1, 'Statistics'),
       (1406, 1596, 1, 'Enter Text or something.... '),
       (1407, 1800, 1, 'Information about'),
       (1408, 1801, 1, 'psd'),
       (1409, 1598, 1, 'Enter Text or something.... '),
       (1410, 1860, 1,
        '[[[SITE_CONFIG_SITE_NAME]]] frequently asked questions. If you have anymore questions please <a href=''[[[WEB_ROOT]]]/contact.[[[SITE_CONFIG_PAGE_EXTENSION]]]''>contact us</a>'),
       (1411, 1600, 1, 'Enter some text or something.....'),
       (1412, 1856, 1,
        'Please enter your information to register for an account. Your new account password will be sent to your email address.'),
       (1413, 1603, 1, 'Enter some text or something.....'),
       (1414, 1864, 1, 'Share Files'),
       (1415, 1605, 1, 'Enter some text or something.....'),
       (1416, 1607, 1, 'Enter Text or something.... '),
       (1417, 1609, 1, 'Enter some text or something.....'),
       (1418, 19508, 1, 'Save Options'),
       (1419, 19457, 1, 'Processing...'),
       (1420, 1615, 1,
        'Download files directly from other sites into your account. Note: If the files are on another file download site or password protected, this may not work.'),
       (1421, 19495, 1, 'Transfer Files'),
       (1422, 1861, 1, 'Sign up now!'),
       (1423, 1862, 1, 'Home'),
       (1424, 1618, 1, 'Enter Text or something.... '),
       (1425, 1619, 1, 'File Information'),
       (1426, 1876, 1, ''),
       (1427, 1621, 1, 'Enter Text or something.... '),
       (1428, 19399, 1, 'Uploading...'),
       (1429, 19402, 1, 'Upload Progress:'),
       (1430, 19401, 1, 'Upload complete. Click here to view links.'),
       (1431, 1627, 1, 'account settings'),
       (1432, 1628, 1, 'Welcome'),
       (1433, 16996, 1, 'Or'),
       (1434, 19372, 1, 'Logout'),
       (1435, 1866, 1, 'Safe and Secure'),
       (1436, 1632, 1, 'Downloads [[[DOWNLOAD_DATE]]]'),
       (1437, 1633, 1, 'Change password.'),
       (1438, 1634, 1, 'Account avatar.'),
       (1439, 1635, 1, 'Select File (jpg, png or gif)'),
       (1440, 1636, 1, 'The uploaded image can not be more than [[[MAX_SIZE_FORMATTED]]]'),
       (1441, 1637, 1, 'Your avatar must be a jpg, png or gif image.'),
       (1442, 1638, 1, 'Remove avatar'),
       (1443, 1639, 1, '- File is too large to include in zip file ([[[FILE_NAME]]], [[[FILE_SIZE_FORMATTED]]])'),
       (1444, 1640, 1, 'Error: Selected files are greater than [[[MAX_FILESIZE]]] in total. Can not create zip.'),
       (1445, 1641, 1,
        'Error: Selected files are greater than [[[MAX_FILESIZE]]] (total [[[TOTAL_SIZE_FORMATTED]]]). Can not create zip.'),
       (1446, 1642, 1, 'Folder'),
       (1447, 1643, 1, 'Filename'),
       (1448, 1644, 1, 'Folder:'),
       (1449, 1645, 1, 'Where'),
       (1450, 1646, 1, 'Current Folder'),
       (1451, 1647, 1, 'All Files'),
       (1452, 19511, 1, 'Freetext search...'),
       (1453, 19515, 1, 'Select range...'),
       (1454, 1651, 1, 'Uploaded [[[UPLOADED_DATE]]]'),
       (1455, 1872, 1, 'csv'),
       (1456, 1873, 1, 'Mcypt functions not found within PHP, please ask support to install and try again.'),
       (1457, 1653, 1, 'Uploaded [[[UPLOADED_DATE]]]'),
       (1458, 1870, 1, 'mozilla'),
       (1459, 1871, 1, 'View file statistics'),
       (1460, 1655, 1, 'Uploaded [[[UPLOADED_DATE]]] Downloads [[[DOWNLOAD_DATE]]]'),
       (1461, 1656, 1, 'Uploaded [[[UPLOADED_DATE]]]</br> Downloads [[[DOWNLOAD_DATE]]]'),
       (1462, 1657, 1, 'The expiry date is in the past.'),
       (1463, 1658, 1, 'Ban Expiry'),
       (1464, 1659, 1,
        'You have been temporarily blocked from logging in due to too many failed login attempts. Please try again [[[EXPIRY_TIME]]].'),
       (1465, 1660, 1, 'Password changed for account on [[[SITE_NAME]]]'),
       (1466, 1661, 1,
        'Dear [[[FIRST_NAME]]],<br/><br/>This is a courtesy email notifying you that your account password on [[[SITE_NAME]]] has been changed.<br/><br/>If you didn''t change your password, please contact us immediately. Otherwise just ignore this email.<br/><br/><strong>Url:</strong> <a href=''[[[WEB_ROOT]]]''>[[[WEB_ROOT]]]</a><br/><strong>Username:</strong> [[[USERNAME]]]<br/><br/>Feel free to contact us if you need any support with your account.<br/><br/>Regards,<br/>[[[SITE_NAME]]] Admin'),
       (1467, 1662, 1, 'Email changed for account on [[[SITE_NAME]]]'),
       (1468, 1663, 1,
        'Dear [[[FIRST_NAME]]],<br/><br/>This is a courtesy email notifying you that your account email address on [[[SITE_NAME]]] has been changed to [[[NEW_EMAIL]]].<br/><br/>If you didn''t change your email address, please contact us immediately. Otherwise just ignore this email.<br/><br/><strong>Url:</strong> <a href=''[[[WEB_ROOT]]]''>[[[WEB_ROOT]]]</a><br/><strong>Username:</strong> [[[USERNAME]]]<br/><strong>New Email:</strong> [[[NEW_EMAIL]]]<br/><br/>Feel free to contact us if you need any support with your account.<br/><br/>Regards,<br/>[[[SITE_NAME]]] Admin'),
       (1469, 1664, 1, 'Could not find file owner username. Leave blank to set the file with no owner.'),
       (1470, 1665, 1, 'Short url already exists on another file.'),
       (1471, 1666, 1, 'Short url structure is invalid. Only alphanumeric values are allowed.'),
       (1472, 1667, 1, 'Secure and safe'),
       (1473, 1668, 1, 'secure and safe uploads'),
       (1474, 1669, 1, 'ods'),
       (1475, 1670, 1, 'odt'),
       (1476, 1671, 1, 'Instant Access'),
       (1477, 1672, 1, 'manage themes'),
       (1478, 1673, 1, 'add theme'),
       (1479, 1674, 1, 'themes'),
       (1480, 1675, 1, 'theme title'),
       (1481, 1676, 1,
        'Theme folder is not writable. Ensure you set the following folder to CHMOD 755 or 777: [[[THEME_FOLDER]]]'),
       (1482, 1677, 1, 'What are you waiting for?'),
       (1483, 1678, 1, 'Register below!'),
       (1484, 1679, 1, 'Register'),
       (1485, 1680, 1, 'Slow...'),
       (1486, 1681, 1, 'Super Fast!'),
       (1487, 1682, 1, 'test sdkjfgk dsfkudfh gkusdf hgukdg sdugshfdgsdfgsughuft hfsghsfghsfghf '),
       (1488, 1683, 1, 'test'),
       (1489, 1684, 1, 'File'),
       (1490, 1685, 1, 'Safe and Secure'),
       (1491, 1686, 1,
        'Safely store and backup all your essential files. From family photos & videos to important documents, you can rely on us to store all your media securely and forever.'),
       (1492, 1687, 1, 'Select Payment Method:'),
       (1493, 1689, 1, 'Enter Text or something.... '),
       (1494, 1690, 1, 'Direction'),
       (1495, 1706, 1, 's'),
       (1496, 1709, 1, 's'),
       (1497, 1708, 1, 's'),
       (1498, 19507, 1, 'Cancel'),
       (1499, 1705, 1, 's'),
       (1500, 1704, 1, 's'),
       (1501, 1752, 1, 'Error: Can not download root folder as zip file.'),
       (1502, 1703, 1, 's'),
       (1503, 1702, 1, 's'),
       (1504, 19446, 1, 'Hide'),
       (1505, 1698, 1, 's'),
       (1506, 1699, 1, 's'),
       (1507, 1885, 1, 'File is larger than permitted. (max [[[MAX_FILESIZE]]])'),
       (1508, 1700, 1, 's'),
       (1509, 1697, 1, 's'),
       (1510, 1859, 1, ''),
       (1511, 1855, 1, 'You''re just one step away from taking advantage of our file sharing service!'),
       (1512, 1696, 1, 's'),
       (1513, 20579, 1, 'last'),
       (1514, 19832, 1, 'By'),
       (1515, 16898, 1, 'Share on Facebook, Twitter, via Email & more.'),
       (1516, 16894, 1, 'Upload Your Images From <strong>Any Device</strong>.'),
       (1517, 20581, 1, 'view now'),
       (1518, 19580, 1, 'Browse Categories'),
       (1519, 1692, 1, 's'),
       (1520, 1777, 1,
        'Dear [[[FIRST_NAME]]],<br/><br/>We''ve received a request to reset your password on [[[SITE_NAME]]] for account [[[USERNAME]]]. Follow the url below to set a new account password:<br/><br/><a href=''[[[WEB_ROOT]]]/forgot_password_reset.[[[PAGE_EXTENSION]]]?u=[[[ACCOUNT_ID]]]&h=[[[RESET_HASH]]]''>[[[WEB_ROOT]]]/forgot_password_reset.[[[PAGE_EXTENSION]]]?u=[[[ACCOUNT_ID]]]&h=[[[RESET_HASH]]]</a><br/><br/>If you didn''t request a password reset, just ignore this email and your existing password will continue to work.<br/><br/>Regards,<br/>[[[SITE_NAME]]] Admin'),
       (1521, 1778, 1, 'Password reset instructions for account on [[[SITE_NAME]]]'),
       (1522, 1695, 1, 's'),
       (1523, 1691, 1, 's'),
       (1524, 3073, 1, 'Powerful Image Hosting'),
       (1525, 20582, 1, 'Choose free or premium access'),
       (1526, 1868, 1, 'Welcome to the [[[SITE_CONFIG_SITE_NAME]]] terms of service. Please read them fully.'),
       (1527, 17385, 1, 'See below for the various account and payment options.'),
       (1528, 1854, 1, ''),
       (1529, 1714, 1, 's'),
       (1530, 1715, 1, 's'),
       (1531, 1721, 1, 's'),
       (1532, 1722, 1, 's'),
       (1533, 1723, 1, 's'),
       (1534, 1754, 1, 'Send Via Email'),
       (1535, 1753, 1, 'File Details'),
       (1536, 19443, 1, 'Upload Queue'),
       (1537, 1840, 1,
        'Your withdrawal request has been made. You''ll receive further information once the request has been approved.'),
       (1538, 1725, 1, 's'),
       (1539, 1726, 1, 's'),
       (1540, 1727, 1, 's'),
       (1541, 1738, 1, 's'),
       (1542, 1739, 1, 's'),
       (1543, 1741, 1, 's'),
       (1544, 1746, 1, 's'),
       (1545, 1747, 1, 's'),
       (1546, 1751, 1, 'test123456'),
       (1547, 1748, 1, 's'),
       (1548, 1749, 1, 's'),
       (1549, 1750, 1, 's'),
       (1550, 1757, 1, 'extra info'),
       (1551, 1756, 1, 'additional info'),
       (1552, 1755, 1, 'view image'),
       (1553, 19461, 1, 'Close'),
       (1554, 16873, 1,
        'Upload, access, organize, edit, and share your photos from any device, from anywhere in the world.'),
       (1555, 1863, 1, 'Store and Manage'),
       (1556, 1776, 1, 'later'),
       (1557, 1770, 1, 'view document'),
       (1558, 1771, 1, 'watch video'),
       (1559, 1772, 1, 'play audio'),
       (1560, 1773, 1, 'profile'),
       (1561, 1774, 1, 'logging in...'),
       (1562, 1775, 1, 'requesting reset...'),
       (1563, 1779, 1, 'setting password...'),
       (1564, 1780, 1, 'General error'),
       (1565, 1781, 1, 'Your password has been reset. You can now login to the site below.'),
       (1566, 1782, 1, 'You must be a [[[USER_TYPE]]] to download this file.'),
       (1567, 18664, 1, 'send email'),
       (1568, 18660, 1,
        'Use the form below to share this file via email. The recipient will receive a link to download the file.'),
       (1569, 1785, 1, 'message'),
       (1570, 18662, 1, 'recipient email address'),
       (1571, 20879, 1, 'extra message (optional)'),
       (1572, 18661, 1, 'recipient full name'),
       (1573, 1789, 1, 'Please enter the recipient name.'),
       (1574, 1790, 1, 'Please enter the recipient email address.'),
       (1575, 1791, 1, 'File shared by [[[SHARED_BY_NAME]]] on [[[SITE_NAME]]]'),
       (1576, 1792, 1, 'n/a'),
       (1577, 1793, 1, 'File sent via email to [[[RECIPIENT_EMAIL_ADDRESS]]]'),
       (1578, 1795, 1, 'Please enter a valid recipient email address.'),
       (1579, 1796, 1,
        'Dear [[[RECIPIENT_NAME]]],<br/><br/>[[[SHARED_BY_NAME]]] has shared the following file with you via <a href=''[[[WEB_ROOT]]]''>[[[SITE_NAME]]]</a>:<br/><br/><strong>File:</strong> [[[FILE_NAME]]]<br/><strong>Url:</strong> [[[FILE_URL]]]<br/><strong>From:</strong> [[[SHARED_BY_NAME]]] ([[[SHARED_EMAIL_ADDRESS]]])<br/><strong>Message:</strong> [[[EXTRA_MESSAGE]]]<br/><br/>Feel free to contact us if you have any difficulties downloading the file.<br/><br/>Regards,<br/>[[[SITE_NAME]]] Admin'),
       (1580, 1797, 1, 'get themes'),
       (1581, 1799, 1, 'newsletter text'),
       (1582, 1804, 1,
        'Your PHP limits on [[[SERVER_NAME]]] need to be set to at least [[[MAX_SIZE]]] to allow larger files to be uploaded (currently [[[CURRENT_LIMIT]]]). Contact your host to set.'),
       (1583, 1805, 1,
        'Could not move the file into storage on [[[SERVER]]], possibly a permissions issue with the file storage directory.'),
       (1584, 1806, 1, 'admin removed'),
       (1585, 1867, 1, 'Register'),
       (1586, 1809, 1, 'Download file'),
       (1587, 1813, 1, 'Registration from email addresses on [[[EMAIL_DOMAIN]]] have been blocked on this site.'),
       (1588, 1814, 1, 'Date Added'),
       (1589, 1816, 1, ''),
       (1590, 1817, 1,
        'Your paid account is expiring in [[[DAYS]]] days. Your inactive files may removed if you do not renew your membership. Click here for more information.'),
       (1591, 1818, 1, 'admin User'),
       (1592, 1819, 1, 'Could not read the theme settings file ''_theme_config.inc.php''.'),
       (1593, 1820, 1, 'Active Servers'),
       (1594, 1821, 1, 'File Path'),
       (1595, 1822, 1, 'Server'),
       (1596, 1823, 1, 'File Action'),
       (1597, 1824, 1, 'manage file action queue'),
       (1598, 1825, 1, 'action queue'),
       (1599, 1826, 1, 'dev.mellowfish.com'),
       (1600, 1865, 1, 'Fast Downloading'),
       (1601, 1828, 1, ''),
       (1602, 1829, 1, 'Embed HTML Code'),
       (1603, 1830, 1, 'Embed Forum Code'),
       (1604, 1831, 1, 'Direct Link'),
       (1605, 1833, 1, 'Payment Method:'),
       (1606, 1834, 1, 'Paypal Email:'),
       (1607, 1835, 1, 'Your Postal Address:'),
       (1608, 1836, 1, 'Your Account Name:'),
       (1609, 1837, 1, 'International Iban Number:'),
       (1610, 1838, 1, 'Swift Number:'),
       (1611, 1839, 1, 'Error: Please enter all the outpayment details.'),
       (1612, 1841, 1, 'Method'),
       (1613, 1842, 1, 'total paid'),
       (1614, 1846, 1, ''),
       (1615, 1847, 1,
        'Thanks for registering and welcome to your account! Start uploading files straight away by clicking the ''Upload'' button below. Feel free to contact us if you need any help.'),
       (1616, 1848, 1, 'xlsx'),
       (1617, 16880, 1, 'First Class Image Manager'),
       (1618, 1880, 1, '91838000 1'),
       (1619, 1881, 1, '34782400 1'),
       (1620, 1882, 1, '99907800 1'),
       (1621, 1883, 1, 'xml'),
       (1622, 1884, 1, 'profsave'),
       (1623, 1886, 1, 'mov'),
       (1624, 1887, 1, 'db'),
       (1625, 1888, 1, 'Paid User'),
       (1626, 1889, 1, 'Want to earn some money?'),
       (1627, 1890, 1, 'You can earn thousands of dollers from us!'),
       (1628, 1891, 1, 'Earn Money'),
       (1629, 1894, 1, 'View Tickets'),
       (1630, 1895, 1, 'Create Ticket'),
       (1631, 1896, 1, 'Support Tickets'),
       (1632, 1934, 1, 'Delete Selected'),
       (1633, 19403, 1, 'Are you sure you want to duplicate the selected [[[TOTAL_FILES]]] file(s)?'),
       (1634, 1957, 1, 'Duplicate'),
       (1635, 1958, 1, 'Files duplicated in current folder.'),
       (1636, 1959, 1, 'Enter Your Account Home'),
       (1637, 1960, 1, 'Your Files'),
       (1638, 1961, 1, 'Upload, share and manage your files'),
       (1639, 1964, 1, 'Please confirm whether to delete the file below.'),
       (1640, 1965, 1, 'Logout'),
       (1641, 1966, 1, 'File Hosting Script'),
       (1642, 1967, 1, 'Upload'),
       (1643, 1968, 1, 'Free File Hosting Manager'),
       (1644, 1969, 1, 'Happy Customers'),
       (1645, 1970, 1, 'Facebook Likes'),
       (1646, 1971, 1, 'Twiter Followers'),
       (1647, 1972, 1, 'Files Downloaded'),
       (1648, 1973, 1, 'Upload'),
       (1649, 1974, 1, 'Premium'),
       (1650, 1975, 1, 'Terms & Conditions'),
       (1651, 1976, 1, 'FAQ'),
       (1652, 1977, 1, 'Report Files'),
       (1653, 1978, 1, 'Contact Us'),
       (1654, 1979, 1, '100% Safe &'),
       (1655, 1980, 1, 'Anonymous'),
       (1656, 1981, 1, 'Contact'),
       (1657, 1982, 1, 'Home'),
       (1658, 1983, 1, 'Submit Form'),
       (1659, 1984, 1, 'Report File'),
       (1660, 1985, 1, 'Submit Report'),
       (1661, 1986, 1, 'Thanks for your payment!'),
       (1662, 1987, 1, ''),
       (1663, 1988, 1, 'Password Reset'),
       (1664, 1989, 1, 'Request Reset'),
       (1665, 1990, 1, 'Login'),
       (1666, 1992, 1, 'download / view now'),
       (1667, 19836, 1, 'Total Images'),
       (1668, 1994, 1,
        'There was a problem creating the theme folder. Please ensure the following folder has CHMOD 777 permissions: /var/www/php_site_scripts/file_hosting/themes/'),
       (1669, 17396, 1, ' HOME'),
       (1670, 1996, 1, 'rewards'),
       (1671, 1997, 1, 'rewards'),
       (1672, 1998, 1, 'index1'),
       (1673, 1999, 1, 'index2'),
       (1674, 2000, 1, 'index3'),
       (1675, 2001, 1, ''),
       (1676, 2002, 1, ''),
       (1677, 2003, 1, 'Thank you for registering!'),
       (1678, 2004, 1, ''),
       (1679, 2006, 1, 'remote access'),
       (1680, 20577, 1, 'previous'),
       (1681, 2045, 1, 'Extract Files'),
       (1682, 2046, 1, 'Compress to Zip/Rar'),
       (1683, 16882, 1, 'Slick image management for the digital generation'),
       (1684, 2071, 1, 'No'),
       (1685, 2072, 1, 'Yes'),
       (1686, 2079, 1, 'Frequently Asked Questions'),
       (1687, 2080, 1, 'Register'),
       (1688, 2083, 1, 'rar'),
       (1689, 2084, 1, 'Alert'),
       (1690, 2085, 1, 'Search'),
       (1691, 2086, 1, 'dashboard'),
       (1692, 2087, 1, 'Plugins'),
       (1693, 2088, 1, 'Configuration'),
       (1694, 2089, 1, 'more....'),
       (1695, 2090, 1, 'new notifications.'),
       (1696, 19363, 1, 'You have <strong>[[[UNREAD]]]</strong> new notifications.'),
       (1697, 2092, 1, 'Premium Download (No Waiting Time)'),
       (1698, 2093, 1, 'Download'),
       (1699, 2094, 1, 'Manage Torrents'),
       (1700, 2095, 1, 'Torrents'),
       (1701, 2103, 1, 'Ms'),
       (1702, 2104, 1, 'View Torrents'),
       (1703, 2126, 1, 'background task logs'),
       (1704, 2127, 1, 'Task Name'),
       (1705, 2128, 1, 'Last Update'),
       (1706, 2129, 1, 'Last Run'),
       (1707, 2130, 1, 'Start Time'),
       (1708, 2131, 1, 'End Time'),
       (1709, 19839, 1, 'Total Likes'),
       (1710, 2133, 1, 'css'),
       (1711, 2134, 1, 'Item1'),
       (1712, 2135, 1, 'Item2'),
       (1713, 2140, 1, 'week'),
       (1714, 2141, 1, 'weeks'),
       (1715, 16886, 1, 'Desktop Image Manager'),
       (1716, 2152, 1, 'Mark all Read'),
       (1717, 2153, 1, 'You have <strong>[[[UNREAD]]]</strong> new notification.'),
       (1718, 2155, 1, '000'),
       (1719, 2156, 1, 'Date Added'),
       (1720, 2157, 1, 'Type'),
       (1721, 2158, 1, 'Please enter your G2aPay secret key.'),
       (1722, 2159, 1, '001'),
       (1723, 19440, 1, 'Drag &amp; drop images here or click to browse...'),
       (1724, 17395, 1, 'UPLOAD'),
       (1725, 19437, 1, 'Add images...'),
       (1726, 2174, 1, 'add more...'),
       (1727, 2175, 1, 'add more'),
       (1728, 19421, 1, 'ERROR: There was a server problem when attempting the upload.'),
       (1729, 2177, 1, 'Album'),
       (1730, 19383, 1, 'Add Album'),
       (1731, 2179, 1, 'Edit'),
       (1732, 2180, 1, 'Delete'),
       (1733, 19389, 1, 'Share Album'),
       (1734, 19512, 1, 'Current Album'),
       (1735, 2183, 1, 'Album Name:'),
       (1736, 2184, 1, 'Parent Album:'),
       (1737, 2185, 1, 'Public:'),
       (1738, 2186, 1, 'Optional Password:'),
       (1739, 19387, 1, 'Add Album'),
       (1740, 19390, 1,
        'Are you sure you want to remove this album? Any files within the album will be moved into your default root folder and remain active.'),
       (1741, 2189, 1, 'Please enter the album name'),
       (1742, 2190, 1, 'There was a problem updating the album, please try again later.'),
       (1743, 19346, 1, 'your albums'),
       (1744, 2192, 1, 'Album created.'),
       (1745, 2193, 1, 'Edit Existing Album'),
       (1746, 2194, 1, 'update album'),
       (1747, 19388, 1, 'Download All Images (Zip)'),
       (1748, 19509, 1, 'Filter Your Images'),
       (1749, 19513, 1, 'All Albums'),
       (1750, 19522, 1, 'Image Urls'),
       (1751, 2199, 1, 'Theme'),
       (1752, 2200, 1, 'Manage'),
       (1753, 2201, 1, 'Add'),
       (1754, 2202, 1, 'Image Categories'),
       (1755, 2203, 1, 'Manage Categories'),
       (1756, 2204, 1, 'Add Category'),
       (1757, 2205, 1, 'Album updated.'),
       (1758, 2206, 1, 'Leave us a message'),
       (1759, 2207, 1, 'More Info'),
       (1760, 2208, 1, 'No categories found in current search filter.'),
       (1761, 2209, 1, 'Category with same name or url key already exists. Please try again.'),
       (1762, 2210, 1, 'Please enter the category url key'),
       (1763, 2211, 1, 'Please enter the category name'),
       (1764, 2212, 1, 'category'),
       (1765, 19505, 1, 'public category'),
       (1766, 2214, 1, 'public category (shown on the public image browsing pages)'),
       (1767, 2215, 1, '(shown on the public image browsing pages)'),
       (1768, 2216, 1, 'album'),
       (1769, 2217, 1, 'Image Privacy:'),
       (1770, 2218, 1, 'Private, no access outside of your account.'),
       (1771, 2219, 1, 'Limited, access only if users know the sharing link.'),
       (1772, 2220, 1, 'Public, listed on the site and within search results.'),
       (1773, 2221, 1, 'File Privacy:'),
       (1774, 18649, 1, 'views'),
       (1775, 2224, 1, 'track 1'),
       (1776, 2225, 1, 'Image Stats'),
       (1777, 19394, 1, 'Edit Image'),
       (1778, 18645, 1, 'Image Stats'),
       (1779, 18646, 1, 'Download Image'),
       (1780, 2229, 1, 'Delete Image'),
       (1781, 18652, 1, 'sharing code'),
       (1782, 18654, 1, 'image data'),
       (1783, 19340, 1, 'Browse'),
       (1784, 19341, 1, 'Browse Images'),
       (1785, 19342, 1, 'browser, images, file, your, interface, upload, download, site'),
       (1786, 2235, 1, 'Search Images...'),
       (1787, 19359, 1, 'Search images...'),
       (1788, 19361, 1, 'Advanced Search'),
       (1789, 2238, 1, 'used'),
       (1790, 2239, 1, 'Unlimited Storage'),
       (1791, 2240, 1, 'account types'),
       (1792, 2241, 1, 'account packages'),
       (1793, 2242, 1, 'upload allowed'),
       (1794, 2243, 1, 'max upload size'),
       (1795, 2244, 1, 'upgrade page'),
       (1796, 2245, 1, 'total users'),
       (1797, 2246, 1, 'label'),
       (1798, 2247, 1, 'period label'),
       (1799, 2248, 1, 'price usd'),
       (1800, 2249, 1, 'price gbp'),
       (1801, 2250, 1, 'price eur'),
       (1802, 2251, 1, 'pricing label'),
       (1803, 2252, 1, 'price'),
       (1804, 2253, 1, 'account package'),
       (1805, 2255, 1, 'Note'),
       (1806, 2256, 1, 'PPD is not available with your account.'),
       (1807, 2257, 1, 'Note: PPD is not available with your account.'),
       (1808, 2258, 1, 'Buy Now'),
       (1809, 2260, 1,
        '<li class="list-group-item"><i class="fa fa-lock"></i> Secure Payment</li><li class="list-group-item"><i class="fa fa-eye-slash"></i> 100% Safe & Anonymous</li>'),
       (1810, 2261, 1, 'Upgrade To'),
       (1811, 2262, 1, 'support info'),
       (1812, 2263, 1, 'Method'),
       (1813, 2264, 1, 'progress'),
       (1814, 2265, 1, 'Are you sure you want to cancel this download?'),
       (1815, 2267, 1, 'clear'),
       (1816, 2268, 1, 'Please specify the label.'),
       (1817, 2269, 1, 'That label has already been used, please choose another.'),
       (1818, 2270, 1, 'Premium account expiry details.'),
       (1819, 2271, 1, 'Account expiry date'),
       (1820, 19352, 1, 'Browse'),
       (1821, 19353, 1, 'Featured'),
       (1822, 2275, 1, 'Profile'),
       (1823, 19356, 1, 'Likes'),
       (1824, 18733, 1, 'last seen'),
       (1825, 2278, 1, 'Feed'),
       (1826, 19536, 1, 'albums'),
       (1827, 18738, 1, 'Likes'),
       (1828, 19533, 1, 'Images'),
       (1829, 18735, 1, 'likes received'),
       (1830, 2283, 1, 'Profile Image.'),
       (1831, 2284, 1, 'Select File (jpg, png or gif)'),
       (1832, 2285, 1, 'Your profile image must be a jpg, png or gif image.'),
       (1833, 2286, 1, 'Remove profile image'),
       (1834, 18736, 1, 'Edit Profile'),
       (1835, 2288, 1, 'No albums found.'),
       (1836, 2289, 1, 'repeat password'),
       (1837, 2290, 1, 'Speed'),
       (1838, 2291, 1, 'Comments Overview'),
       (1839, 2292, 1, 'Reported Comments'),
       (1840, 18648, 1, 'comments'),
       (1841, 2299, 1, 'Image sent via email to [[[RECIPIENT_EMAIL_ADDRESS]]]'),
       (1842, 2303, 1, 'by'),
       (1843, 2305, 1, 'at'),
       (1844, 2308, 1, 'Like'),
       (1845, 16995, 1, 'Register'),
       (1846, 19378, 1, 'All Images'),
       (1847, 20576, 1, 'first'),
       (1848, 18647, 1, 'Click to view comments'),
       (1849, 2318, 1, 'Click to view stats'),
       (1850, 18650, 1, 'Like this image'),
       (1851, 19357, 1, 'Your Images'),
       (1852, 19350, 1, 'selected file'),
       (1853, 2322, 1, 'private info page'),
       (1854, 2323, 1, 'Sharing links has been disabled on this file.'),
       (1855, 2324, 1, 'Premium for'),
       (1856, 2325, 1, 'user settings'),
       (1857, 2326, 1, 'package price'),
       (1858, 2327, 1, 'package pricing label'),
       (1859, 2328, 1, 'payment period'),
       (1860, 2329, 1, 'package label'),
       (1861, 2330, 1, 'allow upload'),
       (1862, 2331, 1, 'Test User'),
       (1863, 2332, 1, 'Public - access only if users know the sharing link.'),
       (1864, 2333, 1, 'file privacy'),
       (1865, 2334, 1, 'Whether to keep all files private or allow sharing.'),
       (1866, 2335, 1, 'All Files Publicly Accessible'),
       (1867, 2336, 1, 'All Files Private (only via your account'),
       (1868, 2337, 1, 'File is not shared publicly.'),
       (1869, 2338, 1, 'View Folder'),
       (1870, 2339, 1, 'View Folder'),
       (1871, 2340, 1, 'File is not publicly available.'),
       (1872, 2341, 1, 'permissions'),
       (1873, 20845, 1, 'Private File - Only available via your account, or via a generated sharing url.'),
       (1874, 18641, 1, 'Sharing'),
       (1875, 18642, 1, 'Public File - Can be Shared'),
       (1876, 2345, 1, 'm2v'),
       (1877, 2346, 1, 'flv'),
       (1878, 2348, 1, 'TEST USER USER'),
       (1879, 2349, 1, 'TEST USER'),
       (1880, 2350, 1,
        '<li class="list-group-item"><i class="fa fa-lock"></i> Secure Payment</li><li class="list-group-item"><i class="fa fa-eye-slash"></i> 100% Safe & Anonymous</li>'),
       (1881, 2351, 1, 'Guest'),
       (1882, 3074, 1,
        'Upload, access, organize, edit, and share your photos from any device, from anywhere in the world.'),
       (1883, 15041, 1, 'Or'),
       (1884, 15042, 1, 'Premium Pricing'),
       (1885, 2357, 1, 'Login to your Account'),
       (1886, 16890, 1, 'Mobile Phone Image Manager'),
       (1887, 2359, 1, 'Guest User'),
       (1888, 2361, 1, 'Home'),
       (1889, 17414, 1, 'Weddings'),
       (1890, 17415, 1, 'Work'),
       (1891, 16872, 1, 'Powerful Image Hosting'),
       (1892, 17406, 1, 'Illustrations'),
       (1893, 17407, 1, 'Just For Fun'),
       (1894, 17409, 1, 'Nature'),
       (1895, 17411, 1, 'Scenes'),
       (1896, 16924, 1,
        'Safely store all of your precious images. You can rely on us to keep your images safe and secure.'),
       (1897, 2376, 1,
        '<li class="list-group-item"><i class="fa fa-lock"></i> Secure Payment</li><li class="list-group-item"><i class="fa fa-eye-slash"></i> 100% Safe & Anonymous</li>'),
       (1898, 2377, 1,
        '<li class="list-group-item"><i class="fa fa-lock"></i> Secure Payment</li><li class="list-group-item"><i class="fa fa-eye-slash"></i> 100% Safe & Anonymous</li>'),
       (1899, 2378, 1,
        '<li class="list-group-item"><i class="fa fa-lock"></i> Secure Payment</li><li class="list-group-item"><i class="fa fa-eye-slash"></i> 100% Safe & Anonymous</li>'),
       (1900, 17430, 1, 'Most Popular'),
       (1901, 17439, 1, 'Upgrade Now'),
       (1902, 2381, 1, 'Register'),
       (1903, 2382, 1, '<li><i class="fa fa-hdd-o"></i> Advert Supported</li>'),
       (1904, 2383, 1, 'Register Now'),
       (1905, 17441, 1, 'Unique Members Area'),
       (1906, 17420, 1, 'Advert Supported'),
       (1907, 17442, 1, 'No Adverts'),
       (1908, 2387, 1, 'Priority Support'),
       (1909, 2388, 1, 'Features Overview'),
       (1910, 2389, 1, 'Some of the Features that are gonna blow your mind off'),
       (1911, 11757, 1, 'Unique Image Manager'),
       (1912, 11758, 1,
        'Our high peformance image manager allows you to control all of your pictures with its easy to use interface.'),
       (1913, 11760, 1, 'Mobile, Tablet &amp; Desktop'),
       (1914, 11761, 1,
        'Powerful Layout with Responsive functionality that can be adapted to any screen size. Resize browser to view.'),
       (1915, 11763, 1, 'Safe &amp; Secure'),
       (1916, 11764, 1, 'Safely store all of your precious images. You can rely on us to keep your images protected.'),
       (1917, 11766, 1, 'Backed Up Forever'),
       (1918, 11767, 1, 'All of your images are securely backed up on our databases to give you peace of mind.'),
       (1919, 11769, 1, 'Powerful Image Tools'),
       (1920, 11772, 1, 'Share Your Memories'),
       (1921, 11773, 1,
        'We supply you with all the tools necessary to easily share your images with friends &amp; family.'),
       (1922, 11775, 1, 'Fast Image Searching'),
       (1923, 11776, 1, 'Quickly access all of your images by using our fast image searching tools.'),
       (1924, 11778, 1, 'Private Albums'),
       (1925, 11779, 1, 'Keep your most personal &amp; valued images entirely private with our locked albums feature.'),
       (1926, 11781, 1, 'Always On'),
       (1927, 11782, 1, 'Access our site at any time from any location to store &amp; manage your images.'),
       (1928, 2408, 1, 'Navigation'),
       (1929, 17413, 1, 'Travel'),
       (1930, 16997, 1, 'Premium Access'),
       (1931, 17412, 1, 'Sports'),
       (1932, 6169, 1, 'First Class Image Manager'),
       (1933, 6170, 1, 'Some of the Features that are gonna blow your mind off'),
       (1934, 14512, 1, 'Flexible &amp; Easy Pricing for wide Audience Groups'),
       (1935, 14791, 1, 'What are you waiting for? Join us!'),
       (1936, 2417, 1, 'Any'),
       (1937, 2418, 1, 'Personal'),
       (1938, 19499, 1, 'store in album:'),
       (1939, 2420, 1,
        'Select an album below to store these files in. All current uploads files will be available within these albums.'),
       (1940, 2421, 1,
        'When downloading these images, users will be prompted for a password, if set. Download managers will not work if a password is set.'),
       (1941, 19497, 1, 'Enter an email address below to send the list of images via email once they''re uploaded.'),
       (1942, 19501, 1, 'Album Name'),
       (1943, 19447, 1, 'Image uploads completed.'),
       (1944, 19460, 1, '<a href="[[[WEB_ROOT]]]">Click here</a> to upload more images.'),
       (1945, 19458, 1, 'View All Links'),
       (1946, 2427, 1, 'View image on'),
       (1947, 2428, 1, 'on'),
       (1948, 2429, 1, 'Sharing Url:'),
       (1949, 2430, 1, 'Sharing Url:'),
       (1950, 2431, 1, 'your album'),
       (1951, 19504, 1,
        'Listed in this category whe shared publicly on the site. Leave blank if you are keeping the images private.'),
       (1952, 2437, 1, 'Public Limited - access only if users know the sharing link.'),
       (1953, 2438, 1,
        'You can not update this [[[FILEFOLDER]]] permissions as your account settings are set to make all files private.'),
       (1954, 2439, 1, 'Album Privacy:'),
       (1955, 2440, 1,
        'You can not update this album privacy settings as your account settings are set to make all files private or the parent folder is set to private.'),
       (1956, 2441, 1,
        'Note: You can not update this album privacy settings as your account settings are set to make all files private or the parent folder is set to private.'),
       (1957, 2442, 1,
        'Whether to keep all files private or allow sharing. If this is set as public, you can still set albums as private.'),
       (1958, 2443, 1, 'Privacy'),
       (1959, 2444, 1, 'Default Album Privacy'),
       (1960, 2445, 1, 'Image Statistics'),
       (1961, 2446, 1,
        'Folder is not publicly shared. Please contact the owner and request they update the privacy settings.'),
       (1962, 19384, 1, 'Upload Images'),
       (1963, 6652, 1, 'Desktop Image Manager'),
       (1964, 6653, 1, 'Tablet Image Manager'),
       (1965, 6654, 1, 'Phone Image Manager'),
       (1966, 2452, 1, 'Image Sample'),
       (1967, 11756, 1, 'Unique Image Manager'),
       (1968, 11759, 1, 'Mobile, Tablet &amp; Desktop'),
       (1969, 11762, 1, 'Safe &amp; Secure'),
       (1970, 11765, 1, 'Backed Up Forever'),
       (1971, 11768, 1, 'Powerful Image Tools'),
       (1972, 11771, 1, 'Share Your Memories'),
       (1973, 11774, 1, 'Fast Image Searching'),
       (1974, 11777, 1, 'Private Albums'),
       (1975, 11780, 1, 'Always On'),
       (1976, 2462, 1, 'Folder Protected'),
       (1977, 2463, 1, 'Password Protected'),
       (1978, 2464, 1,
        'This folder requires a password to gain access. Use the form below to enter the password, then click "unlock".'),
       (1979, 2465, 1, 'Password Required'),
       (1980, 2466, 1, 'Unlock'),
       (1981, 2467, 1, 'The album password is invalid'),
       (1982, 2468, 1, 'There was a problem loading the album, please try again later.'),
       (1983, 20824, 1,
        'No files found within this folder. Drag & drop files to upload here or click ''Upload'' above.'),
       (1984, 2470, 1, 'No images found within this album.'),
       (1985, 2471, 1, 'You already have an album with that name, please use another'),
       (1986, 2472, 1, 'This user has not publicly shared any albums..'),
       (1987, 2473, 1, 'No images found.'),
       (1988, 2474, 1, 'About Us'),
       (1989, 2475, 1, 'Facebook url is invalid.'),
       (1990, 17463, 1,
        'Premium image hosting, <strong>Fast Access</strong> to your important images & <strong>Huge Storage</strong> limits. Mobile, tablet & desktop access. See what you missing, <a href="[[[WEB_ROOT]]]/register.[[[SITE_CONFIG_PAGE_EXTENSION]]]">join us</a> today.'),
       (1991, 17464, 1, 'Total Views'),
       (1992, 17465, 1, 'Total Images'),
       (1993, 17466, 1, 'Like us'),
       (1994, 17467, 1, 'on Facebook'),
       (1995, 20570, 1, 'Add to Zip/Rar'),
       (1996, 2482, 1, 'Enable Download Accelerators?'),
       (1997, 2483, 1, 'By Date Taken'),
       (1998, 19583, 1, 'Categories'),
       (1999, 2485, 1, 'Profiles'),
       (2000, 2486, 1, 'There are no albums shared publicly.'),
       (2001, 2487, 1, 'Account security lock.'),
       (2002, 2488, 1, 'Account lock status'),
       (2003, 2489, 1,
        'The account security lock, when enabled, prevents your account details (name, email, password) from being edited, it also prevents files from being edited, moved and deleted.<br/>To unlock your account, you will need the password which is emailed to your registered email address when the lock is enabled.'),
       (2004, 2490, 1, 'Activate security lock'),
       (2005, 2491, 1, 'Security lock details for [[[SITE_NAME]]]'),
       (2006, 2492, 1,
        'Dear [[[FIRST_NAME]]],<br/><br/>Your account on [[[SITE_NAME]]] has been locked as per your request. Use the code below to unlock your account:<br/><br/><strong>Unlock code:</strong> [[[UNLOCK_CODE]]]<br/><br/>Feel free to contact us if you need any support with your account.<br/><br/>Regards,<br/>[[[SITE_NAME]]] Admin'),
       (2007, 2493, 1, 'Account successfully secured.'),
       (2008, 2494, 1, 'This account has been locked, please unlock the account to regain full functionality.'),
       (2009, 2495, 1, 'This account has been locked, please unlock the account to regain full functionality.'),
       (2010, 2496, 1, 'Account lock code'),
       (2011, 2497, 1, 'De-activate security lock'),
       (2012, 2498, 1, 'Resend security code'),
       (2013, 2499, 1, 'Please enter the unlock code and try again.'),
       (2014, 2500, 1, 'Locked'),
       (2015, 2501, 1, 'Account successfully unlocked.'),
       (2016, 2502, 1, 'Unlocked'),
       (2017, 2503, 1, 'The email containing the unlock code has been emailed to the registered email account.'),
       (2018, 2504, 1, 'Account could not be unlocked as the code is incorrect.'),
       (2019, 2505, 1, 'Uploaded [[[UPLOADED_DATE]]]</br> Downloads [[[DOWNLOAD_DATE]]]'),
       (2020, 2506, 1, 'Improved Downloads'),
       (2021, 2507, 1, 'REGISTER'),
       (2022, 19847, 1, 'Total Views'),
       (2023, 20571, 1, 'Split File'),
       (2024, 20573, 1, 'Download from'),
       (2025, 19851, 1, 'Share'),
       (2026, 2514, 1, 'browse'),
       (2027, 19535, 1, 'Browse Albums'),
       (2028, 20575, 1, 'from'),
       (2029, 2517, 1, 'Slideshow'),
       (2030, 2518, 1, 'Play Slideshow'),
       (2031, 19534, 1, 'Recent Image Uploads'),
       (2032, 2520, 1, 'PROFESSIONAL'),
       (2033, 2521, 1, 'This account has been locked, please unlock the account to regain full functionality.'),
       (2034, 2522, 1, 'Search'),
       (2035, 2523, 1, 'Search Images'),
       (2036, 2524, 1, 'Search Albums'),
       (2037, 2525, 1, 'Search [[[TERM]]]'),
       (2038, 2526, 1, 'Search "[[[TERM]]]"'),
       (2039, 2527, 1, 'Recent Image Uploads - Search Results'),
       (2040, 2528, 1, 'Albums Search Results'),
       (2041, 2529, 1, 'Recent Image Search Results'),
       (2042, 2530, 1, 'Image Search Results'),
       (2043, 19408, 1, 'Browse Images'),
       (2044, 2532, 1, 'There are no albums given the current search criteria.'),
       (2045, 2533, 1, 'No images found within album or search criteria.'),
       (2046, 2534, 1, 'In order to prevent abuse of this service, please copy the words into the text box below.'),
       (2047, 2535, 1, 'Account could not be secured at this time, please try again later.'),
       (2048, 2536, 1, 'Premium Expires.'),
       (2049, 2537, 1, 'Account status'),
       (2050, 2538, 1, 'Account Lock');
INSERT INTO `language_content` (`id`, `languageKeyId`, `languageId`, `content`)
VALUES (2051, 2539, 1, 'Do Nothing'),
       (2052, 2540, 1, 'Activate Lock'),
       (2053, 2541, 1,
        'The account security lock prevents your account details and files from being edited, moved and deleted.'),
       (2054, 2542, 1, 'ppt'),
       (2055, 2543, 1, 'Image Colors'),
       (2056, 18643, 1, 'Color Palette'),
       (2057, 19351, 1, 'Community'),
       (2058, 19354, 1, 'Account'),
       (2059, 19368, 1, 'Public Profile'),
       (2060, 19432, 1, 'image upload'),
       (2061, 19453, 1,
        'Download images directly from other sites into your account. Note: If the images are on another image download site or password protected, this may not work.'),
       (2062, 19454, 1, 'Transfer Images'),
       (2063, 19456, 1, 'Enter up to [[[MAX_REMOTE_URL_IMAGES]]] image urls. Separate each url on it''s own line.'),
       (2064, 19459, 1, 'Image transfers completed.'),
       (2065, 19500, 1,
        'Select an album below to store these images in. All current uploads will be available within these albums.'),
       (2066, 2554, 1, 'Unlock Code'),
       (2067, 2555, 1, 'The unlock code that was sent to the registered email address when the lock was activated.'),
       (2068, 2556, 1, 'unlock account'),
       (2069, 2557, 1, 'resend unlock code'),
       (2070, 2558, 1, 'Account could not be unlocked at this time, please try again later.'),
       (2071, 17410, 1, 'Other'),
       (2072, 11259, 1, 'We have a large varierty of features available'),
       (2073, 11770, 1,
        'We have multple tools that you can use for your images such as slide shows, embedding, sharing and more.'),
       (2074, 19473, 1, 'You can not add more than [[[MAX_URLS]]] urls at once.'),
       (2075, 16902, 1, 'Unique Image Tools, Watermarking, Slideshows & more.'),
       (2076, 16597, 1, 'Upload & Share Images'),
       (2077, 16904, 1, 'Heroic <strong>Support Team</strong>.'),
       (2078, 16906, 1, 'Powerful Features'),
       (2079, 16908, 1, 'Packed full of features that will blow your mind!'),
       (2080, 16910, 1, 'Unique Image Manager'),
       (2081, 16892, 1, 'What Is [[[SITE_CONFIG_SITE_NAME]]]?'),
       (2082, 16893, 1,
        'Built for the modern world of digital imagery, we''ve got loads of great features to help you manage your images.'),
       (2083, 16918, 1,
        'Access images on the go using your mobile phone, or show a client photos using your iPad. Use any modern device.'),
       (2084, 16900, 1, 'Secure Storage & Password Protected Albums.'),
       (2085, 16920, 1, 'Safe &amp; Secure'),
       (2086, 16922, 1, 'Safe &amp; Secure'),
       (2087, 16926, 1, 'Stored In The Cloud'),
       (2088, 16928, 1, 'Stored In The Cloud'),
       (2089, 16912, 1, 'Unique Image Manager'),
       (2090, 16913, 1,
        'Our image manager allows you to quickly manage all of your images and photos with its modern, easy to use interface.'),
       (2091, 16942, 1, 'Fast Image Searching'),
       (2092, 16944, 1, 'Fast Image Searching'),
       (2093, 16932, 1, 'Powerful Image Tools'),
       (2094, 16933, 1, 'Powerful Image Tools'),
       (2095, 17477, 1, 'terms and conditions'),
       (2096, 17478, 1, 'report file'),
       (2097, 16952, 1, 'Keep your most personal & valued images entirely private with our locked albums feature.'),
       (2098, 16953, 1, 'Always On'),
       (2099, 19371, 1, 'extend account'),
       (2100, 16993, 1, 'Get Started Now'),
       (2101, 16994, 1, 'What are you waiting for? It''s Free!'),
       (2102, 17596, 1, 'account, home, file, your, interface, upload, download, site'),
       (2103, 17394, 1, 'Logo'),
       (2104, 19344, 1, 'premium'),
       (2105, 19345, 1, 'login'),
       (2106, 17399, 1, 'Premium Access'),
       (2107, 17400, 1, 'Get Started Now'),
       (2108, 17401, 1, ' BROWSE'),
       (2109, 17402, 1, 'Animals'),
       (2110, 16888, 1, 'Tablet Image Manager'),
       (2111, 17416, 1, 'Type & Hit Enter..'),
       (2112, 17408, 1, 'Music'),
       (2113, 16896, 1, 'Lots of <strong>Free Storage</strong> for Your Images.'),
       (2114, 16914, 1, 'Mobile, Tablet &amp; Desktop'),
       (2115, 16916, 1, 'Mobile, Tablet &amp; Desktop'),
       (2116, 16930, 1,
        'All of your images are securely stored in the cloud for piece of mind. Don''t risk loosing CDs or hard drives failing.'),
       (2117, 16934, 1,
        'We have lots of tools that you can use to easily manage your images. Slideshows, embedding, sharing, rotating and more.'),
       (2118, 16936, 1, 'Share Your Memories'),
       (2119, 16938, 1, 'Share Your Memories'),
       (2120, 16940, 1,
        'Share your images on social networks like Facebook or provide limited access to just friends & family.'),
       (2121, 16946, 1, 'Quickly access all of your images by using our fast image searching tools.'),
       (2122, 16948, 1, 'Private Albums'),
       (2123, 16950, 1, 'Private Albums'),
       (2124, 16954, 1, 'Always On'),
       (2125, 16956, 1,
        'Access our site at any time from any location in the world. Upload while travelling or straight after a photoshoot.'),
       (2126, 16958, 1, 'Premium Access'),
       (2127, 16960, 1, 'Optional premium access for additional storage space'),
       (2128, 17479, 1, 'contact'),
       (2129, 19376, 1, 'Recent Images'),
       (2130, 17458, 1, 'Images kept for [[[DAYS]]] days.'),
       (2131, 17473, 1, 'your files'),
       (2132, 19370, 1, 'upgrade account'),
       (2133, 17476, 1, 'faq'),
       (2134, 17445, 1, 'free'),
       (2135, 17440, 1, 'Storage'),
       (2136, 17469, 1, 'to RSS Feeds'),
       (2137, 17471, 1, 'Your Account'),
       (2138, 20567, 1, 'View'),
       (2139, 17481, 1, 'rewards'),
       (2140, 17485, 1, 'English (en)'),
       (2141, 19415, 1, 'second'),
       (2142, 19416, 1, 'seconds'),
       (2143, 17459, 1, 'Upload images up to [[[MAX_UPLOAD_FILESIZE]]] in size.'),
       (2144, 20583, 1, 'Direct album downloads. No waiting.'),
       (2145, 20584, 1, 'Search files...'),
       (2146, 20585, 1, 'select subject'),
       (2147, 20586, 1, 'Site Support'),
       (2148, 20587, 1, 'Bug Report'),
       (2149, 20588, 1, 'Abuse Report'),
       (2150, 20589, 1, 'Suggest Improvements'),
       (2151, 20590, 1, 'Other'),
       (2152, 20591, 1, 'Please select your type of query.'),
       (2153, 20597, 1, 'Query type'),
       (2154, 20598, 1, 'Image Link'),
       (2155, 20599, 1, 'email'),
       (2156, 20600, 1, 'Meta'),
       (2157, 20601, 1, 'Album'),
       (2158, 20602, 1, 'Album'),
       (2159, 20603, 1, 'album, images, file, your, interface, upload, download, site'),
       (2160, 20604, 1, 'View'),
       (2161, 20605, 1, 'Album'),
       (2162, 20606, 1, 'Image'),
       (2163, 20607, 1, 'View 630803_87861202.jpg Image'),
       (2164, 20608, 1, 'image'),
       (2165, 20609, 1, 'Edit Image Info'),
       (2166, 20610, 1, 'Set As Album Cover'),
       (2167, 20611, 1, 'Cover image updated.'),
       (2168, 20612, 1, 'Cover Image:'),
       (2169, 20613, 1, 'Cover Image: (Url of the Image in Your Account)'),
       (2170, 20614, 1, 'nef'),
       (2171, 20615, 1, 'eip'),
       (2172, 20616, 1, 'arw'),
       (2173, 20617, 1, 'erf'),
       (2174, 20618, 1, 'bmp'),
       (2175, 20619, 1, 'dng'),
       (2176, 20620, 1, 'orf'),
       (2177, 20621, 1, 'cr2'),
       (2178, 20622, 1, 'crw'),
       (2179, 20623, 1, 'Images'),
       (2180, 20624, 1, 'Albums'),
       (2181, 20625, 1, 'Categories'),
       (2182, 20626, 1, 'Category Listing'),
       (2183, 20627, 1, '3fr'),
       (2184, 20628, 1, 'View on'),
       (2185, 20629, 1, 'Direct Image Link'),
       (2186, 20630, 1, 'Image Page Link'),
       (2187, 20631, 1,
        'This image is not publicly shared. You will need to make it public before the recipient can view it.'),
       (2188, 20632, 1,
        'This image is not publicly shared. You will need to make it public before the recipient can view it.'),
       (2189, 20633, 1, 'Original'),
       (2190, 20634, 1, 'Version'),
       (2191, 20635, 1, 'eps'),
       (2192, 20636, 1, 'Select All Images'),
       (2193, 20637, 1, 'selected image'),
       (2194, 20638, 1, 'selected images'),
       (2195, 20639, 1, 'clear'),
       (2196, 20640, 1, 'selected'),
       (2197, 20641, 1, 'Search Your Images'),
       (2198, 20642, 1, 'Your Images'),
       (2199, 20643, 1, 'All Images'),
       (2200, 20652, 1, 'Profile Banner Image.'),
       (2201, 20654, 1, 'Your passwords do not match.'),
       (2202, 20655, 1, 'mng'),
       (2203, 20658, 1, 'Store all of your images with us'),
       (2204, 20659, 1,
        'You can store all of your images on our powerful servers at the touch of a button at home or on the go..'),
       (2205, 20660, 1, 'Did you know..'),
       (2206, 20661, 1, 'We also offer a premium membership with lots of bonuses!'),
       (2207, 20662, 1, 'Premium Pricing'),
       (2208, 20762, 1,
        'Upload and share your images and you''ll be paid for every image viewed or downloaded on your account.'),
       (2209, 20753, 1, 'link checker'),
       (2210, 20754, 1, 'Link Checker'),
       (2211, 20755, 1, 'Check multiple download links at the same time.'),
       (2212, 20756, 1, 'link, checker, copyright, infringement, file, hosting'),
       (2213, 20757, 1, ''),
       (2214, 20758, 1, ''),
       (2215, 20759, 1,
        'Use this page to check whether multiple download links are still active. Enter up to 200 urls below, a new one on each line and click ''Check Files'''),
       (2216, 20682, 1, 'Description of the copyrighted works and supporting information'),
       (2217, 20761, 1, 'check files'),
       (2218, 20760, 1, 'List of file download urls, 1 on each line.'),
       (2219, 20685, 1, 'Please enter the url of the file you''re reporting.'),
       (2220, 20782, 1, 'Please enter 1 or more file urls.'),
       (2221, 20687, 1,
        'Found [[[TOTAL_FOUND]]] link(s), [[[TOTAL_ACTIVE]]] active and [[[TOTAL_DISABLED]]] disabled.'),
       (2222, 20688, 1, 'check more'),
       (2223, 20764, 1, 'Check multiple download links at the same time.'),
       (2224, 20765, 1, 'link, checker, copyright, infringement, file, hosting'),
       (2225, 20766, 1, ''),
       (2226, 20767, 1, ''),
       (2227, 20796, 1, 'Search or browse all publicly shared files on this site using the form below.'),
       (2228, 20784, 1, 'Enter your search term here...'),
       (2229, 20769, 1, 'List of file download urls, 1 on each line.'),
       (2230, 20770, 1, 'Filename'),
       (2231, 20771, 1, 'Filesize'),
       (2232, 20772, 1, 'Dated Uploaded'),
       (2233, 20773, 1, 'No files available in search results'),
       (2234, 20774, 1, 'Showing _START_ to _END_ of _TOTAL_ files'),
       (2235, 20787, 1, ''),
       (2236, 20776, 1, 'Show _MENU_ files'),
       (2237, 20777, 1, 'Images'),
       (2238, 20778, 1, 'Documents'),
       (2239, 20779, 1, 'Videos'),
       (2240, 20780, 1, 'Audio'),
       (2241, 20781, 1, 'Archives'),
       (2242, 20786, 1, 'Search'),
       (2243, 20801, 1, 'public files'),
       (2244, 20798, 1, 'SEARCH FILES'),
       (2245, 20816, 1, 'created'),
       (2246, 20817, 1, 'user'),
       (2247, 20818, 1, 'period'),
       (2248, 20819, 1, 'amount'),
       (2249, 20820, 1, 'status'),
       (2250, 20821, 1, 'dcr'),
       (2251, 20822, 1, 'Your Files'),
       (2252, 20823, 1, 'File Manager'),
       (2253, 20825, 1, 'File Search Results'),
       (2254, 20826, 1, 'No files found within folder or search criteria.'),
       (2255, 20827, 1, 'Recent Files'),
       (2256, 20829, 1, 'Select'),
       (2257, 20830, 1, 'Select File'),
       (2258, 20831, 1, 'Edit File Info'),
       (2259, 20832, 1, 'Download File'),
       (2260, 20833, 1, 'Download'),
       (2261, 20834, 1, 'Filesize'),
       (2262, 20835, 1, 'Search files...'),
       (2263, 20836, 1, 'Search Your Files'),
       (2264, 20837, 1, 'All Folders'),
       (2265, 20838, 1, 'Upload complete.'),
       (2266, 20839, 1, 'Enter an email address below to send the list of files via email once they''re uploaded.'),
       (2267, 20840, 1,
        'Select an album below to store these files in. All current uploads will be available within these albums.'),
       (2268, 20841, 1, 'Delete Image'),
       (2269, 20842, 1, 'Image Stats'),
       (2270, 20843, 1, 'Image Page Link'),
       (2271, 20844, 1, 'Folder:'),
       (2272, 20846, 1, 'your folder'),
       (2273, 20847, 1, 'file folder'),
       (2274, 20848, 1,
        'File is not publicly shared. Please contact the owner and request they update the privacy settings.'),
       (2275, 20849, 1, 'Add Sub Folder'),
       (2276, 20850, 1, 'package type'),
       (2277, 20851, 1, 'download allowance'),
       (2278, 20852, 1, 'Please specify the download limit for this price.'),
       (2279, 20853, 1, 'remaining download allowance'),
       (2280, 20854, 1, 'Folder'),
       (2281, 20855, 1, 'View'),
       (2282, 20856, 1, 'Folder'),
       (2283, 20857, 1, 'folder, images, file, your, interface, upload, download, site'),
       (2284, 20858, 1, 'your folders'),
       (2285, 20859, 1,
        'Select an folder below to store these files in. All current uploads will be available within these folders.'),
       (2286, 20860, 1, 'The folder password is invalid'),
       (2287, 20861, 1, 'There was a problem accessing the folder, please try again later.'),
       (2288, 20862, 1, 'Set As Folder Cover'),
       (2289, 20863, 1,
        'No files found within this folder. Drag & drop files to upload here or click ''Upload'' above.'),
       (2290, 20864, 1, 'Cover Image: (Url of the Image in Your Account)'),
       (2291, 20865, 1, 'Folder Privacy:'),
       (2292, 20866, 1,
        'This file is not publicly shared. You will need to make it public before the recipient can view it.'),
       (2293, 20867, 1, 'No files found within this folder.'),
       (2294, 20868, 1, 'registered user'),
       (2295, 20869, 1, 'Search Folders'),
       (2296, 20870, 1, 'Search your files...'),
       (2297, 20871, 1, 'Default Folder Privacy'),
       (2298, 20872, 1, 'Downloads'),
       (2299, 20873, 1, 'Download Zip File'),
       (2300, 20874, 1, 'Share On:'),
       (2301, 20877, 1, 'Share On'),
       (2302, 20878, 1, 'Send via Email:'),
       (2303, 20880, 1, 'send'),
       (2304, 20881, 1, 'Folder shared by [[[SHARED_BY_NAME]]] on [[[SITE_NAME]]]'),
       (2305, 20882, 1,
        '[[[SHARED_BY_NAME]]] has shared the following file with you via <a href=''[[[WEB_ROOT]]]''>[[[SITE_NAME]]]</a>:<br/><br/><strong>Folder Name:</strong> [[[FOLDER_NAME]]]<br/><strong>View:</strong> [[[FOLDER_URL]]]<br/><strong>From:</strong> [[[SHARED_BY_NAME]]] [[[SHARED_EMAIL_ADDRESS]]]<br/><strong>Message:</strong><br/>[[[EXTRA_MESSAGE]]]<br/><br/>Feel free to contact us if you have any difficulties viewing the folder.<br/><br/>Regards,<br/>[[[SITE_NAME]]] Admin'),
       (2306, 20884, 1, 'Folder shared via email to [[[RECIPIENT_EMAIL_ADDRESS]]]'),
       (2307, 20885, 1, 'Create Copy'),
       (2308, 20886, 1, 'Copy Url to Clipboard'),
       (2309, 20887, 1, 'Copy Url(s) to Clipboard'),
       (2310, 20888, 1, 'Admin Area'),
       (2311, 20891, 1, 'Drag & drop files or click here to upload'),
       (2312, 20892, 1, '- Document can not be previewed as it is too big. Please download the file to view it.'),
       (2313, 20893, 1, 'safari'),
       (2314, 20894, 1, 'Clear Selected'),
       (2315, 20895, 1,
        'Note: You can not update this folder privacy settings as your account settings are set to make all files private, or the parent folder is set to private.');

-- --------------------------------------------------------

--
-- Table structure for table `language_key`
--

CREATE TABLE IF NOT EXISTS `language_key`
(
    `id` int
(
    11
) NOT NULL AUTO_INCREMENT,
    `languageKey` varchar
(
    255
) NOT NULL,
    `defaultContent` text NOT NULL,
    `isAdminArea` int
(
    1
) NOT NULL DEFAULT '0',
    `foundOnScan` int
(
    1
) NOT NULL DEFAULT '0',
    PRIMARY KEY
(
    `id`
),
    UNIQUE KEY `languageKey`
(
    `languageKey`
)
    ) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=20896;

--
-- Dumping data for table `language_key`
--

INSERT INTO `language_key` (`id`, `languageKey`, `defaultContent`, `isAdminArea`, `foundOnScan`)
VALUES (1, 'home', 'home', 1, 0),
       (3, 'banned_words_urls', 'banned words / urls', 1, 0),
       (4, 'admin_users', 'admin users', 1, 0),
       (5, 'banned_ips', 'banned ips', 1, 0),
       (6, 'site_settings', 'site settings', 1, 0),
       (7, 'languages', 'languages', 1, 0),
       (8, 'logout', 'logout', 1, 1),
       (9, 'language_details', 'Language Details', 1, 0),
       (10, 'are_you_sure_you_want_to_remove_this_ip_ban', 'Are you sure you want to remove this IP ban?', 1, 0),
       (11, 'are_you_sure_update_user_status', 'Are you sure you want to update the status of this user?', 1, 0),
       (12, 'view', 'view', 1, 0),
       (13, 'disable', 'disable', 1, 0),
       (14, 'enable', 'enable', 1, 0),
       (15, 'are_you_sure_remove_banned_word', 'Are you sure you want to remove this banned word?', 1, 0),
       (16, 'ip_address_invalid_try_again', 'IP address appears to be invalid, please try again.', 1, 0),
       (17, 'ip_address_already_blocked', 'IP address is already in the blocked list.', 1, 0),
       (18, 'error_problem_record', 'There was a problem inserting/updating the record, please try again later.', 1, 0),
       (19, 'banned_word_already_in_list', 'Banned word is already in the list.', 1, 0),
       (20, 'language_already_in_system', 'Language already in the system.', 1, 0),
       (21, 'username_length_invalid', 'Username must be between 6-16 characters long.', 1, 0),
       (22, 'password_length_invalid', 'Password must be between 6-16 characters long.', 1, 0),
       (23, 'enter_first_name', 'Please enter the firstname.', 1, 0),
       (24, 'enter_last_name', 'Please enter the lastname.', 1, 0),
       (25, 'enter_email_address', 'Please enter the email address.', 1, 0),
       (26, 'entered_email_address_invalid', 'The email address you entered appears to be invalid.', 1, 0),
       (17482, 'copyright', 'copyright', 0, 0),
       (28, 'support', 'Support', 1, 0),
       (30, 'admin_panel', 'Admin Panel', 1, 0),
       (31, 'logged_in_as', 'Logged in as', 1, 0),
       (32, 'banned_ips_intro',
        'To ban an IP Address <a href="#" onClick="displayBannedIpPopup(); return false;">click here</a> or delete any existing ones below',
        1, 0),
       (33, 'banned_ips_add_banned_ip', 'Add banned IP address', 1, 0),
       (34, 'remove', 'remove', 1, 0),
       (35, 'ip_address', 'IP Address', 1, 0),
       (36, 'ban_from', 'Ban From', 1, 0),
       (37, 'notes', 'Notes', 1, 0),
       (38, 'add_banned_ip', 'Add Banned IP', 1, 0),
       (39, 'error_submitting_form', 'There was an error submitting the form, please try again later.', 1, 0),
       (40, 'enter_ip_address_details', 'Enter IP Address details', 1, 0),
       (41, 'banned_terms_intro',
        'To ban an word within the original url <a href="#" onClick="displayBannedWordsPopup(); return false;">click here</a> or delete any existing ones below',
        1, 0),
       (42, 'add_banned_term', 'Add banned word', 1, 0),
       (43, 'banned_term', 'Banned Word', 1, 0),
       (44, 'date_banned', 'Date Banned', 1, 0),
       (45, 'ban_notes', 'Ban Notes', 1, 0),
       (46, 'action', 'Action', 1, 1),
       (47, 'enter_banned_term_details', 'Enter Banned Word details', 1, 0),
       (48, 'dashboard_intro',
        'Use the main navigation above to manage this site. A quick overview of the site can be seen below', 1, 0),
       (49, 'dashboard_graph_last_14_days_title', 'New Files (last 14 days)', 1, 0),
       (50, 'dashboard_graph_last_12_months_title', 'New Files (last 12 months)', 1, 0),
       (51, 'urls', 'Urls', 1, 0),
       (52, 'active', 'active', 1, 0),
       (53, 'disabled', 'disabled', 1, 0),
       (54, 'spam', 'spam', 1, 0),
       (55, 'expired', 'expired', 1, 0),
       (56, 'dashboard_total_active_urls', 'Total active files', 1, 0),
       (57, 'dashboard_total_disabled_urls', 'Total disabled files', 1, 0),
       (58, 'dashboard_total_visits_to_all_urls', 'Total downloads to all files', 1, 0),
       (59, 'item_name', 'Item Name', 1, 0),
       (60, 'value', 'Value', 1, 0),
       (61, 'manage_languages_intro_2',
        'Manage the available content for the selected language. Click on any of the ''Translated Content'' cells to edit the value.',
        1, 0),
       (62, 'manage_languages_intro_1',
        'Select a language to manage or <a href=''#'' onClick=''displayAddLanguagePopup(); return false;''>add a new one here</a>. NOTE Once translated, to set the site default language go to the <a href=''settings.php''>site settings</a> area.',
        1, 0),
       (63, 'language_key', 'Language Key', 1, 0),
       (64, 'default_content', 'Default Content', 1, 0),
       (65, 'translated_content', 'Translated Content', 1, 0),
       (66, 'no_changes_in_demo_mode', 'Error Changes to this section can not be made within demo mode.', 1, 0),
       (67, 'manage_other_languages', 'Manage other languages', 1, 0),
       (68, 'no_available_content', 'There is no available content.', 1, 0),
       (69, 'select_language', 'select language', 1, 0),
       (70, 'add_language', 'Add Language', 1, 0),
       (71, 'language_name', 'Language Name', 1, 0),
       (72, 'settings_intro', 'Click on any of the items within the "Config Value" column below to edit', 1, 0),
       (73, 'group', 'Group', 1, 1),
       (74, 'config_description', 'Config Description', 1, 0),
       (75, 'config_value', 'Config Value', 1, 0),
       (76, 'shorturls_filter_results', 'Filter results', 1, 0),
       (77, 'user_management_intro',
        'Double click on any of the users below to edit the account information or <a href="#" onClick="displayUserPopup(); return false;">click here to add a new user</a>',
        1, 0),
       (78, 'add_new_user', 'Add new user', 1, 0),
       (79, 'username', 'Username', 1, 1),
       (19498, 'email_address', 'Email Address', 0, 0),
       (17447, 'account_type', 'account type', 0, 0),
       (82, 'last_login', 'Last Login', 1, 0),
       (17446, 'account_status', 'account status', 0, 0),
       (84, 'password', 'Password', 1, 1),
       (85, 'title', 'Title', 1, 1),
       (86, 'firstname', 'Firstname', 1, 1),
       (87, 'lastname', 'Lastname', 1, 1),
       (88, 'enter_user_details', 'Enter user details', 1, 0),
       (17487, 'test', 'test', 0, 0),
       (515, 'main_navigation', 'Main Navigation', 0, 1),
       (19411, 'uploader_hour', 'hour', 0, 0),
       (1427, 'dat', 'dat', 1, 0),
       (617, 'fast_and_instant_downloading', 'Fast and instant downloading!', 0, 1),
       (618, 'our_premium_members_benefit_from_no_waiting_time_and_direct',
        'Our premium members benefit from no waiting time and direct downloads for all of their files. Unlike other file hosts we don''t limit the transfer speed of our downloads.',
        0, 1),
       (616, 'we_supply_you_with_all_the_tools_necessary_to_easily_share',
        'We supply you with all the tools necessary to easily share your files. Use our pre-generated html code to link from your website or post directly to Facebook or Twitter.',
        0, 1),
       (1429, 'settings_statistics_public', 'Publicly Accessible (using ~s on url)', 0, 0),
       (108, 'please_wait', 'please wait', 0, 1),
       (109, 'general_site_error', 'There was a general site error, please try again later.', 0, 1),
       (110, 'error', 'Error', 0, 1),
       (615, 'share_your_files_with_everyone', 'Share your files with everyone!', 0, 1),
       (603, 'could_not_load_server', 'Could not load server details.', 0, 0),
       (604, 'ftp_host', 'FTP Host', 1, 0),
       (605, 'ftp_port', 'FTP Port', 1, 0),
       (606, 'server_ftp_host_invalid', 'Please specify the server ftp host.', 0, 0),
       (607, 'files_filter_server', 'By File Server', 0, 0),
       (608, 'view_files', 'view files', 0, 0),
       (609, 'files_filter_user', 'By User', 0, 0),
       (19364, 'admin_area', 'ADMIN AREA', 0, 0),
       (611, 'system expired', 'system expired', 0, 0),
       (612, 'upload_share_and_manage_your_files_for_free', 'Upload, share and manage your files for free.', 0, 1),
       (613, 'store_and_manage_all_your_files', 'Store and manage all your files!', 0, 1),
       (614, 'upload_multiple_files_at_once_and_keep_them',
        'Upload multiple files at once and keep them forever on this site. If you''re using FireFox or Chrome, you can simply drag &amp; drop your files to begin uploading.',
        0, 1),
       (567, 'error_meta_keywords', 'error, file, upload, script', 0, 1),
       (568, 'choose_free_or_premium_download', 'Choose free or premium download', 0, 1),
       (569, 'slow_download', 'slow download', 0, 1),
       (570, 'wait', 'wait', 0, 1),
       (571, 'sec', 'sec', 0, 1),
       (572, 'fast_instant_download', 'FAST INSTANT DOWNLOAD', 0, 1),
       (573, 'download_type', 'download type', 0, 1),
       (575, 'download_speed', 'download speed', 0, 1),
       (576, 'maximum', 'maximum', 0, 1),
       (577, 'waiting_time', 'waiting time', 0, 1),
       (578, 'seconds', 'seconds', 0, 1),
       (579, 'instant', 'instant', 0, 1),
       (580, 'site_advertising', 'site advertising', 0, 1),
       (581, 'yes', 'yes', 0, 1),
       (582, 'none', 'none', 0, 1),
       (583, 'how_long_to_keep_files', 'how long to keep files', 0, 1),
       (584, 'forever', 'forever', 0, 1),
       (585, 'maximum_file_upload_size', 'Maximum file upload size', 0, 1),
       (586, 'interface_to_manage_uploaded_files', 'interface to manage uploaded files', 0, 1),
       (587, 'not_available', 'not available', 0, 1),
       (588, 'available', 'available', 0, 1),
       (589, 'fast_download_even_when_servers_are_busy', 'fast download even when servers are busy', 0, 1),
       (1849, 'file_download_title_page_description_left', '', 0, 0),
       (561, 'stats_meta_description', 'Uploaded file statistics', 0, 1),
       (562, 'stats_meta_keywords', 'stats, statistics, unique, visitors, hits, file, upload', 0, 1),
       (563, 'upgrade_now_for_instant_access', 'upgrade now for instant access', 0, 0),
       (564, 'downloading', 'downloading', 0, 0),
       (565, 'error_page_name', 'Error', 0, 1),
       (566, 'error_meta_description', 'Error', 0, 1),
       (552, 'please_enter_your_lastname', 'Please enter your lastname', 0, 1),
       (553, 'report_abuse_page_name', 'Report Abuse', 0, 1),
       (554, 'report_abuse_meta_description', 'Report Abuse or Copyright Infringement', 0, 1),
       (555, 'report_abuse_meta_keywords', 'report, abuse, copyright, infringement, file, hosting', 0, 1),
       (556, 'report_abuse_intro',
        'Please use the following form to report any copyright infringements ensuring you supply all the following information<br/><br/>\n<ul class=''formattedList''>\n<li>A physical or electronic signature of the copyright owner or the person authorized to act on its behalf;</li>\n<li>A description of the copyrighted work claimed to have been infringed;</li>\n<li>A description of the infringing material and information reasonably sufficient to permit File Upload Script to locate the material;</li>\n<li>Your contact information, including your address, telephone number, and email;</li>\n<li>A statement by you that you have a good faith belief that use of the material in the manner complained of is not authorized by the copyright owner, its agent, or the law; and</li>\n<li>A statement that the information in the notification is accurate, and, under the pains and penalties of perjury, that you are authorized to act on behalf of the copyright owner.</li>\n</ul>',
        0, 0),
       (557, 'submit_report', 'submit report', 0, 1),
       (558, 'optional_account_expiry', 'Paid Expiry Y-m-d (optional)', 0, 0),
       (559, 'account_expiry_invalid', 'Account expiry date is invalid. It should be in the format YYYY-mm-dd', 1, 0),
       (153, 'visits_', 'visits', 0, 0),
       (154, 'created_', 'created', 0, 0),
       (155, 'visitors', 'Visitors', 0, 1),
       (156, 'countries', 'Countries', 0, 1),
       (157, 'top_referrers', 'Top Referrers', 0, 1),
       (158, 'browsers', 'Browsers', 0, 1),
       (159, 'operating_systems', 'Operating Systems', 0, 1),
       (160, 'last_24_hours', 'last 24 hours', 0, 1),
       (161, 'last_7_days', 'last 7 days', 0, 1),
       (162, 'last_30_days', 'last 30 days', 0, 1),
       (163, 'last_12_months', 'last 12 months', 0, 1),
       (164, 'hour', 'Hour', 0, 0),
       (165, 'visits', 'Visits', 0, 0),
       (166, 'date', 'Date', 0, 1),
       (167, 'total_visits', 'Total visits', 0, 0),
       (168, 'percentage', 'Percentage', 0, 1),
       (169, 'day', 'Day', 0, 0),
       (170, 'month', 'Month', 0, 1),
       (171, 'country', 'Country', 0, 1),
       (172, 'site', 'Site', 0, 1),
       (173, 'browser', 'Browser', 0, 1),
       (174, 'operating_system', 'Operating System', 0, 1),
       (175, 'AD', 'Andorra', 0, 0),
       (176, 'AE', 'United Arab Emirates', 0, 0),
       (177, 'AF', 'Afghanistan', 0, 0),
       (178, 'AG', 'Antigua And Barbuda', 0, 0),
       (179, 'AI', 'Anguilla', 0, 0),
       (180, 'AL', 'Albania', 0, 0),
       (181, 'AM', 'Armenia', 0, 0),
       (182, 'AN', 'Netherlands Antilles', 0, 0),
       (183, 'AO', 'Angola', 0, 0),
       (184, 'AQ', 'Antarctica', 0, 0),
       (185, 'AR', 'Argentina', 0, 0),
       (186, 'AS', 'American Samoa', 0, 0),
       (187, 'AT', 'Austria', 0, 0),
       (188, 'AU', 'Australia', 0, 0),
       (189, 'AW', 'Aruba', 0, 0),
       (190, 'AZ', 'Azerbaijan', 0, 0),
       (191, 'BA', 'Bosnia And Herzegovina', 0, 0),
       (192, 'BB', 'Barbados', 0, 0),
       (193, 'BD', 'Bangladesh', 0, 0),
       (194, 'BE', 'Belgium', 0, 0),
       (195, 'BF', 'Burkina Faso', 0, 0),
       (196, 'BG', 'Bulgaria', 0, 0),
       (197, 'BH', 'Bahrain', 0, 0),
       (198, 'BI', 'Burundi', 0, 0),
       (199, 'BJ', 'Benin', 0, 0),
       (200, 'BM', 'Bermuda', 0, 0),
       (201, 'BN', 'Brunei Darussalam', 0, 0),
       (202, 'BO', 'Bolivia', 0, 0),
       (203, 'BR', 'Brazil', 0, 0),
       (204, 'BS', 'Bahamas', 0, 0),
       (205, 'BT', 'Bhutan', 0, 0),
       (206, 'BW', 'Botswana', 0, 0),
       (207, 'BY', 'Belarus', 0, 0),
       (208, 'BZ', 'Belize', 0, 0),
       (209, 'CA', 'Canada', 0, 0),
       (210, 'CD', 'The Democratic Republic Of The Congo', 0, 0),
       (211, 'CF', 'Central African Republic', 0, 0),
       (212, 'CG', 'Congo', 0, 0),
       (213, 'CH', 'Switzerland', 0, 0),
       (214, 'CI', 'Cote Divoire', 0, 0),
       (215, 'CK', 'Cook Islands', 0, 0),
       (216, 'CL', 'Chile', 0, 0),
       (217, 'CM', 'Cameroon', 0, 0),
       (218, 'CN', 'China', 0, 0),
       (219, 'CO', 'Colombia', 0, 0),
       (220, 'CR', 'Costa Rica', 0, 0),
       (221, 'CS', 'Serbia And Montenegro', 0, 0),
       (222, 'CU', 'Cuba', 0, 0),
       (223, 'CV', 'Cape Verde', 0, 0),
       (224, 'CY', 'Cyprus', 0, 0),
       (225, 'CZ', 'Czech Republic', 0, 0),
       (226, 'DE', 'Germany', 0, 0),
       (227, 'DJ', 'Djibouti', 0, 0),
       (228, 'DK', 'Denmark', 0, 0),
       (229, 'DM', 'Dominica', 0, 0),
       (230, 'DO', 'Dominican Republic', 0, 0),
       (231, 'DZ', 'Algeria', 0, 0),
       (232, 'EC', 'Ecuador', 0, 0),
       (233, 'EE', 'Estonia', 0, 0),
       (234, 'EG', 'Egypt', 0, 0),
       (235, 'ER', 'Eritrea', 0, 0),
       (236, 'ES', 'Spain', 0, 0),
       (237, 'ET', 'Ethiopia', 0, 0),
       (238, 'EU', 'European Union', 0, 0),
       (239, 'FI', 'Finland', 0, 0),
       (240, 'FJ', 'Fiji', 0, 0),
       (241, 'FK', 'Falkland Islands (Malvinas)', 0, 0),
       (242, 'FM', 'Federated States Of Micronesia', 0, 0),
       (243, 'FO', 'Faroe Islands', 0, 0),
       (244, 'FR', 'France', 0, 0),
       (245, 'GA', 'Gabon', 0, 0),
       (246, 'GB', 'United Kingdom', 0, 0),
       (247, 'GD', 'Grenada', 0, 0),
       (248, 'GE', 'Georgia', 0, 0),
       (249, 'GF', 'French Guiana', 0, 0),
       (250, 'GH', 'Ghana', 0, 0),
       (251, 'GI', 'Gibraltar', 0, 0),
       (252, 'GL', 'Greenland', 0, 0),
       (253, 'GM', 'Gambia', 0, 0),
       (254, 'GN', 'Guinea', 0, 0),
       (255, 'GP', 'Guadeloupe', 0, 0),
       (256, 'GQ', 'Equatorial Guinea', 0, 0),
       (257, 'GR', 'Greece', 0, 0),
       (258, 'GS', 'South Georgia And The South Sandwich Islands', 0, 0),
       (259, 'GT', 'Guatemala', 0, 0),
       (260, 'GU', 'Guam', 0, 0),
       (261, 'GW', 'Guinea-Bissau', 0, 0),
       (262, 'GY', 'Guyana', 0, 0),
       (263, 'HK', 'Hong Kong', 0, 0),
       (264, 'HN', 'Honduras', 0, 0),
       (265, 'HR', 'Croatia', 0, 0),
       (266, 'HT', 'Haiti', 0, 0),
       (267, 'HU', 'Hungary', 0, 0),
       (268, 'ID', 'Indonesia', 0, 0),
       (269, 'IE', 'Ireland', 0, 0),
       (270, 'IL', 'Israel', 0, 0),
       (271, 'IN', 'India', 0, 0),
       (272, 'IO', 'British Indian Ocean Territory', 0, 0),
       (273, 'IQ', 'Iraq', 0, 0),
       (274, 'IR', 'Islamic Republic Of Iran', 0, 0),
       (275, 'IS', 'Iceland', 0, 0),
       (276, 'IT', 'Italy', 0, 0),
       (277, 'JM', 'Jamaica', 0, 0),
       (278, 'JO', 'Jordan', 0, 0),
       (279, 'JP', 'Japan', 0, 0),
       (280, 'KE', 'Kenya', 0, 0),
       (281, 'KG', 'Kyrgyzstan', 0, 0),
       (282, 'KH', 'Cambodia', 0, 0),
       (283, 'KI', 'Kiribati', 0, 0),
       (284, 'KM', 'Comoros', 0, 0),
       (285, 'KN', 'Saint Kitts And Nevis', 0, 0),
       (286, 'KR', 'Republic Of Korea', 0, 0),
       (287, 'KW', 'Kuwait', 0, 0),
       (288, 'KY', 'Cayman Islands', 0, 0),
       (289, 'KZ', 'Kazakhstan', 0, 0),
       (290, 'LA', 'Lao Peoples Democratic Republic', 0, 0),
       (291, 'LB', 'Lebanon', 0, 0),
       (292, 'LC', 'Saint Lucia', 0, 0),
       (293, 'LI', 'Liechtenstein', 0, 0),
       (294, 'LK', 'Sri Lanka', 0, 0),
       (295, 'LR', 'Liberia', 0, 0),
       (296, 'LS', 'Lesotho', 0, 0),
       (297, 'LT', 'Lithuania', 0, 0),
       (298, 'LU', 'Luxembourg', 0, 0),
       (299, 'LV', 'Latvia', 0, 0),
       (300, 'LY', 'Libyan Arab Jamahiriya', 0, 0),
       (301, 'MA', 'Morocco', 0, 0),
       (302, 'MC', 'Monaco', 0, 0),
       (303, 'MD', 'Republic Of Moldova', 0, 0),
       (304, 'MG', 'Madagascar', 0, 0),
       (305, 'MH', 'Marshall Islands', 0, 0),
       (306, 'MK', 'The Former Yugoslav Republic Of Macedonia', 0, 0),
       (307, 'ML', 'Mali', 0, 0),
       (308, 'MM', 'Myanmar', 0, 0),
       (309, 'MN', 'Mongolia', 0, 0),
       (310, 'MO', 'Macao', 0, 0),
       (311, 'MP', 'Northern Mariana Islands', 0, 0),
       (312, 'MQ', 'Martinique', 0, 0),
       (313, 'MR', 'Mauritania', 0, 0),
       (314, 'MT', 'Malta', 0, 0),
       (315, 'MU', 'Mauritius', 0, 0),
       (316, 'MV', 'Maldives', 0, 0),
       (317, 'MW', 'Malawi', 0, 0),
       (318, 'MX', 'Mexico', 0, 0),
       (319, 'MY', 'Malaysia', 0, 0),
       (320, 'MZ', 'Mozambique', 0, 0),
       (321, 'NA', 'Namibia', 0, 0),
       (322, 'NC', 'New Caledonia', 0, 0),
       (323, 'NE', 'Niger', 0, 0),
       (324, 'NF', 'Norfolk Island', 0, 0),
       (325, 'NG', 'Nigeria', 0, 0),
       (326, 'NI', 'Nicaragua', 0, 0),
       (327, 'NL', 'Netherlands', 0, 0),
       (328, 'NO', 'Norway', 0, 0),
       (329, 'NP', 'Nepal', 0, 0),
       (330, 'NR', 'Nauru', 0, 0),
       (331, 'NU', 'Niue', 0, 0),
       (332, 'NZ', 'New Zealand', 0, 0),
       (333, 'OM', 'Oman', 0, 0),
       (334, 'PA', 'Panama', 0, 0),
       (335, 'PE', 'Peru', 0, 0),
       (336, 'PF', 'French Polynesia', 0, 0),
       (337, 'PG', 'Papua New Guinea', 0, 0),
       (338, 'PH', 'Philippines', 0, 0),
       (339, 'PK', 'Pakistan', 0, 0),
       (340, 'PL', 'Poland', 0, 0),
       (341, 'PR', 'Puerto Rico', 0, 0),
       (342, 'PS', 'Palestinian Territory', 0, 0),
       (343, 'PT', 'Portugal', 0, 0),
       (344, 'PW', 'Palau', 0, 0),
       (345, 'PY', 'Paraguay', 0, 0),
       (346, 'QA', 'Qatar', 0, 0),
       (347, 'RE', 'Reunion', 0, 0),
       (348, 'RO', 'Romania', 0, 0),
       (349, 'RU', 'Russian Federation', 0, 0),
       (350, 'RW', 'Rwanda', 0, 0),
       (351, 'SA', 'Saudi Arabia', 0, 0),
       (352, 'SB', 'Solomon Islands', 0, 0),
       (353, 'SC', 'Seychelles', 0, 0),
       (354, 'SD', 'Sudan', 0, 0),
       (355, 'SE', 'Sweden', 0, 0),
       (356, 'SG', 'Singapore', 0, 0),
       (357, 'SI', 'Slovenia', 0, 0),
       (358, 'SK', 'Slovakia (Slovak Republic)', 0, 0),
       (359, 'SL', 'Sierra Leone', 0, 0),
       (360, 'SM', 'San Marino', 0, 0),
       (361, 'SN', 'Senegal', 0, 0),
       (362, 'SO', 'Somalia', 0, 0),
       (363, 'SR', 'Suriname', 0, 0),
       (364, 'ST', 'Sao Tome And Principe', 0, 0),
       (365, 'SV', 'El Salvador', 0, 0),
       (366, 'SY', 'Syrian Arab Republic', 0, 0),
       (367, 'SZ', 'Swaziland', 0, 0),
       (368, 'TD', 'Chad', 0, 0),
       (369, 'TF', 'French Southern Territories', 0, 0),
       (370, 'TG', 'Togo', 0, 0),
       (371, 'TH', 'Thailand', 0, 0),
       (372, 'TJ', 'Tajikistan', 0, 0),
       (373, 'TK', 'Tokelau', 0, 0),
       (374, 'TL', 'Timor-Leste', 0, 0),
       (375, 'TM', 'Turkmenistan', 0, 0),
       (376, 'TN', 'Tunisia', 0, 0),
       (377, 'TO', 'Tonga', 0, 0),
       (378, 'TR', 'Turkey', 0, 0),
       (379, 'TT', 'Trinidad And Tobago', 0, 0),
       (380, 'TV', 'Tuvalu', 0, 0),
       (381, 'TW', 'Taiwan Province Of China', 0, 0),
       (382, 'TZ', 'United Republic Of Tanzania', 0, 0),
       (383, 'UA', 'Ukraine', 0, 0),
       (384, 'UG', 'Uganda', 0, 0),
       (385, 'US', 'United States', 0, 0),
       (386, 'UY', 'Uruguay', 0, 0),
       (387, 'UZ', 'Uzbekistan', 0, 0),
       (388, 'VA', 'Holy See (Vatican City State)', 0, 0),
       (389, 'VC', 'Saint Vincent And The Grenadines', 0, 0),
       (390, 'VE', 'Venezuela', 0, 0),
       (391, 'VG', 'Virgin Islands', 0, 0),
       (392, 'VI', 'Virgin Islands', 0, 0),
       (393, 'VN', 'Viet Nam', 0, 0),
       (394, 'VU', 'Vanuatu', 0, 0),
       (395, 'WS', 'Samoa', 0, 0),
       (396, 'YE', 'Yemen', 0, 0),
       (397, 'YT', 'Mayotte', 0, 0),
       (398, 'YU', 'Serbia And Montenegro (Formally Yugoslavia)', 0, 0),
       (399, 'ZA', 'South Africa', 0, 0),
       (400, 'ZM', 'Zambia', 0, 0),
       (401, 'ZW', 'Zimbabwe', 0, 0),
       (402, 'ZZ', 'Unknown', 0, 0),
       (17403, 'home_category_art', 'Art', 0, 0),
       (410, 'register_complete_page_name', 'Registration completed', 0, 1),
       (411, 'register_complete_meta_description', 'Your registration has been completed.', 0, 1),
       (412, 'register_complete_meta_keywords', 'registration, completed, file, hosting, site', 0, 1),
       (413, 'register_complete_sub_title', 'Thank you for registering!', 0, 0),
       (414, 'register_complete_main_text',
        'We''ve sent an email to your registered email address with your access password. Please check your spam filters to ensure emails from this site get through. ',
        0, 0),
       (415, 'register_complete_email_from', 'Emails from this site are sent from ', 0, 1),
       (416, 'login_page_name', 'Login', 0, 1),
       (417, 'login_meta_description', 'Login to your account', 0, 1),
       (418, 'login_meta_keywords', 'login, register, short url', 0, 1),
       (419, 'username_and_password_is_invalid', 'Your username and password are invalid', 0, 1),
       (420, 'account_login', 'Account Login', 0, 0),
       (421, 'login_intro_text', 'Please enter your username and password below to login.', 0, 1),
       (422, 'username_requirements', 'Your account username. 6 characters or more and alpha numeric.', 0, 0),
       (423, 'password_requirements', 'Your account password. Min 6 characters, alpha numeric, no spaces.', 0, 0),
       (551, 'click_here_to_browse_your_files', 'Click here to browse your files...', 0, 1),
       (16601, 'index_meta_keywords',
        'share, track, image, picture, pic, img, hosting, sharing, upload, storage, site, website', 0, 0),
       (550, 'please_enter_your_firstname', 'Please enter your firstname', 0, 1),
       (428, 'please_enter_your_username', 'Please enter your username', 0, 1),
       (17594, 'account_home_page_name', 'Account Home', 0, 0),
       (17595, 'account_home_meta_description', 'Your Account Home', 0, 0),
       (20578, 'next', 'next', 0, 0),
       (434, 'faq_page_name', 'FAQ', 0, 1),
       (435, 'faq_meta_description', 'Frequently Asked Questions', 0, 1),
       (436, 'faq_meta_keywords', 'faq, frequently, asked, questions, file, hosting, site', 0, 1),
       (437, 'please_enter_your_password', 'Please enter your password', 0, 1),
       (590, 'estimated_download_time', 'estimated Download time', 0, 1),
       (511, 'report_abuse', 'Report Abuse', 0, 0),
       (441, 'register_account', 'Register Account', 0, 0),
       (19369, 'file_manager_account_settings', 'Account Settings', 0, 0),
       (16599, 'index_meta_description', 'Upload, share, track, manage your images in one simple to use image host.', 0,
        0),
       (1428, 'file_statistics', 'File Statistics', 0, 1),
       (446, 'info', 'info', 0, 1),
       (447, 'email_address_confirm', 'Email Confirm', 0, 1),
       (19413, 'uploader_minute', 'minute', 0, 0),
       (449, 'created_last_visited', 'Created/Last Visited', 0, 0),
       (450, 'status', 'Status', 0, 1),
       (19478, 'options', 'options', 0, 0),
       (17472, 'upload_file', 'upload file', 0, 0),
       (453, 'register_page_name', 'Register', 0, 1),
       (454, 'register_meta_description', 'Register for an account', 0, 1),
       (455, 'register_meta_keywords', 'register, account, short, url, user', 0, 1),
       (17483, 'created_by', 'created by ', 0, 0),
       (457, 'error_file_has_been_removed_by_user', 'File has been removed.', 0, 1),
       (18639, 'uploaded', 'uploaded', 0, 0),
       (459, 'downloads', 'downloads', 0, 1),
       (460, 'download_now', 'download now', 0, 1),
       (461, 'loading_file_please_wait', 'loading file, please wait', 0, 0),
       (462, 'file_download_title', 'Download File', 0, 0),
       (463, 'file_download_description', 'Download file', 0, 1),
       (464, 'file_download_keywords', 'download, file, upload, mp3, avi, zip', 0, 1),
       (465, 'your_recent_files', 'Your Files', 0, 1),
       (466, 'download_url', 'Download Url', 0, 1),
       (467, 'uploaded_last_visited', 'Uploaded/Last Visited', 0, 0),
       (468, 'download_url_filename', 'Download Url/Filename', 0, 1),
       (469, 'dashboard_total_active_files', 'Total Active Files', 0, 0),
       (470, 'dashboard_total_disabled_files', 'Total Inactive Files', 0, 0),
       (471, 'dashboard_total_downloads_to_all', 'Total Downloads', 0, 0),
       (472, 'user removed', 'user removed', 0, 0),
       (473, 'files', 'files', 0, 1),
       (474, 'manage_files', 'Manage Files', 0, 0),
       (475, 'files_filter_results', 'Filter Results', 0, 0),
       (476, 'files_filter_disabled', 'Show Disabled', 0, 0),
       (477, 'export_files_as_csv', 'Export File Data', 0, 0),
       (478, 'error_file_has_been_removed_by_admin', 'File has been removed by the site administrator.', 0, 1),
       (479, 'files_filter_removed', 'Show Removed', 0, 0),
       (480, 'admin removed', 'admin removed', 0, 0),
       (481, 'delete_file_page_name', 'Delete File', 0, 1),
       (482, 'delete_file_meta_description', 'Delete File', 0, 1),
       (483, 'delete_file_meta_keywords', 'delete, remove, file', 0, 1),
       (484, 'delete_file', 'Delete File', 0, 1),
       (485, 'delete_file_intro', 'Please confirm whether to delete the file below.', 0, 0),
       (486, 'cancel', 'Cancel', 0, 1),
       (17488, 'switch_site_language_to', 'Switch site language to', 0, 0),
       (20574, 'class_file_download', 'Download', 0, 0),
       (489, 'terms_page_name', 'Terms and Conditions', 0, 1),
       (490, 'terms_meta_description', 'Terms and Conditions', 0, 1),
       (491, 'terms_meta_keywords', 'terms, and, conditions, file, hosting, site', 0, 1),
       (19374, 'image_manager', 'Image Manager', 0, 0),
       (493, 'upgrade_page_name', 'Extend Account', 0, 0),
       (494, 'upgrade_meta_description', 'Extend Your Account', 0, 1),
       (496, 'payment_complete_page_name', 'Payment Complete', 0, 1),
       (497, 'payment_complete_meta_description', 'Payment Complete', 0, 1),
       (498, 'payment_complete_meta_keywords', 'payment, complete, file, hosting, site', 0, 1),
       (499, 'premium_account_benefits', 'premium account benefits', 0, 0),
       (17451, 'account_benefits', 'account benefits', 0, 0),
       (501, 'file_information_page_name', ' Information', 0, 0),
       (502, 'file_information_description', 'Information about ', 0, 1),
       (503, 'file_information_meta_keywords', ', share, information, file, upload, download, site', 0, 1),
       (504, 'download_urls', 'download urls', 0, 1),
       (505, 'statistics', 'statistics', 0, 1),
       (506, 'share', 'share', 0, 1),
       (507, 'other_options', 'other options', 0, 1),
       (508, 'problem_file_requirements', 'Enter the details of the file (as above) you wish to report.', 0, 0),
       (591, 'error_can_not_locate_file', 'File can not be located, please try again later.', 0, 1),
       (592, 'admin_file_servers', 'File Servers', 1, 0),
       (593, 'file_server_management_intro', 'Double click on any of the servers below to edit.', 0, 0),
       (594, 'add_new_server', 'Add new server', 0, 0),
       (595, 'server_label', 'server label', 0, 0),
       (596, 'server_type', 'server type', 0, 0),
       (597, 'storage_path', 'storage path', 0, 0),
       (598, 'enter_server_details', 'Enter Server Details', 0, 0),
       (599, 'total_space_used', 'total space used', 0, 0),
       (600, 'total_files', 'total files', 0, 0),
       (601, 'file_server_test_ftp_intro', 'Testing connection to file server... (via ftp)', 0, 0),
       (602, 'back_to_server_management', 'Back to Server Management', 0, 0),
       (510, 'report_abuse_error_no_content', 'Please enter the details of the reported file.', 0, 0),
       (516, 'legal_bits', 'Legal Bits', 0, 0),
       (19532, 'account_home_folder_treeview_double_click', 'Double click to view/hide subfolders', 0, 0),
       (518, 'days', 'days', 0, 1),
       (17398, 'powerful_features', 'Powerful Features', 0, 0),
       (520, 'pay_via_paypal', 'Pay via PayPal', 0, 0),
       (17443, 'secure_payment', 'Secure Payment', 0, 0),
       (17444, 'safe_and_anonymous', '100% Safe & Anonymous', 0, 0),
       (523, 'add_files', 'Add files...', 0, 1),
       (19438, 'start_upload', 'Start upload', 0, 0),
       (19439, 'cancel_upload', 'Cancel upload', 0, 0),
       (526, 'select_files', 'Select files', 0, 1),
       (527, 'drag_and_drop_files_here_or_click_to_browse', 'Drag &amp; drop files here or click to browse...', 0, 1),
       (19445, 'max_file_size', 'Max file size', 0, 0),
       (529, 'add_file', 'add file', 0, 1),
       (530, 'copy_all_links', 'copy all links', 0, 1),
       (531, 'file_upload_completed', 'File uploads completed.', 0, 1),
       (532, 'delete_url', 'Delete Url', 0, 1),
       (533, 'stats_url', 'Stats Url', 0, 1),
       (18655, 'html_code', 'HTML Code', 0, 0),
       (18659, 'forum_code', 'forum code', 0, 0),
       (536, 'full_info', 'Full Info', 0, 1),
       (537, 'click_here', 'click here', 0, 1),
       (17383, 'extend', 'extend', 0, 0),
       (17449, 'reverts_to_free_account', 'reverts to free account', 0, 0),
       (17450, 'never', 'never', 0, 0),
       (541, 'filename', 'filename', 0, 1),
       (542, 'download', 'download', 0, 1),
       (18640, 'filesize', 'filesize', 0, 0),
       (544, 'url', 'url', 0, 1),
       (19343, 'register', 'register', 0, 0),
       (546, 'share_file', 'share file', 0, 1),
       (619, 'email_large_attachments', 'Email large attachments!', 0, 0),
       (620, 'no_longer_do_you_have_to_risk_a_large_file_being_bounced_by_a_mail',
        'No longer do you have to risk a large file being bounced by a mail server. Upload and send your recipient a link to download the file. You can even track when it''s been downloaded.',
        0, 0),
       (621, 'server_info', 'Server Info', 0, 0),
       (622, 'edit_page_name', 'Edit', 0, 0),
       (623, 'edit_meta_description', 'Edit existing item', 0, 0),
       (624, 'edit_meta_keywords', 'edit, existing, item', 0, 0),
       (625, 'edit_existing_item', 'Edit Existing Item', 0, 1),
       (626, 'edit_existing_item_intro_text', 'Use the form below to amend the selected item.', 0, 0),
       (627, 'new_long_url', 'new long url', 0, 0),
       (628, 'reset_stats', 'reset stats', 0, 1),
       (629, 'update_url', 'update url', 0, 0),
       (630, 'no_keep_existing_stats', 'No (keep existing stats)', 0, 0),
       (631, 'yes_remove_existing_stats', 'Yes (remove existing stats)', 0, 0),
       (632, 'whether_to_reset_the_statistics_or_not', 'Whether to reset the statistics or not', 0, 0),
       (633, 'no_keep_stats', 'No, keep stats', 0, 1),
       (634, 'yes_remove_stats', 'Yes, remove stats', 0, 1),
       (635, 'update_item', 'update item', 0, 1),
       (636, 'folder', 'folder', 0, 1),
       (637, 'the_items_folder', 'The items folder', 0, 0),
       (19506, '_none_', '- None -', 0, 0),
       (639, 'the_filename_on_download', 'The filename on download', 0, 0),
       (640, 'folders', 'folders', 0, 0),
       (641, 'account_folder_name', 'File Folders', 0, 0),
       (642, 'account_folder_meta_description', 'Your File Folders', 0, 0),
       (643, 'account_folder_meta_keywords', 'file, folders, home, file, your, interface, upload, download, site', 0,
        0),
       (644, 'folder_name', 'Folder Name', 0, 1),
       (645, 'is_public', 'Public', 0, 0),
       (646, 'public_no', 'no', 0, 0),
       (647, 'total_active_files', 'Total Active Files', 0, 0),
       (648, 'active_files', 'Active Files', 0, 1),
       (649, 'add_page_name', 'Add', 0, 0),
       (650, 'add_meta_description', 'Add existing item', 0, 0),
       (651, 'add_meta_keywords', 'add, existing, item', 0, 0),
       (652, 'add_folder', 'Add Folder', 0, 1),
       (653, 'add_folder_intro_text', 'Use the form below to add a new folder to your account.', 0, 0),
       (654, 'the_folder_name', 'The folder name', 0, 0),
       (655, 'no_keep_private', 'No, keep private', 0, 1),
       (656, 'yes_allow_public', 'Yes, allow sharing', 0, 1),
       (657, 'whether_to_allow_public_access_to_the_folder', 'Whether to allow public access to the folder or not', 0,
        0),
       (658, 'add_item', 'add item', 0, 0),
       (659, 'edit_existing_folder', 'Edit Existing Folder', 0, 1),
       (660, 'edit_existing_folder_intro_text', 'Use the form below to amend the selected folder.', 0, 0),
       (661, 'public_yes', 'yes', 0, 0),
       (662, 'folder_password', 'folder password', 0, 0),
       (663, 'the_folder_password', 'The folder password. (must be a public folder)', 0, 0),
       (664, 'please_enter_the_foldername', 'Please enter the folder name', 0, 1),
       (665, 'already_a_folder_with_that_name', 'You already have a folder with that name, please use another', 0, 1),
       (666, 'listing_url', 'Listing Url', 0, 0),
       (667, 'files_within_folder', 'Files Within Folder', 0, 1),
       (668, 'there_are_no_files_within_this_folder', 'There are no files within this folder.', 0, 1),
       (669, 'sharing_url', 'Sharing Url', 0, 0),
       (670, 'public_link', 'public link', 0, 0),
       (671, 'folder_login', 'Folder Login', 0, 0),
       (672, 'folder_login_intro_text', 'Please enter the password below to access this folder.', 0, 1),
       (673, 'folder_password_requirements', 'The folder password.', 0, 0),
       (674, 'continue', 'continue', 0, 1),
       (675, 'folder_restricted', 'Folder Restricted', 0, 1),
       (676, 'please_enter_the_folder_password', 'Please enter the folder password', 0, 1),
       (677, 'password_is_invalid', 'The folder password is invalid', 0, 1),
       (678, 'save_to_folder', 'Save To Folder', 0, 0),
       (679, 'forgot_password', 'forgot password', 0, 1),
       (680, 'forgot_password_page_name', 'Forgot Password', 0, 1),
       (681, 'forgot_password_meta_description', 'Forgot account password', 0, 1),
       (682, 'forgot_password_meta_keywords', 'forgot, password, account, short, url, user', 0, 1),
       (683, 'forgot_password_intro_text',
        'Enter your email address below to receive further instructions on how to reset your account password.', 0, 1),
       (684, 'reset', 'reset', 0, 0),
       (685, 'please_enter_your_email_address', 'Please enter the account email address', 0, 1),
       (686, 'account_not_found', 'Account with that email address not found', 0, 1),
       (687, 'forgot_password_sent_intro_text',
        'An email has been sent to [[[EMAIL_ADDRESS]]] with further instructions on how to reset your password.', 0, 1),
       (688, 'forgot_password_confirm_intro_text',
        'An email has been sent to [[[EMAIL_ADDRESS]]] with further instructions on how to reset your password.', 0, 0),
       (689, 'request_reset', 'request reset', 0, 1),
       (690, 'forgot_password_reset_intro_text', 'Set your new password below to access your account.', 0, 1),
       (691, 'confirm_password', 'confirm password', 0, 1),
       (692, 'update_password', 'update password', 0, 1),
       (693, 'password_length_incorrect', 'Password should be between 6 - 20 characters in length', 0, 1),
       (694, 'password_confirmation_does_not_match', 'Your password confirmation does not match', 0, 1),
       (695, 'forgot_password_reset_confirm_intro_text',
        'Your password has been reset. You can now login to the site above.', 0, 1),
       (696, 'username_must_be_between_6_and_20_characters', 'Your username must be between 6 and 20 characters', 0, 1),
       (697, 'account_edit_page_name', 'Account Details', 0, 1),
       (698, 'account_edit_meta_description', 'Account details', 0, 1),
       (699, 'account_edit_meta_keywords', 'details, account, short, url, user', 0, 1),
       (700, 'account_details', 'Account Details', 0, 1),
       (701, 'change_password', 'Change Password', 0, 1),
       (702, 'update_account', 'update account', 0, 1),
       (703, 'email_address_already_exists', 'Email address already exists', 0, 1),
       (704, 'account_updated_success_message', 'Account details successfully updated', 0, 1),
       (705, 'admin', 'admin', 0, 0),
       (17384, 'account', 'account', 0, 0),
       (707, 'settings', 'settings', 0, 0),
       (708, 'captcha_confirmation', 'Captcha Confirmation', 0, 0),
       (709, 'in_order_to_prevent_abuse_captcha_intro',
        'In order to prevent abuse of this service, please copy the words into the text box on the right.', 0, 1),
       (710, 'invalid_captcha', 'Captcha confirmation text is invalid.', 0, 1),
       (711, 'proceed_to_payment', 'process to payment', 0, 1),
       (712, 'register_account_complete', 'Register Account - Complete', 0, 0),
       (713, 'your_username_is_invalid', 'Your username can only contact alpha numeric and underscores.', 0, 1),
       (714, 'upgrade', 'upgrade', 0, 1),
       (715, 'username_already_exists', 'Username already exists on another account', 0, 1),
       (716, 'login_to_the_admin_area_below', 'Login to the admin area below', 0, 0),
       (717, 'admin_login', 'admin login', 0, 0),
       (718, 'submit', 'submit', 0, 0),
       (719, 'manage_file_servers', 'manage file servers', 0, 0),
       (720, 'file_servers', 'file servers', 0, 0),
       (721, 'manage_users', 'manage users', 0, 0),
       (722, 'users', 'users', 0, 0),
       (723, 'payments', 'payments', 0, 0),
       (724, 'translations', 'translations', 0, 0),
       (725, 'short_url', 'Short Url', 0, 0),
       (726, 'date_uploaded', 'Date Uploaded', 0, 0),
       (727, 'total_downloads', 'Total Downloads', 0, 1),
       (728, 'uploaded_ip', 'Upload IP', 0, 0),
       (729, 'last_downloaded', 'Last Downloaded', 0, 0),
       (730, 'actions', 'Actions', 0, 1),
       (731, 'date_uploaded_uploaded_ip', 'Date Uploaded/IP', 0, 0),
       (732, 'space_used', 'HD Used', 0, 0),
       (733, 'type', 'Type', 0, 0),
       (734, 'server_information', 'server information', 0, 0),
       (735, 'account_expiry_invalid_dd_mm_yy', 'Account expiry date invalid, it should be in the format dd/mm/yyyy', 0,
        0),
       (736, 'description', 'Description', 0, 1),
       (737, 'ban_type', 'Ban Type', 0, 0),
       (738, 'enter_the_ip_address', 'Please enter the IP address.', 0, 0),
       (739, 'enter_the_language_name', 'Please enter the language name.', 0, 0),
       (740, 'language_already_exists', 'A language with that name already exists in the database.', 0, 0),
       (741, 'english_content', 'English Content', 0, 0),
       (742, 'default', 'Default', 0, 0),
       (743, 'file_status', 'File Status', 0, 0),
       (744, 'dashboard_graph_user_registrations_title', 'Last 14 days user registrations', 0, 0),
       (745, 'free_user', 'free user', 0, 0),
       (746, 'file_type', 'File Type', 0, 0),
       (747, 'paid_user', 'paid user', 0, 0),
       (748, 'dll', 'dll', 0, 0),
       (749, 'doc', 'doc', 0, 0),
       (750, 'exe', 'exe', 0, 0),
       (751, 'ini', 'ini', 0, 0),
       (752, 'jpg', 'jpg', 0, 0),
       (753, 'mp3', 'mp3', 0, 0),
       (754, 'php', 'php', 0, 0),
       (755, 'png', 'png', 0, 0),
       (756, 'sql', 'sql', 0, 0),
       (757, 'txt', 'txt', 0, 0),
       (758, 'ftp_username', 'ftp username', 0, 0),
       (759, 'ftp_password', 'ftp password', 0, 0),
       (760, 'server_label_invalid', 'Please specify the server label.', 0, 0),
       (761, 'server_label_already_in_use', 'That server label has already been used, please choose another.', 0, 0),
       (762, 'server_ftp_username_invalid', 'Please specify the server ftp username.', 0, 0),
       (763, 'owner', 'Owner', 1, 0),
       (764, 'other', 'other', 1, 1),
       (765, 'wmv', 'wmv', 1, 0),
       (766, 'date_started', 'date started', 1, 0),
       (767, 'file_name', 'file name', 1, 0),
       (768, 'file_size', 'file size', 1, 0),
       (769, 'total_threads', 'total threads', 1, 0),
       (770, 'threads', 'threads', 1, 0),
       (771, 'username_is_reserved', 'Username is reserved and can not be used, please choose another', 0, 1),
       (19412, 'uploader_hours', 'hours', 0, 0),
       (19843, 'album_total_comments', 'Total Comments', 0, 0),
       (774, 'French', 'French', 0, 0),
       (775, 'German', 'German', 0, 0),
       (776, 'Spanish', 'Spanish', 0, 0),
       (19452, 'delete', 'delete', 0, 0),
       (778, 'file_is_too_big', 'File is too big', 0, 1),
       (779, 'file_is_too_small', 'File is too small', 0, 1),
       (780, 'filetype_is_not_allowed', 'Filetype not allowed', 0, 1),
       (781, 'max_number_of_files_exceeded', 'Max number of files exceeded', 0, 1),
       (782, 'file_exceeds_upload_max_filesize_php_ini_directive',
        'File exceeds upload_max_filesize (php.ini directive)', 0, 1),
       (783, 'file_exceeds_max_file_size_html_form_directive', 'File exceeds MAX_FILE_SIZE (HTML form directive)', 0,
        1),
       (784, 'file_was_only_partially_uploaded', 'File was only partially uploaded', 0, 1),
       (785, 'no_file_was_uploaded', 'No File was uploaded', 0, 1),
       (786, 'missing_a_temporary_folder', 'Missing a temporary folder', 0, 1),
       (787, 'failed_to_write_file_to_disk', 'Failed to write file to disk', 0, 1),
       (788, 'file_upload_stopped_by_extension', 'File upload stopped by extension', 0, 1),
       (789, 'uploaded_bytes_exceed_file_size', 'Uploaded bytes exceed file size', 0, 1),
       (790, 'empty_file_upload_result', 'Empty file upload result', 0, 1),
       (791, 'from', 'from', 0, 1),
       (792, 'quick_overview', 'Quick Overview', 1, 0),
       (793, 'please_enter_you_information_below_to_register_for_an_account',
        'Please enter your information below to register for an account. Your new account password will be sent to your email address.',
        0, 0),
       (794, 'mrs', 'Mrs', 0, 0),
       (795, 'miss', 'Miss', 0, 0),
       (796, 'dr', 'Dr', 0, 0),
       (797, 'pro', 'Pro', 0, 0),
       (798, 'your_title', 'Your title', 0, 1),
       (799, 'your_firstname', 'Your firstname', 0, 1),
       (800, 'your_lastname', 'Your lastname', 0, 1),
       (801, 'your_email_address', 'Your email address', 0, 0),
       (802, 'confirm_your_email_address', 'Confirm your email address', 0, 0),
       (803, 'your_account_username', 'Your account username. 6 characters or more and alpha numeric.', 0, 0),
       (805, 'by_clicking_register_you_agree_to_our_terms',
        'By clicking ''register'', you agree to our <a href=''terms.html''>Terms of service</a>.', 0, 0),
       (806, 'title_mr', 'Mr', 0, 1),
       (807, 'title_mrs', 'Mrs', 0, 1),
       (808, 'title_miss', 'Miss', 0, 1),
       (809, 'title_dr', 'Dr', 0, 1),
       (810, 'title_pro', 'Pro', 0, 1),
       (811, 'download from', 'Download From', 0, 1),
       (812, 'terms_and_conditions_text',
        '<strong>Basic TOS</strong><br/>\n<br/>\nAll users must be of at least the age of 13, and agree to not use the [[[SITE_NAME]]] service for any illegal or unauthorized purposes. All users must agree to comply with local laws regarding online conduct, and copyright laws. [[[SITE_NAME]]] is intended for personal use, and any business use is strictly prohibited. All users must not use [[[SITE_NAME]]]''s services to violate any laws which include but are not limited to copyright laws. Any violations will result in immediate deletion of all files [[[SITE_NAME]]] has on record for your IP Address.<br/>\n<br/>\nAll users use [[[SITE_NAME]]] at their own risk, users understand that files uploaded on [[[SITE_NAME]]] are not private, they may be displayed for others to view, and [[[SITE_NAME]]] users understand and agree that [[[SITE_NAME]]] cannot be responsible for the content posted on its web site and you nonetheless may be exposed to such materials and that you use [[[SITE_NAME]]]''s service at your own risk.<br/>\n<br/>\n<strong>Conditions</strong><br/>\n<br/>\n- We reserve the right to modify or terminate the [[[SITE_NAME]]] service for any reason, without notice at any time.<br/>\n- We reserve the right to alter these Terms of Use at any time.<br/>\n- We reserve the right to refuse service to anyone for any reason at any time.<br/>\n- We may, but have no obligation to, remove Content and accounts containing Content that we determine in our sole discretion are unlawful, offensive, threatening, libelous, defamatory, obscene or otherwise objectionable or violates any party''s intellectual property or these Terms of Use.<br/>\n- If a user is found to be using [[[SITE_NAME]]] to host icons, smileys, buddy icons, forum avatars, forum badges, forum signature images, or any other graphic for website design all your images will be removed.<br/>\n<br/>\n<strong>Copyright Information</strong><br/>\n<br/>\n[[[SITE_NAME]]] claims no intellectual property rights over the images uploaded by its'' users.<br/>\n<br/>\n[[[SITE_NAME]]] will review all copyright &copy; infringement claims received and remove files found to have been upload or distributed in violation of any such laws. To make a valid claim you must provide [[[SITE_NAME]]] with the following information:<br/>\n<br/>\n- A physical or electronic signature of the copyright owner or the person authorized to act on its behalf;<br/>\n- A description of the copyrighted work claimed to have been infringed;<br/>\n- A description of the infringing material and information reasonably sufficient to permit [[[SITE_NAME]]] to locate the material;<br/>\n- Your contact information, including your address, telephone number, and email;<br/>\n- A statement by you that you have a good faith belief that use of the material in the manner complained of is not authorized by the copyright owner, its agent, or the law; and<br/>\n- A statement that the information in the notification is accurate, and, under the pains and penalties of perjury, that you are authorized to act on behalf of the copyright owner.<br/>\n<br/>\nClaims can be sent to us via the <a href="report_file.[[[PAGE_EXTENSION]]]">report abuse</a> page.',
        0, 0),
       (813, 'register_user_email_subject', 'Account details for [[[SITE_NAME]]]', 0, 0),
       (814, 'register_user_email_content',
        'Dear [[[FIRST_NAME]]],<br/><br/>Your account on [[[SITE_NAME]]] has been created. Use the details below to login to your new account:<br/><br/><strong>Url:</strong> <a href=''[[[WEB_ROOT]]]''>[[[WEB_ROOT]]]</a><br/><strong>Username:</strong> [[[USERNAME]]]<br/><strong>Password:</strong> [[[PASSWORD]]]<br/><br/>Feel free to contact us if you need any support with your account.<br/><br/>Regards,<br/>[[[SITE_NAME]]] Admin',
        0, 0),
       (815, 'sftp_host', 'sftp host', 1, 0),
       (816, 'sftp_port', 'sftp port', 1, 0),
       (817, 'sftp_username', 'sftp username', 1, 0),
       (818, 'sftp_password', 'sftp password', 1, 0),
       (819, 'manage_plugins', 'manage plugins', 1, 0),
       (820, 'add_plugin', 'add plugin', 1, 0),
       (822, 'directory_name', 'directory name', 1, 0),
       (823, 'is_installed', 'is installed', 1, 0),
       (824, 'installed', 'installed?', 1, 0),
       (825, 'no_file_found', 'No file found, please try again.', 1, 0),
       (826, 'not_a_zip_file', 'The uploaded file does not appear to be a zip file.', 1, 0),
       (827, 'error_creating_plugin_folder',
        'There was a problem creating the plugin folder. Please ensure the following folder has CHMOD 777 permissions: /var/www/php_site_scripts/file_hosting/plugins/',
        1, 0),
       (828, 'error_reading_plugin_details', 'Could not read the plugin settings file ''_plugin_config.inc.php''.', 1,
        0),
       (829, 'error_problem_unzipping_the_file',
        'There was a problem unzipping the file, please try and manually upload the zip files contents into the plugins directory or contact support.',
        1, 0),
       (831, 'User Earnings', 'User Earnings', 1, 0),
       (832, 'Detailed Referrals', 'Detailed Referrals', 1, 0),
       (833, 'Payment Requests', 'Payment Requests', 1, 0),
       (834, 'keep_your_account_details_up_to_date_below', 'Keep your account details up to date below.', 0, 1),
       (835, 'your_new_email_address', 'Your new email address', 0, 1),
       (836, 'a_new_account_password_leave_blank_to_keep',
        'Optional. A new account password, leave this blank to keep your existing.', 0, 1),
       (837, 'active_downloads', 'active downloads', 1, 0),
       (17452, 'direct_downloads_no_waiting', 'Direct downloads. No waiting.', 0, 0),
       (17453, 'no_advertising', 'No advertising.', 0, 0),
       (17454, 'unlimited_simultaneous_downloads', 'Unlimited simultaneous downloads.', 0, 0),
       (17455, 'maximum_downloads_speeds_possible', 'Maximum download speeds possible.', 0, 0),
       (17456, 'download_manager_support', 'Download manager support.', 0, 0),
       (17457, 'unlimited_storage', 'Unlimited storage.', 0, 0),
       (17247, 'files_kept_for_x_days', 'Files kept for [[[DAYS]]] days.', 0, 0),
       (17248, 'upload_files_up_to_x_in_size', 'Upload files up to [[[MAX_UPLOAD_FILESIZE]]] in size.', 0, 0),
       (17460, 'no_limits_on_the_amount_of_downloads', 'No limits on the amount of downloads.', 0, 0),
       (17461, 'low_price_per_day', 'Low price per day.', 0, 0),
       (17462, 'no_subscriptions', 'No subscriptions.', 0, 0),
       (849, 'rewards_meta_description', 'Rewards', 0, 1),
       (850, 'rewards_meta_keywords', 'earn, money, rewards, cash, sales, affiliate, file, hosting, site', 0, 1),
       (851, 'overview', 'overview', 0, 1),
       (852, 'total_rewards', 'total rewards', 0, 0),
       (853, 'cleared_rewards', 'cleared rewards', 0, 0),
       (854, 'available_for_withdrawal', 'available for withdrawal', 0, 0),
       (856, 'this_months_rewards', 'this months rewards', 0, 0),
       (857, 'you_have_not_uploaded_any_file_recently',
        '- You have not uploaded any files recently. <a href="[[[WEB_ROOT]]]/index.[[[PAGE_EXTENSION]]]">Click here</a> to upload some now.',
        0, 0),
       (858, 'if_you_have_an_account_signin',
        'If you have an account, <a href="[[[WEB_ROOT]]]/login.[[[PAGE_EXTENSION]]]">click here</a> to login and manage your files.',
        0, 0),
       (859, 'detailed_rewards', 'detailed rewards', 0, 0),
       (860, 'how_to_start_earning', 'how to start earning', 0, 1),
       (861, 'reward_date', 'Reward Date', 0, 1),
       (862, 'reward_amount', 'Amount', 0, 1),
       (863, 'recent_rewards', 'recent rewards', 0, 0),
       (864, 'copyright removed', 'copyright removed', 1, 0),
       (865, 'user_status', 'User Status', 1, 0),
       (866, 'free user', 'free user', 1, 0),
       (867, 'paid user', 'paid user', 1, 0),
       (868, 'amount', 'Amount', 1, 1),
       (869, 'original_order_number', 'Original Order #', 1, 1),
       (870, 'upgrade_source', 'Upgrade Source', 1, 1),
       (871, 'user', 'User', 1, 1),
       (872, 'filter_results', 'Filter Results', 0, 0),
       (873, 'by_folder', 'By Folder', 0, 0),
       (874, 'all', 'all', 0, 0),
       (875, 'by_status', 'By Status', 0, 0),
       (877, 'Aggregated Earnings', 'Aggregated Earnings', 1, 0),
       (878, 'monthly_totals', 'monthly totals', 0, 1),
       (879, 'rewards_request_withdrawal_email_to_admin_subject', 'Rewards withdrawal request for [[[AMOUNT]]]', 0, 0),
       (880, 'rewards_request_withdrawal_email_to_admin_content',
        'Dear Admin,<br/><br/>A rewards withdrawal request has been received. Please login to [[[SITE_NAME]]] and process the request:<br/><br/><a href=''[[[ADMIN_WEB_ROOT]]]''>[[[ADMIN_WEB_ROOT]]]</a><br/><br/>Regards,<br/>[[[SITE_NAME]]] Admin',
        0, 0),
       (881, 'date_requested', 'Date Requested', 1, 1),
       (882, 'Русский', 'Русский', 0, 0),
       (883, 'file', 'File', 0, 1),
       (884, 'file_permanently_removed', 'File permanently removed.', 0, 1),
       (885, 'zip', 'zip', 1, 0),
       (886, 'please_enter_your_skrill_email_address', 'Please enter your Skrill account email address.', 1, 1),
       (887, 'error_you_must_register_for_a_premium_account_for_filesize',
        'You must register for a premium account for files of this size. Please use the links above to register or login.',
        0, 1),
       (888, 'error_you_have_reached_the_max_permitted_downloads',
        'You have reached the maximum concurrent downloads. Please wait for your existing downloads to complete or register for a premium account above.',
        0, 1),
       (889, 'Newsletters', 'Newsletters', 1, 0),
       (890, 'Create Newsletter', 'Create Newsletter', 1, 0),
       (891, 'Manage Newsletters', 'Manage Newsletters', 1, 0),
       (892, 'Export User Data', 'Export User Data', 1, 0),
       (893, 'newsletter_date', 'date', 1, 0),
       (894, 'newsletter_title', 'title', 1, 1),
       (895, 'newsletter_subject', 'subject', 1, 1),
       (896, 'newsletter_status', 'status', 1, 1),
       (897, 'newsletter_user_group', 'send to', 1, 1),
       (898, 'newsletter_html_content', 'newsletter content (html)', 1, 1),
       (899, 'upload', 'upload', 0, 0),
       (900, 'file_upload', 'file upload', 0, 1),
       (19433, 'remote_url_upload', 'remote url upload', 0, 0),
       (19463, 'ftp_upload', 'FTP Upload', 0, 0),
       (903, 'enter_urls', 'Enter Urls', 0, 0),
       (19479, 'enter_up_to_x_file_urls',
        'Enter up to [[[MAX_REMOTE_URL_FILES]]] file urls. Separate each url on it''s own line.', 0, 0),
       (19462, 'processing', 'processing', 0, 0),
       (906, 'file_transfers_completed', 'File transfers completed.', 0, 1),
       (907, 'html', 'html', 1, 0),
       (908, 'ico', 'ico', 1, 0),
       (909, 'MPG', 'MPG', 1, 0),
       (19471, 'please_enter_the_urls_to_start', 'Please enter the urls to start.', 0, 0),
       (19472, 'no_valid_urls_found_please_make_sure_any_start_with_http_or_https',
        'No valid urls found, please make sure any start with http or https and try again.', 0, 0),
       (913, 'error_renaming_plugin_folder',
        'Could not rename plugin folder, it may be that the plugin is already installed or a permissions issue.', 1, 0),
       (914, 'com:8080/p', 'com:8080/p', 1, 0),
       (915, 'newsletter_created', 'created', 1, 1),
       (916, 'newsletter_unsubscribe_title', 'newsletter unsubscribe', 0, 1),
       (917, 'newsletter_unsubscribe_description', 'Unsubscribe', 0, 1),
       (918, 'newsletter_unsubscribe_meta_keywords', 'newsletter, unsubscribe, file, hosting, site', 0, 1),
       (919, 'newsletter_unsubscribe', 'newsletter unsubscribe', 0, 1),
       (920, 'newsletter_unsubscribe_intro_text',
        'Enter your email address below to be removed from future newsletters from our site.', 0, 1),
       (921, 'newsletter_unsubscribe_email_tip', 'Your registered email address.', 0, 1),
       (922, 'unsubscribe', 'unsubscribe', 0, 1),
       (923, 'newsletter_unsubscribe_problem_unsubscribing',
        'There was a problem unsubscribing your from our mailing list. Please contact us and we''ll manually remove you',
        0, 1),
       (924, 'newsletter_unsubscribe_account_already_unsubscribed',
        'The email address you''ve provided has already been unsubscribed', 0, 1),
       (925, 'newsletter_unsubscribe_successfully_unsubscribed',
        'Your email address has been sucessfully removed from our mailing lists', 0, 1),
       (928, 'newsletter_subscribe_title', 'newsletter subscribe', 0, 1),
       (929, 'newsletter_subscribe_description', 'Subscribe', 0, 1),
       (930, 'newsletter_subscribe_meta_keywords', 'newsletter, subscribe, file, hosting, site', 0, 1),
       (931, 'newsletter_subscribe', 'newsletter subscribe', 0, 1),
       (932, 'newsletter_subscribe_intro_text',
        'Enter your email address below to be added to future newsletters from our site. Note, you must have a registered account to be added to the mailing list.',
        0, 1),
       (933, 'newsletter_subscribe_email_tip', 'Your registered email address.', 0, 1),
       (17468, 'subscribe', 'Subscribe', 0, 0),
       (935, 'your_email_address_is_invalid', 'Your email address is invalid', 0, 1),
       (936, 'newsletter_subscribe_could_not_find_account', 'Could not find an account with that email address', 0, 1);
INSERT INTO `language_key` (`id`, `languageKey`, `defaultContent`, `isAdminArea`, `foundOnScan`)
VALUES (937, 'newsletter_subscribe_successfully_subscribed',
        'Your email address has been sucessfully added to our mailing lists', 0, 1),
       (939, 'thanks_for_your_payment', 'Thanks for your payment!', 0, 0),
       (940, 'once_we_receive_notication_from_gateway_your_account_will_be_upgraded',
        'Once we receive notification from the payment gateway, your account will be upgraded/extended. Please allow up to an hour for this to complete.',
        0, 1),
       (941, 'you_can_check_your_accout_status_by_going', 'You can check your account status by going ', 0, 1),
       (942, 'here', 'here', 0, 1),
       (943, 'download_view_now', 'download/view now', 0, 1),
       (944, 'mp4', 'mp4', 1, 0),
       (945, 'media_player_plugin_watch_page_name', 'Watch', 0, 1),
       (946, 'media_player_plugin_page_description', 'Watch or listen to ', 0, 1),
       (947, 'media_player_plugin_meta_keywords', ', watch, listen, file, upload, download, site', 0, 1),
       (948, 'ogv', 'ogv', 1, 0),
       (949, 'limited', 'limited', 0, 1),
       (950, 'file_details', 'file details', 0, 1),
       (951, 'please_enter_your_tranzila_account_id', 'Please enter your Tranzila account id.', 1, 1),
       (952, 'get_plugin', 'get plugins', 1, 0),
       (953, 'ftp_directory_does_not_exist', 'The ftp path you''ve set does not exist.', 1, 0),
       (954, 'set_the_ftp_path', 'Please set the path to store ftp accounts.', 1, 1),
       (958, 'error_message', 'Error message', 0, 1),
       (959, 'ftp_details', 'FTP Details', 0, 1),
       (969, 'please_enter_your_paymentwall_application_key',
        'Please enter your PaymentWall application key. This can be found in Application Settings.', 1, 1),
       (970, 'please_enter_your_okpay_waller_number', 'Please enter your OKPay wallet number.', 1, 1),
       (971, 'please_enter_the_filename', 'Please enter the filename', 0, 1),
       (972, 'please_enter_your_firstdata_transaction_key', 'Please enter your First Data transaction key.', 1, 1),
       (973, 'downloader', 'downloader', 1, 0),
       (974, 'image_viewer_plugin_page_name', 'Watch', 0, 1),
       (975, 'image_viewer_plugin_page_description', 'Watch or listen to ', 0, 1),
       (976, 'image_viewer_plugin_meta_keywords', ', view, picture, file, upload, download, site', 0, 1),
       (978, 'html_thumb_code', 'HTML Thumbnail Code', 0, 1),
       (979, 'forum_thumb_code', 'Forum Thumbnail Code', 0, 1),
       (980, 'full_url', 'Full Url', 0, 0),
       (981, 'embed_code', 'embed code', 0, 1),
       (982, 'thumb_url', 'Thumbnail Url', 0, 1),
       (983, 'full_image_url', 'Full Image Url', 0, 1),
       (984, 'confirm_text', 'Confirmation Text', 0, 1),
       (985, 'paging_first', 'First', 0, 0),
       (986, 'paging_last', 'Last', 0, 0),
       (987, 'paging_next', 'Next', 0, 0),
       (988, 'paging_previous', 'Previous', 0, 0),
       (989, 'datatable_empty', 'No data found.', 0, 0),
       (990, 'datatable_data_info', 'Showing _START_ to _END_ of _TOTAL_ entries', 0, 0),
       (991, 'datatable_per_page', 'Show _MENU_ entries', 0, 0),
       (992, 'dfdf', 'dfdf', 1, 0),
       (993, 'error_you_must_wait_between_downloads',
        'You must wait [[[WAITING_TIME_LABEL]]] between downloads. Please try again later or register for a premium account above to remove the restriction.',
        0, 0),
       (994, 'max_uploads_reached', 'Max uploads reached.', 0, 1),
       (995, 'reached_maximum_uploads', 'You have reached the maximum permitted uploads for today.', 0, 1),
       (996, 'AVI', 'AVI', 1, 0),
       (997, '3gp', '3gp', 1, 0),
       (998, 'embed_video', 'Embed Video', 0, 1),
       (1002, 'search_plugin_settings', 'Plugin Settings', 1, 1),
       (1003, 'search_plugin_state', 'Plugin State', 1, 1),
       (1004, 'search_plugin_enabled', 'Whether the search system is enabled', 1, 1),
       (1005, 'search_enabled', 'Plugin Enabled', 1, 1),
       (1006, 'search_disable_selling', 'Users which have access', 1, 1),
       (1007, 'search_disable_selling_desc',
        'Select from the drop down who you want to have access to the search feature', 1, 1),
       (1008, 'search_disable_label', 'Who has access', 1, 1),
       (1009, 'search_files', 'Search Files', 0, 1),
       (1010, 'webmaster', 'webmaster', 1, 0),
       (1011, 'level', 'Level', 1, 0),
       (1012, 'status_level', 'Status/Level:', 0, 0),
       (1013, 'file_level', 'file level', 0, 0),
       (1014, 'by_level', 'By Level', 0, 0),
       (1015, 'file_server_domain_name', 'file server domain name', 1, 0),
       (1016, 'script_path', 'script path', 1, 0),
       (1017, 'upload_script_path', 'upload script path', 1, 0),
       (1018, 'code_setup', 'code setup', 1, 0),
       (1019, 'server_storage_path', 'server storage path', 1, 0),
       (1020, 'server_file_server_domain_name_empty', 'Please specify the file server domain name.', 1, 0),
       (1021, 'server_file_server_domain_name_invalid', 'The file server domain name you''ve entered is invalid.', 1,
        0),
       (1022, 'set_password', 'set password:', 0, 1),
       (1023, 'enter_a_password_below_to_secure_your_files',
        'When downloading these files, users will be prompted for a password, if set. Download managers will not work if a password is set.',
        0, 1),
       (1024, 'set_file_password', 'Set Password', 0, 1),
       (19496, 'send_via_email', 'send via email:', 0, 0),
       (1026, 'enter_an_email_address_below_to_send_the_list_of_urls',
        'Enter an email address below to send the list of urls via email once they''re uploaded.', 0, 1),
       (19422, 'links_copies_to_clipboard', 'Links copied to clipboard:\\n\\n', 0, 0),
       (1028, 'file_password_page_name', 'File Password', 0, 1),
       (1029, 'file_password_meta_description', 'Enter file password', 0, 1),
       (1030, 'file_password_meta_keywords', 'file, password, account, short, url, user', 0, 1),
       (1031, 'file_password', 'file password', 0, 0),
       (1032, 'file_password_intro_text', 'A password is required to access this file, please enter it below.', 0, 0),
       (1033, 'the_file_password', 'The file password', 0, 0),
       (1034, 'access_file', 'access file', 0, 1),
       (1035, 'file_password_is_invalid', 'File password is invalid.', 0, 1),
       (1036, 'image_url', 'Image Url', 0, 1),
       (1037, 'image_size', 'Size', 0, 1),
       (1038, 'send_urls_by_email_subject', 'Your url links from [[[SITE_NAME]]]', 0, 0),
       (1039, 'send_urls_by_email_html_content',
        'Copies of your urls, which completed uploading on [[[UPDATE_COMPLETED_DATE_TIME]]] are below:<br/><br/>[[[FILE_URLS]]]<br/><br/>Regards,<br/>[[[SITE_NAME]]] Admin',
        0, 0),
       (1040, 'error_you_have_reached_the_maximum_permitted_downloads_in_the_last_24_hours',
        'You have reached the maximum permitted downloads in the last 24 hours.', 0, 1),
       (1041, 'resize_image', 'resize image', 0, 1),
       (1042, 'fixed_size', 'fixed size', 0, 1),
       (1043, 'keep_proportion', 'keep proportion', 0, 1),
       (1044, 'custom_size', 'custom size', 0, 1),
       (1045, 'resize', 'resize', 0, 1),
       (1046, 'please_enter_the_width', 'Please enter the width', 0, 1),
       (1047, 'please_enter_the_height', 'Please enter the height', 0, 1),
       (1048, 'please_enter_a_valid_number_for_the_width', 'Please enter a valid number for the width', 0, 1),
       (1049, 'please_enter_a_valid_number_for_the_height', 'Please enter a valid number for the height', 0, 1),
       (1050, 'Detailed Referrals (PPS)', 'Detailed Referrals (PPS)', 1, 0),
       (1051, 'Detailed Downloads (PPD)', 'Detailed Downloads (PPD)', 1, 0),
       (1052, 'Detailed Referrals PPS', 'Detailed Referrals PPS', 1, 0),
       (1053, 'Detailed PPD', 'Detailed PPD', 1, 0),
       (1054, 'Detailed Referrals P.P.S', 'Detailed Referrals P.P.S', 1, 0),
       (1055, 'Detailed P.P.D', 'Detailed P.P.D', 1, 0),
       (1056, 'Detailed Referrals P P S', 'Detailed Referrals P P S', 1, 0),
       (1057, 'Detailed P P D', 'Detailed P P D', 1, 0),
       (1058, 'Detailed (ppd)', 'Detailed (ppd)', 1, 0),
       (1059, 'Referrals (pps)', 'Referrals (pps)', 1, 0),
       (1060, 'Downloads (ppd)', 'Downloads (ppd)', 1, 0),
       (1061, 'rewards_plugin_error_please_select_at_least_1_country_for_row',
        'Please select at least 1 country for row [[[ROW_NUMBER]]]', 1, 0),
       (1062, 'rewards_plugin_error_please_enter_payout_rate_for_row',
        'Please enter the payout rate for row [[[ROW_NUMBER]]]', 1, 0),
       (1063, 'download_date', 'Download Date', 1, 1),
       (1064, 'reward_group', 'Reward Group', 1, 1),
       (1065, 'reward_user', 'Reward User', 1, 1),
       (1066, 'pay_per_download_rates', 'Pay Per Download (PPD) Rates', 0, 1),
       (1067, 'recent_downloads', 'recent downloads', 0, 0),
       (1068, 'upload_your_files_and_youll_be_paid_for_every',
        'Upload your files and you''ll be paid for every file downloaded on your account.', 0, 1),
       (1069, 'files_above_x_will_count', 'Files above [[[FILE_SIZE]]]MB will count.', 0, 1),
       (1070, 'group_name', 'Group Name', 0, 1),
       (1071, 'paid_per_1000_users', 'Paid Per 1,000 Downloads', 0, 1),
       (1072, 'downloading_country', 'Downloading Country', 0, 1),
       (1073, 'see_the_payment_rates_below', 'See the payment rates below:', 0, 1),
       (1074, 'ppd_recent_downloads', 'ppd recent downloads', 0, 1),
       (1075, 'noncleared_ppd_downloads', 'uncleared ppd downloads', 0, 0),
       (1076, 'total_rewards_pps', 'total rewards pps', 0, 0),
       (1077, 'total_rewards_pps_', 'total rewards (pps)', 0, 0),
       (1078, 'noncleared_downloads_ppd', 'uncleared downloads (ppd)', 0, 0),
       (1079, 'mix_groups', '(mixed groups)', 0, 0),
       (1080, 'report_file_email_subject', 'New abuse report on [[[SITE_NAME]]]', 0, 0),
       (1081, 'report_file_email_content',
        'There is a new abuse report on [[[SITE_NAME]]] with the following details:<br/><br/>***************************************<br/>[[[FILE_DETAILS]]]<br/>***************************************<br/>Submitted IP: [[[USERS_IP]]]<br/>***************************************<br/><br/>Please login via [[[WEB_ROOT]]]/admin/ to investigate further.',
        0, 0),
       (1098, 'log_viewer', 'view logs', 1, 0),
       (1100, 'system_tools', 'system tools', 1, 0),
       (1101, 'database_browser', 'database browser', 1, 0),
       (1102, 'system_logs', 'system logs', 1, 0),
       (1103, 'you_have_x_active_files_within_your_account',
        'You have [[[ACTIVE_FILES]]] active file(s) within your account. Use the table below to navigate or search for files you''ve previously uploaded. <a href="index.[[[SITE_CONFIG_PAGE_EXTENSION]]]">Click here</a> to upload a file.',
        0, 0),
       (1104, 'add_user', 'add user', 1, 0),
       (1105, 'view_payments', 'view payments', 1, 0),
       (1106, 'payment_date', 'payment date', 1, 0),
       (1107, 'user_name', 'user name', 1, 0),
       (1108, 'received_payments', 'received payments', 1, 0),
       (1109, 'report_file_intro',
        'Please use the following form to report any copyright infringements ensuring you supply all the following information:',
        0, 0),
       (1110, 'report_abuse_error_no_irl', 'Please enter the url of the reported file.', 0, 0),
       (1111, 'report_abuse_error_no_url', 'Please enter the url of the file you\\''re reporting.', 0, 1),
       (1112, 'report_abuse_error_confirm_1',
        'Please confirm you have a good faith belief that use of the material in the manner complained of is not authorized by the copyright owner, its agent, or the law.',
        0, 1),
       (1113, 'report_abuse_error_could_not_find_file',
        'Could not find a file with that url, please check and try again.', 0, 1),
       (1114, 'report_abuse_error_file_not_active', 'The file url you''ve set is not active.', 0, 1),
       (1115, 'key', 'Key', 1, 0),
       (1116, 'you_have_no_active_files_within_your_account',
        'You have no active files within your account. <a href="index.[[[SITE_CONFIG_PAGE_EXTENSION]]]">Click here</a> to upload a file.',
        0, 0),
       (1117, 'file_upload_space_full', 'File upload space full.', 0, 1),
       (1118, 'file_upload_space_full_text',
        'You have reached the maximum permitted storage within your account, please delete some active files and try again.',
        0, 1),
       (1119, 'report_abuse_error_description',
        'Please enter the description and support information of the reported file.', 0, 1),
       (1120, 'report_file_success',
        'Thanks for submitted the information needed to report a file on our servers. We''ll review the file as soon as possible and remove if required.',
        0, 1),
       (1121, 'abuse_reports', 'abuse reports', 1, 0),
       (1122, 'report_date', 'Report Date', 1, 0),
       (1123, 'reported_by_name', 'Reported Name', 1, 0),
       (1124, 'reported_by_ip', 'Reported By IP', 1, 0),
       (1125, 'error_file_has_been_removed_due_to_copyright', 'File has been removed due to copyright issues.', 0, 1),
       (1126, 'by_upload_date', 'By Upload Date', 0, 0),
       (1127, 'parent_folder', 'Parent Folder:', 0, 0),
       (1128, 'base_folder', 'Base Folder', 0, 0),
       (1129, 'root', '- root -', 0, 0),
       (1130, 'the_parent_folder_to_create_this_within', 'The parent folder to create this within', 0, 0),
       (1131, 'edit_folder_folder_name', 'folder name', 0, 0),
       (1132, 'edit_folder_parent_folder', 'Parent Folder:', 0, 1),
       (1133, 'edit_folder_is_public', 'Public:', 0, 1),
       (1134, 'edit_folder_password', 'Password:', 0, 0),
       (1135, 'edit_folder_name', 'Folder Name:', 0, 1),
       (1136, 'edit_folder_sharing_url', 'Sharing Url:', 0, 1),
       (1137, 'update_folder', 'update folder', 0, 0),
       (19510, 'filter', 'Filter', 0, 0),
       (19514, 'upload_date', 'Upload Date', 0, 0),
       (1140, 'folder_share_you_can_share_this_page_with_other',
        'You can share this page with other users who do not have access to your account.', 0, 0),
       (1141, 'folder_share_you_can_share_this_page_with_other_external_users',
        'You can share this page with other users who do not have access to your account. Just copy the website url in the url bar and provide this via email or other sharing method.',
        0, 1),
       (1142, 'folder_share_as_youve_set_a_password_on_this_folder',
        'Note: As you''ve set a password on this folder, users will need to correctly enter this before they gain access to this page.',
        0, 1),
       (1143, 'folder_share_this_folder_can_not_be_shared_as_it_is_not_public',
        'This folder can not be shared as it is not set to a publicly accessible folder.', 0, 0),
       (1144, 'folder_share_this_folder_can_not_be_shared_as_it_is_not_publicly_accessible',
        'This folder can not be shared as it is not set to a publicly accessible folder. Only users with access to your account can see this listing.',
        0, 1),
       (1145, 'file_server_test_direct_intro', 'Testing file server... (direct file server)', 0, 0),
       (1146, 'language', 'Language', 0, 1),
       (1147, 'settings_tip_site_language', 'The language to use on the site.', 0, 1),
       (1148, 'please_select_the_username', 'Please select the username.', 1, 0),
       (1149, 'please_enter_the_payment_amount', 'Please enter the payment amount.', 1, 0),
       (1150, 'error_plugin_folder_is_not_writable',
        'Plugin folder is not writable. Ensure you set the following folder to CHMOD 755 or 777: [[[PLUGIN_FOLDER]]]',
        1, 0),
       (1151, 'moderator_area', 'moderator area', 0, 0),
       (1152, 'ogg', 'ogg', 1, 0),
       (1153, 'page', 'Page', 0, 0),
       (19366, 'of', 'of', 0, 0),
       (1155, 'last_accessed', 'last accessed', 0, 1),
       (1156, 'added', 'added', 0, 1),
       (1157, 'statistics_url', 'statistics url', 0, 1),
       (1158, 'delete_file_url', 'delete file url', 0, 1),
       (1159, 'store_in_folder', 'store in folder:', 0, 1),
       (1160, 'select_folder_below_intro_text', 'Select a folder below to store these uploaded files in.', 0, 0),
       (1161, 'select_folder_below_to_store_intro_text',
        'Select a folder below to store these files in. All uploads files will be available within these folders.', 0,
        1),
       (1162, '_default_', '- Default -', 0, 1),
       (1163, 'order_by', 'Order By', 0, 0),
       (1164, 'order_by_filename_asc', 'Filename ASC', 0, 0),
       (1165, 'order_by_filename_desc', 'Filename DESC', 0, 0),
       (1166, 'order_by_uploaded_date_asc', 'Uploaded Date ASC', 0, 0),
       (1167, 'order_by_uploaded_date_desc', 'Uploaded Date DESC', 0, 0),
       (1168, 'order_by_downloads_asc', 'Downloads ASC', 0, 0),
       (1169, 'order_by_downloads_desc', 'Downloads DESC', 0, 0),
       (1170, 'order_by_filesize_asc', 'Filesize ASC', 0, 0),
       (1171, 'order_by_filesize_desc', 'Filesize DESC', 0, 0),
       (1172, 'order_by_last_access_date_asc', 'Last Access Date ASC', 0, 0),
       (1173, 'order_by_last_access_date_desc', 'Last Access Date DESC', 0, 0),
       (1174, 'file_item_updated', 'File updated.', 0, 1),
       (1175, 'your_uploads', 'Your Uploads', 0, 1),
       (1176, 'recent_uploads', 'Recent Uploads', 0, 1),
       (19380, 'trash_can', 'Trash Can', 0, 0),
       (19530, 'close', 'Close', 0, 0),
       (1179, 'upload_files', 'Upload Files', 0, 1),
       (1180, 'edit', 'Edit', 0, 0),
       (1181, 'share_folder', 'Share Folder', 0, 1),
       (19385, 'edit_folder', 'Edit', 0, 0),
       (19386, 'delete_folder', 'Delete', 0, 0),
       (1184, 'are_you_sure_you_want_to_remove_this_folder',
        'Are you sure you want to remove this folder? Any files within the folder will be moved into your default root folder and remain active.',
        0, 1),
       (19391, 'are_you_sure_you_want_to_empty_the_trash',
        'Are you sure you want to empty the trash can? Any statistics and other file information will be permanently deleted.',
        0, 0),
       (1186, 'selected_files', 'selected files', 0, 1),
       (1187, 'close_fullscreen', 'Close Fullscreen', 0, 0),
       (1188, 'fullscreen', 'Fullscreen', 0, 1),
       (1189, 'list_view', 'List View', 0, 1),
       (1190, 'icon_view', 'Icon View', 0, 1),
       (1191, 'show_tree', 'Show Tree', 0, 0),
       (1192, 'hide_tree', 'Hide Tree', 0, 0),
       (1193, 'file_url', 'File Url', 0, 0),
       (19526, 'file_urls', 'File Urls', 0, 0),
       (1195, 'error_no_files_selected', 'Error: No files selected.', 0, 0),
       (1196, 'refresh', 'Refresh', 0, 0),
       (1197, 'show_links', 'Show Links', 0, 0),
       (1198, 'update', 'Update', 0, 0),
       (1201, 'status_text', 'Status Text', 0, 0),
       (19362, 'upload_account', 'Upload', 0, 0),
       (1203, 'no_files_found', 'No files found.', 0, 1),
       (1204, 'urls_file_urls', 'File Urls', 0, 0),
       (19523, 'urls_html_code', 'HTML Code', 0, 0),
       (19524, 'urls_bbcode', 'Forum BBCode', 0, 0),
       (1207, 'urls_bb_code', 'Forum BBCode', 0, 0),
       (1208, 'media_converter_item_pending', 'This video is awaiting conversion, please check back again later.', 0,
        1),
       (1209, 'media_converter_item_processing',
        'This video is in the process of being converted, please check back again soon.', 0, 1),
       (19381, 'empty_trash', 'Empty Trash', 0, 0),
       (1211, 'copy_into_your_account', 'copy file', 0, 1),
       (1212, 'file_copied', 'File copied into your account. [[[FILE_LINK]]]', 0, 0),
       (1213, 'public_info_page', 'public info page', 0, 1),
       (1214, 'failed_to_copy_file', 'There was a problem copying the file, please try again later.', 0, 0),
       (1215, 'max_storage_space', 'maxiumum storage space', 1, 0),
       (1216, 'max_storage', 'maxiumum storage', 1, 0),
       (1217, 'max_storage_bytes', 'max storage (bytes)', 1, 0),
       (1218, 'server_priority', 'server priority', 1, 0),
       (1219, 'unpaid_earnings', 'unpaid earnings', 0, 0),
       (1220, 'estimated_pps_earnings', 'estimated PPS earnings', 0, 1),
       (1221, 'estimated_ppd_earnings', 'PPD estimated earnings', 0, 0),
       (1222, 'from_all_ppd_rate_groups', '(from all PPD rate groups)', 0, 0),
       (1223, 'total_unpaid_earnings', 'total unpaid earnings', 0, 1),
       (1224, 'pps_recent_rewards', 'pps recent rewards', 0, 1),
       (1225, 'from_x_items_across_all_ppd_rate_groups', '(from [[[ITEMS]]] items accross all PPD rate groups)', 0, 0),
       (1226, 'recent_ppd_earnings', 'PPD recent earnings', 0, 1),
       (1227, 'period', 'Period', 1, 1),
       (1228, 'links', 'Links', 0, 0),
       (1229, 'removed', 'removed', 0, 1),
       (1230, 'docviewer_plugin_watch_page_name', 'Preview', 0, 1),
       (1231, 'docviewer_plugin_page_description', 'Preview ', 0, 1),
       (1232, 'docviewer_plugin_meta_keywords', ', preview, file, upload, download, site', 0, 1),
       (1233, 'embed_document', 'Embed Document', 0, 1),
       (1235, 'pdf', 'pdf', 1, 0),
       (1236, 'docx', 'docx', 1, 0),
       (1237, 'xls', 'xls', 1, 0),
       (1240, 'site_path', 'site path', 1, 0),
       (1241, 'file_storage_path', 'file storage path', 1, 0),
       (1242, 'gdoc', 'gdoc', 1, 0),
       (1243, 'select_file_max', 'Select File (max: [[[MAX_SIZE]]])', 0, 0),
       (1244, 'delete_x_files', 'Delete <span class="fileCount"></span>Files', 0, 0),
       (1245, 'move_x_files', 'Move <span class="fileCount"></span>Files', 0, 0),
       (1246, 'delete_files_x', 'Delete Files[[[fileCount]]]', 0, 0),
       (1247, 'move_files_x', 'Move Files[[[fileCount]]]', 0, 0),
       (1248, 'delete_files_total', 'Delete Files[[[FILE_COUNT]]]', 0, 0),
       (1249, 'move_files_total', 'Move Files[[[FILE_COUNT]]]', 0, 0),
       (19396, 'file_manager_links', 'Links', 0, 0),
       (1251, 'file_manager_delete', 'Delete', 0, 1),
       (1252, 'file_manager_are_you_sure_you_want_to_delete', 'Are you sure you want to remove the selected files?', 0,
        0),
       (1253, 'file_manager_are_you_sure_you_want_to_delete_x_files',
        'Are you sure you want to remove the selected [[[TOTAL_FILES]]] file(s)?', 0, 1),
       (1254, 'report_file_full_file_url', 'Full file url', 0, 1),
       (1255, 'report_file_description_of_the_works', 'Description of the copyrighted works and supporting information',
        0, 1),
       (1256, 'report_file_your_name', 'Your name', 0, 1),
       (1257, 'report_file_email_address', 'Email address', 0, 1),
       (1258, 'report_file_postal_address', 'Postal address', 0, 1),
       (1259, 'report_file_phone_number', 'Phone number', 0, 1),
       (1260, 'report_file_signature', 'Signature', 0, 1),
       (1261, 'report_file_electronic_signature_of_the_copyright',
        'Electronic signature of the copyright owner or the person authorized to act on its behalf', 0, 1),
       (1262, 'report_file_confirm_1', 'Confirm 1', 0, 1),
       (1263, 'report_file_you_have_a_good_faith_belief',
        'You have a good faith belief that use of the material in the manner complained of is not authorized by the copyright owner, its agent, or the law.',
        0, 1),
       (1264, 'report_file_the_information_in_this_noticiation',
        'The information in the notification is accurate, and, under the pains and penalties of perjury, that you are authorized to act on behalf of the copyright owner.',
        0, 1),
       (1265, 'faq_unlimited', 'unlimited', 0, 1),
       (1266, 'faq_q1_question', 'Q: Is this free?', 0, 1),
       (1267, 'faq_q1_answer',
        'A: Yes, uploading and downloading is 100% Free for all users. We offer premium accounts which allows for greater flexibility with uploading/downloading.',
        0, 1),
       (1268, 'faq_q2_question', 'Q: Will my files be removed?', 0, 1),
       (1269, 'faq_q2_answer',
        'A: Free/non accounts files are kept for [[[KEPT_FOR_DAYS_FREE]]] days. Premium accounts files are kept for [[[KEPT_FOR_DAYS_PAID]]] days.',
        0, 0),
       (1270, 'faq_q3_question', 'Q: How many files can I upload?', 0, 1),
       (1271, 'faq_q3_answer',
        'A: You can upload as many files as you want, as long as each one adheres to the Terms of Service and the maximum file upload size.',
        0, 1),
       (1272, 'faq_q4_question', 'Q: Which files types am I allowed to upload?', 0, 1),
       (1273, 'faq_any', 'Any', 0, 0),
       (1274, 'faq_q4_answer', 'A: You may upload the following types of files: [[[FILE_TYPES]]].', 0, 1),
       (1275, 'faq_q5_question', 'Q: Are there any restrictions to the size of my uploaded files?', 0, 1),
       (1276, 'faq_q5_answer',
        'A: Each file you upload must be less than [[[MAX_UPLOAD_SIZE_FREE]]] in size for free/non accounts or less than [[[MAX_UPLOAD_SIZE_PAID]]] in size for premium accounts. If it is greater than that amount, your file will be rejected.',
        0, 0),
       (1277, 'faq_q6_question', 'Q: Can I upload music or videos?', 0, 1),
       (1278, 'faq_q6_answer',
        'A: Yes. Music and video hosting is permitted as long as you own the copyright on the content and it adheres to the terms and conditions.',
        0, 1),
       (1279, 'faq_q7_question',
        'Q: There are some files on our servers which may have been subject to copyright protection, how can I notify you of them?',
        0, 1),
       (1280, 'faq_q7_answer',
        'A: Via our <a href="report_file.[[[SITE_CONFIG_PAGE_EXTENSION]]]">report abuse</a> pages.', 0, 0),
       (1281, 'use_main_site_url', 'use main site url', 1, 0),
       (1282, 'report_file_no', 'no', 0, 1),
       (1283, 'report_file_yes', 'yes', 0, 1),
       (1284, 'test_trans', 'Test Trans', 0, 0),
       (1285, 'error_file_has_expired', 'File has been removed due to inactivity.', 0, 1),
       (17489, 'Arabic', 'Arabic', 0, 0),
       (1287, 'contact_page_name', 'Contact Us', 0, 1),
       (1288, 'contact_meta_description', 'Contact us', 0, 1),
       (1289, 'contact_meta_keywords', 'contact, us, questions, queries, file, hosting', 0, 1),
       (1290, 'contact_us', 'Contact Us', 0, 0),
       (1962, 'contact_title_page_description_left', 'Please fill out the following contact form to contact us', 0, 0),
       (1963, 'contact_intro',
        'If you wish to contact us regarding a copyright claim then please submit an abuse report. Abuse reports should be sent via our <a href="[[[ABUSE_URL]]]">abuse pages</a>.',
        0, 0),
       (1292, 'contact_full_name', 'Your full name', 0, 1),
       (1293, 'contact_email_address', 'Your email address', 0, 1),
       (1294, 'contact_your_query', 'Your query', 0, 1),
       (1295, 'contact_submit_query', 'submit query', 0, 0),
       (1296, 'contact_submit_form', 'submit form', 0, 1),
       (1297, 'contact_error_signature', 'Please enter your query.', 0, 1),
       (20594, 'contact_abuse_report_popup_notice',
        'Please submit all abuse reports via our dedicated abuse report page. Click OK to continue to it now.', 0, 0),
       (20595, 'contact_email_subject_v2',
        '"[[[QUERY_TYPE]]]" contact from [[[SITE_NAME]]] by "[[[LOGGED_IN_USERNAME]]]" user.', 0, 0),
       (20596, 'contact_email_content_v2',
        'There has been a contact form submission from [[[SITE_NAME]]] with the following details:<br/><br/>***************************************<br/>Full Name: [[[FULL_NAME]]]<br/>Email Address: [[[EMAIL_ADDRESS]]]<br/>Query Type: [[[QUERY_TYPE]]]<br/><br/>[[[QUERY]]]<br/>***************************************<br/>Logged In: [[[LOGGED_IN]]]<br/>Username: [[[LOGGED_IN_USERNAME]]]<br/>Submitted IP: [[[USERS_IP]]]<br/>***************************************<br/><br/>',
        0, 0),
       (1300, 'contact_success',
        'Thanks for submitting the contact form on our site. We''ll review the query as soon as possible and get back to your within the nexr 48 hours.',
        0, 1),
       (1301, 'contact_error_name', 'Please enter your name.', 0, 1),
       (1302, 'contact_error_email', 'Please enter your email.', 0, 1),
       (1303, 'contact_error_email_invalid', 'Please enter a valid email address.', 0, 1),
       (1304, 'js', 'js', 1, 0),
       (1305, 'remove_files_total', 'Remove Files[[[FILE_COUNT]]] (keep stats)', 0, 0),
       (1306, 'delete_files_and_data_total', 'Delete Files And Data[[[FILE_COUNT]]]', 1, 0),
       (1307, 'all_files', 'All Files', 0, 1),
       (1308, 'allowed_file_types', 'Allowed file types', 0, 1),
       (1310, '20', '20', 1, 0),
       (1311, '2', '2', 1, 0),
       (1312, '10', '10', 1, 0),
       (1313, 'moderator', 'moderator', 1, 0),
       (1315, 'pls', 'pls', 1, 0),
       (1316, 'time', 'time', 0, 1),
       (1317, 'no_data', 'No data', 0, 1),
       (1318, 'dev.mellowfish.com:8080', 'dev.mellowfish.com:8080', 0, 0),
       (1319, 'firefox', 'firefox', 0, 0),
       (1320, 'windows', 'windows', 0, 0),
       (1321, 'your_registered_account_email_address', 'Your registered account email address', 0, 1),
       (1322, 'login_form', 'login form', 0, 1),
       (1323, 'm4v', 'm4v', 1, 0),
       (1324, 'chrome', 'chrome', 0, 0),
       (1325, 'translation_import_csv_incorrect_columns', 'Line [[[LINE]]] should have [[[COLUMNS]]] columns.', 1, 0),
       (1326, 'no_file_selected', 'No file selected, please try again.', 1, 0),
       (1327, 'translation_import_csv_incorrect_columns_please_check',
        'Line [[[LINE]]] should have [[[COLUMNS]]] columns. Please check there''s not a double quote in the text content causing the error. Any double quotes in text should be escaped with a backslash. i.e. \\"',
        1, 0),
       (1328, 'index_upload_more_files', '<a href="[[[WEB_ROOT]]]">Click here</a> to upload more files.', 0, 1),
       (1329, 'account_home_per_page', 'Per Page:', 0, 1),
       (20792, 'datatable_first', 'First', 0, 0),
       (20793, 'datatable_previous', 'Previous', 0, 0),
       (20794, 'datatable_next', 'Next', 0, 0),
       (20795, 'datatable_last', 'Last', 0, 0),
       (19484, 'datatable_no_data_available_in_table', 'No data available in table', 0, 0),
       (19485, 'datatable_showing_x_to_x_of_total_entries', 'Showing _START_ to _END_ of _TOTAL_ entries', 0, 0),
       (19486, 'datatable_no_data', 'No data', 0, 0),
       (19487, 'datatable_show_menu_entries', 'Show _MENU_ entries', 0, 0),
       (19488, 'datatable_loading_please_wait', 'Loading, please wait...', 0, 0),
       (19489, 'datatable_base_filtered', ' (filtered)', 0, 0),
       (19490, 'datatable_search_text', 'Search:', 0, 0),
       (19491, 'datatable_no_matching_records_found', 'No matching records found', 0, 0),
       (17404, 'home_category_cars', 'Cars', 0, 0),
       (17405, 'home_category_colorful', 'Colorful', 0, 0),
       (1344, 'account_file_details_edit_file', 'Edit File', 0, 1),
       (19395, 'account_file_details_delete', 'Delete', 0, 0),
       (19393, 'account_file_details_download', 'Download', 0, 0),
       (1377, 'your_name_password_min_x_characters',
        'Your new password. Min 6 characters, alpha numeric and hypens only.', 0, 1),
       (1378, 'confirm_your_new_password', 'Confirm your new password.', 0, 1),
       (1379, 'indexjs_error_server_problem',
        'ERROR: There was a server problem when attempting the upload, please try again later.', 0, 1),
       (19423, 'indexjs_progress', 'Progress', 0, 0),
       (19424, 'indexjs_speed', 'Speed', 0, 0),
       (19426, 'indexjs_remaining', 'Remaining', 0, 0),
       (1383, 'file_download_error', 'Error', 0, 1),
       (1384, 'stats_file_details', 'file details', 0, 1),
       (1385, 'please_register_for_an_account', 'Please register for an account to upload.', 1, 0),
       (1386, 'uploading_has_been_disabled', 'Uploading has been disabled.', 1, 1),
       (19451, 'index_error', 'Error', 0, 0),
       (1388, 'index_login_to_enable', '- login to enable -', 0, 1),
       (19569, 'index_default', '- default -', 0, 0),
       (1390, 'classuploader_error', 'Error', 0, 1),
       (1391, 'classuploader_filename_not_found', 'Filename not found.', 0, 1),
       (1392, 'classuploader_file_received_has_zero_size',
        'File received has zero size. This is likely an issue with the maximum permitted size within PHP', 0, 1),
       (1393, 'classuploader_file_has_zero_size', 'File received has zero size.', 0, 1),
       (1394, 'classuploader_could_not_move_file_into_storage',
        'Could not move the file into storage, possibly a permissions issue.', 0, 1),
       (1395, 'search_results', 'Search Results', 0, 1),
       (1396, 'search_download_file', '[Download File]', 0, 1),
       (1397, 'search_searched_nothing', '<p>You didn\\''t enter anything to search for.</p>', 0, 1),
       (1398, 'search_too_short_p', '<p>Your search query is too short, minimum is ', 0, 1),
       (1399, 'search_too_short_a', ' characters.</p>', 0, 1),
       (1400, 'search_no_files_found', 'No Files Found', 0, 1),
       (1405, 'torrent_url', 'Torrent Url', 0, 1),
       (1406, 'report_abuse_error_name', 'Please enter your name.', 0, 1),
       (1407, 'report_abuse_error_email', 'Please enter your email.', 0, 1),
       (1408, 'report_abuse_error_signature',
        'Please provide the electronic signature of yourself or the copyright owner.', 0, 1),
       (1409, 'report_abuse_error_confirm_2',
        'Please confirm the information in the notification is accurate, and, under the pains and penalties of perjury, that you are authorized to act on behalf of the copyright owner.',
        0, 1),
       (1410, 'report_abuse_error_failed_reporting', 'Failed reporting file, please try again later', 0, 1),
       (1411, 'problem_updating_item', 'There was a problem updating the item, please try again later.', 1, 1),
       (1412, 'password_contains_illegal_characters', 'Password contains invalid characters, please choose another.', 1,
        1),
       (19397, 'account_file_details_stats', 'Stats', 0, 0),
       (1414, 'please_enter_your_title', 'Please enter your title', 1, 1),
       (1415, 'problem_creating_your_account_try_again_later',
        'There was a problem creating your account, please try again later', 1, 1),
       (1416, 'your_email_address_confirmation_does_not_match', 'Your email address confirmation does not match', 0, 1),
       (1417, 'please_enter_your_preferred_username', 'Please enter your preferred username', 0, 1),
       (19367, 'unlimited', 'unlimited', 0, 0),
       (1419, 'registration_required', 'Registration required.', 1, 0),
       (1420, 'unavailable', 'Unavailable.', 1, 1),
       (1421, 'file_upload_max_upload_php_limit', 'PHP Upload Limit.', 0, 1),
       (1422, 'please_enter_the_file_password', 'Please enter the file password.', 0, 1),
       (1423, 'upgrade_boxes_per_day', 'per day', 0, 1),
       (1424, 'classuploader_curl_module_not_found',
        'Curl module not found. Please enable within PHP to enable remote uploads.', 0, 1),
       (19436, 'torrent', 'torrent', 0, 0),
       (1426, 'newsletter_unsubscribe_could_not_find_account', 'Could not find an account with that email address', 0,
        1),
       (1430, 'settings_statistics_private', 'Private (only via your account)', 0, 0),
       (1431, 'settings_tip_file_statistics', 'Whether to keep all file stats private or allow public access.', 0, 1),
       (1432, 'stats_error_file_statistics_are_private', 'Statistics for this file are not publicly viewable.', 0, 1),
       (1433, 'index_uploading_disabled', 'Error: Uploading has been disabled.', 0, 1),
       (1434, 'registered', 'registered', 0, 1),
       (1435, 'download_page_yes', 'yes', 0, 1),
       (1436, 'download_page_none', 'none', 0, 1),
       (1437, 'download_page_premium', 'PREMIUM', 0, 1),
       (1438, 'download_page_slow_download', 'slow download', 0, 1),
       (1439, 'download_page_high_speed_download', 'high speed download', 0, 1),
       (1440, 'download_page_upgrade_to_premium', 'upgrade to premium', 0, 1),
       (1441, 'download_page_file', 'File', 0, 1),
       (1442, 'download_page_size', 'Size', 0, 1),
       (1443, 'download_pages', 'download pages', 1, 0),
       (1444, 'manage_download_pages', 'manage download pages', 1, 0),
       (1445, 'user_level', 'User Level', 1, 0),
       (1446, 'download_page', 'Download Page', 1, 0),
       (1447, 'view_order', 'View Order', 1, 0),
       (1448, 'user_level_page', 'User Level / Page', 1, 0),
       (20568, 'account_file_details_rotate_right', 'Rotate Right', 0, 0),
       (20572, 'account_file_details_join', 'Join Files', 0, 0),
       (19414, 'uploader_minutes', 'minutes', 0, 0),
       (20569, 'account_file_details_rotate_left', 'Rotate Left', 0, 0),
       (1455, 'please_enter_your_payload_account', 'Please enter your Payload Mercant Key.', 1, 0),
       (1456, 'download_page_page_order_can_not_be_zero_or_less', 'Page order can not be zero or less.', 1, 0),
       (1457, 'ftp_server_type', 'ftp server type', 1, 0),
       (1458, 'ftp_enable_passive_mode', 'enable passive mode', 1, 0),
       (1459, 'gif', 'gif', 1, 0),
       (1460, 'access_password', 'access password', 0, 1),
       (1461, 'the_password_to_access_the_file', 'The password to access the file', 0, 0),
       (17448, 'account_type_admin', 'Admin', 0, 0),
       (1463, 'file_status_system_expired', 'system expired', 0, 0),
       (1464, 'minute', 'minute', 0, 0),
       (1465, 'minutes', 'minutes', 0, 0),
       (1466, 'second', 'second', 0, 0),
       (1467, 'file_manager_moving', 'Moving', 0, 1),
       (1468, 'file_manager_moving_files', 'file(s)', 0, 1),
       (1469, 'account_type_free_user', 'Free User', 0, 0),
       (1470, 'file_manager_download', 'Download', 0, 0),
       (1471, 'file_manager_edit', 'Edit', 0, 0),
       (1472, 'unknown', 'unknown', 0, 1),
       (1473, 'account_file_details_select_all', 'Select All', 0, 0),
       (1474, 'account_file_details_select_all_files', 'Select All Files', 0, 1),
       (1476, 'classuploader_could_not_get_remote_file', 'Could not get remote file. [[[FILE_URL]]]', 0, 0),
       (1477, 'rewards_error_please_enter_your_paypal_email_address',
        'Error: Please enter your PayPal email address for the payment.', 0, 1),
       (1478, 'rewards_there_was_a_problem_requesting_the_withdraw',
        'There was a problem requesting the withdrawal, please try again later.', 0, 1),
       (1479, 'rewards_ppd_recent_earnings_are_added',
        'PPD recent earnings are added to your unpaid earnings each night.', 0, 1),
       (1480, 'rewards_earnings_can_be_withdrawn_when_balance',
        'Earnings can be withdrawn when balance is over [[[SYMBOL]]][[[PAYMENT_THRESHOLD]]].', 0, 0),
       (1832, 'rewards_please_confirm_your_withdrawal',
        'Please confirm your withdrawal of [[[SITE_CONFIG_COST_CURRENCY_SYMBOL]]][[[AVAILABLE_FOR_WITHDRAWAL]]]:', 0,
        0),
       (1482, 'rewards_your_paypal_email_address', 'Your PayPal Email Address:', 0, 1),
       (1483, 'rewards_ppd_logged_out_faq_additional_text',
        '\n                Once you''ve completed your registration just start uploading your files and sharing the download links with your family and friends.<br/><br/>You''ll be paid for any downloads outside of your account. Note: We only count completed downloads and downloads from unique IP addresses.\n                ',
        0, 0),
       (1484, 'rewards_logged_out_faq',
        '<p class="rewardsTopPadding"><strong>How can I claim my rewards?</strong></p>\n            <p>\n                Any rewards will take [[[PAYMENT_LEAD_TIME]]] days to clear within your account. Once your cleared rewards are over [[[SITE_CONFIG_COST_CURRENCY_SYMBOL]]][[[PAYMENT_THRESHOLD]]] you can request a payment via your account. Payments are made on the [[[PAYMENT_DATE]]] of every month via PayPal.\n            </p>\n            <p class="rewardsTopPadding"><strong>How do I get started?</strong></p>\n            <p>\n                Signup for an account on our <a href="[[[WEB_ROOT]]]/register.[[[SITE_CONFIG_PAGE_EXTENSION]]]">registration page</a>.\n                [[[ADDITIONAL_TEXT]]]\n            </p>',
        0, 0),
       (1485, 'password_policy_password_must_be_more_than_characters',
        'Password must be more than #VALUE# characters long', 0, 1),
       (1486, 'password_policy_password_must_be_less_than_characters',
        'Password must be less than #VALUE# characters long', 0, 1),
       (1487, 'password_policy_password_must_contact_uppercase_characters',
        'Password must contain at least #VALUE# uppercase characters', 0, 1),
       (1488, 'password_policy_password_must_contain_min_numeric_characters',
        'Password must contain at least #VALUE# numbers', 0, 1),
       (1489, 'password_policy_password_must_contain_min_nonalphanumeric_characters',
        'Password must contain at least #VALUE# non-aplhanumeric characters', 0, 1),
       (1490, 'confirm_password_edit', 'Confirm Password', 0, 1),
       (1491, 'your_password_confirmation_does_not_match', 'Your password confirmation does not match', 0, 1),
       (1492, 'a_new_account_password_confirm_leave_blank_to_keep',
        'Optional. Confirm the password entered above, leave this blank to keep your existing.', 0, 1),
       (1493, 'webm', 'webm', 1, 0),
       (1494, 'please_enter_your_paymentwall_sopg_username',
        'Please enter your PaySafeCard application key. This can be found in Application Settings.', 1, 1),
       (1495, 'please_enter_your_paymentwall_sopg_password', 'Please enter your PaySafeCard password.', 1, 1),
       (1496, 'micropayment_plugin_settings', 'Plugin Settings', 1, 1),
       (1497, 'micropayment_plugin_state', 'Plugin State', 1, 1),
       (1498, 'micropayment_plugin_state_desc', 'Whether the Micropayment payment option for upgrades is enabled', 1,
        1),
       (1499, 'micropayment_plugin_enabled', 'Plugin Enabled', 1, 1),
       (1500, 'micropayment_plugin_acct_number_desc', 'Your Micropayment account number.', 1, 0),
       (1501, 'micropayment_plugin_acct_number', 'Account number', 1, 1),
       (1502, 'micropayment_plugin_project_name', 'Project Name', 1, 1),
       (1503, 'micropayment_plugin_campaign_name', 'Campaign Name', 1, 1),
       (1504, 'micropayment_plugin_theme_name', 'Theme Name', 1, 1),
       (1505, 'micropayment_plugin_gfx_name', 'Gfx Name', 1, 1),
       (1506, 'micropayment_plugin_currency', 'Currency', 1, 1),
       (1507, 'micropayment_plugin_cc_enabled', 'Credit Card Enabled?', 1, 1),
       (1508, 'micropayment_plugin_dd_enabled', 'Direct Debit Enabled?', 1, 1),
       (1509, 'micropayment_plugin_telephone_enabled', 'Telephone Payment Enabled?', 1, 1),
       (1510, 'micropayment_plugin_sms_enabled', 'SMS Payment Enabled?', 1, 1),
       (1511, 'micropayment_plugin_acct_number_description',
        'Your Micropayment account number. Signup via <a href="http://micropayment.ch" target="_blank">micropayment.ch</a>',
        1, 1),
       (1512, 'please_enter_your_micropayment_account', 'Please enter your Micropayment Account.', 1, 1),
       (1513, 'please_enter_your_micropayment_project', 'Please enter your Micropayment Project Name.', 1, 1),
       (1514, 'please_enter_your_micropayment_theme', 'Please enter your Micropayment Theme.', 1, 1),
       (1515, 'please_enter_your_micropayment_gfx', 'Please enter your Micropayment Gfx Name.', 1, 1),
       (1516, 'please_enter_your_micropayment_currency', 'Please enter your Micropayment Currency.', 1, 1),
       (1517, 'html?', 'html?', 1, 0),
       (17386, 'upgrade_meta_keywords',
        ', account, paid, membership, download,  image, picture, pic, img, hosting, sharing, upload, storage, site, website',
        0, 0),
       (1540, 'com', 'com', 1, 0),
       (1541, '7e0ov', '7e0ov', 1, 0),
       (1542, 'download_all_files', 'Download All Files (Zip)', 0, 1),
       (19398, 'account_home_are_you_sure_download_all_files',
        'Are you sure you want to download all the files in this folder? This may take some time to complete.', 0, 0),
       (1544, 'account_home_getting', '- Getting ', 0, 1),
       (1545, 'account_home_download_zip_file', 'Download Zip File', 0, 1),
       (1546, 'report_file_confirm_2', 'Confirm 2', 0, 1),
       (1547, 'account_home_added_folder_to_zip', '- Added folder ', 0, 1),
       (1548, 'classuploader_file_received_larger_than_permitted',
        'File received is larger than permitted. (max [[[MAX_FILESIZE]]])', 0, 0),
       (1550, 'srt', 'srt', 1, 0),
       (1551, 'responsive_navigation_select_page', '- select page -', 0, 0),
       (19417, 'file_upload_maximum_number_of_files_exceeded', 'Maximum number of files exceeded', 0, 0),
       (19418, 'file_upload_file_type_not_allowed', 'File type not allowed', 0, 0),
       (19419, 'file_upload_file_is_too_large', 'File is too large', 0, 0),
       (19420, 'file_upload_file_is_too_small', 'File is too small', 0, 0),
       (1556, 'file_status_user_removed', 'user removed', 0, 0),
       (1557, 'hours', 'hours', 0, 0),
       (1558, 'mkv', 'mkv', 1, 0),
       (1559, 'rewards_day_clearing_on_all_pps_rewards_next_update',
        '[[[DAYS]]] day clearing period on all PPS rewards. Next update [[[NEXT_UPDATE]]].', 0, 0),
       (1560, 'rewards_pps_info_text_logged_in',
        '<p>\n                    Earn [[[PERCENTAGE]]]% of each sale you refer to this site! You can earn money from upgrading users in 2 ways:\n                </p>\n                <ol class="rewardsTextList">\n                    <li>Using your unique affiliate id, simply link to the site via your existing website. You''ll earn [[[PERCENTAGE]]]% for any users which register for an account and subsequently upgrade.</li>\n                    <li>From users which upgrade to download files within your account.</li>\n                </ol>\n                <p>\n                    Begin by uploading and sharing your files or by linking from your existing site using your affiliate id like this:\n                </p>\n                <ul>\n                    <li><a href="[[[WEB_ROOT]]]/?aff=[[[AFFILIATE_KEY]]]">[[[WEB_ROOT]]]/?aff=[[[AFFILIATE_KEY]]]</a></li>\n                </ul>',
        0, 0),
       (1561, 'rewards_pps_info_text_logged_out',
        '<p>\n                    Earn [[[PERCENTAGE]]]% of each sale you refer to this site! You can earn money from upgrading users in 2 ways:\n                </p>\n                <ol class="rewardsTextList">\n                    <li>Using your unique affiliate id, simply link to the site via your existing website. You''ll earn [[[PERCENTAGE]]]% for any users which register for an account and subsequently upgrade.</li>\n                    <li>From users which upgrade to download files within your account.</li>\n                </ol>\n                <p><strong>How much can you earn?</strong></p>\n                \n                <p>Based on [[[MONTHLY_UPGRADE_EXAMPLE]]] upgrades and each upgrade costing [[[SITE_CONFIG_COST_CURRENCY_SYMBOL]]][[[SITE_CONFIG_COST_FOR_30_DAYS_PREMIUM]]] per month, you could earn the following:</p>',
        0, 0),
       (1562, 'rewards_month', 'Month:', 0, 1),
       (1563, 'rewards_referrals', 'Referrals:', 0, 1),
       (1564, 'rewards_total_referrals', 'Total Referrals: (inc renewals)', 0, 1),
       (1565, 'rewards_monthly_total', 'Monthly Total:', 0, 1),
       (1566, 'rewards_total', 'Total:', 0, 1),
       (1567, 'rewards_pps_logged_out_faq_additional_text',
        '\n                Once you''ve completed your registration you''ll find your affiliate id in the ''rewards'' section of your account. Begin by uploading and sharing your files or by linking from your existing site using your affiliate id like this:\n                <ul>\n                    <li><a href="[[[WEB_ROOT]]]/?aff=[AFFILIATE_ID]">[[[WEB_ROOT]]]/?aff=[AFFILIATE_ID]</a></li>\n                </ul>',
        0, 0),
       (19425, 'indexjs_speed_ps', 'ps', 0, 0),
       (19427, 'indexjs_uploaded', 'Uploaded', 0, 0),
       (1570, 'active_file_with_same_name_found',
        'Active file with same name found in the same folder. Please ensure the file name is unique.', 0, 1),
       (1571, 'items_with_same_name_in_folder',
        'There are already [[[TOTAL_SAME]]] file(s) with the same filename in that folder. Files can not be removed.',
        0, 0),
       (19517, 'clear_filter', 'Clear Filter', 0, 0),
       (19518, 'apply_filter', 'Apply Filter', 0, 0),
       (1574, 'filter_your_files', 'Filter Your Files', 0, 1),
       (1575, 'account_home_no_active_files_in_folder', 'Error: No active files in folder.', 0, 1),
       (1576, 'edit_folder_optional_password', 'Optional Password:', 0, 1),
       (1577, 'folder_created', 'Folder created.', 0, 1),
       (1578, '<span>report_file_you_have_a_good_faith_belief',
        'You have a good faith belief that use of the material in the manner complained of is not authorized by the copyright owner, its agent, or the law.</span>',
        0, 0),
       (1579, '<strong>report_file_you_have_a_good_faith_belief',
        'You have a good faith belief that use of the material in the manner complained of is not authorized by the copyright owner, its agent, or the law.</strong>',
        0, 0),
       (1580, '<li>report_file_you_have_a_good_faith_belief',
        'You have a good faith belief that use of the material in the manner complained of is not authorized by the copyright owner, its agent, or the law.</li>',
        0, 0),
       (1581, 'folder_updated', 'Folder updated.', 0, 1),
       (1582, 'rdp', 'rdp', 1, 0),
       (1583, 'file_manager_loading', 'Loading...', 0, 1),
       (1584, 'success', 'Success', 0, 1),
       (1585, 'available_storage', 'Available Storage', 0, 1),
       (1586, 'used_storage', 'Used Storage', 0, 1),
       (1587, 'upload_files_link', 'Upload Files', 0, 0),
       (1588, 'click_to_upload', 'Click to <a href="#" onClick="uploadFiles(); return false;">Upload</a>', 0, 1),
       (1589, 'account_home_sort_by', 'Sort By', 0, 1),
       (1590, 'title_page_description',
        'Welcome, to, the,File Upload Scriptterms, of, service. Please, read, them, fully', 0, 0),
       (1991, 'report_abuse_title_page_description_left',
        'Please use the following form to report any copyright infringements ensuring you supply all the following information',
        0, 0),
       (1592, 'title_page_description_right', 'Enter Text or something.... ', 0, 0),
       (19529, 'loading_please_wait', 'Loading, please wait...', 0, 0),
       (1875, 'file_password_title_page_description_left',
        'A password is required to access this file, please enter it below.', 0, 0),
       (1594, 'faq_title_page_description_right', 'Enter Text or something.... ', 0, 1),
       (1857, 'register_text_2',
        'Please check your spam filters to ensure emails from this site get through. Emails from this site are sent from [[[SITE_CONFIG_DEFAULT_EMAIL_ADDRESS_FROM]]]',
        0, 0),
       (1869, 'stats_title', 'Statistics', 0, 0),
       (1596, 'report_abuse_title_page_description_right', 'Enter Text or something.... ', 0, 1),
       (1800, 'file_information_left_description', 'Information about', 0, 0),
       (1801, 'psd', 'psd', 1, 0),
       (1598, 'contact_title_page_description_right', 'Enter Text or something.... ', 0, 1),
       (1860, 'faq_title_page_description_left',
        '[[[SITE_CONFIG_SITE_NAME]]] frequently asked questions. If you have anymore questions please <a href=''[[[WEB_ROOT]]]/contact.[[[SITE_CONFIG_PAGE_EXTENSION]]]''>contact us</a>',
        0, 0),
       (1600, 'register_title_page_description_right', 'Enter some text or something.....', 0, 1),
       (1856, 'register_text',
        'Please enter your information to register for an account. Your new account password will be sent to your email address.',
        0, 0),
       (1603, 'file_delete_title_page_description_right', 'Enter some text or something.....', 0, 1),
       (1864, 'navigation_share_files', 'Share Files', 0, 0),
       (1605, 'payment_complete_title_page_description_right', 'Enter some text or something.....', 0, 1),
       (1607, 'terms_title_page_description_right', 'Enter Text or something.... ', 0, 1),
       (1609, 'register_complete_title_page_description_right', 'Enter some text or something.....', 0, 1),
       (19508, 'set_save_and_close', 'Save Options', 0, 0),
       (19457, 'set_upload_processing', 'Processing...', 0, 0),
       (1615, 'file_upload_remote_url_intro',
        'Download files directly from other sites into your account. Note: If the files are on another file download site or password protected, this may not work.',
        0, 1),
       (19495, 'set_transfer_files', 'Transfer Files', 0, 0),
       (1861, 'index_sign_up', 'Sign up now!', 0, 0),
       (1862, 'navigation_home', 'Home', 0, 0),
       (1618, 'file_statistics_title_page_description_right', 'Enter Text or something.... ', 0, 0),
       (1619, 'share_file_title', 'File Information', 0, 1),
       (1876, 'file_password_title_page_description_right', '', 0, 0),
       (1621, 'download_page_captcha_title_page_description_right', 'Enter Text or something.... ', 0, 1),
       (19399, 'file_manager_uploading', 'Uploading...', 0, 0),
       (19402, 'file_manager_upload_progress', 'Upload Progress:', 0, 0),
       (19401, 'file_manager_upload_complete_click_here_to_view', 'Upload complete. Click here to view links.', 0, 0),
       (1627, 'account_settings', 'account settings', 0, 0),
       (1628, 'file_manager_welcome', 'Welcome', 0, 1),
       (16996, 'index_slide1_or', 'Or', 0, 0),
       (19372, 'file_manager_logout', 'Logout', 0, 0),
       (1866, 'navigation_safe_and_secure', 'Safe and Secure', 0, 0),
       (1632, 'files_statistics_title_page_description_right', 'Downloads [[[DOWNLOAD_DATE]]]', 0, 0),
       (1633, 'account_settings_change_password', 'Change password.', 0, 1),
       (1634, 'account_settings_avatar', 'Account avatar.', 0, 1),
       (1635, 'account_settings_avatar_file', 'Select File (jpg, png or gif)', 0, 1),
       (1636, 'account_edit_avatar_is_too_large', 'The uploaded image can not be more than [[[MAX_SIZE_FORMATTED]]]', 0,
        0),
       (1637, 'account_edit_avatar_is_not_an_image', 'Your avatar must be a jpg, png or gif image.', 0, 1),
       (1638, 'account_settings_avatar_remove', 'Remove avatar', 0, 1),
       (1639, 'account_home_file_item_too_large_for_zip',
        '- File is too large to include in zip file ([[[FILE_NAME]]], [[[FILE_SIZE_FORMATTED]]])', 0, 1),
       (1640, 'account_home_too_many_files',
        'Error: Selected files are greater than [[[MAX_FILESIZE]]] in total. Can not create zip.', 0, 0),
       (1641, 'account_home_too_many_files_size',
        'Error: Selected files are greater than [[[MAX_FILESIZE]]] (total [[[TOTAL_SIZE_FORMATTED]]]). Can not create zip.',
        0, 0),
       (1642, 'file_manager_folder', 'Folder', 0, 1),
       (1643, 'edit_file_filename', 'Filename', 0, 0),
       (1644, 'edit_file_folder', 'Folder:', 0, 0),
       (1645, 'filter_in_where', 'Where', 0, 0),
       (1646, 'file_manager_current_folder', 'Current Folder', 0, 1),
       (1647, 'file_manager_all_files', 'All Files', 0, 1),
       (19511, 'file_manager_freetext_search', 'Freetext search...', 0, 0),
       (19515, 'file_manager_select_range', 'Select range...', 0, 0),
       (1651, 'filess_statistics_title_page_description_right', 'Uploaded [[[UPLOADED_DATE]]]', 0, 0),
       (1872, 'csv', 'csv', 1, 0),
       (1873, 'mcrypt_not_found', 'Mcypt functions not found within PHP, please ask support to install and try again.',
        0, 0),
       (1653, 'filesss_statistics_title_page_description_right', 'Uploaded [[[UPLOADED_DATE]]]', 0, 0),
       (1870, 'mozilla', 'mozilla', 0, 0),
       (1871, 'stats_page_name', 'View file statistics', 0, 0),
       (1655, 'filessss_statistics_title_page_description_right',
        'Uploaded [[[UPLOADED_DATE]]] Downloads [[[DOWNLOAD_DATE]]]', 0, 0),
       (1656, 'filesssss_statistics_title_page_description_right',
        'Uploaded [[[UPLOADED_DATE]]]</br> Downloads [[[DOWNLOAD_DATE]]]', 0, 0),
       (1657, 'banned_ip_expiry_date_is_in_the_past', 'The expiry date is in the past.', 1, 0),
       (1658, 'ban_expiry', 'Ban Expiry', 1, 0),
       (1659, 'login_ip_banned',
        'You have been temporarily blocked from logging in due to too many failed login attempts. Please try again [[[EXPIRY_TIME]]].',
        0, 0),
       (1660, 'password_change_email_subject', 'Password changed for account on [[[SITE_NAME]]]', 0, 0);
INSERT INTO `language_key` (`id`, `languageKey`, `defaultContent`, `isAdminArea`, `foundOnScan`)
VALUES (1661, 'password_change_email_content',
        'Dear [[[FIRST_NAME]]],<br/><br/>This is a courtesy email notifying you that your account password on [[[SITE_NAME]]] has been changed.<br/><br/>If you didn''t change your password, please contact us immediately. Otherwise just ignore this email.<br/><br/><strong>Url:</strong> <a href=''[[[WEB_ROOT]]]''>[[[WEB_ROOT]]]</a><br/><strong>Username:</strong> [[[USERNAME]]]<br/><br/>Feel free to contact us if you need any support with your account.<br/><br/>Regards,<br/>[[[SITE_NAME]]] Admin',
        0, 0),
       (1662, 'email_change_email_subject', 'Email changed for account on [[[SITE_NAME]]]', 0, 0),
       (1663, 'email_change_email_content',
        'Dear [[[FIRST_NAME]]],<br/><br/>This is a courtesy email notifying you that your account email address on [[[SITE_NAME]]] has been changed to [[[NEW_EMAIL]]].<br/><br/>If you didn''t change your email address, please contact us immediately. Otherwise just ignore this email.<br/><br/><strong>Url:</strong> <a href=''[[[WEB_ROOT]]]''>[[[WEB_ROOT]]]</a><br/><strong>Username:</strong> [[[USERNAME]]]<br/><strong>New Email:</strong> [[[NEW_EMAIL]]]<br/><br/>Feel free to contact us if you need any support with your account.<br/><br/>Regards,<br/>[[[SITE_NAME]]] Admin',
        0, 0),
       (1664, 'edit_file_could_not_find_username',
        'Could not find file owner username. Leave blank to set the file with no owner.', 1, 0),
       (1665, 'edit_file_file_with_same_short_url_exist', 'Short url already exists on another file.', 1, 0),
       (1666, 'edit_file_short_url_is_invalid', 'Short url structure is invalid. Only alphanumeric values are allowed.',
        1, 0),
       (1667, 'secure_and_safe', 'Secure and safe', 0, 0),
       (1668, 'secure_and_safe_description', 'secure and safe uploads', 0, 0),
       (1669, 'ods', 'ods', 1, 0),
       (1670, 'odt', 'odt', 1, 0),
       (1671, 'instant_access', 'Instant Access', 0, 0),
       (1672, 'manage_themes', 'manage themes', 1, 0),
       (1673, 'add_theme', 'add theme', 1, 0),
       (1674, 'themes', 'themes', 1, 0),
       (1675, 'theme_title', 'theme title', 1, 0),
       (1676, 'error_theme_folder_is_not_writable',
        'Theme folder is not writable. Ensure you set the following folder to CHMOD 755 or 777: [[[THEME_FOLDER]]]', 1,
        0),
       (1677, 'register_index', 'What are you waiting for?', 0, 1),
       (1678, 'register_index_description', 'Register below!', 0, 0),
       (1679, 'register_index_button', 'Register', 0, 1),
       (1680, 'index_slow', 'Slow...', 0, 1),
       (1681, 'index_super_fast', 'Super Fast!', 0, 1),
       (1682, 'contact_title_page_description_lleft',
        'test sdkjfgk dsfkudfh gkusdf hgukdg sdugshfdgsdfgsughuft hfsghsfghsfghf ', 0, 1),
       (1683, 'share_files_title_page_description_rightssdfsdf', 'test', 0, 0),
       (1684, 'share_file_titles', 'File', 0, 0),
       (1685, 'safe_and_secure', 'Safe and Secure', 0, 1),
       (1686, 'safe_and_secure_description',
        'Safely store and backup all your essential files. From family photos & videos to important documents, you can rely on us to store all your media securely and forever.',
        0, 1),
       (1687, 'select_payment_method', 'Select Payment Method:', 0, 1),
       (1689, 'view_folder_title_page_description_right', 'Enter Text or something.... ', 0, 1),
       (1690, 'direction', 'Direction', 1, 0),
       (1706, 'classuploader_general_upload_error', 's', 0, 0),
       (1709, 'account_home_ziparchive_class_no_exists', 's', 0, 1),
       (1708, 'account_home_can_not_locate_folder', 's', 0, 1),
       (19507, 'set_cancel', 'Cancel', 0, 0),
       (1705, 'classuploader_failed_adding_to_database', 's', 0, 0),
       (1704, 'classuploader_there_was_problem_uploading_file', 's', 0, 0),
       (1752, 'account_home_can_not_download_root', 'Error: Can not download root folder as zip file.', 0, 1),
       (1703, 'classuploader_could_not_authenticate_with_file_server', 's', 0, 0),
       (1702, 'classuploader_could_not_connect_file_server', 's', 0, 0),
       (19446, 'set_hide', 'Hide', 0, 0),
       (1698, 'account_home_failed_creating_zip_file', 's', 0, 0),
       (1699, 'classuploader_failed_creating_tmp_storage_folder', 's', 0, 0),
       (1885, 'classuploader_file_larger_than_permitted', 'File is larger than permitted. (max [[[MAX_FILESIZE]]])', 0,
        0),
       (1700, 'classuploader_temp_storage_folder_for_uploads_not_writable', 's', 0, 0),
       (1697, 'file_status_'' . str_replace('' ', 's', 0, 0),
       (1859, 'view_folder_title_page_description_left', '', 0, 0),
       (1855, 'register_title_page_description_left',
        'You''re just one step away from taking advantage of our file sharing service!', 0, 0),
       (1696, 'share_files_title_page_description_right', 's', 0, 1),
       (20579, 'last', 'last', 0, 0),
       (19832, 'album_by', 'By', 0, 0),
       (16898, 'index_slide2_right_text_bullet_3', 'Share on Facebook, Twitter, via Email & more.', 0, 0),
       (16894, 'index_slide2_right_text_bullet_1', 'Upload Your Images From <strong>Any Device</strong>.', 0, 0),
       (20581, 'view_now', 'view now', 0, 0),
       (19580, 'browse_categories', 'Browse Categories', 0, 0),
       (1692, 'test12345', 's', 0, 0),
       (1777, 'forgot_password_email_content',
        'Dear [[[FIRST_NAME]]],<br/><br/>We''ve received a request to reset your password on [[[SITE_NAME]]] for account [[[USERNAME]]]. Follow the url below to set a new account password:<br/><br/><a href=''[[[WEB_ROOT]]]/forgot_password_reset.[[[PAGE_EXTENSION]]]?u=[[[ACCOUNT_ID]]]&h=[[[RESET_HASH]]]''>[[[WEB_ROOT]]]/forgot_password_reset.[[[PAGE_EXTENSION]]]?u=[[[ACCOUNT_ID]]]&h=[[[RESET_HASH]]]</a><br/><br/>If you didn''t request a password reset, just ignore this email and your existing password will continue to work.<br/><br/>Regards,<br/>[[[SITE_NAME]]] Admin',
        0, 0),
       (1778, 'forgot_password_email_subject', 'Password reset instructions for account on [[[SITE_NAME]]]', 0, 0),
       (1695, 'problem_adding_item', 's', 0, 1),
       (1691, 'account_type_'' . str_replace('' ', 's', 0, 0),
       (3073, 'index_header', 'Powerful Image Hosting', 0, 0),
       (20582, 'choose_free_or_premium_access', 'Choose free or premium access', 0, 0),
       (1868, 'terms_title_page_description_left',
        'Welcome to the [[[SITE_CONFIG_SITE_NAME]]] terms of service. Please read them fully.', 0, 0),
       (17385, 'upgrade_title_page_description_left', 'See below for the various account and payment options.', 0, 0),
       (1854, 'error_title_page_description_left', '', 0, 0),
       (1714, 'please_enter_your_payza_email_address', 's', 1, 1),
       (1715, 'please_enter_your_maxipayment_urls_address', 's', 1, 1),
       (1721, 'please_enter_your_paymentwall_application_secret_key', 's', 1, 1),
       (1722, 'please_enter_your_api_login_id', 's', 1, 1),
       (1723, 'please_enter_your_transaction_key', 's', 1, 1),
       (1754, 'account_home_send_via_email', 'Send Via Email', 0, 1),
       (1753, 'account_home_file_details', 'File Details', 0, 1),
       (19443, 'set_upload_queue', 'Upload Queue', 0, 0),
       (1840, 'rewards_withdraw_confirmation_on_screen',
        'Your withdrawal request has been made. You''ll receive further information once the request has been approved.',
        0, 0),
       (1725, 'withdraw', 's', 0, 1),
       (1726, 'please_enter_your_secret_key', 's', 1, 1),
       (1727, 'please_enter_your_paypal_email_address', 's', 1, 1),
       (1738, 'please_enter_your_merchant_id_address', 's', 1, 1),
       (1739, 'please_enter_your_api_key', 's', 1, 1),
       (1741, 'please_enter_your_firstdata_api_login_id', 's', 1, 1),
       (1746, 'please_enter_your_egopay_store_id', 's', 1, 1),
       (1747, 'please_enter_your_egopay_store_password', 's', 1, 1),
       (1751, 'test123456', 'test123456', 0, 0),
       (1748, 'please_enter_your_micropayment_ccard', 's', 1, 1),
       (1749, 'please_enter_your_micropayment_ddebit', 's', 1, 1),
       (1750, 'please_enter_your_micropayment_mobpay', 's', 1, 1),
       (1757, 'extra_info', 'extra info', 0, 1),
       (1756, 'additional_info', 'additional info', 0, 0),
       (1755, 'view_image', 'view image', 0, 1),
       (19461, 'set_close', 'Close', 0, 0),
       (16873, 'index_slide1_description',
        'Upload, access, organize, edit, and share your photos from any device, from anywhere in the world.', 0, 0),
       (1863, 'navigation_store_and_manage', 'Store and Manage', 0, 0),
       (1776, 'later', 'later', 0, 1),
       (1770, 'view_document', 'view document', 0, 1),
       (1771, 'watch_video', 'watch video', 0, 1),
       (1772, 'play_audio', 'play audio', 0, 1),
       (1773, 'profile', 'profile', 1, 0),
       (1774, 'login_logging_in', 'logging in...', 0, 1),
       (1775, 'forgot_password_requesting_reset', 'requesting reset...', 0, 1),
       (1779, 'forgot_password_setting_password', 'setting password...', 0, 0),
       (1780, 'general_error', 'General error', 0, 0),
       (1781, 'forgot_password_reset_confirm_intro_text_login_below',
        'Your password has been reset. You can now login to the site below.', 0, 0),
       (1782, 'error_you_must_be_a_x_user_to_download_this_file',
        'You must be a [[[USER_TYPE]]] to download this file.', 0, 0),
       (18664, 'send_email', 'send email', 0, 0),
       (18660, 'account_file_details_intro_user_the_form_below_send_email',
        'Use the form below to share this file via email. The recipient will receive a link to download the file.', 0,
        0),
       (1785, 'message', 'message', 0, 0),
       (18662, 'recipient_email_address', 'recipient email address', 0, 0),
       (20879, 'extra_message', 'extra message (optional)', 0, 0),
       (18661, 'recipient_name', 'recipient full name', 0, 0),
       (1789, 'please_enter_the_recipient_name', 'Please enter the recipient name.', 0, 0),
       (1790, 'please_enter_the_recipient_email_address', 'Please enter the recipient email address.', 0, 0),
       (1791, 'account_file_details_share_via_email_subject', 'File shared by [[[SHARED_BY_NAME]]] on [[[SITE_NAME]]]',
        0, 0),
       (1792, 'not_applicable_short', 'n/a', 0, 0),
       (1793, 'file_sent_via_email_to_x', 'File sent via email to [[[RECIPIENT_EMAIL_ADDRESS]]]', 0, 0),
       (1795, 'please_enter_a_valid_recipient_email_address', 'Please enter a valid recipient email address.', 0, 0),
       (1796, 'account_file_details_share_via_email_content',
        'Dear [[[RECIPIENT_NAME]]],<br/><br/>[[[SHARED_BY_NAME]]] has shared the following file with you via <a href=''[[[WEB_ROOT]]]''>[[[SITE_NAME]]]</a>:<br/><br/><strong>File:</strong> [[[FILE_NAME]]]<br/><strong>Url:</strong> [[[FILE_URL]]]<br/><strong>From:</strong> [[[SHARED_BY_NAME]]] ([[[SHARED_EMAIL_ADDRESS]]])<br/><strong>Message:</strong> [[[EXTRA_MESSAGE]]]<br/><br/>Feel free to contact us if you have any difficulties downloading the file.<br/><br/>Regards,<br/>[[[SITE_NAME]]] Admin',
        0, 0),
       (1797, 'get_themes', 'get themes', 1, 0),
       (1799, 'newsletter_subscribe_title_page_description_right', 'newsletter text', 0, 0),
       (1804, 'file_upload_max_upload_php_limit_text',
        'Your PHP limits on [[[SERVER_NAME]]] need to be set to at least [[[MAX_SIZE]]] to allow larger files to be uploaded (currently [[[CURRENT_LIMIT]]]). Contact your host to set.',
        0, 0),
       (1805, 'classuploader_could_not_move_file_into_storage_on_x',
        'Could not move the file into storage on [[[SERVER]]], possibly a permissions issue with the file storage directory.',
        0, 0),
       (1806, 'file_status_admin_removed', 'admin removed', 0, 0),
       (1867, 'navigation_register', 'Register', 0, 0),
       (1809, 'file_download_title_page_description_right', 'Download file', 0, 0),
       (1813, 'email_address_not_allowed',
        'Registration from email addresses on [[[EMAIL_DOMAIN]]] have been blocked on this site.', 0, 0),
       (1814, 'date_added', 'Date Added', 1, 0),
       (1816, 'error_title_page_description_right', '', 0, 0),
       (1817, 'internal_notification_paid_account_expiring',
        'Your paid account is expiring in [[[DAYS]]] days. Your inactive files may removed if you do not renew your membership. Click here for more information.',
        0, 0),
       (1818, 'admin_user', 'admin User', 0, 0),
       (1819, 'error_reading_theme_details', 'Could not read the theme settings file ''_theme_config.inc.php''.', 1, 0),
       (1820, 'active_servers', 'Active Servers', 1, 0),
       (1821, 'file_path', 'File Path', 1, 0),
       (1822, 'server', 'Server', 1, 0),
       (1823, 'file_action', 'File Action', 1, 0),
       (1824, 'manage_file_action_queue', 'manage file action queue', 1, 0),
       (1825, 'action_queue', 'action queue', 1, 0),
       (1826, 'dev.mellowfish.com', 'dev.mellowfish.com', 0, 0),
       (1865, 'navigation_fast_downloading', 'Fast Downloading', 0, 0),
       (1828, 'forgot_password_title_page_description_right', '', 0, 0),
       (1829, 'embed_html_code', 'Embed HTML Code', 0, 0),
       (1830, 'embed_forum_code', 'Embed Forum Code', 0, 0),
       (1831, 'direct_link', 'Direct Link', 0, 0),
       (1833, 'rewards_select_payment_method', 'Payment Method:', 0, 0),
       (1834, 'rewards_field_label_paypal_email', 'Paypal Email:', 0, 0),
       (1835, 'rewards_field_label_your_postal_address', 'Your Postal Address:', 0, 0),
       (1836, 'rewards_field_label_your_account_name', 'Your Account Name:', 0, 0),
       (1837, 'rewards_field_label_international_iban_number', 'International Iban Number:', 0, 0),
       (1838, 'rewards_field_label_swift_number', 'Swift Number:', 0, 0),
       (1839, 'rewards_error_please_enter_all_the_details', 'Error: Please enter all the outpayment details.', 0, 0),
       (1841, 'method', 'Method', 1, 0),
       (1842, 'total_paid', 'total paid', 0, 0),
       (1846, 'upgrade_title_page_description_right', '', 0, 0),
       (1847, 'register_account_notification_text',
        'Thanks for registering and welcome to your account! Start uploading files straight away by clicking the ''Upload'' button below. Feel free to contact us if you need any help.',
        0, 0),
       (1848, 'xlsx', 'xlsx', 1, 0),
       (16880, 'index_slide2_header', 'First Class Image Manager', 0, 0),
       (1880, '91838000 1', '91838000 1', 1, 0),
       (1881, '34782400 1', '34782400 1', 1, 0),
       (1882, '99907800 1', '99907800 1', 1, 0),
       (1883, 'xml', 'xml', 1, 0),
       (1884, 'profsave', 'profsave', 1, 0),
       (1886, 'mov', 'mov', 1, 0),
       (1887, 'db', 'db', 1, 0),
       (1888, 'account_type_paid_user', 'Paid User', 0, 0),
       (1889, 'index_earn_money_title_one', 'Want to earn some money?', 0, 0),
       (1890, 'index_earn_money_title_two', 'You can earn thousands of dollers from us!', 0, 0),
       (1891, 'index_rewards_button', 'Earn Money', 0, 0),
       (1894, 'View Tickets', 'View Tickets', 1, 0),
       (1895, 'Create Ticket', 'Create Ticket', 1, 0),
       (1896, 'Support Tickets', 'Support Tickets', 1, 0),
       (1934, 'delete_selected', 'Delete Selected', 0, 0),
       (19403, 'file_manager_are_you_sure_you_want_to_duplicate_x_files',
        'Are you sure you want to duplicate the selected [[[TOTAL_FILES]]] file(s)?', 0, 0),
       (1957, 'file_manager_duplicate', 'Duplicate', 0, 0),
       (1958, 'file_manager_files_duplicated_success_message', 'Files duplicated in current folder.', 0, 0),
       (1959, 'your_files_index', 'Enter Your Account Home', 0, 0),
       (1960, 'your_files_index_button', 'Your Files', 0, 0),
       (1961, 'index_your_files_tagline', 'Upload, share and manage your files', 0, 0),
       (1964, 'file_delete_title_page_description_left', 'Please confirm whether to delete the file below.', 0, 0),
       (1965, 'user_logout', 'Logout', 0, 0),
       (1966, 'brt_file_hosting_script', 'File Hosting Script', 0, 0),
       (1967, 'brt_upload', 'Upload', 0, 0),
       (1968, 'brt_free_file_hosting', 'Free File Hosting Manager', 0, 0),
       (1969, 'brt_happy_customers', 'Happy Customers', 0, 0),
       (1970, 'brt_fb_likes', 'Facebook Likes', 0, 0),
       (1971, 'brt_twiter_followers', 'Twiter Followers', 0, 0),
       (1972, 'brt_files_download', 'Files Downloaded', 0, 0),
       (1973, 'brt_upload_files', 'Upload', 0, 0),
       (1974, 'brt_premium', 'Premium', 0, 0),
       (1975, 'brt_terms', 'Terms & Conditions', 0, 0),
       (1976, 'brt_faq', 'FAQ', 0, 0),
       (1977, 'brt_report', 'Report Files', 0, 0),
       (1978, 'brt_contact', 'Contact Us', 0, 0),
       (1979, 'safe_anonymous', '100% Safe &', 0, 0),
       (1980, 'safe_anonymou', 'Anonymous', 0, 0),
       (1981, 'brt_conatct', 'Contact', 0, 0),
       (1982, 'brt_home', 'Home', 0, 0),
       (1983, 'brt_submit_form', 'Submit Form', 0, 0),
       (1984, 'brt_report_file', 'Report File', 0, 0),
       (1985, 'brt_submit_report', 'Submit Report', 0, 0),
       (1986, 'payment_complete_title_page_description_left', 'Thanks for your payment!', 0, 0),
       (1987, 'forgot_password_title_page_description_left', '', 0, 0),
       (1988, 'brt_password_reset', 'Password Reset', 0, 0),
       (1989, 'brt_forgot.psw', 'Request Reset', 0, 0),
       (1990, 'brt_login', 'Login', 0, 0),
       (1992, 'download_or_view_now', 'download / view now', 0, 0),
       (19836, 'album_total_images', 'Total Images', 0, 0),
       (1994, 'error_creating_theme_folder',
        'There was a problem creating the theme folder. Please ensure the following folder has CHMOD 777 permissions: /var/www/php_site_scripts/file_hosting/themes/',
        1, 0),
       (17396, 'home_dropdown', ' HOME', 0, 0),
       (1996, 'rewards_index', 'rewards', 0, 0),
       (1997, 'rewards_index_test', 'rewards', 0, 0),
       (1998, 'index1', 'index1', 1, 0),
       (1999, 'index2', 'index2', 1, 0),
       (2000, 'index3', 'index3', 1, 0),
       (2001, 'forgot_password_reset_title_page_description_left', '', 0, 0),
       (2002, 'forgot_password_reset_title_page_description_right', '', 0, 0),
       (2003, 'register_complete_title_page_description_left', 'Thank you for registering!', 0, 0),
       (2004, '', '', 0, 0),
       (2006, 'remote_access', 'remote access', 0, 0),
       (20577, 'previous', 'previous', 0, 0),
       (2045, 'account_file_details_extract', 'Extract Files', 0, 0),
       (2046, 'account_file_details_archive', 'Compress to Zip/Rar', 0, 0),
       (16882, 'index_slide2_description', 'Slick image management for the digital generation', 0, 0),
       (2071, 'option_no', 'No', 0, 0),
       (2072, 'option_yes', 'Yes', 0, 0),
       (2079, 'faq_title', 'Frequently Asked Questions', 0, 0),
       (2080, 'register_title', 'Register', 0, 0),
       (2083, 'rar', 'rar', 1, 0),
       (2084, 'alert', 'Alert', 1, 0),
       (2085, 'search', 'Search', 1, 0),
       (2086, 'dashboard', 'dashboard', 1, 0),
       (2087, 'plugins', 'Plugins', 1, 0),
       (2088, 'Configuration', 'Configuration', 1, 0),
       (2089, 'more', 'more....', 1, 0),
       (2090, 'file_manager_new_notifications', 'new notifications.', 0, 0),
       (19363, 'file_manager_you_have_x_new_notifications', 'You have <strong>[[[UNREAD]]]</strong> new notifications.',
        0, 0),
       (2092, 'custom_premium_download_button', 'Premium Download (No Waiting Time)', 0, 0),
       (2093, 'custom_download_button', 'Download', 0, 0),
       (2094, 'Manage Torrents', 'Manage Torrents', 1, 0),
       (2095, 'Torrents', 'Torrents', 1, 0),
       (2103, 'title_ms', 'Ms', 0, 0),
       (2104, 'View Torrents', 'View Torrents', 1, 0),
       (2126, 'background_task_logs', 'background task logs', 1, 0),
       (2127, 'task_name', 'Task Name', 1, 0),
       (2128, 'last_update', 'Last Update', 1, 0),
       (2129, 'last_run', 'Last Run', 1, 0),
       (2130, 'start_time', 'Start Time', 1, 0),
       (2131, 'end_time', 'End Time', 1, 0),
       (19839, 'album_total_likes', 'Total Likes', 0, 0),
       (2133, 'css', 'css', 1, 0),
       (2134, 'Item1', 'Item1', 1, 0),
       (2135, 'Item2', 'Item2', 1, 0),
       (2140, 'week', 'week', 0, 0),
       (2141, 'weeks', 'weeks', 0, 0),
       (16886, 'index_slide2_image_manager_desktop', 'Desktop Image Manager', 0, 0),
       (2152, 'file_manager_mark_all_read', 'Mark all Read', 0, 0),
       (2153, 'file_manager_you_have_x_new_notification', 'You have <strong>[[[UNREAD]]]</strong> new notification.', 0,
        0),
       (2155, '000', '000', 1, 0),
       (2156, 'date_scheduled', 'Date Added', 1, 0),
       (2157, 'action_type', 'Type', 1, 0),
       (2158, 'please_enter_your_your_secret', 'Please enter your G2aPay secret key.', 1, 0),
       (2159, '001', '001', 1, 0),
       (19440, 'drag_and_drop_images_here_or_click_to_browse', 'Drag &amp; drop images here or click to browse...', 0,
        0),
       (17395, 'navigation_home_upload', 'UPLOAD', 0, 0),
       (19437, 'add_images', 'Add images...', 0, 0),
       (2174, 'add_more', 'add more...', 0, 0),
       (2175, 'add_more_images', 'add more', 0, 0),
       (19421, 'indexjs_error_server_problem_reservo', 'ERROR: There was a server problem when attempting the upload.',
        0, 0),
       (2177, 'file_manager_album', 'Album', 0, 0),
       (19383, 'add_album', 'Add Album', 0, 0),
       (2179, 'edit_album', 'Edit', 0, 0),
       (2180, 'delete_album', 'Delete', 0, 0),
       (19389, 'share_album', 'Share Album', 0, 0),
       (19512, 'file_manager_current_album', 'Current Album', 0, 0),
       (2183, 'edit_album_name', 'Album Name:', 0, 0),
       (2184, 'edit_folder_parent_album', 'Parent Album:', 0, 0),
       (2185, 'edit_album_is_public', 'Public:', 0, 0),
       (2186, 'edit_album_optional_password', 'Optional Password:', 0, 0),
       (19387, 'add_albumfolder', 'Add Album', 0, 0),
       (19390, 'are_you_sure_you_want_to_remove_this_album',
        'Are you sure you want to remove this album? Any files within the album will be moved into your default root folder and remain active.',
        0, 0),
       (2189, 'please_enter_the_albumname', 'Please enter the album name', 0, 0),
       (2190, 'problem_updating_album', 'There was a problem updating the album, please try again later.', 0, 0),
       (19346, 'your_albums', 'your albums', 0, 0),
       (2192, 'album_created', 'Album created.', 0, 0),
       (2193, 'edit_existing_album', 'Edit Existing Album', 0, 0),
       (2194, 'update_album', 'update album', 0, 0),
       (19388, 'download_all_images', 'Download All Images (Zip)', 0, 0),
       (19509, 'filter_your_images', 'Filter Your Images', 0, 0),
       (19513, 'file_manager_all_albums', 'All Albums', 0, 0),
       (19522, 'image_urls', 'Image Urls', 0, 0),
       (2199, 'Theme', 'Theme', 1, 0),
       (2200, 'Manage', 'Manage', 1, 0),
       (2201, 'Add', 'Add', 1, 0),
       (2202, 'Image Categories', 'Image Categories', 1, 0),
       (2203, 'Manage Categories', 'Manage Categories', 1, 0),
       (2204, 'Add Category', 'Add Category', 1, 0),
       (2205, 'album_updated', 'Album updated.', 0, 0),
       (2206, 'contact_page_title_1', 'Leave us a message', 0, 0),
       (2207, 'contact_page_title_2', 'More Info', 0, 0),
       (2208, 'theme_reservo_datatable_no_matching_records_found', 'No categories found in current search filter.', 0,
        0),
       (2209, 'category_with_same_name_found', 'Category with same name or url key already exists. Please try again.',
        1, 0),
       (2210, 'please_enter_the_category_key', 'Please enter the category url key', 1, 0),
       (2211, 'please_enter_the_category_name', 'Please enter the category name', 1, 0),
       (2212, 'category', 'category', 0, 0),
       (19505, 'public_category', 'public category', 0, 0),
       (2214, 'public_category_listed_on_site', 'public category (shown on the public image browsing pages)', 0, 0),
       (2215, 'public_category_shown_on_site', '(shown on the public image browsing pages)', 0, 0),
       (2216, 'album', 'album', 0, 0),
       (2217, 'edit_image_privacy', 'Image Privacy:', 0, 0),
       (2218, 'privacy_private_no_access', 'Private, no access outside of your account.', 0, 0),
       (2219, 'privacy_limited_access', 'Limited, access only if users know the sharing link.', 0, 0),
       (2220, 'privacy_yes_allow_public', 'Public, listed on the site and within search results.', 0, 0),
       (2221, 'edit_file_privacy', 'File Privacy:', 0, 0),
       (18649, 'views', 'views', 0, 0),
       (2224, 'track 1', 'track 1', 1, 0),
       (2225, 'account_image_details_stats', 'Image Stats', 0, 0),
       (19394, 'account_file_details_edit_image', 'Edit Image', 0, 0),
       (18645, 'account_file_details_image_stats', 'Image Stats', 0, 0),
       (18646, 'account_file_details_download_image', 'Download Image', 0, 0),
       (2229, 'account_file_details_delete_image', 'Delete Image', 0, 0),
       (18652, 'sharing_code', 'sharing code', 0, 0),
       (18654, 'image_data', 'image data', 0, 0),
       (19340, 'browse_page_name', 'Browse', 0, 0),
       (19341, 'browse_meta_description', 'Browse Images', 0, 0),
       (19342, 'browse_meta_keywords', 'browser, images, file, your, interface, upload, download, site', 0, 0),
       (2235, 'account_home_search_images', 'Search Images...', 0, 0),
       (19359, 'account_header_search_images', 'Search images...', 0, 0),
       (19361, 'advanced_search', 'Advanced Search', 0, 0),
       (2238, 'used', 'used', 0, 0),
       (2239, 'umlimited_storage', 'Unlimited Storage', 0, 0),
       (2240, 'account_types', 'account types', 1, 0),
       (2241, 'account_packages', 'account packages', 1, 0),
       (2242, 'upload_allowed', 'upload allowed', 1, 0),
       (2243, 'max_upload_size', 'max upload size', 1, 0),
       (2244, 'on_upgrade_page', 'upgrade page', 1, 0),
       (2245, 'total_users', 'total users', 1, 0),
       (2246, 'label', 'label', 1, 0),
       (2247, 'period_label', 'period label', 1, 0),
       (2248, 'price_usd', 'price usd', 1, 0),
       (2249, 'price_gbp', 'price gbp', 1, 0),
       (2250, 'price_eur', 'price eur', 1, 0),
       (2251, 'pricing_label', 'pricing label', 1, 0),
       (2252, 'price', 'price', 1, 0),
       (2253, 'account_package', 'account package', 1, 0),
       (2255, 'rewards_ppd_note', 'Note', 0, 0),
       (2256, 'rewards_ppd_not_available_for_user_type', 'PPD is not available with your account.', 0, 0),
       (2257, 'rewards_ppd_note:_not_available_for_user_type', 'Note: PPD is not available with your account.', 0, 0),
       (2258, 'buy_paid_account_button_now', 'Buy Now', 0, 0),
       (2260, 'upgrade_page_package_features_level_id_2',
        '<li class="list-group-item"><i class="fa fa-lock"></i> Secure Payment</li><li class="list-group-item"><i class="fa fa-eye-slash"></i> 100% Safe & Anonymous</li>',
        0, 0),
       (2261, 'upgrade_account_choose_pricing_upgrade', 'Upgrade To', 0, 0),
       (2262, 'support_info', 'support info', 1, 0),
       (2263, 'upload_method', 'Method', 1, 0),
       (2264, 'progress', 'progress', 0, 0),
       (2265, 'are_you_sure_you_want_to_remove_the_remote_url_download',
        'Are you sure you want to cancel this download?', 0, 0),
       (2267, 'clear', 'clear', 0, 0),
       (2268, 'account_level_label_invalid', 'Please specify the label.', 1, 0),
       (2269, 'account_level_label_already_in_use', 'That label has already been used, please choose another.', 1, 0),
       (2270, 'paid_account_expiry_section_header', 'Premium account expiry details.', 0, 0),
       (2271, 'account_home_expiry_date', 'Account expiry date', 0, 0),
       (19352, 'navigation_browse', 'Browse', 0, 0),
       (19353, 'navigation_featured', 'Featured', 0, 0),
       (2275, 'navigation_profile', 'Profile', 0, 0),
       (19356, 'navigation_likes', 'Likes', 0, 0),
       (18733, 'last_seen', 'last seen', 0, 0),
       (2278, 'feed', 'Feed', 0, 0),
       (19536, 'albums', 'albums', 0, 0),
       (18738, 'likes', 'Likes', 0, 0),
       (19533, 'images', 'Images', 0, 0),
       (18735, 'likes received', 'likes received', 0, 0),
       (2283, 'account_settings_profile_image', 'Profile Image.', 0, 0),
       (2284, 'account_settings_profile_image_file', 'Select File (jpg, png or gif)', 0, 0),
       (2285, 'account_edit_profile_image_is_not_an_image', 'Your profile image must be a jpg, png or gif image.', 0,
        0),
       (2286, 'account_settings_profile_image_remove', 'Remove profile image', 0, 0),
       (18736, 'edit_profile', 'Edit Profile', 0, 0),
       (2288, 'no_albums_found', 'No albums found.', 0, 0),
       (2289, 'repeat_password', 'repeat password', 0, 0),
       (2290, 'speed', 'Speed', 0, 0),
       (2291, 'Comments Overview', 'Comments Overview', 1, 0),
       (2292, 'Reported Comments', 'Reported Comments', 1, 0),
       (18648, 'comments', 'comments', 0, 0),
       (2299, 'image_sent_via_email_to_x', 'Image sent via email to [[[RECIPIENT_EMAIL_ADDRESS]]]', 0, 0),
       (2303, 'profile_by', 'by', 0, 0),
       (2305, 'file_at', 'at', 0, 0),
       (2308, 'like', 'Like', 0, 0),
       (16995, 'index_slide1_register', 'Register', 0, 0),
       (19378, 'all_images', 'All Images', 0, 0),
       (20576, 'first', 'first', 0, 0),
       (18647, 'account_file_details_view_comments', 'Click to view comments', 0, 0),
       (2318, 'account_file_details_view_stats', 'Click to view stats', 0, 0),
       (18650, 'account_file_details_likes', 'Like this image', 0, 0),
       (19357, 'navigation_your_images', 'Your Images', 0, 0),
       (19350, 'selected_file', 'selected file', 0, 0),
       (2322, 'private_info_page', 'private info page', 0, 0),
       (2323, 'account_file_details_send_email_links_disabled', 'Sharing links has been disabled on this file.', 0, 0),
       (2324, 'premium_for', 'Premium for', 0, 0),
       (2325, 'user_settings', 'user settings', 1, 0),
       (2326, 'package_price', 'package price', 1, 0),
       (2327, 'package_pricing_label', 'package pricing label', 1, 0),
       (2328, 'payment_period', 'payment period', 1, 0),
       (2329, 'package_label', 'package label', 1, 0),
       (2330, 'allow_upload', 'allow upload', 1, 0),
       (2331, 'Test User', 'Test User', 1, 0),
       (2332, 'privacy_public_access', 'Public - access only if users know the sharing link.', 0, 0),
       (2333, 'file_privacy', 'file privacy', 0, 0),
       (2334, 'settings_tip_private_files', 'Whether to keep all files private or allow sharing.', 0, 0),
       (2335, 'settings_public_files', 'All Files Publicly Accessible', 0, 0),
       (2336, 'settings_private_files', 'All Files Private (only via your account', 0, 0),
       (2337, 'error_file_is_not_public', 'File is not shared publicly.', 0, 0),
       (2338, 'view_folder_page_name', 'View Folder', 0, 0),
       (2339, 'view_folder_meta_description', 'View Folder', 0, 0),
       (2340, 'error_file_is_not_publicly_shared', 'File is not publicly available.', 0, 0),
       (2341, 'permissions', 'permissions', 0, 0),
       (20845, 'private_file', 'Private File - Only available via your account, or via a generated sharing url.', 0, 0),
       (18641, 'sharing', 'Sharing', 0, 0),
       (18642, 'public_file', 'Public File - Can be Shared', 0, 0),
       (2345, 'm2v', 'm2v', 1, 0),
       (2346, 'flv', 'flv', 1, 0),
       (2348, 'test_user_user', 'TEST USER USER', 0, 0),
       (2349, 'test_user', 'TEST USER', 0, 0),
       (2350, 'upgrade_page_package_features_level_id_3',
        '<li class="list-group-item"><i class="fa fa-lock"></i> Secure Payment</li><li class="list-group-item"><i class="fa fa-eye-slash"></i> 100% Safe & Anonymous</li>',
        0, 0),
       (2351, 'guest', 'Guest', 0, 0),
       (3074, 'index_description',
        'Upload, access, organize, edit, and share your photos from any device, from anywhere in the world.', 0, 0),
       (15041, 'or', 'Or', 0, 0),
       (15042, 'premium_pricing', 'Premium Pricing', 0, 0),
       (2357, 'login_to_your_account', 'Login to your Account', 0, 0),
       (16890, 'index_slide2_image_manager_phone', 'Mobile Phone Image Manager', 0, 0),
       (2359, 'guest_user', 'Guest User', 0, 0),
       (2361, 'home_category_', 'Home', 0, 0),
       (17414, 'home_category_weddings', 'Weddings', 0, 0),
       (17415, 'home_category_work', 'Work', 0, 0),
       (16872, 'index_slide1_header', 'Powerful Image Hosting', 0, 0),
       (17406, 'home_category_illustrations', 'Illustrations', 0, 0),
       (17407, 'home_category_just-for-fun', 'Just For Fun', 0, 0),
       (17409, 'home_category_nature', 'Nature', 0, 0),
       (17411, 'home_category_scenes', 'Scenes', 0, 0),
       (16924, 'index_slide3_safe_secure_description',
        'Safely store all of your precious images. You can rely on us to keep your images safe and secure.', 0, 0),
       (2376, 'upgrade_page_package_features_level_id_21',
        '<li class="list-group-item"><i class="fa fa-lock"></i> Secure Payment</li><li class="list-group-item"><i class="fa fa-eye-slash"></i> 100% Safe & Anonymous</li>',
        0, 0),
       (2377, 'upgrade_page_package_features_level_id_23',
        '<li class="list-group-item"><i class="fa fa-lock"></i> Secure Payment</li><li class="list-group-item"><i class="fa fa-eye-slash"></i> 100% Safe & Anonymous</li>',
        0, 0),
       (2378, 'upgrade_page_package_features_level_id_24',
        '<li class="list-group-item"><i class="fa fa-lock"></i> Secure Payment</li><li class="list-group-item"><i class="fa fa-eye-slash"></i> 100% Safe & Anonymous</li>',
        0, 0),
       (17430, 'most_popular', 'Most Popular', 0, 0),
       (17439, 'upgrade_now', 'Upgrade Now', 0, 0),
       (2381, 'register_free_account_button', 'Register', 0, 0),
       (2382, 'upgrade_page_package_features_level_id_1', '<li><i class="fa fa-hdd-o"></i> Advert Supported</li>', 0,
        0),
       (2383, 'register_now', 'Register Now', 0, 0),
       (17441, 'unique_members_area', 'Unique Members Area', 0, 0),
       (17420, 'advert_supported', 'Advert Supported', 0, 0),
       (17442, 'advert_free', 'No Adverts', 0, 0),
       (2387, 'priority_support', 'Priority Support', 0, 0),
       (2388, 'features_overview_header', 'Features Overview', 0, 0),
       (2389, 'features_overview_description', 'Some of the Features that are gonna blow your mind off', 0, 0),
       (11757, 'unique_image_manager_header', 'Unique Image Manager', 0, 0),
       (11758, 'unique_image_manager_description',
        'Our high peformance image manager allows you to control all of your pictures with its easy to use interface.',
        0, 0),
       (11760, 'responsive_design_header', 'Mobile, Tablet &amp; Desktop', 0, 0),
       (11761, 'responsive_design_description',
        'Powerful Layout with Responsive functionality that can be adapted to any screen size. Resize browser to view.',
        0, 0),
       (11763, 'safe_secure_header', 'Safe &amp; Secure', 0, 0),
       (11764, 'safe_secure_description',
        'Safely store all of your precious images. You can rely on us to keep your images protected.', 0, 0),
       (11766, 'backup_header', 'Backed Up Forever', 0, 0),
       (11767, 'backup_description',
        'All of your images are securely backed up on our databases to give you peace of mind.', 0, 0),
       (11769, 'image_tools_header', 'Powerful Image Tools', 0, 0),
       (11772, 'share_memories_header', 'Share Your Memories', 0, 0),
       (11773, 'share_memories_description',
        'We supply you with all the tools necessary to easily share your images with friends &amp; family.', 0, 0),
       (11775, 'image_searching_header', 'Fast Image Searching', 0, 0),
       (11776, 'image_searching_description',
        'Quickly access all of your images by using our fast image searching tools.', 0, 0),
       (11778, 'private_albums_header', 'Private Albums', 0, 0),
       (11779, 'private_albums_description',
        'Keep your most personal &amp; valued images entirely private with our locked albums feature.', 0, 0),
       (11781, 'always_on_header', 'Always On', 0, 0),
       (11782, 'always_on_description',
        'Access our site at any time from any location to store &amp; manage your images.', 0, 0),
       (2408, 'footer_navigation', 'Navigation', 0, 0),
       (17413, 'home_category_travel', 'Travel', 0, 0),
       (16997, 'index_slide1_premium', 'Premium Access', 0, 0),
       (17412, 'home_category_sports', 'Sports', 0, 0),
       (6169, 'first_class_image_manager', 'First Class Image Manager', 0, 0),
       (6170, 'first_class_image_manager_description', 'Some of the Features that are gonna blow your mind off', 0, 0),
       (14512, 'premium_access_description', 'Flexible &amp; Easy Pricing for wide Audience Groups', 0, 0),
       (14791, 'get_started_now_description', 'What are you waiting for? Join us!', 0, 0),
       (2417, 'any', 'Any', 0, 0),
       (2418, 'Personal', 'Personal', 1, 0),
       (19499, 'store_in_album', 'store in album:', 0, 0),
       (2420, 'select_album_below_to_store_intro_text',
        'Select an album below to store these files in. All current uploads files will be available within these albums.',
        0, 0),
       (2421, 'enter_a_password_below_to_secure_your_images',
        'When downloading these images, users will be prompted for a password, if set. Download managers will not work if a password is set.',
        0, 0),
       (19497, 'enter_an_email_address_below_to_send_the_list_of_images',
        'Enter an email address below to send the list of images via email once they''re uploaded.', 0, 0),
       (19501, 'album_name', 'Album Name', 0, 0),
       (19447, 'image_upload_completed', 'Image uploads completed.', 0, 0),
       (19460, 'index_upload_more_images', '<a href="[[[WEB_ROOT]]]">Click here</a> to upload more images.', 0, 0),
       (19458, 'view_all_links', 'View All Links', 0, 0),
       (2427, 'view_image_on', 'View image on', 0, 0),
       (2428, 'on', 'on', 0, 0),
       (2429, 'edit_file_sharing_url', 'Sharing Url:', 0, 0),
       (2430, 'edit_image_sharing_url', 'Sharing Url:', 0, 0),
       (2431, 'your_album', 'your album', 0, 0),
       (19504, 'public_category_shown_on_site_intro',
        'Listed in this category whe shared publicly on the site. Leave blank if you are keeping the images private.',
        0, 0),
       (2437, 'privacy_public_limited_access', 'Public Limited - access only if users know the sharing link.', 0, 0),
       (2438, 'file_folder_privacy_notice',
        'You can not update this [[[FILEFOLDER]]] permissions as your account settings are set to make all files private.',
        0, 0),
       (2439, 'edit_album_privacy', 'Album Privacy:', 0, 0),
       (2440, 'edit_album_privacy_notice',
        'You can not update this album privacy settings as your account settings are set to make all files private or the parent folder is set to private.',
        0, 0),
       (2441, 'edit_album_privacy_notice_note',
        'Note: You can not update this album privacy settings as your account settings are set to make all files private or the parent folder is set to private.',
        0, 0),
       (2442, 'settings_tip_private_files_text',
        'Whether to keep all files private or allow sharing. If this is set as public, you can still set albums as private.',
        0, 0),
       (2443, 'privacy', 'Privacy', 0, 0),
       (2444, 'default_album_privacy', 'Default Album Privacy', 0, 0),
       (2445, 'image_statistics', 'Image Statistics', 0, 0),
       (2446, 'folder_is_not_publicly_shared_please_contact',
        'Folder is not publicly shared. Please contact the owner and request they update the privacy settings.', 0, 0),
       (19384, 'upload_images', 'Upload Images', 0, 0),
       (6652, 'image_manager_desktop', 'Desktop Image Manager', 0, 0),
       (6653, 'image_manager_tablet', 'Tablet Image Manager', 0, 0),
       (6654, 'image_manager_phone', 'Phone Image Manager', 0, 0),
       (2452, 'image_sample', 'Image Sample', 0, 0),
       (11756, 'unique_image_manager_alt', 'Unique Image Manager', 0, 0),
       (11759, 'mobile_tablet_desktop_alt', 'Mobile, Tablet &amp; Desktop', 0, 0),
       (11762, 'safe_secure_alt', 'Safe &amp; Secure', 0, 0),
       (11765, 'backed_up_alt', 'Backed Up Forever', 0, 0),
       (11768, 'image_tools_alt', 'Powerful Image Tools', 0, 0),
       (11771, 'share_memories_alt', 'Share Your Memories', 0, 0),
       (11774, 'image_searching_alt', 'Fast Image Searching', 0, 0),
       (11777, 'private_albums_alt', 'Private Albums', 0, 0),
       (11780, 'always_on_alt', 'Always On', 0, 0),
       (2462, 'folder_protected', 'Folder Protected', 0, 0),
       (2463, 'password_protected', 'Password Protected', 0, 0),
       (2464, 'this_folder_has_a_password_set',
        'This folder requires a password to gain access. Use the form below to enter the password, then click "unlock".',
        0, 0),
       (2465, 'password_required', 'Password Required', 0, 0),
       (2466, 'unlock', 'Unlock', 0, 0),
       (2467, 'album_password_is_invalid', 'The album password is invalid', 0, 0),
       (2468, 'problem_loading_album', 'There was a problem loading the album, please try again later.', 0, 0),
       (20824, 'no_files_found_in_this_album',
        'No files found within this folder. Drag & drop files to upload here or click ''Upload'' above.', 0, 0),
       (2470, 'no_images_found_in_this_album', 'No images found within this album.', 0, 0),
       (2471, 'already_an_album_with_that_name', 'You already have an album with that name, please use another', 0, 0),
       (2472, 'this_user_has_not_set_any_albums_public', 'This user has not publicly shared any albums..', 0, 0),
       (2473, 'no_images_found', 'No images found.', 0, 0),
       (2474, 'footer_about_us', 'About Us', 0, 0),
       (2475, 'facebook_page_url_is_invalid', 'Facebook url is invalid.', 1, 0),
       (17463, 'footer_about_us_text',
        'Premium image hosting, <strong>Fast Access</strong> to your important images & <strong>Huge Storage</strong> limits. Mobile, tablet & desktop access. See what you missing, <a href="[[[WEB_ROOT]]]/register.[[[SITE_CONFIG_PAGE_EXTENSION]]]">join us</a> today.',
        0, 0),
       (17464, 'total_views', 'Total Views', 0, 0),
       (17465, 'total_images', 'Total Images', 0, 0),
       (17466, 'like_is', 'Like us', 0, 0),
       (17467, 'on_facebook', 'on Facebook', 0, 0),
       (20570, 'account_file_details_add_archive', 'Add to Zip/Rar', 0, 0),
       (2482, 'enable_download_accelerators', 'Enable Download Accelerators?', 1, 0),
       (2483, 'browse_by_date_taben', 'By Date Taken', 0, 0),
       (19583, 'categories', 'Categories', 0, 0),
       (2485, 'profiles', 'Profiles', 0, 0),
       (2486, 'there_are_no_albums_shared_publicly', 'There are no albums shared publicly.', 0, 0),
       (2487, 'account_edit_security_lock_header', 'Account security lock.', 0, 0),
       (2488, 'account_edit_security_lock_description', 'Account lock status', 0, 0),
       (2489, 'account_lock_long_description',
        'The account security lock, when enabled, prevents your account details (name, email, password) from being edited, it also prevents files from being edited, moved and deleted.<br/>To unlock your account, you will need the password which is emailed to your registered email address when the lock is enabled.',
        0, 0),
       (2490, 'activate_security_lock', 'Activate security lock', 0, 0),
       (2491, 'lock_account_email_subject', 'Security lock details for [[[SITE_NAME]]]', 0, 0),
       (2492, 'lock_account_email_content',
        'Dear [[[FIRST_NAME]]],<br/><br/>Your account on [[[SITE_NAME]]] has been locked as per your request. Use the code below to unlock your account:<br/><br/><strong>Unlock code:</strong> [[[UNLOCK_CODE]]]<br/><br/>Feel free to contact us if you need any support with your account.<br/><br/>Regards,<br/>[[[SITE_NAME]]] Admin',
        0, 0),
       (2493, 'account_lock_activation_success_message', 'Account successfully secured.', 0, 0),
       (2494, 'account_locked_folder_delete_error_message',
        'This account has been locked, please unlock the account to regain full functionality.', 0, 0),
       (2495, 'account_locked_folder_edit_error_message',
        'This account has been locked, please unlock the account to regain full functionality.', 0, 0),
       (2496, 'account_edit_security_lock_code', 'Account lock code', 0, 0),
       (2497, 'deactivate_security_lock', 'De-activate security lock', 0, 0),
       (2498, 'deactivate_security_lock_resend_code', 'Resend security code', 0, 0),
       (2499, 'account_lock_deactivation_no_code_message', 'Please enter the unlock code and try again.', 0, 0),
       (2500, 'account_edit_security_locked', 'Locked', 0, 0),
       (2501, 'account_lock_deactivation_success_message', 'Account successfully unlocked.', 0, 0),
       (2502, 'account_edit_security_unlocked', 'Unlocked', 0, 0),
       (2503, 'account_lock_resend_email_confirm_message',
        'The email containing the unlock code has been emailed to the registered email account.', 0, 0),
       (2504, 'account_lock_deactivation_code_mismatch', 'Account could not be unlocked as the code is incorrect.', 0,
        0),
       (2505, 'file_statistics_title_page_description_rights',
        'Uploaded [[[UPLOADED_DATE]]]</br> Downloads [[[DOWNLOAD_DATE]]]', 0, 0),
       (2506, 'improved_download_management', 'Improved Downloads', 1, 0),
       (2507, 'btn_register', 'REGISTER', 0, 0),
       (19847, 'album_total_views', 'Total Views', 0, 0),
       (20571, 'account_file_details_split', 'Split File', 0, 0),
       (20573, 'download_from', 'Download from', 0, 0),
       (19851, 'album_share', 'Share', 0, 0),
       (2514, 'browse', 'browse', 0, 0),
       (19535, 'browse_albums', 'Browse Albums', 0, 0),
       (20575, 'class_file_from', 'from', 0, 0),
       (2517, 'slideshow', 'Slideshow', 0, 0),
       (2518, 'account_file_play_slideshow', 'Play Slideshow', 0, 0),
       (19534, 'recent_image_uploads', 'Recent Image Uploads', 0, 0),
       (2520, 'professional', 'PROFESSIONAL', 0, 0),
       (2521, 'account_locked_file_edit_error_message',
        'This account has been locked, please unlock the account to regain full functionality.', 0, 0),
       (2522, 'search_page_name', 'Search', 0, 0),
       (2523, 'search_images', 'Search Images', 0, 0),
       (2524, 'search_albums', 'Search Albums', 0, 0),
       (2525, 'search_page_title', 'Search [[[TERM]]]', 0, 0),
       (2526, 'search_page_title_term', 'Search "[[[TERM]]]"', 0, 0),
       (2527, 'recent_image_uploads_search_results', 'Recent Image Uploads - Search Results', 0, 0),
       (2528, 'search_albums_results', 'Albums Search Results', 0, 0),
       (2529, 'recent_image_search_results', 'Recent Image Search Results', 0, 0),
       (2530, 'image_search_results', 'Image Search Results', 0, 0),
       (19408, 'browse_images', 'Browse Images', 0, 0),
       (2532, 'there_are_no_album_results_search', 'There are no albums given the current search criteria.', 0, 0),
       (2533, 'no_images_found_in_search', 'No images found within album or search criteria.', 0, 0),
       (2534, 'download_page_captcha_title_page_description_left',
        'In order to prevent abuse of this service, please copy the words into the text box below.', 0, 0),
       (2535, 'account_lock_activation_failure_message',
        'Account could not be secured at this time, please try again later.', 0, 0),
       (2536, 'paid_account_expires', 'Premium Expires.', 0, 0),
       (2537, 'account_lock_status', 'Account status', 0, 0),
       (2538, 'account_lock', 'Account Lock', 0, 0),
       (2539, 'do_nothing', 'Do Nothing', 0, 0),
       (2540, 'activate_lock', 'Activate Lock', 0, 0),
       (2541, 'account_lock_long_description_blue_v2',
        'The account security lock prevents your account details and files from being edited, moved and deleted.', 0,
        0),
       (2542, 'ppt', 'ppt', 1, 0),
       (2543, 'image_colors', 'Image Colors', 0, 0),
       (18643, 'color_palette', 'Color Palette', 0, 0),
       (19351, 'navigation_community', 'Community', 0, 0),
       (19354, 'navigation_account', 'Account', 0, 0),
       (19368, 'navigation_public_profile', 'Public Profile', 0, 0),
       (19432, 'image_upload', 'image upload', 0, 0),
       (19453, 'image_upload_remote_url_intro',
        'Download images directly from other sites into your account. Note: If the images are on another image download site or password protected, this may not work.',
        0, 0),
       (19454, 'set_transfer_images', 'Transfer Images', 0, 0),
       (19456, 'enter_up_to_x_image_urls',
        'Enter up to [[[MAX_REMOTE_URL_IMAGES]]] image urls. Separate each url on it''s own line.', 0, 0),
       (19459, 'image_transfers_completed', 'Image transfers completed.', 0, 0),
       (19500, 'select_album_below_to_store_intro_text_images',
        'Select an album below to store these images in. All current uploads will be available within these albums.', 0,
        0),
       (2554, 'account_unlock_code', 'Unlock Code', 0, 0),
       (2555, 'account_unlock_long_description',
        'The unlock code that was sent to the registered email address when the lock was activated.', 0, 0),
       (2556, 'unlock_account', 'unlock account', 0, 0),
       (2557, 'resend_unlock_code', 'resend unlock code', 0, 0),
       (2558, 'account_lock_deactivation_failure_message',
        'Account could not be unlocked at this time, please try again later.', 0, 0),
       (17410, 'home_category_other', 'Other', 0, 0),
       (11259, 'powerful_features_description', 'We have a large varierty of features available', 0, 0),
       (11770, 'image_tools_description',
        'We have multple tools that you can use for your images such as slide shows, embedding, sharing and more.', 0,
        0),
       (19473, 'you_can_not_add_more_than_x_urls_at_once', 'You can not add more than [[[MAX_URLS]]] urls at once.', 0,
        0),
       (16902, 'index_slide2_right_text_bullet_5', 'Unique Image Tools, Watermarking, Slideshows & more.', 0, 0),
       (16597, 'index_page_name', 'Upload & Share Images', 0, 0),
       (16904, 'index_slide2_right_text_bullet_6', 'Heroic <strong>Support Team</strong>.', 0, 0),
       (16906, 'index_slide3_header', 'Powerful Features', 0, 0),
       (16908, 'index_slide3_description', 'Packed full of features that will blow your mind!', 0, 0),
       (16910, 'index_slide3_unique_image_manager_alt', 'Unique Image Manager', 0, 0),
       (16892, 'index_slide2_right_text_title', 'What Is [[[SITE_CONFIG_SITE_NAME]]]?', 0, 0),
       (16893, 'index_slide2_right_text_intro',
        'Built for the modern world of digital imagery, we''ve got loads of great features to help you manage your images.',
        0, 0),
       (16918, 'index_slide3_responsive_design_description',
        'Access images on the go using your mobile phone, or show a client photos using your iPad. Use any modern device.',
        0, 0),
       (16900, 'index_slide2_right_text_bullet_4', 'Secure Storage & Password Protected Albums.', 0, 0),
       (16920, 'index_slide3_safe_secure_alt', 'Safe &amp; Secure', 0, 0),
       (16922, 'index_slide3_safe_secure_header', 'Safe &amp; Secure', 0, 0),
       (16926, 'index_slide3_backed_up_alt', 'Stored In The Cloud', 0, 0),
       (16928, 'index_slide3_backup_header', 'Stored In The Cloud', 0, 0),
       (16912, 'index_slide3_unique_image_manager_header', 'Unique Image Manager', 0, 0),
       (16913, 'index_slide3_unique_image_manager_description',
        'Our image manager allows you to quickly manage all of your images and photos with its modern, easy to use interface.',
        0, 0),
       (16942, 'index_slide3_image_searching_alt', 'Fast Image Searching', 0, 0),
       (16944, 'index_slide3_image_searching_header', 'Fast Image Searching', 0, 0),
       (16932, 'index_slide3_image_tools_alt', 'Powerful Image Tools', 0, 0),
       (16933, 'index_slide3_image_tools_header', 'Powerful Image Tools', 0, 0),
       (17477, 'term_and_conditions', 'terms and conditions', 0, 0),
       (17478, 'report_file', 'report file', 0, 0),
       (16952, 'index_slide3_private_albums_description',
        'Keep your most personal & valued images entirely private with our locked albums feature.', 0, 0),
       (16953, 'index_slide3_always_on_alt', 'Always On', 0, 0),
       (19371, 'extend_account', 'extend account', 0, 0),
       (16993, 'index_slide5_header', 'Get Started Now', 0, 0),
       (16994, 'index_slide5_description', 'What are you waiting for? It''s Free!', 0, 0),
       (17596, 'account_home_meta_keywords', 'account, home, file, your, interface, upload, download, site', 0, 0),
       (17394, 'logo', 'Logo', 0, 0),
       (19344, 'premium', 'premium', 0, 0),
       (19345, 'login', 'login', 0, 0),
       (17399, 'premium_access', 'Premium Access', 0, 0),
       (17400, 'get_started_now', 'Get Started Now', 0, 0),
       (17401, 'home_browse', ' BROWSE', 0, 0),
       (17402, 'home_category_animals', 'Animals', 0, 0),
       (16888, 'index_slide2_image_manager_tablet', 'Tablet Image Manager', 0, 0),
       (17416, 'search_type_and_hit_enter', 'Type & Hit Enter..', 0, 0),
       (17408, 'home_category_music', 'Music', 0, 0),
       (16896, 'index_slide2_right_text_bullet_2', 'Lots of <strong>Free Storage</strong> for Your Images.', 0, 0),
       (16914, 'index_slide3_mobile_tablet_desktop_alt', 'Mobile, Tablet &amp; Desktop', 0, 0),
       (16916, 'index_slide3_responsive_design_header', 'Mobile, Tablet &amp; Desktop', 0, 0),
       (16930, 'index_slide3_backup_description',
        'All of your images are securely stored in the cloud for piece of mind. Don''t risk loosing CDs or hard drives failing.',
        0, 0),
       (16934, 'index_slide3_image_tools_description',
        'We have lots of tools that you can use to easily manage your images. Slideshows, embedding, sharing, rotating and more.',
        0, 0),
       (16936, 'index_slide3_share_memories_alt', 'Share Your Memories', 0, 0),
       (16938, 'index_slide3_share_memories_header', 'Share Your Memories', 0, 0),
       (16940, 'index_slide3_share_memories_description',
        'Share your images on social networks like Facebook or provide limited access to just friends & family.', 0, 0),
       (16946, 'index_slide3_image_searching_description',
        'Quickly access all of your images by using our fast image searching tools.', 0, 0),
       (16948, 'index_slide3_private_albums_alt', 'Private Albums', 0, 0),
       (16950, 'index_slide3_private_albums_header', 'Private Albums', 0, 0),
       (16954, 'index_slide3_always_on_header', 'Always On', 0, 0),
       (16956, 'index_slide3_always_on_description',
        'Access our site at any time from any location in the world. Upload while travelling or straight after a photoshoot.',
        0, 0),
       (16958, 'index_slide4_header', 'Premium Access', 0, 0),
       (16960, 'index_slide4_description', 'Optional premium access for additional storage space', 0, 0),
       (17479, 'contact', 'contact', 0, 0),
       (19376, 'recent_images', 'Recent Images', 0, 0),
       (17458, 'images_kept_for_x_days', 'Images kept for [[[DAYS]]] days.', 0, 0),
       (17473, 'your_files', 'your files', 0, 0),
       (19370, 'uprade_account', 'upgrade account', 0, 0),
       (17476, 'faq', 'faq', 0, 0),
       (17445, 'free', 'free', 0, 0),
       (17440, 'storage', 'Storage', 0, 0),
       (17469, 'to_rss_feeds', 'to RSS Feeds', 0, 0),
       (17471, 'your_account', 'Your Account', 0, 0),
       (20567, 'account_file_details_view', 'View', 0, 0),
       (17481, 'rewards', 'rewards', 0, 0),
       (17485, 'English (en)', 'English (en)', 0, 0),
       (19415, 'uploader_second', 'second', 0, 0),
       (19416, 'uploader_seconds', 'seconds', 0, 0),
       (17459, 'upload_images_up_to_x_in_size', 'Upload images up to [[[MAX_UPLOAD_FILESIZE]]] in size.', 0, 0),
       (20583, 'direct_album_downloads_no_waiting', 'Direct album downloads. No waiting.', 0, 0),
       (20584, 'header_search_files', 'Search files...', 1, 0),
       (20585, 'contact_select_subject', 'select subject', 0, 0),
       (20586, 'contact_query_type_site_support', 'Site Support', 0, 0),
       (20587, 'contact_query_type_bug_report', 'Bug Report', 0, 0),
       (20588, 'contact_query_type_abuse_report', 'Abuse Report', 0, 0),
       (20589, 'contact_query_type_suggest_improvements', 'Suggest Improvements', 0, 0),
       (20590, 'contact_query_type_other', 'Other', 0, 0),
       (20591, 'contact_error_query_type', 'Please select your type of query.', 0, 0),
       (20597, 'contact_query_type', 'Query type', 0, 0),
       (20598, 'Image Link', 'Image Link', 0, 0),
       (20599, 'email', 'email', 0, 0),
       (20600, 'meta', 'Meta', 0, 0),
       (20601, 'album_page_name', 'Album', 0, 0),
       (20602, 'album_meta_description', 'Album', 0, 0),
       (20603, 'album_meta_keywords', 'album, images, file, your, interface, upload, download, site', 0, 0),
       (20604, 'album_view', 'View', 0, 0),
       (20605, 'album_album', 'Album', 0, 0),
       (20606, 'account_home_image_name_og', 'Image', 0, 0);
INSERT INTO `language_key` (`id`, `languageKey`, `defaultContent`, `isAdminArea`, `foundOnScan`)
VALUES (20607, 'account_home_description_og', 'View 630803_87861202.jpg Image', 0, 0),
       (20608, 'image', 'image', 0, 0),
       (20609, 'account_file_details_edit_image_info', 'Edit Image Info', 0, 0),
       (20610, 'account_file_set_as_albume_cover', 'Set As Album Cover', 0, 0),
       (20611, 'account_set_cover_image_success', 'Cover image updated.', 0, 0),
       (20612, 'edit_album_cover_image', 'Cover Image:', 0, 0),
       (20613, 'edit_album_cover_image_description', 'Cover Image: (Url of the Image in Your Account)', 0, 0),
       (20614, 'nef', 'nef', 1, 0),
       (20615, 'eip', 'eip', 1, 0),
       (20616, 'arw', 'arw', 1, 0),
       (20617, 'erf', 'erf', 1, 0),
       (20618, 'bmp', 'bmp', 1, 0),
       (20619, 'dng', 'dng', 1, 0),
       (20620, 'orf', 'orf', 1, 0),
       (20621, 'cr2', 'cr2', 1, 0),
       (20622, 'crw', 'crw', 1, 0),
       (20623, 'navigation_images', 'Images', 0, 0),
       (20624, 'navigation_albums', 'Albums', 0, 0),
       (20625, 'navigation_categories', 'Categories', 0, 0),
       (20626, 'category_listing', 'Category Listing', 0, 0),
       (20627, '3fr', '3fr', 1, 0),
       (20628, 'view_on', 'View on', 0, 0),
       (20629, 'direct_image_link', 'Direct Image Link', 0, 0),
       (20630, 'image_page_link', 'Image Page Link', 0, 0),
       (20631, 'account_file_details_album_not_publicy_shared',
        'This image is not publicly shared. You will need to make it public before the recipient can view it.', 0, 0),
       (20632, 'account_file_details_album_not_publicly_shared',
        'This image is not publicly shared. You will need to make it public before the recipient can view it.', 0, 0),
       (20633, 'account_file_details_original', 'Original', 0, 0),
       (20634, 'account_file_details_version', 'Version', 0, 0),
       (20635, 'eps', 'eps', 1, 0),
       (20636, 'account_file_details_select_all_images', 'Select All Images', 0, 0),
       (20637, 'selected_image', 'selected image', 0, 0),
       (20638, 'selected_images', 'selected images', 0, 0),
       (20639, 'selected_image_clear', 'clear', 0, 0),
       (20640, 'selected', 'selected', 0, 0),
       (20641, 'search_your_images', 'Search Your Images', 0, 0),
       (20642, 'file_manager_your_images', 'Your Images', 0, 0),
       (20643, 'file_manager_all_images', 'All Images', 0, 0),
       (20652, 'account_settings_profile_banner_image', 'Profile Banner Image.', 0, 0),
       (20654, 'passwords_do_not_match', 'Your passwords do not match.', 0, 0),
       (20655, 'mng', 'mng', 1, 0),
       (20658, 'index_store_title', 'Store all of your images with us', 0, 0),
       (20659, 'index_store_description',
        'You can store all of your images on our powerful servers at the touch of a button at home or on the go..', 0,
        0),
       (20660, 'index_premium_title', 'Did you know..', 0, 0),
       (20661, 'index_why_choose_us_description', 'We also offer a premium membership with lots of bonuses!', 0, 0),
       (20662, 'index_premium_button', 'Premium Pricing', 0, 0),
       (20762, 'upload_your_image_and_youll_be_paid_for_every',
        'Upload and share your images and you''ll be paid for every image viewed or downloaded on your account.', 0, 0),
       (20753, 'link_checker', 'link checker', 0, 0),
       (20754, 'link_checker_page_name', 'Link Checker', 0, 0),
       (20755, 'link_checker_meta_description', 'Check multiple download links at the same time.', 0, 0),
       (20756, 'link_checker_meta_keywords', 'link, checker, copyright, infringement, file, hosting', 0, 0),
       (20757, 'link_checker_title_page_description_left', '', 0, 0),
       (20758, 'link_checker_title_page_description_right', '', 0, 0),
       (20759, 'link_checker_intro',
        'Use this page to check whether multiple download links are still active. Enter up to 200 urls below, a new one on each line and click ''Check Files''',
        0, 0),
       (20682, 'link_checker_description_of_the_works',
        'Description of the copyrighted works and supporting information', 0, 0),
       (20761, 'check_files', 'check files', 0, 0),
       (20760, 'link_checker_list_of_file_download_urls', 'List of file download urls, 1 on each line.', 0, 0),
       (20685, 'link_checker_error_no_url', 'Please enter the url of the file you''re reporting.', 0, 0),
       (20782, 'link_checker_error_please_enter_1_or_more_urls', 'Please enter 1 or more file urls.', 0, 0),
       (20687, 'link_checker_result',
        'Found [[[TOTAL_FOUND]]] link(s), [[[TOTAL_ACTIVE]]] active and [[[TOTAL_DISABLED]]] disabled.', 0, 0),
       (20688, 'check_more', 'check more', 0, 0),
       (20764, 'search_meta_description', 'Check multiple download links at the same time.', 0, 0),
       (20765, 'search_meta_keywords', 'link, checker, copyright, infringement, file, hosting', 0, 0),
       (20766, 'search_title_page_description_left', '', 0, 0),
       (20767, 'search_title_page_description_right', '', 0, 0),
       (20796, 'search_intro', 'Search or browse all publicly shared files on this site using the form below.', 0, 0),
       (20784, 'search_box_placeholder', 'Enter your search term here...', 0, 0),
       (20769, 'search_list_of_file_download_urls', 'List of file download urls, 1 on each line.', 0, 0),
       (20770, 'search_filename', 'Filename', 0, 0),
       (20771, 'search_filesize', 'Filesize', 0, 0),
       (20772, 'search_date_uploaded', 'Dated Uploaded', 0, 0),
       (20773, 'datatable_no_files_available_in_search_results', 'No files available in search results', 0, 0),
       (20774, 'datatable_showing_x_to_x_of_total_files', 'Showing _START_ to _END_ of _TOTAL_ files', 0, 0),
       (20787, 'datatable_no_files', '', 0, 0),
       (20776, 'datatable_show_menu_files', 'Show _MENU_ files', 0, 0),
       (20777, 'search_type_images', 'Images', 0, 0),
       (20778, 'search_type_documents', 'Documents', 0, 0),
       (20779, 'search_type_videos', 'Videos', 0, 0),
       (20780, 'search_type_audio', 'Audio', 0, 0),
       (20781, 'search_type_archives', 'Archives', 0, 0),
       (20786, 'search_form_search', 'Search', 0, 0),
       (20801, 'public_files', 'public files', 0, 0),
       (20798, 'home_search_files', 'SEARCH FILES', 0, 0),
       (20816, 'subscriber_created', 'created', 1, 0),
       (20817, 'subscriber_user', 'user', 1, 0),
       (20818, 'subscriber_period', 'period', 1, 0),
       (20819, 'subscriber_amount', 'amount', 1, 0),
       (20820, 'subscriber_status', 'status', 1, 0),
       (20821, 'dcr', 'dcr', 1, 0),
       (20822, 'file_manager_your_files', 'Your Files', 0, 0),
       (20823, 'file_manager', 'File Manager', 0, 0),
       (20825, 'file_search_results', 'File Search Results', 0, 0),
       (20826, 'no_files_found_in_search', 'No files found within folder or search criteria.', 0, 0),
       (20827, 'recent_files', 'Recent Files', 0, 0),
       (20829, 'account_file_details_select', 'Select', 0, 0),
       (20830, 'account_file_details_select_file', 'Select File', 0, 0),
       (20831, 'account_file_details_edit_file_info', 'Edit File Info', 0, 0),
       (20832, 'file_details_download_file', 'Download File', 0, 0),
       (20833, 'file_details_download', 'Download', 0, 0),
       (20834, 'file_details_filesize', 'Filesize', 0, 0),
       (20835, 'account_header_search_files', 'Search files...', 0, 0),
       (20836, 'search_your_files', 'Search Your Files', 0, 0),
       (20837, 'file_manager_all_folders', 'All Folders', 0, 0),
       (20838, 'file_manager_upload_complete', 'Upload complete.', 0, 0),
       (20839, 'enter_an_email_address_below_to_send_the_list_of_files',
        'Enter an email address below to send the list of files via email once they''re uploaded.', 0, 0),
       (20840, 'select_album_below_to_store_intro_text_files',
        'Select an album below to store these files in. All current uploads will be available within these albums.', 0,
        0),
       (20841, 'account_file_details_delete_file', 'Delete Image', 0, 0),
       (20842, 'account_file_details_file_stats', 'Image Stats', 0, 0),
       (20843, 'file_page_link', 'Image Page Link', 0, 0),
       (20844, 'profile_folder', 'Folder:', 0, 0),
       (20846, 'your_folder', 'your folder', 0, 0),
       (20847, 'file_folder', 'file folder', 0, 0),
       (20848, 'file_is_not_publicly_shared_please_contact',
        'File is not publicly shared. Please contact the owner and request they update the privacy settings.', 0, 0),
       (20849, 'add_sub_folder', 'Add Sub Folder', 0, 0),
       (20850, 'package_type', 'package type', 1, 0),
       (20851, 'download_allowance', 'download allowance', 1, 0),
       (20852, 'download_allowance_invalid', 'Please specify the download limit for this price.', 1, 0),
       (20853, 'remaining_download_allowance', 'remaining download allowance', 0, 0),
       (20854, 'folder_page_name', 'Folder', 0, 0),
       (20855, 'folder_view', 'View', 0, 0),
       (20856, 'folder_folder', 'Folder', 0, 0),
       (20857, 'folder_meta_keywords', 'folder, images, file, your, interface, upload, download, site', 0, 0),
       (20858, 'your_folders', 'your folders', 0, 0),
       (20859, 'select_folder_below_to_store_intro_text_files',
        'Select an folder below to store these files in. All current uploads will be available within these folders.',
        0, 0),
       (20860, 'folder_password_is_invalid', 'The folder password is invalid', 0, 0),
       (20861, 'problem_updating_folder', 'There was a problem accessing the folder, please try again later.', 0, 0),
       (20862, 'account_file_set_as_folder_cover', 'Set As Folder Cover', 0, 0),
       (20863, 'no_files_found_in_this_folder',
        'No files found within this folder. Drag & drop files to upload here or click ''Upload'' above.', 0, 0),
       (20864, 'edit_folder_cover_image_description', 'Cover Image: (Url of the Image in Your Account)', 0, 0),
       (20865, 'edit_folder_privacy', 'Folder Privacy:', 0, 0),
       (20866, 'account_file_details_folder_not_publicly_shared',
        'This file is not publicly shared. You will need to make it public before the recipient can view it.', 0, 0),
       (20867, 'no_files_found_in_folder', 'No files found within this folder.', 0, 0),
       (20868, 'registered user', 'registered user', 1, 0),
       (20869, 'search_folders', 'Search Folders', 0, 0),
       (20870, 'account_header_search_your_files', 'Search your files...', 0, 0),
       (20871, 'default_folder_privacy', 'Default Folder Privacy', 0, 0),
       (20872, 'stats_downloads', 'Downloads', 0, 0),
       (20873, 'download_zip_file', 'Download Zip File', 0, 0),
       (20874, 'edit_folder_share_on', 'Share On:', 0, 0),
       (20877, 'share_on', 'Share On', 0, 0),
       (20878, 'edit_folder_send_via_email', 'Send via Email:', 0, 0),
       (20880, 'send', 'send', 0, 0),
       (20881, 'email_folder_url_process_subject', 'Folder shared by [[[SHARED_BY_NAME]]] on [[[SITE_NAME]]]', 0, 0),
       (20882, 'email_folder_url_process_content',
        '[[[SHARED_BY_NAME]]] has shared the following file with you via <a href=''[[[WEB_ROOT]]]''>[[[SITE_NAME]]]</a>:<br/><br/><strong>Folder Name:</strong> [[[FOLDER_NAME]]]<br/><strong>View:</strong> [[[FOLDER_URL]]]<br/><strong>From:</strong> [[[SHARED_BY_NAME]]] [[[SHARED_EMAIL_ADDRESS]]]<br/><strong>Message:</strong><br/>[[[EXTRA_MESSAGE]]]<br/><br/>Feel free to contact us if you have any difficulties viewing the folder.<br/><br/>Regards,<br/>[[[SITE_NAME]]] Admin',
        0, 0),
       (20884, 'email_folder_url_process_folder_send_via_email_to',
        'Folder shared via email to [[[RECIPIENT_EMAIL_ADDRESS]]]', 0, 0),
       (20885, 'account_file_details_create_copy', 'Create Copy', 0, 0),
       (20886, 'copy_url_to_clipboard', 'Copy Url to Clipboard', 0, 0),
       (20887, 'copy_urls_to_clipboard', 'Copy Url(s) to Clipboard', 0, 0),
       (20888, 'admin_area_link', 'Admin Area', 0, 0),
       (20891, 'no_files_found_in_this_folder_drag_and_drop', 'Drag & drop files or click here to upload', 0, 0),
       (20892, 'document_can_not_be_previewed',
        '- Document can not be previewed as it is too big. Please download the file to view it.', 0, 0),
       (20893, 'safari', 'safari', 0, 0),
       (20894, 'account_file_details_clear_selected', 'Clear Selected', 0, 0),
       (20895, 'edit_folder_privacy_notice_note',
        'Note: You can not update this folder privacy settings as your account settings are set to make all files private, or the parent folder is set to private.',
        0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `login_failure`
--

CREATE TABLE IF NOT EXISTS `login_failure`
(
    `id` int
(
    11
) NOT NULL AUTO_INCREMENT,
    `ip_address` varchar
(
    15
) COLLATE utf8_bin NOT NULL,
    `date_added` datetime NOT NULL,
    `username` varchar
(
    65
) COLLATE utf8_bin NOT NULL,
    PRIMARY KEY
(
    `id`
),
    KEY `ip_address`
(
    `ip_address`
),
    KEY `date_added`
(
    `date_added`
)
    ) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE =utf8_bin AUTO_INCREMENT=115;

--
-- Dumping data for table `login_failure`
--


-- --------------------------------------------------------

--
-- Table structure for table `login_success`
--

CREATE TABLE IF NOT EXISTS `login_success`
(
    `id` int
(
    11
) NOT NULL AUTO_INCREMENT,
    `ip_address` varchar
(
    15
) COLLATE utf8_bin NOT NULL,
    `date_added` datetime NOT NULL,
    `user_id` int
(
    11
) NOT NULL,
    `country_code` varchar
(
    2
) COLLATE utf8_bin DEFAULT NULL,
    PRIMARY KEY
(
    `id`
),
    KEY `ip_address`
(
    `ip_address`
),
    KEY `date_added`
(
    `date_added`
),
    KEY `user_id`
(
    `user_id`
),
    KEY `country_code`
(
    `country_code`
)
    ) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE =utf8_bin AUTO_INCREMENT=2;

--
-- Dumping data for table `login_success`
--

INSERT INTO `login_success` (`id`, `ip_address`, `date_added`, `user_id`, `country_code`)
VALUES (1, '192.168.1.226', '2015-12-31 13:38:04', 1, '');

-- --------------------------------------------------------

--
-- Table structure for table `payment_log`
--

CREATE TABLE IF NOT EXISTS `payment_log`
(
    `id` int
(
    11
) NOT NULL AUTO_INCREMENT,
    `user_id` int
(
    11
) NOT NULL,
    `date_created` datetime NOT NULL,
    `amount` float
(
    9,
    2
) NOT NULL,
    `currency_code` varchar
(
    3
) NOT NULL,
    `from_email` varchar
(
    255
) NOT NULL,
    `to_email` varchar
(
    255
) NOT NULL,
    `description` varchar
(
    255
) NOT NULL,
    `request_log` text NOT NULL,
    `payment_method` varchar
(
    50
) DEFAULT NULL,
    PRIMARY KEY
(
    `id`
),
    KEY `date_created`
(
    `date_created`
),
    KEY `description`
(
    `description`
),
    KEY `user_id`
(
    `user_id`
)
    ) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1;

--
-- Dumping data for table `payment_log`
--


-- --------------------------------------------------------

--
-- Table structure for table `plugin`
--

CREATE TABLE IF NOT EXISTS `plugin`
(
    `id` int
(
    11
) NOT NULL AUTO_INCREMENT,
    `plugin_name` varchar
(
    150
) COLLATE utf8_bin NOT NULL,
    `folder_name` varchar
(
    100
) COLLATE utf8_bin NOT NULL,
    `plugin_description` varchar
(
    255
) COLLATE utf8_bin NOT NULL,
    `is_installed` int
(
    1
) NOT NULL DEFAULT '0',
    `date_installed` datetime DEFAULT NULL,
    `plugin_settings` text COLLATE utf8_bin DEFAULT NULL,
    `plugin_enabled` int
(
    1
) NOT NULL DEFAULT '1',
    `load_order` int
(
    3
) DEFAULT '999',
    PRIMARY KEY
(
    `id`
),
    KEY `load_order`
(
    `load_order`
)
    ) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE =utf8_bin AUTO_INCREMENT=59;

--
-- Dumping data for table `plugin`
--

INSERT INTO `plugin` (`id`, `plugin_name`, `folder_name`, `plugin_description`, `is_installed`, `date_installed`,
                      `plugin_settings`, `plugin_enabled`, `load_order`)
VALUES (41, 'File Import', 'fileimport', 'Batch import your existing files.', 0, '0000-00-00 00:00:00', '', 0, 999),
       (58, 'File Previewer', 'filepreviewer', 'Display files directly within the file manager.', 1,
        '0000-00-00 00:00:00',
        0x7b226e6f6e5f73686f775f766965776572223a312c22667265655f73686f775f766965776572223a312c22706169645f73686f775f766965776572223a312c22656e61626c655f707265766965775f696d616765223a312c22707265766965775f696d6167655f73686f775f7468756d62223a312c226175746f5f726f74617465223a312c22737570706f727465645f696d6167655f7479706573223a226a70672c6a7065672c706e672c6769662c77626d70222c22656e61626c655f707265766965775f646f63756d656e74223a312c22707265766965775f646f63756d656e745f7064665f7468756d6273223a312c22707265766965775f646f63756d656e745f657874223a22646f632c646f63782c786c732c786c73782c7070742c707074782c7064662c70616765732c61692c7073642c746966662c6478662c7376672c6570732c70732c7474662c6f74662c787073222c22656e61626c655f707265766965775f766964656f223a312c22707265766965775f766964656f5f657874223a226d70342c666c762c6f6767222c22707265766965775f766964656f5f6175746f706c6179223a312c22656e61626c655f707265766965775f617564696f223a312c22707265766965775f617564696f5f657874223a226d7033222c22707265766965775f617564696f5f6175746f706c6179223a312c2263616368696e67223a312c22696d6167655f7175616c697479223a39307d,
        1, 999);

-- --------------------------------------------------------

--
-- Table structure for table `plugin_filepreviewer_meta`
--

CREATE TABLE IF NOT EXISTS `plugin_filepreviewer_meta`
(
    `id` int
(
    11
) NOT NULL AUTO_INCREMENT,
    `file_id` int
(
    11
) NOT NULL,
    `width` int
(
    8
) NOT NULL,
    `height` int
(
    8
) NOT NULL,
    `raw_data` text COLLATE utf8_bin,
    `date_taken` datetime DEFAULT NULL,
    `image_colors` varchar
(
    100
) COLLATE utf8_bin DEFAULT NULL,
    `image_bg_color` varchar
(
    7
) COLLATE utf8_bin DEFAULT NULL,
    PRIMARY KEY
(
    `id`
),
    KEY `file_id`
(
    `file_id`
),
    KEY `image_bg_color`
(
    `image_bg_color`
),
    FULLTEXT KEY `image_colors`
(
    `image_colors`
)
    ) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE =utf8_bin AUTO_INCREMENT=1;

--
-- Dumping data for table `plugin_filepreviewer_meta`
--


-- --------------------------------------------------------

--
-- Table structure for table `plugin_filepreviewer_watermark`
--

CREATE TABLE IF NOT EXISTS `plugin_filepreviewer_watermark`
(
    `id` int
(
    11
) NOT NULL AUTO_INCREMENT,
    `file_name` varchar
(
    255
) COLLATE utf8_bin NOT NULL,
    `image_content` blob NOT NULL,
    PRIMARY KEY
(
    `id`
)
    ) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE =utf8_bin AUTO_INCREMENT=1;

--
-- Dumping data for table `plugin_filepreviewer_watermark`
--


-- --------------------------------------------------------

--
-- Table structure for table `premium_order`
--

CREATE TABLE IF NOT EXISTS `premium_order`
(
    `id` int
(
    11
) NOT NULL AUTO_INCREMENT,
    `user_id` int
(
    11
) NOT NULL,
    `description` varchar
(
    100
) DEFAULT NULL,
    `payment_hash` varchar
(
    32
) NOT NULL,
    `user_level_pricing_id` int
(
    11
) DEFAULT NULL,
    `days` int
(
    11
) NOT NULL,
    `amount` decimal
(
    10,
    2
) NOT NULL,
    `order_status` enum
(
    'pending',
    'cancelled',
    'completed'
) NOT NULL,
    `date_created` datetime NOT NULL,
    `upgrade_file_id` int
(
    11
) NOT NULL,
    `upgrade_user_id` int
(
    11
) NOT NULL,
    PRIMARY KEY
(
    `id`
)
    ) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1;

--
-- Dumping data for table `premium_order`
--


-- --------------------------------------------------------

--
-- Table structure for table `remote_url_download_queue`
--

CREATE TABLE IF NOT EXISTS `remote_url_download_queue`
(
    `id` int
(
    11
) NOT NULL AUTO_INCREMENT,
    `user_id` int
(
    11
) NOT NULL,
    `url` text COLLATE utf8_bin NOT NULL,
    `file_server_id` int
(
    11
) NOT NULL,
    `created` datetime NOT NULL,
    `started` datetime NOT NULL,
    `finished` datetime NOT NULL,
    `job_status` enum
(
    'downloading',
    'pending',
    'processing',
    'complete',
    'cancelled',
    'failed'
) COLLATE utf8_bin NOT NULL DEFAULT 'pending',
    `total_size` bigint
(
    16
) NOT NULL DEFAULT '0',
    `downloaded_size` bigint
(
    16
) NOT NULL DEFAULT '0',
    `download_percent` int
(
    3
) NOT NULL,
    `folder_id` int
(
    11
) DEFAULT NULL,
    `notes` text COLLATE utf8_bin,
    `new_file_id` int
(
    11
) DEFAULT NULL,
    PRIMARY KEY
(
    `id`
)
    ) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE =utf8_bin AUTO_INCREMENT=35;

--
-- Dumping data for table `remote_url_download_queue`
--


-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE IF NOT EXISTS `sessions`
(
    `id` varchar
(
    255
) COLLATE utf8_unicode_ci NOT NULL,
    `data` text COLLATE utf8_unicode_ci NOT NULL,
    `updated_on` int
(
    10
) NOT NULL,
    `user_id` int
(
    11
) DEFAULT NULL,
    PRIMARY KEY
(
    `id`
),
    KEY `user_id`
(
    `user_id`
),
    KEY `updated_on`
(
    `updated_on`
)
    ) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE =utf8_unicode_ci;

--
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` (`id`, `data`, `updated_on`, `user_id`)
VALUES ('oq7cbpo43av8c4uo276bh2lo30',
        '_t|s:12:"English (en)";pluginConfigs|a:1:{s:13:"filepreviewer";a:2:{s:4:"data";a:18:{s:2:"id";s:2:"58";i:0;s:2:"58";s:11:"plugin_name";s:14:"File Previewer";i:1;s:14:"File Previewer";s:11:"folder_name";s:13:"filepreviewer";i:2;s:13:"filepreviewer";s:18:"plugin_description";s:47:"Display files directly within the file manager.";i:3;s:47:"Display files directly within the file manager.";s:12:"is_installed";s:1:"1";i:4;s:1:"1";s:14:"date_installed";s:19:"0000-00-00 00:00:00";i:5;s:19:"0000-00-00 00:00:00";s:15:"plugin_settings";s:506:"{"non_show_viewer":1,"free_show_viewer":1,"paid_show_viewer":1,"enable_preview_image":1,"preview_image_show_thumb":1,"auto_rotate":1,"supported_image_types":"jpg,jpeg,png,gif,wbmp","enable_preview_document":1,"preview_document_pdf_thumbs":1,"preview_document_ext":"doc,docx,xls,xlsx,ppt,pptx,pdf,pages,ai,psd,tiff,dxf,svg,eps,ps,ttf,otf,xps","enable_preview_video":1,"preview_video_ext":"mp4,flv,ogg","preview_video_autoplay":1,"enable_preview_audio":1,"preview_audio_ext":"mp3","preview_audio_autoplay":1}";i:6;s:506:"{"non_show_viewer":1,"free_show_viewer":1,"paid_show_viewer":1,"enable_preview_image":1,"preview_image_show_thumb":1,"auto_rotate":1,"supported_image_types":"jpg,jpeg,png,gif,wbmp","enable_preview_document":1,"preview_document_pdf_thumbs":1,"preview_document_ext":"doc,docx,xls,xlsx,ppt,pptx,pdf,pages,ai,psd,tiff,dxf,svg,eps,ps,ttf,otf,xps","enable_preview_video":1,"preview_video_ext":"mp4,flv,ogg","preview_video_autoplay":1,"enable_preview_audio":1,"preview_audio_ext":"mp3","preview_audio_autoplay":1}";s:14:"plugin_enabled";s:1:"1";i:7;s:1:"1";s:10:"load_order";s:3:"999";i:8;s:3:"999";}s:6:"config";a:8:{s:11:"plugin_name";s:14:"File Previewer";s:11:"folder_name";s:13:"filepreviewer";s:18:"plugin_description";s:47:"Display files directly within the file manager.";s:14:"plugin_version";i:1;s:23:"required_script_version";s:3:"4.2";s:12:"database_sql";s:20:"offline/database.sql";s:10:"fixedSizes";a:11:{i:0;s:5:"16x16";i:1;s:5:"32x32";i:2;s:5:"64x64";i:3;s:7:"125x125";i:4;s:7:"180x150";i:5;s:7:"250x250";i:6;s:7:"300x250";i:7;s:7:"120x240";i:8;s:7:"160x600";i:9;s:7:"500x500";i:10;s:7:"800x800";}s:17:"scaledPercentages";a:6:{i:0;s:2:"10";i:1;s:2:"25";i:2;s:2:"35";i:3;s:2:"50";i:4;s:2:"70";i:5;s:2:"85";}}}}',
        1451569260, NULL),
       ('2ttuk0he2v83oedbe5cjcsnt23',
        '_t|s:12:"English (en)";pluginConfigs|a:1:{s:13:"filepreviewer";a:2:{s:4:"data";a:18:{s:2:"id";s:2:"58";i:0;s:2:"58";s:11:"plugin_name";s:14:"File Previewer";i:1;s:14:"File Previewer";s:11:"folder_name";s:13:"filepreviewer";i:2;s:13:"filepreviewer";s:18:"plugin_description";s:47:"Display files directly within the file manager.";i:3;s:47:"Display files directly within the file manager.";s:12:"is_installed";s:1:"1";i:4;s:1:"1";s:14:"date_installed";s:19:"0000-00-00 00:00:00";i:5;s:19:"0000-00-00 00:00:00";s:15:"plugin_settings";s:506:"{"non_show_viewer":1,"free_show_viewer":1,"paid_show_viewer":1,"enable_preview_image":1,"preview_image_show_thumb":1,"auto_rotate":1,"supported_image_types":"jpg,jpeg,png,gif,wbmp","enable_preview_document":1,"preview_document_pdf_thumbs":1,"preview_document_ext":"doc,docx,xls,xlsx,ppt,pptx,pdf,pages,ai,psd,tiff,dxf,svg,eps,ps,ttf,otf,xps","enable_preview_video":1,"preview_video_ext":"mp4,flv,ogg","preview_video_autoplay":1,"enable_preview_audio":1,"preview_audio_ext":"mp3","preview_audio_autoplay":1}";i:6;s:506:"{"non_show_viewer":1,"free_show_viewer":1,"paid_show_viewer":1,"enable_preview_image":1,"preview_image_show_thumb":1,"auto_rotate":1,"supported_image_types":"jpg,jpeg,png,gif,wbmp","enable_preview_document":1,"preview_document_pdf_thumbs":1,"preview_document_ext":"doc,docx,xls,xlsx,ppt,pptx,pdf,pages,ai,psd,tiff,dxf,svg,eps,ps,ttf,otf,xps","enable_preview_video":1,"preview_video_ext":"mp4,flv,ogg","preview_video_autoplay":1,"enable_preview_audio":1,"preview_audio_ext":"mp3","preview_audio_autoplay":1}";s:14:"plugin_enabled";s:1:"1";i:7;s:1:"1";s:10:"load_order";s:3:"999";i:8;s:3:"999";}s:6:"config";a:8:{s:11:"plugin_name";s:14:"File Previewer";s:11:"folder_name";s:13:"filepreviewer";s:18:"plugin_description";s:47:"Display files directly within the file manager.";s:14:"plugin_version";i:1;s:23:"required_script_version";s:3:"4.2";s:12:"database_sql";s:20:"offline/database.sql";s:10:"fixedSizes";a:11:{i:0;s:5:"16x16";i:1;s:5:"32x32";i:2;s:5:"64x64";i:3;s:7:"125x125";i:4;s:7:"180x150";i:5;s:7:"250x250";i:6;s:7:"300x250";i:7;s:7:"120x240";i:8;s:7:"160x600";i:9;s:7:"500x500";i:10;s:7:"800x800";}s:17:"scaledPercentages";a:6:{i:0;s:2:"10";i:1;s:2:"25";i:2;s:2:"35";i:3;s:2:"50";i:4;s:2:"70";i:5;s:2:"85";}}}}',
        1451569200, NULL),
       ('1iu7o3ui09bfbd0q1tq4joe122',
        '_t|s:12:"English (en)";pluginConfigs|a:1:{s:13:"filepreviewer";a:2:{s:4:"data";a:18:{s:2:"id";s:2:"58";i:0;s:2:"58";s:11:"plugin_name";s:14:"File Previewer";i:1;s:14:"File Previewer";s:11:"folder_name";s:13:"filepreviewer";i:2;s:13:"filepreviewer";s:18:"plugin_description";s:47:"Display files directly within the file manager.";i:3;s:47:"Display files directly within the file manager.";s:12:"is_installed";s:1:"1";i:4;s:1:"1";s:14:"date_installed";s:19:"0000-00-00 00:00:00";i:5;s:19:"0000-00-00 00:00:00";s:15:"plugin_settings";s:506:"{"non_show_viewer":1,"free_show_viewer":1,"paid_show_viewer":1,"enable_preview_image":1,"preview_image_show_thumb":1,"auto_rotate":1,"supported_image_types":"jpg,jpeg,png,gif,wbmp","enable_preview_document":1,"preview_document_pdf_thumbs":1,"preview_document_ext":"doc,docx,xls,xlsx,ppt,pptx,pdf,pages,ai,psd,tiff,dxf,svg,eps,ps,ttf,otf,xps","enable_preview_video":1,"preview_video_ext":"mp4,flv,ogg","preview_video_autoplay":1,"enable_preview_audio":1,"preview_audio_ext":"mp3","preview_audio_autoplay":1}";i:6;s:506:"{"non_show_viewer":1,"free_show_viewer":1,"paid_show_viewer":1,"enable_preview_image":1,"preview_image_show_thumb":1,"auto_rotate":1,"supported_image_types":"jpg,jpeg,png,gif,wbmp","enable_preview_document":1,"preview_document_pdf_thumbs":1,"preview_document_ext":"doc,docx,xls,xlsx,ppt,pptx,pdf,pages,ai,psd,tiff,dxf,svg,eps,ps,ttf,otf,xps","enable_preview_video":1,"preview_video_ext":"mp4,flv,ogg","preview_video_autoplay":1,"enable_preview_audio":1,"preview_audio_ext":"mp3","preview_audio_autoplay":1}";s:14:"plugin_enabled";s:1:"1";i:7;s:1:"1";s:10:"load_order";s:3:"999";i:8;s:3:"999";}s:6:"config";a:8:{s:11:"plugin_name";s:14:"File Previewer";s:11:"folder_name";s:13:"filepreviewer";s:18:"plugin_description";s:47:"Display files directly within the file manager.";s:14:"plugin_version";i:1;s:23:"required_script_version";s:3:"4.2";s:12:"database_sql";s:20:"offline/database.sql";s:10:"fixedSizes";a:11:{i:0;s:5:"16x16";i:1;s:5:"32x32";i:2;s:5:"64x64";i:3;s:7:"125x125";i:4;s:7:"180x150";i:5;s:7:"250x250";i:6;s:7:"300x250";i:7;s:7:"120x240";i:8;s:7:"160x600";i:9;s:7:"500x500";i:10;s:7:"800x800";}s:17:"scaledPercentages";a:6:{i:0;s:2:"10";i:1;s:2:"25";i:2;s:2:"35";i:3;s:2:"50";i:4;s:2:"70";i:5;s:2:"85";}}}}',
        1451569261, NULL),
       ('o36orvbeg1u04admllh2tqaar5',
        '_t|s:12:"English (en)";pluginConfigs|a:1:{s:13:"filepreviewer";a:2:{s:4:"data";a:18:{s:2:"id";s:2:"58";i:0;s:2:"58";s:11:"plugin_name";s:14:"File Previewer";i:1;s:14:"File Previewer";s:11:"folder_name";s:13:"filepreviewer";i:2;s:13:"filepreviewer";s:18:"plugin_description";s:47:"Display files directly within the file manager.";i:3;s:47:"Display files directly within the file manager.";s:12:"is_installed";s:1:"1";i:4;s:1:"1";s:14:"date_installed";s:19:"0000-00-00 00:00:00";i:5;s:19:"0000-00-00 00:00:00";s:15:"plugin_settings";s:506:"{"non_show_viewer":1,"free_show_viewer":1,"paid_show_viewer":1,"enable_preview_image":1,"preview_image_show_thumb":1,"auto_rotate":1,"supported_image_types":"jpg,jpeg,png,gif,wbmp","enable_preview_document":1,"preview_document_pdf_thumbs":1,"preview_document_ext":"doc,docx,xls,xlsx,ppt,pptx,pdf,pages,ai,psd,tiff,dxf,svg,eps,ps,ttf,otf,xps","enable_preview_video":1,"preview_video_ext":"mp4,flv,ogg","preview_video_autoplay":1,"enable_preview_audio":1,"preview_audio_ext":"mp3","preview_audio_autoplay":1}";i:6;s:506:"{"non_show_viewer":1,"free_show_viewer":1,"paid_show_viewer":1,"enable_preview_image":1,"preview_image_show_thumb":1,"auto_rotate":1,"supported_image_types":"jpg,jpeg,png,gif,wbmp","enable_preview_document":1,"preview_document_pdf_thumbs":1,"preview_document_ext":"doc,docx,xls,xlsx,ppt,pptx,pdf,pages,ai,psd,tiff,dxf,svg,eps,ps,ttf,otf,xps","enable_preview_video":1,"preview_video_ext":"mp4,flv,ogg","preview_video_autoplay":1,"enable_preview_audio":1,"preview_audio_ext":"mp3","preview_audio_autoplay":1}";s:14:"plugin_enabled";s:1:"1";i:7;s:1:"1";s:10:"load_order";s:3:"999";i:8;s:3:"999";}s:6:"config";a:8:{s:11:"plugin_name";s:14:"File Previewer";s:11:"folder_name";s:13:"filepreviewer";s:18:"plugin_description";s:47:"Display files directly within the file manager.";s:14:"plugin_version";i:1;s:23:"required_script_version";s:3:"4.2";s:12:"database_sql";s:20:"offline/database.sql";s:10:"fixedSizes";a:11:{i:0;s:5:"16x16";i:1;s:5:"32x32";i:2;s:5:"64x64";i:3;s:7:"125x125";i:4;s:7:"180x150";i:5;s:7:"250x250";i:6;s:7:"300x250";i:7;s:7:"120x240";i:8;s:7:"160x600";i:9;s:7:"500x500";i:10;s:7:"800x800";}s:17:"scaledPercentages";a:6:{i:0;s:2:"10";i:1;s:2:"25";i:2;s:2:"35";i:3;s:2:"50";i:4;s:2:"70";i:5;s:2:"85";}}}}',
        1451569321, NULL),
       ('tu0b71aiavqi1cdcfuhtn25r93',
        '_t|s:12:"English (en)";pluginConfigs|a:1:{s:13:"filepreviewer";a:2:{s:4:"data";a:18:{s:2:"id";s:2:"58";i:0;s:2:"58";s:11:"plugin_name";s:14:"File Previewer";i:1;s:14:"File Previewer";s:11:"folder_name";s:13:"filepreviewer";i:2;s:13:"filepreviewer";s:18:"plugin_description";s:47:"Display files directly within the file manager.";i:3;s:47:"Display files directly within the file manager.";s:12:"is_installed";s:1:"1";i:4;s:1:"1";s:14:"date_installed";s:19:"0000-00-00 00:00:00";i:5;s:19:"0000-00-00 00:00:00";s:15:"plugin_settings";s:506:"{"non_show_viewer":1,"free_show_viewer":1,"paid_show_viewer":1,"enable_preview_image":1,"preview_image_show_thumb":1,"auto_rotate":1,"supported_image_types":"jpg,jpeg,png,gif,wbmp","enable_preview_document":1,"preview_document_pdf_thumbs":1,"preview_document_ext":"doc,docx,xls,xlsx,ppt,pptx,pdf,pages,ai,psd,tiff,dxf,svg,eps,ps,ttf,otf,xps","enable_preview_video":1,"preview_video_ext":"mp4,flv,ogg","preview_video_autoplay":1,"enable_preview_audio":1,"preview_audio_ext":"mp3","preview_audio_autoplay":1}";i:6;s:506:"{"non_show_viewer":1,"free_show_viewer":1,"paid_show_viewer":1,"enable_preview_image":1,"preview_image_show_thumb":1,"auto_rotate":1,"supported_image_types":"jpg,jpeg,png,gif,wbmp","enable_preview_document":1,"preview_document_pdf_thumbs":1,"preview_document_ext":"doc,docx,xls,xlsx,ppt,pptx,pdf,pages,ai,psd,tiff,dxf,svg,eps,ps,ttf,otf,xps","enable_preview_video":1,"preview_video_ext":"mp4,flv,ogg","preview_video_autoplay":1,"enable_preview_audio":1,"preview_audio_ext":"mp3","preview_audio_autoplay":1}";s:14:"plugin_enabled";s:1:"1";i:7;s:1:"1";s:10:"load_order";s:3:"999";i:8;s:3:"999";}s:6:"config";a:8:{s:11:"plugin_name";s:14:"File Previewer";s:11:"folder_name";s:13:"filepreviewer";s:18:"plugin_description";s:47:"Display files directly within the file manager.";s:14:"plugin_version";i:1;s:23:"required_script_version";s:3:"4.2";s:12:"database_sql";s:20:"offline/database.sql";s:10:"fixedSizes";a:11:{i:0;s:5:"16x16";i:1;s:5:"32x32";i:2;s:5:"64x64";i:3;s:7:"125x125";i:4;s:7:"180x150";i:5;s:7:"250x250";i:6;s:7:"300x250";i:7;s:7:"120x240";i:8;s:7:"160x600";i:9;s:7:"500x500";i:10;s:7:"800x800";}s:17:"scaledPercentages";a:6:{i:0;s:2:"10";i:1;s:2:"25";i:2;s:2:"35";i:3;s:2:"50";i:4;s:2:"70";i:5;s:2:"85";}}}}',
        1451569321, NULL),
       ('qnkshfs5nq6t6ivh9rgfpjjs21',
        '_t|s:12:"English (en)";pluginConfigs|a:1:{s:13:"filepreviewer";a:2:{s:4:"data";a:18:{s:2:"id";s:2:"58";i:0;s:2:"58";s:11:"plugin_name";s:14:"File Previewer";i:1;s:14:"File Previewer";s:11:"folder_name";s:13:"filepreviewer";i:2;s:13:"filepreviewer";s:18:"plugin_description";s:47:"Display files directly within the file manager.";i:3;s:47:"Display files directly within the file manager.";s:12:"is_installed";s:1:"1";i:4;s:1:"1";s:14:"date_installed";s:19:"0000-00-00 00:00:00";i:5;s:19:"0000-00-00 00:00:00";s:15:"plugin_settings";s:506:"{"non_show_viewer":1,"free_show_viewer":1,"paid_show_viewer":1,"enable_preview_image":1,"preview_image_show_thumb":1,"auto_rotate":1,"supported_image_types":"jpg,jpeg,png,gif,wbmp","enable_preview_document":1,"preview_document_pdf_thumbs":1,"preview_document_ext":"doc,docx,xls,xlsx,ppt,pptx,pdf,pages,ai,psd,tiff,dxf,svg,eps,ps,ttf,otf,xps","enable_preview_video":1,"preview_video_ext":"mp4,flv,ogg","preview_video_autoplay":1,"enable_preview_audio":1,"preview_audio_ext":"mp3","preview_audio_autoplay":1}";i:6;s:506:"{"non_show_viewer":1,"free_show_viewer":1,"paid_show_viewer":1,"enable_preview_image":1,"preview_image_show_thumb":1,"auto_rotate":1,"supported_image_types":"jpg,jpeg,png,gif,wbmp","enable_preview_document":1,"preview_document_pdf_thumbs":1,"preview_document_ext":"doc,docx,xls,xlsx,ppt,pptx,pdf,pages,ai,psd,tiff,dxf,svg,eps,ps,ttf,otf,xps","enable_preview_video":1,"preview_video_ext":"mp4,flv,ogg","preview_video_autoplay":1,"enable_preview_audio":1,"preview_audio_ext":"mp3","preview_audio_autoplay":1}";s:14:"plugin_enabled";s:1:"1";i:7;s:1:"1";s:10:"load_order";s:3:"999";i:8;s:3:"999";}s:6:"config";a:8:{s:11:"plugin_name";s:14:"File Previewer";s:11:"folder_name";s:13:"filepreviewer";s:18:"plugin_description";s:47:"Display files directly within the file manager.";s:14:"plugin_version";i:1;s:23:"required_script_version";s:3:"4.2";s:12:"database_sql";s:20:"offline/database.sql";s:10:"fixedSizes";a:11:{i:0;s:5:"16x16";i:1;s:5:"32x32";i:2;s:5:"64x64";i:3;s:7:"125x125";i:4;s:7:"180x150";i:5;s:7:"250x250";i:6;s:7:"300x250";i:7;s:7:"120x240";i:8;s:7:"160x600";i:9;s:7:"500x500";i:10;s:7:"800x800";}s:17:"scaledPercentages";a:6:{i:0;s:2:"10";i:1;s:2:"25";i:2;s:2:"35";i:3;s:2:"50";i:4;s:2:"70";i:5;s:2:"85";}}}}user|s:1115:"O:4:"Auth":9:{s:2:"id";s:1:"1";s:8:"username";s:5:"admin";s:8:"level_id";i:20;s:4:"user";O:4:"User":6:{s:2:"id";s:1:"1";s:9:"tableName";s:5:"users";s:12:"idColumnName";N;s:8:"errorMsg";N;s:10:"\0*\0columns";a:18:{s:8:"username";s:5:"admin";s:8:"password";s:77:"sha256:1000:KQpu8LquZVfABv5kvC7Kf0n22a8TN3FL:v7sM7IkhoWpRJc04qbvv1h6o6MQAl/GP";s:13:"lastlogindate";s:19:"2015-12-31 13:43:27";s:8:"level_id";s:2:"20";s:5:"email";s:18:"you@yourdomain.com";s:14:"paidExpiryDate";s:19:"2015-12-31 13:29:31";s:9:"firstname";s:5:"Admin";s:8:"lastname";s:7:"Account";s:5:"title";s:2:"Mr";s:10:"languageId";s:1:"1";s:20:"storageLimitOverride";N;s:21:"privateFileStatistics";s:1:"1";s:20:"uploadServerOverride";N;s:6:"apikey";s:32:"f86cff6189c7bd13db7f94ab9b74030f";s:7:"profile";s:17:"{"image_size":[]}";s:8:"isPublic";s:1:"1";s:17:"accountLockStatus";s:1:"0";s:19:"remainingBWDownload";s:1:"0";}s:12:"\0*\0className";s:4:"User";}s:10:"package_id";s:2:"20";s:5:"level";s:5:"Admin";s:5:"email";s:18:"you@yourdomain.com";s:14:"paidExpiryDate";s:19:"2015-12-31 13:29:31";s:14:"paymentTracker";s:32:"5f4dcc3b5aa765d61d8327deb882cf99";}";themeConfigs|a:1:{s:9:"cloudable";a:2:{s:4:"data";a:18:{s:2:"id";s:2:"27";i:0;s:2:"27";s:10:"theme_name";s:9:"Cloudable";i:1;s:9:"Cloudable";s:11:"folder_name";s:9:"cloudable";i:2;s:9:"cloudable";s:17:"theme_description";s:15:"Cloudable Theme";i:3;s:15:"Cloudable Theme";s:11:"author_name";s:9:"MFScripts";i:4;s:9:"MFScripts";s:14:"author_website";s:21:"https://mfscripts.com";i:5;s:21:"https://mfscripts.com";s:12:"is_installed";s:1:"1";i:6;s:1:"1";s:14:"date_installed";s:19:"0000-00-00 00:00:00";i:7;s:19:"0000-00-00 00:00:00";s:14:"theme_settings";s:53:"{"thumbnail_type":"square","site_skin":"default.css"}";i:8;s:53:"{"thumbnail_type":"square","site_skin":"default.css"}";}s:6:"config";a:10:{s:10:"theme_name";s:15:"Cloudable Theme";s:11:"folder_name";s:9:"cloudable";s:17:"theme_description";s:21:"Personal File Manager";s:11:"author_name";s:9:"MFScripts";s:14:"author_website";s:21:"https://mfscripts.com";s:13:"theme_version";i:1;s:23:"required_script_version";s:3:"1.0";s:7:"product";s:9:"cloudable";s:12:"product_name";s:9:"Cloudable";s:11:"product_url";s:21:"https://mfscripts.com";}}}search|a:2:{s:7:"perPage";i:30;s:13:"filterOrderBy";s:21:"order_by_filename_asc";}browse|a:1:{s:8:"viewType";s:15:"fileManagerIcon";}',
        1451569888, 1);

-- --------------------------------------------------------

--
-- Table structure for table `site_config`
--

CREATE TABLE IF NOT EXISTS `site_config`
(
    `id` int
(
    11
) NOT NULL AUTO_INCREMENT,
    `config_key` varchar
(
    100
) NOT NULL,
    `config_value` text NOT NULL,
    `config_description` varchar
(
    255
) NOT NULL,
    `availableValues` varchar
(
    255
) NOT NULL,
    `config_type` varchar
(
    30
) NOT NULL,
    `config_group` varchar
(
    100
) NOT NULL DEFAULT 'Default',
    PRIMARY KEY
(
    `id`
),
    KEY `config_key`
(
    `config_key`
),
    KEY `config_group`
(
    `config_group`
)
    ) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=183;

--
-- Dumping data for table `site_config`
--

INSERT INTO `site_config` (`id`, `config_key`, `config_value`, `config_description`, `availableValues`, `config_type`,
                           `config_group`)
VALUES (21, 'language_show_key', 'translation',
        'Show translation value or key. (use ''key'' to debug translations, ''translation'' to show actual translated value. ''key title text'' to show the key as a title tag around the text content)',
        '["key","translation", "key title text"]', 'select', 'Language'),
       (4, 'page_extension', 'html', 'The page extension to use on the site', '["html"]', 'select', 'System'),
       (5, 'date_time_format', 'd/m/Y H:i:s', 'Date time format in php', '', 'string', 'Local'),
       (6, 'date_format', 'd/m/Y', 'Date format in php', '', 'string', 'Local'),
       (7, 'site_name', 'Cloudable File Manager', 'Site name', '', 'string', 'Site Options'),
       (9, 'site_theme', 'cloudable', 'Site template theme',
        'SELECT folder_name AS itemValue FROM theme ORDER BY folder_name', 'select', 'System'),
       (10, 'max_files_per_day', '0',
        'Spam protect: Max files a user IP address can create per day. Leave blank for unlimited.', '', 'integer',
        'File Uploads'),
       (11, 'date_time_format_js', '%d-%m-%Y %H:%i', 'Date time format in javascript', '', 'string', 'Local'),
       (44, 'email_smtp_port', '587', 'Your SMTP port if you''ve selected SMTP email method. (Normally 25)', '',
        'integer', 'Email Settings'),
       (45, 'email_smtp_requires_auth', 'no', 'Whether your SMTP server requires authentication.', '["yes","no"]',
        'select', 'Email Settings'),
       (46, 'email_smtp_auth_username', '', 'Your SMTP username if SMTP auth is required.', '', 'string',
        'Email Settings'),
       (47, 'email_smtp_auth_password', '', 'Your SMTP password if SMTP auth is required.', '', 'string',
        'Email Settings'),
       (48, 'file_url_show_filename', 'yes', 'Show the original filename on the end of the generated url.',
        '["yes","no"]', 'select', 'File Uploads'),
       (49, 'default_file_server', 'Local Default',
        'The file server to use for all new uploads. Only used if ''active'' state and ''server selection method'' is ''specific server''.',
        'SELECT serverLabel AS itemValue FROM file_server LEFT JOIN file_server_status ON file_server.statusId = file_server_status.id WHERE statusId=2 ORDER BY serverLabel',
        'select', 'File Uploads'),
       (51, 'free_user_show_captcha', 'no', 'Show the captcha after a free user sees the countdown timer.',
        '["yes","no"]', 'select', 'System'),
       (50, 'c_file_server_selection_method', 'Specific Server',
        'Server selection method. How to select the file server to use. If using ''until full'', you''ll also need to set the file server priority on each.',
        '["Least Used Space","Specific Server","Until Full"]', 'select', 'File Uploads'),
       (149, 'purge_deleted_files_period_minutes', '10080',
        'How long to keep deleted files for on the server. On delete via the script UI they are moved into /files/_deleted/ then purged after this period. Useful for recovery if needed. Set in minutes. Default 24 hours, so 1440.',
        '', 'input', 'Site Options'),
       (42, 'email_method', 'php', 'The method for sending emails via the script.', '["php","smtp"]', 'select',
        'Email Settings'),
       (43, 'email_smtp_host', '',
        'Your SMTP host if you''ve selected SMTP email method. (leave blank is email_method = php)', '', 'string',
        'Email Settings'),
       (20, 'site_language', 'English (en)',
        'Site language for text conversions <a href="translation_manage.php">(manage languages)</a>',
        'SELECT languageName AS itemValue FROM language ORDER BY languageName', 'select', 'Language'),
       (31, 'next_check_for_file_removals', '1411399513',
        'System value. The next time to delete any files which haven''t recently been accessed. Timestamp. Do not edit.',
        '', 'integer', 'System'),
       (23, 'stats_only_count_unique', 'yes',
        'Revisits in the same day, by the same IP address will not be counted on stats.', '["yes", "no"]', 'select',
        'Default'),
       (24, 'default_email_address_from', 'email@yoursite.com', 'Emails will be sent from', '', 'string',
        'Site Options'),
       (176, 'next_check_for_rewards_aggregation', '1451952000',
        'System value. The next time collate the rewards data.', '', 'integer', 'System'),
       (28, 'accepted_upload_file_types', '',
        'The file extensions which are permitted. Leave blank for all. Separate by semi-colon. i.e. .jpg;.gif;.doc;',
        '', 'string', 'File Uploads'),
       (171, 'security_account_lock', 'yes', 'Enable users to lock their accounts?', '["yes","no"]', 'select',
        'Security'),
       (174, 'default_admin_file_manager_view', 'thumb', 'Default view to show in the admin file manager.',
        '["list","thumb"]', 'select', 'Site Options'),
       (37, 'cost_currency_symbol', '$', 'The symbol to use for currency. i.e. $', '["$", "£", "€"]', 'string',
        'System'),
       (38, 'cost_currency_code', 'USD', 'The currency code for the current currency. i.e. USD',
        '["USD", "GBP", "EUR"]', 'select', 'System'),
       (54, 'reserved_usernames', 'admin|administrator|localhost|support|billing|sales|payments',
        'Any usernames listed here will be blocked from the main registration. Pipe separated list.', '', 'string',
        'Default'),
       (58, 'site_admin_email', 'you@yoursite.com', 'The email address all site admin emails will be sent.', '',
        'string', 'Site Options'),
       (61, 'require_user_account_download', 'no', 'Users must register for an account to download.', '["yes","no"]',
        'select', 'System'),
       (62, 'generate_upload_url_type', 'Shortest',
        'What format to generate the file url in. Shortest will increment based on the previous upload. Hashed will create a longer random character hash.',
        '["Shortest","Medium Hash", "Long Hash"]', 'select', 'File Uploads'),
       (70, 'downloads_track_current_downloads', 'yes',
        'Whether to track current downloads/connections. Note: This should be enabled if you also want to limit concurrent download connections.',
        '["yes","no"]', 'select', 'File Downloads'),
       (74, 'session_expiry', '86400',
        'The amount of time a user can be inactive before their session will expire. In seconds. Default is 86400 (1 day)',
        '', 'integer', 'Site Options'),
       (75, 'logging_log_enabled', 'yes',
        'Whether to enable logging or not. The /logs/ folder should have write permissions on it. (chmod 755 or 777)',
        '["yes","no"]', 'select', 'Logs'),
       (79, 'logging_log_type', 'All Error Types',
        'The types of log messages to store in the log files. ''Serious Errors Only'' will log the important ones. Ensure logging is enabled for this setting to work.',
        '["Serious Errors Only","Serious Errors and Warnings","All Error Types"]', 'select', 'Logs'),
       (77, 'logging_log_output', 'yes',
        'Whether to output the errors to screen. Always set this to ''no'' for your live site.', '["yes","no"]',
        'select', 'Logs'),
       (97, 'premium_user_block_account_sharing', 'no',
        'Block paid account sharing. Accounts will only allow 1 login session. Any open sessions will be closed on a new login.',
        '["yes","no"]', 'select', 'System'),
       (101, 'language_separate_language_images', 'no',
        'Use different images/css for each language. If yes, copy all the files from images/styles in /themes/blue_v2/ to /themes/blue_v2/[flag_code]/, keeping the folders. Replace ''[flag_code]'' with the 2 letter language flag code. i.e. /themes/blue_v2/es/',
        '["yes","no"]', 'select', 'Language'),
       (102, 'language_user_select_language', 'yes',
        'Give users the option to set their account language. Available as a drop-down in account settings. Automatically sets the language of the site on login.',
        '["yes","no"]', 'select', 'Language'),
       (103, 'maintenance_mode', 'no',
        'Whether to place the entire site into maintenance mode. Useful for site upgrades or server moves. Admin area is still accessible.',
        '["yes","no"]', 'select', 'Site Options'),
       (177, 'next_check_for_ppd_aggregation', '1451433600', 'System value. The next time collate the PPD data.', '',
        'integer', 'System'),
       (106, 'enable_user_registration', 'no', 'Whether to enable user registration on the site.', '["yes","no"]',
        'select', 'System'),
       (108, 'file_manager_default_view', 'icon', 'The default view for the file manager.', '["icon", "list"]',
        'select', 'File Manager'),
       (109, 'site_contact_form_email', 'you@yoursite.com', 'The email address all contact form queries will be sent',
        '', 'string', 'Contact Form'),
       (111, 'performance_js_file_minify', 'no',
        'Whether to automatically group and minify js files. ''yes'' increases page load times. Use ''no'' if you have any issues or in dev. The ''cache'' folder must be writable.',
        '["yes","no"]', 'select', 'System'),
       (162, 'premium_user_block_account_sharing', 'no',
        'Block paid account sharing. Accounts will only allow 1 login session. Any open sessions will be closed on a new login.',
        '["yes","no"]', 'select', 'System'),
       (124, 'password_policy_min_length', '8', 'Minimum password length', '', 'integer', 'Password Policy'),
       (125, 'password_policy_max_length', '8', 'Maximum password length', '', 'integer', 'Password Policy'),
       (126, 'password_policy_min_uppercase_characters', '0', 'Minimum upper case characters (set to 0 to ignore)', '',
        'integer', 'Password Policy'),
       (127, 'password_policy_min_numbers', '0', 'Minimum numbers (set to 0 to ignore)', '', 'integer',
        'Password Policy'),
       (128, 'password_policy_min_nonalphanumeric_characters', '0',
        'Minimum nonalphanumeric characters, i.e. symbols (set to 0 to ignore)', '', 'integer', 'Password Policy'),
       (167, 'blocked_upload_file_types', '',
        'The file extensions which are NOT permitted. Leave blank to allow all file types. Separate by semi-colon. i.e. .jpg;.gif;.doc;',
        '', 'string', 'File Uploads'),
       (168, 'remote_url_download_in_background', 'no',
        'Should remote file downloads should be done in the background? If yes you will need to setup the crontask /admin/tasks/process_remote_file_downloads.cron.php to run every minute.',
        '["no", "yes"]', 'select', 'File Downloads'),
       (139, 'security_block_ip_login_attempts', '5',
        'How many login attempts before an IP is blocked from logging in for 24 hours.', '', 'integer', 'Security'),
       (140, 'security_send_user_email_on_password_change', 'yes',
        'Send user an email confirmation when they change their password in account settings.', '["yes","no"]',
        'select', 'Security'),
       (141, 'security_send_user_email_on_email_change', 'yes',
        'Send user an email confirmation when they change their email address in account settings.', '["yes","no"]',
        'select', 'Security'),
       (142, 'email_template_header',
        '<html>\n    <head>\n        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">\n    </head>\n    <body style="background-color: #eee; padding: 0px; margin: 0px; font-family: Arial, Helvetica; font-size: 12px;">\n        <div style="padding: 18px 18px 0px 18px; background-color: #ffffff;">\n            <a href="[[[WEB_ROOT]]]">\n                <div style="background-image: url(''[[[SITE_IMAGE_PATH]]]/main_logo_inverted.png''); background-repeat: no-repeat; height: 45px; width: 100%; float: left;"><!-- --></div>\n            </a>\n            <div style="clear: left;"><!-- --></div>\n        </div>\n        <div style="background-color: #ffffff; padding: 18px 18px 25px 18px;">',
        'HTML code for the header of all emails. Test using the ''admin/_test_scripts/test_email.php'' script. Accepts the following placeholders for replacements: [[[SITE_NAME]]], [[[WEB_ROOT]]], [[[DATE_NOW]]], [[[TIME_NOW]]].',
        '', 'textarea', 'Email Settings'),
       (143, 'email_template_footer',
        '        </div>\n        <div style="color: #aaa; font-size: 10px; padding: 18px; margin-left: auto; margin-right: auto;">\n            This e-mail is intended solely for the addressee. If you are not the addressee please do not read, print, re-transmit, store or act in reliance on it or any attachments. Instead, please inform [[[SITE_NAME]]] support and then immediately permanently delete it.<br/><br/>\n            Please do not respond to this email. These are generated automatically by the [[[SITE_NAME]]] system and so the return address is not monitored for email. Please submit a request via our <a href="[[[WEB_ROOT]]]">website</a> if you have a query.<br/><br/>\n            Message sent from <a href="[[[WEB_ROOT]]]">[[[SITE_NAME]]]</a> on [[[DATE_TIME_NOW]]]\n        </div>\n    </body>\n</html>',
        'HTML code for the footer of all emails. Test using the ''admin/_test_scripts/test_email.php'' script. Accepts the following placeholders for replacements: [[[SITE_NAME]]], [[[WEB_ROOT]]], [[[DATE_NOW]]], [[[TIME_NOW]]].',
        '', 'textarea', 'Email Settings'),
       (169, 'limit_send_via_email_per_hour', '10',
        'The maximum amount of emails that a user can send per hour from the ''send via email'' page.', '', 'string',
        'Email Settings'),
       (170, 'force_files_private', 'no',
        'Do you want to make all files uploaded private? All sharing links will be removed from the site pages and the users will only be able to download their own files.',
        '["yes","no"]', 'select', 'System'),
       (144, 'email_template_enabled', 'yes', 'Whether to use the email header and footer html.', '["yes","no"]',
        'select', 'Email Settings'),
       (178, 'next_check_for_server_stats_update', '1451569718',
        'System value. The next time to update the total filesize and file count in the file_server table. Timestamp. Do not edit.',
        '', 'integer', 'System');

-- --------------------------------------------------------

--
-- Table structure for table `stats`
--

CREATE TABLE IF NOT EXISTS `stats`
(
    `id` int
(
    11
) NOT NULL AUTO_INCREMENT,
    `download_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
    `referer` varchar
(
    255
) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
    `referer_is_local` tinyint
(
    4
) NOT NULL DEFAULT '0',
    `file_id` int
(
    11
) NOT NULL,
    `country` varchar
(
    6
) COLLATE utf8_unicode_ci NOT NULL,
    `browser_family` varchar
(
    255
) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
    `os` varchar
(
    255
) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
    `ip` varchar
(
    45
) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
    `user_agent` varchar
(
    255
) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
    `base_url` varchar
(
    255
) COLLATE utf8_unicode_ci NOT NULL,
    `user_id` int
(
    11
) DEFAULT NULL,
    PRIMARY KEY
(
    `id`
),
    KEY `ip`
(
    `ip`
),
    KEY `file_id`
(
    `file_id`
),
    KEY `download_date`
(
    `download_date`
)
    ) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE =utf8_unicode_ci AUTO_INCREMENT=1;

--
-- Dumping data for table `stats`
--


-- --------------------------------------------------------

--
-- Table structure for table `theme`
--

CREATE TABLE IF NOT EXISTS `theme`
(
    `id` int
(
    11
) NOT NULL AUTO_INCREMENT,
    `theme_name` varchar
(
    150
) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
    `folder_name` varchar
(
    100
) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
    `theme_description` varchar
(
    255
) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
    `author_name` varchar
(
    255
) DEFAULT NULL,
    `author_website` varchar
(
    255
) DEFAULT NULL,
    `is_installed` int
(
    1
) NOT NULL DEFAULT '0',
    `date_installed` datetime NOT NULL,
    `theme_settings` text CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
    PRIMARY KEY
(
    `id`
)
    ) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=29;

--
-- Dumping data for table `theme`
--

INSERT INTO `theme` (`id`, `theme_name`, `folder_name`, `theme_description`, `author_name`, `author_website`,
                     `is_installed`, `date_installed`, `theme_settings`)
VALUES (27, 'Cloudable', 'cloudable', 'Cloudable Theme', 'MFScripts', 'https://mfscripts.com', 1, '0000-00-00 00:00:00',
        0x7b227468756d626e61696c5f74797065223a22737175617265222c22736974655f736b696e223a2264656661756c742e637373227d);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE IF NOT EXISTS `users`
(
    `id` int
(
    11
) NOT NULL AUTO_INCREMENT,
    `username` varchar
(
    65
) COLLATE utf8_unicode_ci NOT NULL,
    `password` varchar
(
    100
) COLLATE utf8_unicode_ci NOT NULL,
    `level_id` int
(
    5
) NOT NULL DEFAULT '1',
    `email` varchar
(
    65
) COLLATE utf8_unicode_ci DEFAULT NULL,
    `lastlogindate` timestamp NULL DEFAULT NULL,
    `lastloginip` varchar
(
    45
) COLLATE utf8_unicode_ci DEFAULT NULL,
    `status` enum
(
    'active',
    'pending',
    'disabled',
    'suspended'
) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'active',
    `title` varchar
(
    10
) COLLATE utf8_unicode_ci NOT NULL,
    `firstname` varchar
(
    150
) COLLATE utf8_unicode_ci NOT NULL,
    `lastname` varchar
(
    150
) COLLATE utf8_unicode_ci NOT NULL,
    `languageId` int
(
    11
) DEFAULT NULL,
    `datecreated` timestamp NULL DEFAULT NULL,
    `createdip` varchar
(
    45
) COLLATE utf8_unicode_ci DEFAULT NULL,
    `lastPayment` timestamp NULL DEFAULT NULL,
    `paidExpiryDate` timestamp NULL DEFAULT NULL,
    `remainingBWDownload` bigint
(
    20
) DEFAULT NULL,
    `paymentTracker` varchar
(
    32
) COLLATE utf8_unicode_ci DEFAULT NULL,
    `passwordResetHash` varchar
(
    32
) COLLATE utf8_unicode_ci DEFAULT NULL,
    `identifier` varchar
(
    32
) COLLATE utf8_unicode_ci NOT NULL,
    `apikey` varchar
(
    32
) COLLATE utf8_unicode_ci DEFAULT NULL,
    `storageLimitOverride` bigint
(
    20
) DEFAULT NULL,
    `privateFileStatistics` int
(
    1
) NOT NULL DEFAULT '0',
    `uploadServerOverride` bigint
(
    20
) DEFAULT NULL,
    `userGroupId` int
(
    11
) DEFAULT NULL,
    `profile` text COLLATE utf8_unicode_ci,
    `isPublic` int
(
    1
) NOT NULL DEFAULT '1',
    `accountLockStatus` int
(
    1
) NOT NULL DEFAULT '0',
    `accountLockHash` varchar
(
    16
) COLLATE utf8_unicode_ci NOT NULL,
    PRIMARY KEY
(
    `id`
),
    UNIQUE KEY `username`
(
    `username`
),
    KEY `datecreated`
(
    `datecreated`
),
    KEY `username_2`
(
    `username`
),
    KEY `level_id`
(
    `level_id`
),
    KEY `level_id_2`
(
    `level_id`
),
    KEY `level_id_3`
(
    `level_id`
)
    ) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE =utf8_unicode_ci AUTO_INCREMENT=74;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `level_id`, `email`, `lastlogindate`, `lastloginip`, `status`,
                     `title`, `firstname`, `lastname`, `languageId`, `datecreated`, `createdip`, `lastPayment`,
                     `paidExpiryDate`, `remainingBWDownload`, `paymentTracker`, `passwordResetHash`, `identifier`,
                     `apikey`, `storageLimitOverride`, `privateFileStatistics`, `uploadServerOverride`, `userGroupId`,
                     `profile`, `isPublic`, `accountLockStatus`, `accountLockHash`)
VALUES (1, 'admin', 'sha256:1000:KQpu8LquZVfABv5kvC7Kf0n22a8TN3FL:v7sM7IkhoWpRJc04qbvv1h6o6MQAl/GP', 20,
        'you@yourdomain.com', '2015-12-31 13:43:27', '192.168.1.226', 'active', 'Mr', 'Admin', 'Account', 1, NULL, NULL,
        '2015-12-31 13:29:31', '2015-12-31 13:29:31', 0, '5f4dcc3b5aa765d61d8327deb882cf99',
        'a642c8877389b2a091acefc3aee913ca', '', 'f86cff6189c7bd13db7f94ab9b74030f', NULL, 1, NULL, NULL,
        '{"image_size":[]}', 1, 0, '');

-- --------------------------------------------------------

--
-- Table structure for table `user_level`
--

CREATE TABLE IF NOT EXISTS `user_level`
(
    `id` int
(
    5
) NOT NULL AUTO_INCREMENT,
    `level_id` int
(
    5
) NOT NULL,
    `label` varchar
(
    20
) COLLATE utf8_bin NOT NULL,
    `can_upload` int
(
    1
) NOT NULL DEFAULT '0',
    `wait_between_downloads` int
(
    11
) NOT NULL DEFAULT '0',
    `download_speed` int
(
    11
) NOT NULL DEFAULT '0',
    `max_storage_bytes` bigint
(
    18
) NOT NULL DEFAULT '0',
    `show_site_adverts` int
(
    1
) NOT NULL DEFAULT '0',
    `show_upgrade_screen` int
(
    1
) NOT NULL DEFAULT '0',
    `days_to_keep_inactive_files` int
(
    11
) NOT NULL DEFAULT '360',
    `concurrent_uploads` int
(
    11
) NOT NULL DEFAULT '50',
    `concurrent_downloads` int
(
    11
) NOT NULL DEFAULT '5',
    `downloads_per_24_hours` int
(
    11
) NOT NULL DEFAULT '0',
    `max_download_filesize_allowed` bigint
(
    18
) NOT NULL DEFAULT '0',
    `max_remote_download_urls` int
(
    11
) NOT NULL DEFAULT '0',
    `max_upload_size` bigint
(
    18
) NOT NULL DEFAULT '0',
    `level_type` enum
(
    'admin',
    'free',
    'paid',
    'moderator',
    'nonuser'
) COLLATE utf8_bin NOT NULL DEFAULT 'free',
    `on_upgrade_page` int
(
    1
) NOT NULL DEFAULT '0',
    PRIMARY KEY
(
    `id`
)
    ) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE =utf8_bin AUTO_INCREMENT=112;

--
-- Dumping data for table `user_level`
--

INSERT INTO `user_level` (`id`, `level_id`, `label`, `can_upload`, `wait_between_downloads`, `download_speed`,
                          `max_storage_bytes`, `show_site_adverts`, `show_upgrade_screen`,
                          `days_to_keep_inactive_files`, `concurrent_uploads`, `concurrent_downloads`,
                          `downloads_per_24_hours`, `max_download_filesize_allowed`, `max_remote_download_urls`,
                          `max_upload_size`, `level_type`, `on_upgrade_page`)
VALUES (1, 1, 'Registered User', 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5368709120, 'free', 0),
       (20, 20, 'Admin', 1, 0, 0, 0, 0, 1, 0, 1000, 0, 0, 0, 50, 5368709120, 'admin', 0),
       (0, 0, 'Non User', 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 'nonuser', 0);

-- --------------------------------------------------------

--
-- Table structure for table `user_level_pricing`
--

CREATE TABLE IF NOT EXISTS `user_level_pricing`
(
    `id` int
(
    11
) NOT NULL AUTO_INCREMENT,
    `user_level_id` int
(
    11
) NOT NULL,
    `pricing_label` varchar
(
    50
) COLLATE utf8_bin NOT NULL,
    `package_pricing_type` varchar
(
    10
) COLLATE utf8_bin NOT NULL DEFAULT 'period',
    `period` varchar
(
    10
) COLLATE utf8_bin DEFAULT '1M',
    `download_allowance` bigint
(
    20
) DEFAULT NULL,
    `price` decimal
(
    10,
    2
) NOT NULL,
    PRIMARY KEY
(
    `id`
)
    ) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE =utf8_bin AUTO_INCREMENT=1;

--
-- Dumping data for table `user_level_pricing`
--

ALTER TABLE `file_folder`
    ADD `watermarkPreviews` TINYINT( 1 ) NOT NULL AFTER  `coverImageId` ,
ADD  `showDownloadLinks` TINYINT( 1 ) NOT NULL AFTER  `watermarkPreviews`;

ALTER TABLE `language`
    ADD `language_code` VARCHAR(5) NULL DEFAULT NULL;
UPDATE language
SET `language_code` = `flag`;

INSERT INTO site_config
VALUES (NULL, 'google_translate_api_key', '',
        'Google Translate API key. Optional but needed if you use the automatic language translation tool within the admin area.',
        '', 'string', 'Language');

ALTER TABLE `file_server`
    ADD `serverAccess` TEXT NULL;

UPDATE language
SET `language_code` = `flag`;

INSERT INTO `site_config` (`id`, `config_key`, `config_value`, `config_description`, `availableValues`, `config_type`,
                           `config_group`)
VALUES (NULL, 'blocked_filename_keywords', 'yetishare|wurlie|reservo',
        'Any filenames with the keywords listed here will be blocked from uploading. Keep in mind that this is a partial string search, so blocking the word "exe" will also block the word "exercise". Pipe separated list. i.e. word1|word2|word3',
        '', 'string', 'File Uploads');

ALTER TABLE `site_config` CHANGE `config_value` `config_value` MEDIUMTEXT CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL;
INSERT INTO `site_config` (`id`, `config_key`, `config_value`, `config_description`, `availableValues`, `config_type`,
                           `config_group`)
VALUES (NULL, 'system_plugin_config_cache', '',
        'Used internally by the system to store a cache of the plugin settings.', '', 'string', 'System');
INSERT INTO `site_config` (`id`, `config_key`, `config_value`, `config_description`, `availableValues`, `config_type`,
                           `config_group`)
VALUES (NULL, 'system_theme_config_cache', '', 'Used internally by the system to store a cache of the theme settings.',
        '', 'string', 'System');

CREATE TABLE `file_block_hash`
(
    `id`           INT( 11 ) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `file_hash`    VARCHAR(32) NOT NULL,
    `date_created` DATETIME    NOT NULL,
    UNIQUE (`file_hash`)
) ENGINE = MYISAM;

INSERT INTO `site_config` (`id`, `config_key`, `config_value`, `config_description`, `availableValues`, `config_type`,
                           `config_group`)
VALUES (NULL, 'uploads_block_all', 'no',
        'Whether to block all uploads on your site, apart from the admin user. Useful as a temporary setting for site maintenance',
        '["yes", "no"]', 'select', 'File Uploads');
INSERT INTO `site_config` (`id`, `config_key`, `config_value`, `config_description`, `availableValues`, `config_type`,
                           `config_group`)
VALUES (NULL, 'downloads_block_all', 'no',
        'Whether to block all downloads on your site, apart from the admin user. Useful as a temporary setting for site maintenance',
        '["yes", "no"]', 'select', 'File Downloads');

ALTER TABLE `language_content`
    ADD `is_locked` INT( 1 ) NOT NULL DEFAULT  '0';
UPDATE `language_content`
SET is_locked = 1;

INSERT INTO `plugin` (`id`, `plugin_name`, `folder_name`, `plugin_description`, `is_installed`, `date_installed`,
                      `plugin_settings`, `plugin_enabled`, `load_order`)
VALUES (28, 'Social Login', 'sociallogin', 'Login with your Facebook, Twitter or Google+ Account.', 1,
        '0000-00-00 00:00:00',
        0x7b2266616365626f6f6b5f656e61626c6564223a302c2266616365626f6f6b5f6170706c69636174696f6e5f6964223a22222c2266616365626f6f6b5f6170706c69636174696f6e5f736563726574223a22222c22747769747465725f656e61626c6564223a302c22747769747465725f6170706c69636174696f6e5f6b6579223a22222c22747769747465725f6170706c69636174696f6e5f736563726574223a22222c22676f6f676c655f656e61626c6564223a302c22676f6f676c655f6170706c69636174696f6e5f6964223a22222c22676f6f676c655f6170706c69636174696f6e5f736563726574223a22222c22616f6c5f656e61626c6564223a302c22696e7374616772616d5f656e61626c6564223a302c22696e7374616772616d5f6170706c69636174696f6e5f6b6579223a22222c22696e7374616772616d5f6170706c69636174696f6e5f736563726574223a22222c22666f75727371756172655f656e61626c6564223a302c22666f75727371756172655f6170706c69636174696f6e5f6964223a22222c22666f75727371756172655f6170706c69636174696f6e5f736563726574223a22222c226c696e6b6564696e5f656e61626c6564223a302c226c696e6b6564696e5f6170706c69636174696f6e5f6b6579223a22222c226c696e6b6564696e5f6170706c69636174696f6e5f736563726574223a22227d,
        1, 999);

INSERT INTO `site_config`
VALUES (null, 'security_block_register_email_domain', '',
        'Block email address domains from registering. Comma separated list of domains. i.e. exampledomain.com,exampledomain2.com,etc',
        '', 'textarea', 'Security');

INSERT INTO `site_config` (`id`, `config_key`, `config_value`, `config_description`, `availableValues`, `config_type`,
                           `config_group`)
VALUES (NULL, 'reserved_usernames', 'admin|administrator|localhost|support|billing|sales|payments',
        'Any usernames listed here will be blocked from the main registration. Pipe separated list.', '', 'string',
        'Default');

INSERT INTO `site_config` (`id`, `config_key`, `config_value`, `config_description`, `availableValues`, `config_type`,
                           `config_group`)
VALUES (NULL, 'enable_user_registration', 'no', 'Whether to enable user registration on the site.', '["yes","no"]',
        'select', 'Site Options');

INSERT INTO `site_config` (`id`, `config_key`, `config_value`, `config_description`, `availableValues`, `config_type`,
                           `config_group`)
VALUES (NULL, 'register_form_show_captcha', 'no', 'Whether to display the captcha on the site registration form.',
        '["yes","no"]', 'select', 'Captcha');


ALTER TABLE `file_folder_share`
    ADD `shared_with_user_id` INT( 11 ) NULL AFTER  `created_by_user_id`;
ALTER TABLE `file_folder_share`
    ADD `share_permission_level` ENUM(  'view',  'upload_download',  'all' ) NOT NULL DEFAULT  'view';


INSERT INTO `site_config` (`config_key`, `config_value`, `config_description`, `availableValues`, `config_type`,
                           `config_group`)
VALUES ('captcha_secret_key', 'REPLACE_ME', 'Secret key for captcha. Register at https://www.google.com/recaptcha', '',
        'string', 'Captcha');
INSERT INTO `site_config` (`config_key`, `config_value`, `config_description`, `availableValues`, `config_type`,
                           `config_group`)
VALUES ('captcha_public_key', 'REPLACE_ME', 'Public key for captcha. Register at https://www.google.com/recaptcha', '',
        'string', 'Captcha');

ALTER TABLE `theme` CHANGE `date_installed` `date_installed` DATETIME NULL DEFAULT NULL;
ALTER TABLE `theme` CHANGE `theme_settings` `theme_settings` TEXT CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL;


INSERT INTO site_config
VALUES (NULL, 'user_register_default_folders', '',
        'Default folders for new accounts. Theese are automatically created when users register on the site. Leave blank to ignore. Pipe separated list. i.e. Documents|Images|Videos',
        '', 'string', 'File Manager');

ALTER TABLE `file_folder`
    ADD `totalSize` bigint(15) NULL AFTER `folderName`;
ALTER TABLE `file_folder` CHANGE `totalSize` `totalSize` bigint(15) NULL DEFAULT '0' AFTER `folderName`;

ALTER TABLE `file`
    ADD `uploadedUserId` int(11) NULL AFTER `userId`;
ALTER TABLE `file`
    ADD INDEX `uploadedUserId` (`uploadedUserId`);
UPDATE `file`
SET `uploadedUserId` = `userId`;

ALTER TABLE `file`
    ADD `description` varchar(255) COLLATE 'utf8_general_ci' NULL AFTER `keywords`;

ALTER TABLE `site_config`
    ADD `label` varchar(100) COLLATE 'utf8_general_ci' NULL AFTER `id`;
UPDATE site_config
SET label = REPLACE(CONCAT(UCASE(LEFT(config_key, 1)), SUBSTRING(config_key, 2)), '_', ' ');
ALTER TABLE `site_config`
    ADD `display_order` int(5) COLLATE 'utf8_general_ci' DEFAULT 0 AFTER `config_group`;
UPDATE `site_config`
SET label              = 'Max file uploads per day',
    config_description = 'Spam protect: Max files a user IP address can upload per day. Leave blank for unlimited.'
WHERE config_key = 'max_files_per_day';
UPDATE `site_config`
SET label = 'reCaptcha Secret Key'
WHERE config_key = 'captcha_secret_key';
UPDATE `site_config`
SET label = 'reCaptcha Public Key'
WHERE config_key = 'captcha_public_key';
UPDATE `site_config`
SET display_order = 1
WHERE config_key = 'adblock_limiter';
UPDATE `site_config`
SET display_order = 4
WHERE config_key = 'advert_delayed_redirect_top';
UPDATE `site_config`
SET display_order = 5
WHERE config_key = 'advert_delayed_redirect_bottom';
UPDATE `site_config`
SET display_order = 10
WHERE config_key = 'advert_site_footer';

UPDATE `site_config`
SET display_order = 0
WHERE config_key = 'non_user_show_captcha';
UPDATE `site_config`
SET display_order = 3
WHERE config_key = 'free_user_show_captcha';
UPDATE `site_config`
SET display_order = 5
WHERE config_key = 'register_form_show_captcha';
UPDATE `site_config`
SET display_order = 10
WHERE config_key = 'captcha_type';
UPDATE `site_config`
SET display_order = 15
WHERE config_key = 'captcha_public_key';
UPDATE `site_config`
SET display_order = 20
WHERE config_key = 'captcha_secret_key';
UPDATE `site_config`
SET display_order = 25
WHERE config_key = 'captcha_solvemedia_ver_key';
UPDATE `site_config`
SET display_order = 30
WHERE config_key = 'captcha_solvemedia_hash_key';
UPDATE `site_config`
SET display_order = 35
WHERE config_key = 'captcha_solvemedia_challenge_key';

UPDATE `site_config`
SET display_order = 0
WHERE config_key = 'site_contact_form_email';
UPDATE `site_config`
SET display_order = 5
WHERE config_key = 'contact_form_show_captcha';

UPDATE `site_config`
SET display_order = 0
WHERE config_key = 'email_method';
UPDATE `site_config`
SET display_order = 5
WHERE config_key = 'email_smtp_host';
UPDATE `site_config`
SET display_order = 10
WHERE config_key = 'email_smtp_port';
UPDATE `site_config`
SET display_order = 12,
    config_group  = 'Email Settings'
WHERE config_key = 'default_email_address_from';
UPDATE `site_config`
SET display_order = 15
WHERE config_key = 'email_secure_method';
UPDATE `site_config`
SET display_order = 20
WHERE config_key = 'email_smtp_requires_auth';
UPDATE `site_config`
SET display_order = 25
WHERE config_key = 'email_smtp_auth_username';
UPDATE `site_config`
SET display_order = 30
WHERE config_key = 'email_smtp_auth_password';
UPDATE `site_config`
SET display_order = 35
WHERE config_key = 'email_template_enabled';
UPDATE `site_config`
SET display_order = 40
WHERE config_key = 'email_template_header';
UPDATE `site_config`
SET display_order = 45
WHERE config_key = 'email_template_footer';
UPDATE `site_config`
SET display_order = 50
WHERE config_key = 'limit_send_via_email_per_hour';

UPDATE `site_config`
SET display_order = 5
WHERE config_key = 'require_user_account_download';
UPDATE `site_config`
SET display_order = 10
WHERE config_key = 'remote_url_download_in_background';
UPDATE `site_config`
SET display_order = 15
WHERE config_key = 'downloads_track_current_downloads';
UPDATE `site_config`
SET display_order = 20
WHERE config_key = 'downloads_block_all';

UPDATE `site_config`
SET display_order = 0
WHERE config_key = 'file_manager_default_view';
UPDATE `site_config`
SET display_order = 5
WHERE config_key = 'user_register_default_folders';

UPDATE `site_config`
SET display_order = 0
WHERE config_key = 'c_file_server_selection_method';
UPDATE `site_config`
SET display_order = 5
WHERE config_key = 'default_file_server';
UPDATE `site_config`
SET display_order = 10
WHERE config_key = 'accepted_upload_file_types';
UPDATE `site_config`
SET display_order = 15
WHERE config_key = 'max_files_per_day';
UPDATE `site_config`
SET display_order = 20
WHERE config_key = 'generate_upload_url_type';
UPDATE `site_config`
SET display_order = 25
WHERE config_key = 'file_url_show_filename';
UPDATE `site_config`
SET display_order = 30
WHERE config_key = 'blocked_filename_keywords';
UPDATE `site_config`
SET display_order = 35
WHERE config_key = 'blocked_upload_file_types';
UPDATE `site_config`
SET display_order = 40
WHERE config_key = 'uploads_block_all';

UPDATE `site_config`
SET display_order = 0
WHERE config_key = 'site_language';
UPDATE `site_config`
SET display_order = 5
WHERE config_key = 'language_user_select_language';
UPDATE `site_config`
SET display_order = 10
WHERE config_key = 'show_multi_language_selector';
UPDATE `site_config`
SET display_order = 15
WHERE config_key = 'language_separate_language_images';
UPDATE `site_config`
SET display_order = 20
WHERE config_key = 'google_translate_api_key';
UPDATE `site_config`
SET display_order = 25
WHERE config_key = 'language_show_key';

UPDATE `site_config`
SET display_order = 0
WHERE config_key = 'date_format';
UPDATE `site_config`
SET display_order = 5
WHERE config_key = 'date_time_format';
UPDATE `site_config`
SET display_order = 10
WHERE config_key = 'date_time_format_js';

UPDATE `site_config`
SET display_order = 0
WHERE config_key = 'logging_log_enabled';
UPDATE `site_config`
SET display_order = 5
WHERE config_key = 'logging_log_type';
UPDATE `site_config`
SET display_order = 10
WHERE config_key = 'logging_log_output';

UPDATE `site_config`
SET display_order = 0
WHERE config_key = 'password_policy_min_length';
UPDATE `site_config`
SET display_order = 5
WHERE config_key = 'password_policy_max_length';
UPDATE `site_config`
SET display_order = 10
WHERE config_key = 'password_policy_min_numbers';
UPDATE `site_config`
SET display_order = 15
WHERE config_key = 'password_policy_min_uppercase_characters';
UPDATE `site_config`
SET display_order = 20
WHERE config_key = 'password_policy_min_nonalphanumeric_characters';

UPDATE `site_config`
SET display_order = 5
WHERE config_key = 'cost_currency_symbol';
UPDATE `site_config`
SET display_order = 10
WHERE config_key = 'cost_currency_code';

UPDATE `site_config`
SET display_order = 0
WHERE config_key = 'force_files_private';
UPDATE `site_config`
SET display_order = 5
WHERE config_key = 'security_account_lock';
UPDATE `site_config`
SET display_order = 10
WHERE config_key = 'premium_user_block_account_sharing';
UPDATE `site_config`
SET display_order = 15
WHERE config_key = 'security_send_user_email_on_password_change';
UPDATE `site_config`
SET display_order = 20
WHERE config_key = 'security_send_user_email_on_email_change';
UPDATE `site_config`
SET display_order = 25
WHERE config_key = 'security_block_register_email_domain';
UPDATE `site_config`
SET display_order = 30
WHERE config_key = 'security_block_ip_login_attempts';
UPDATE `site_config`
SET display_order = 35
WHERE config_key = 'register_form_allow_password';

UPDATE `site_config`
SET display_order = 5
WHERE config_key = 'site_name';
UPDATE `site_config`
SET display_order = 10
WHERE config_key = 'page_extension';
UPDATE `site_config`
SET display_order = 15
WHERE config_key = 'site_admin_email';
UPDATE `site_config`
SET display_order = 20
WHERE config_key = 'report_abuse_email';
UPDATE `site_config`
SET display_order = 25
WHERE config_key = 'maintenance_mode';
UPDATE `site_config`
SET display_order = 30
WHERE config_key = 'enable_user_registration';
UPDATE `site_config`
SET display_order = 35
WHERE config_key = 'performance_js_file_minify';
UPDATE `site_config`
SET display_order = 40
WHERE config_key = 'enable_file_search';
UPDATE `site_config`
SET display_order = 45
WHERE config_key = 'default_admin_file_manager_view';
UPDATE `site_config`
SET display_order = 50
WHERE config_key = 'purge_deleted_files_period_minutes';
UPDATE `site_config`
SET display_order = 55
WHERE config_key = 'google_analytics_code';
UPDATE `site_config`
SET display_order = 60
WHERE config_key = 'session_expiry';

ALTER TABLE `file` CHANGE `uploadSource` `uploadSource` ENUM('direct','remote','ftp','torrent','leech','webdav','api','fileimport','other') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'direct';

INSERT INTO `site_config` (`label`, `config_key`, `config_value`, `config_description`, `availableValues`,
                           `config_type`, `config_group`, `display_order`)
VALUES ('API Path', 'api_access_host', '',
        'The API hostname. Use [[[WEB_ROOT]]]/api/v2/ unless you want to move the API elsewhere.', '', 'string', 'API',
        5);
INSERT INTO `site_config` (`label`, `config_key`, `config_value`, `config_description`, `availableValues`,
                           `config_type`, `config_group`, `display_order`)
VALUES ('Authentication Method', 'api_authentication_method', 'API Keys',
        'Whether to use the account username and password or generated API keys. (recommended to use generated API keys)',
        '[\"API Keys\",\"Account Access Details\"]', 'select', 'API', 10);
INSERT INTO `site_config` (`label`, `config_key`, `config_value`, `config_description`, `availableValues`,
                           `config_type`, `config_group`, `display_order`)
VALUES ('Access Level', 'api_account_access_type', 'admin',
        'Restric`t access to certain account types. Hold ctrl and click to select multiple.',
        'SELECT label AS itemValue FROM user_level WHERE level_type != "nonuser" ORDER BY level_id', 'multiselect',
        'API', 15);

CREATE TABLE `apiv2_access_token`
(
    `id`             int(11) NOT NULL,
    `user_id`        int(11) NOT NULL,
    `access_token`   varchar(128) NOT NULL,
    `date_added`     datetime DEFAULT NULL,
    `date_last_used` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

ALTER TABLE `apiv2_access_token`
    ADD PRIMARY KEY (`id`),  ADD UNIQUE KEY `access_token` (`access_token`),  ADD KEY `date_last_used` (`date_last_used`);

ALTER TABLE `apiv2_access_token` MODIFY `id` int (11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;

CREATE TABLE `apiv2_api_key`
(
    `id`           int(11) NOT NULL,
    `key_public`   varchar(64) NOT NULL,
    `key_secret`   varchar(64) NOT NULL,
    `user_id`      int(11) NOT NULL,
    `date_created` datetime    NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

ALTER TABLE `apiv2_api_key`
    ADD PRIMARY KEY (`id`),  ADD UNIQUE KEY `keys_public_secret` (`key_public`,`key_secret`) USING BTREE,  ADD KEY `date_created` (`date_created`),  ADD KEY `user_id` (`user_id`);

ALTER TABLE `apiv2_api_key` MODIFY `id` int (11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;

CREATE TABLE `file_server_container`
(
    `id`                   int(11) NOT NULL,
    `label`                varchar(100) NOT NULL,
    `entrypoint`           varchar(50)  NOT NULL,
    `expected_config_json` text,
    `is_enabled`           tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

ALTER TABLE `file_server_container`
    ADD PRIMARY KEY (`id`);
ALTER TABLE `file_server_container` MODIFY `id` int (11) NOT NULL AUTO_INCREMENT;

ALTER TABLE `file_server` CHANGE `serverType` `serverType` VARCHAR (50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'local';

INSERT INTO `file_server_container` (`id`, `label`, `entrypoint`, `expected_config_json`, `is_enabled`)
VALUES (1, 'FTP', 'flysystem_ftp',
        '{"host":{"label":"FTP Host","type":"text","default":""},"username":{"label":"FTP Username","type":"text","default":""},"password":{"label":"FTP Password","type":"text","default":""},"port":{"label":"Port","type":"number","default":"21"},"root":{"label":"Root Path","type":"text","default":"\\/"},"passive":{"label":"Enable Passive Mode","type":"select","default":"1","option_values":["No","Yes"]},"ssl":{"label":"Use SSL","type":"select","default":"0","option_values":["No","Yes"]},"timeout":{"label":"Connection Timeout","type":"number","default":"30"}}',
        1),
       (2, 'SFTP', 'flysystem_sftp',
        '{"host":{"label":"SFTP Host","type":"text","default":""},"username":{"label":"SFTP Username","type":"text","default":""},"password":{"label":"SFTP Password","type":"text","default":""},"port":{"label":"Port","type":"number","default":"21"},"root":{"label":"Root Path","type":"text","default":"\\/"},"timeout":{"label":"Connection Timeout","type":"number","default":"30"}}',
        1),
       (3, 'Amazon S3', 'flysystem_aws',
        '{"key":{"label":"Public Key","type":"text","default":""},"secret":{"label":"Secret Key","type":"text","default":""},"bucket":{"label":"S3 Bucket","type":"text","default":""},"region":{"label":"Your Bucket Region","type":"select","default":"us-east-1","option_values":{"us-east-1":"US East (N. Virginia)","us-east-2":"US East (Ohio) - us-east-2","us-west-1":"US West (N. California) - us-west-1","us-west-2":"US West (Oregon) - us-west-2","ca-central-1":"Canada (Central) - ca-central-1","ap-south-1":"Asia Pacific (Mumbai) - ap-south-1","ap-northeast-2":"Asia Pacific (Seoul) - ap-northeast-2","ap-southeast-1":"Asia Pacific (Singapore) - ap-southeast-1","ap-southeast-2":"Asia Pacific (Sydney) - ap-southeast-2","ap-northeast-1":"Asia Pacific (Tokyo) - ap-northeast-1","eu-central-1":"EU (Frankfurt) - eu-central-1","eu-west-1":"EU (Ireland) - eu-west-1","eu-west-2":"EU (London) - eu-west-2","sa-east-1":"South America (S\\u00e3o Paulo) - sa-east-1"}},"version":{"label":"Version (Don\'t Change)","type":"string","default":"latest"}}', 1),
(4, 'Rackspace Cloud Files', 'flysystem_rackspace', '{"username":{"label":"Rackspace Username","type":"text","default":""},"apiKey":{"label":"API Key","type":"text","default":""},"container":{"label":"Cloud Files Container","type":"text","default":""},"region":{"label":"Container Region","type":"
select "," default ":" IAD "," option_values ":{" IAD ":" Nothern Virginia (IAD)"," DFW ":" Dallas (DFW)"," HKG ":" Hong Kong (HKG)"," SYD ":" Sydney (SYD)"," LON ":" London (LON) "}}}', 1),
(5, 'Azure Blob Storage', 'flysystem_azure', '{" account- name ":{" label ":" Account Name "," type ":" text "," default ":""}," api- key ":{" label ":" API Key "," type ":" text "," default ":""}," container ":{" label ":" Files Container "," type ":" text "," default ":""}}', 0);

ALTER TABLE  `user_level` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
ALTER TABLE  `user_level` CHANGE  `label`  `label` VARCHAR( 20 ) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL;

ALTER TABLE `file_folder` ADD `urlHash` varchar(32) NULL AFTER `showDownloadLinks`;

ALTER TABLE `file_folder` ADD INDEX `userId` (`userId`), ADD INDEX `parentId` (`parentId`), ADD INDEX `totalSize` (`totalSize`), ADD INDEX `isPublic` (`isPublic`), ADD INDEX `folderName` (`folderName`);

ALTER TABLE `country_info` ADD INDEX `iso_alpha2` (`iso_alpha2`), ADD INDEX `iso_alpha3` (`iso_alpha3`);

ALTER TABLE `download_page` ADD INDEX `user_level_id` (`user_level_id`);

ALTER TABLE `download_token` ADD INDEX `ip_address` (`ip_address`), ADD INDEX `file_id` (`file_id`);
ALTER TABLE `download_token` ADD INDEX `user_id` (`user_id`);

ALTER TABLE `language` ADD INDEX `isLocked` (`isLocked`), ADD INDEX `isActive` (`isActive`);

ALTER TABLE `plugin` ADD INDEX `is_installed` (`is_installed`);

ALTER TABLE `user_level` ADD INDEX `level_id` (`level_id`);

ALTER TABLE `users` ADD INDEX `apikey` (`apikey`);

ALTER TABLE `theme` ADD INDEX `is_installed` (`is_installed`);

SET NAMES utf8mb4;

ALTER TABLE `user_level` ADD `can_remote_download` int(1) NOT NULL DEFAULT '1' AFTER `max_download_filesize_allowed`;

INSERT INTO `site_config` (`config_key`, `label`, `config_value`, `config_description`, `availableValues`, `config_type`, `config_group`, `display_order`) VALUES ('captcha_login_screen_normal', 'Show User Login Screen', 'no', 'Show the captcha on the standard login screen.', '[\"yes\",\"no\"]', 'select', 'Captcha', 6);
INSERT INTO `site_config` (`config_key`, `label`, `config_value`, `config_description`, `availableValues`, `config_type`, `config_group`, `display_order`) VALUES ('captcha_login_screen_admin', 'Show Admin Login Screen', 'no', 'Show the captcha on the admin login screen.', '[\"yes\",\"no\"]', 'select', 'Captcha', 7);
UPDATE `site_config` SET label = 'File Download - Non User' WHERE config_key = 'non_user_show_captcha';
UPDATE `site_config` SET label = 'File Download - Free User' WHERE config_key = 'free_user_show_captcha';

ALTER TABLE `download_token` ADD `file_transfer` int(1) NOT NULL DEFAULT '1';

ALTER TABLE `file_action` ADD `is_uploaded_file` int(11) NOT NULL DEFAULT '0' AFTER `file_path`;

UPDATE file_server SET storagePath = 'files/' WHERE (storagePath = '' OR storagePath IS NULL) AND serverType = 'local';

ALTER TABLE `file_server` DROP `lastFileActionQueueProcess`;
ALTER TABLE `file_server` ADD `lastFileActionQueueProcess` datetime NULL AFTER `routeViaMainSite`;
ALTER TABLE `file_server` ADD `scriptRootPath` varchar(255) NULL AFTER `statusId`;

UPDATE file_folder_share SET last_accessed = '2038-01-01 00:00:00' WHERE CAST(last_accessed AS CHAR(20)) = '0000-00-00 00:00:00';
ALTER TABLE `file_folder_share` CHANGE `last_accessed` `last_accessed` datetime NULL AFTER `date_created`;
UPDATE file_folder_share SET last_accessed = NULL WHERE last_accessed = '2038-01-01 00:00:00';

UPDATE plugin SET date_installed = '2038-01-01 00:00:00' WHERE CAST(date_installed AS CHAR(20)) = '0000-00-00 00:00:00';
ALTER TABLE `plugin` CHANGE `date_installed` `date_installed` datetime NULL AFTER `is_installed`;
UPDATE plugin SET date_installed = NULL WHERE date_installed = '2038-01-01 00:00:00';

ALTER TABLE `file` DROP INDEX `keywords`;
ALTER TABLE `file` ADD INDEX `keywords` (`keywords`);
ALTER TABLE `stats` CHANGE `download_date` `download_date` datetime NULL AFTER `id`;

ALTER TABLE `apiv2_access_token` ENGINE= InnoDB COLLATE 'utf8mb4_general_ci';
ALTER TABLE `apiv2_api_key` ENGINE= InnoDB COLLATE 'utf8mb4_general_ci';
ALTER TABLE `background_task` ENGINE= InnoDB COLLATE 'utf8mb4_general_ci';
ALTER TABLE `background_task_log` ENGINE= InnoDB COLLATE 'utf8mb4_general_ci';
ALTER TABLE `banned_ips` ENGINE= InnoDB COLLATE 'utf8mb4_general_ci';
ALTER TABLE `country_info` ENGINE= InnoDB COLLATE 'utf8mb4_general_ci';
ALTER TABLE `cross_site_action` ENGINE= InnoDB COLLATE 'utf8mb4_general_ci';
ALTER TABLE `download_page` ENGINE= InnoDB COLLATE 'utf8mb4_general_ci';
ALTER TABLE `download_token` ENGINE= InnoDB COLLATE 'utf8mb4_general_ci';
ALTER TABLE `download_tracker` ENGINE= InnoDB COLLATE 'utf8mb4_general_ci';
ALTER TABLE `file` ENGINE= InnoDB COLLATE 'utf8mb4_general_ci';
ALTER TABLE `file_action` ENGINE= InnoDB COLLATE 'utf8mb4_general_ci';
ALTER TABLE `file_block_hash` ENGINE= InnoDB COLLATE 'utf8mb4_general_ci';
ALTER TABLE `file_folder` ENGINE= InnoDB COLLATE 'utf8mb4_general_ci';
ALTER TABLE `file_folder_share` ENGINE= InnoDB COLLATE 'utf8mb4_general_ci';
ALTER TABLE `file_report` ENGINE= InnoDB COLLATE 'utf8mb4_general_ci';
ALTER TABLE `file_server` ENGINE= InnoDB COLLATE 'utf8mb4_general_ci';
ALTER TABLE `file_server_container` ENGINE= InnoDB COLLATE 'utf8mb4_general_ci';
ALTER TABLE `file_server_status` ENGINE= InnoDB COLLATE 'utf8mb4_general_ci';
ALTER TABLE `file_status` ENGINE= InnoDB COLLATE 'utf8mb4_general_ci';
ALTER TABLE `internal_notification` ENGINE= InnoDB COLLATE 'utf8mb4_general_ci';
ALTER TABLE `language` ENGINE= InnoDB COLLATE 'utf8mb4_general_ci';
ALTER TABLE `language_content` ENGINE= InnoDB COLLATE 'utf8mb4_general_ci';
ALTER TABLE `language_key` ENGINE= InnoDB COLLATE 'utf8mb4_general_ci';
ALTER TABLE `login_failure` ENGINE= InnoDB COLLATE 'utf8mb4_general_ci';
ALTER TABLE `login_success` ENGINE= InnoDB COLLATE 'utf8mb4_general_ci';
ALTER TABLE `payment_log` ENGINE= InnoDB COLLATE 'utf8mb4_general_ci';
ALTER TABLE `plugin` ENGINE= InnoDB COLLATE 'utf8mb4_general_ci';
ALTER TABLE `premium_order` ENGINE= InnoDB COLLATE 'utf8mb4_general_ci';
ALTER TABLE `remote_url_download_queue` ENGINE= InnoDB COLLATE 'utf8mb4_general_ci';
ALTER TABLE `sessions` ENGINE= InnoDB COLLATE 'utf8mb4_general_ci';
ALTER TABLE `site_config` ENGINE= InnoDB COLLATE 'utf8mb4_general_ci';
ALTER TABLE `stats` ENGINE= InnoDB COLLATE 'utf8mb4_general_ci';
ALTER TABLE `theme` ENGINE= InnoDB COLLATE 'utf8mb4_general_ci';
ALTER TABLE `users` ENGINE= InnoDB COLLATE 'utf8mb4_general_ci';
ALTER TABLE `user_level` ENGINE= InnoDB COLLATE 'utf8mb4_general_ci';
ALTER TABLE `user_level_pricing` ENGINE= InnoDB COLLATE 'utf8mb4_general_ci';

ALTER TABLE `file_folder` ADD `status` enum('active','trash','deleted') COLLATE 'utf8_general_ci' NULL DEFAULT 'active' AFTER `urlHash`;
ALTER TABLE `file` ADD `status` enum('active','trash','deleted') NULL DEFAULT 'active' AFTER `statusId`;
UPDATE `file` SET status = 'deleted' WHERE statusId != 1;
ALTER TABLE `file` ADD `date_updated` datetime NULL;

ALTER TABLE `file` ADD INDEX `status` (`status`);
ALTER TABLE `file_folder` ADD INDEX `status` (`status`);

ALTER TABLE `user_level` ADD `max_uploads_per_day` bigint(18) NOT NULL DEFAULT '0' AFTER `max_upload_size`;
UPDATE `user_level` SET `max_uploads_per_day` = (SELECT config_value FROM site_config WHERE config_key = 'max_files_per_day' LIMIT 1);
DELETE FROM `site_config` WHERE config_key = 'max_files_per_day' LIMIT 1;

ALTER TABLE `file` ADD INDEX `uploadedIP` (`uploadedIP`);

ALTER TABLE `user_level` ADD `accepted_file_types` varchar(255) NOT NULL DEFAULT '' AFTER `max_uploads_per_day`;
UPDATE `user_level` SET `accepted_file_types` = (SELECT config_value FROM site_config WHERE config_key = 'accepted_upload_file_types' LIMIT 1);
DELETE FROM `site_config` WHERE config_key = 'accepted_upload_file_types' LIMIT 1;

ALTER TABLE `user_level` ADD `blocked_file_types` varchar(255) NOT NULL DEFAULT '' AFTER `accepted_file_types`;
UPDATE `user_level` SET `blocked_file_types` = (SELECT config_value FROM site_config WHERE config_key = 'blocked_upload_file_types' LIMIT 1);
DELETE FROM `site_config` WHERE config_key = 'blocked_upload_file_types' LIMIT 1;

ALTER TABLE `user_level` ADD `days_to_keep_trashed_files` int(11) NOT NULL DEFAULT '0' AFTER `days_to_keep_inactive_files`;


ALTER TABLE `download_token` ADD `process_ppd` int(1) NOT NULL DEFAULT '1';

INSERT INTO `site_config` (`label`, `config_key`, `config_value`, `config_description`, `availableValues`, `config_type`, `config_group`, `display_order`) VALUES ('Script Version Number', 'script_version_number', '2.0', 'System value. The current script version number.', '', 'integer', 'System', '0');
INSERT INTO `site_config` (`label`, `config_key`, `config_value`, `config_description`, `availableValues`, `config_type`, `config_group`, `display_order`) VALUES ('Admin Approve Registration', 'admin_approve_registrations', 'no', 'Whether admin should manually approve all account registrations.', '[\"yes\",\"no\"]', 'select', 'Site Options', '31');
ALTER TABLE `users` CHANGE `status` `status` enum('active','pending','disabled','suspended','awaiting approval') COLLATE 'utf8_unicode_ci' NOT NULL DEFAULT 'active' AFTER `lastloginip`;

ALTER TABLE `file_folder` ADD UNIQUE `urlHash` (`urlHash`);
UPDATE file_folder SET urlHash = MD5(CONCAT(NOW(), RAND(), UUID())) WHERE urlHash IS NULL;

UPDATE `site_config` SET `availableValues` = '[\"recaptcha\",\"solvemedia\",\"cryptoloot\"]' WHERE `config_key` = 'captcha_type';
INSERT INTO `site_config` (`label`, `config_key`, `config_value`, `config_description`, `availableValues`, `config_type`, `config_group`) VALUES ('Cryptoloot Public Key', 'captcha_cryptoloot_public_key', '', 'Public site key for cryptoloot captcha, if enabled. Register at https://crypto-loot.com', '', 'string', 'Captcha');
INSERT INTO `site_config` (`label`, `config_key`, `config_value`, `config_description`, `availableValues`, `config_type`, `config_group`) VALUES ('Cryptoloot Private Key', 'captcha_cryptoloot_private_key', '', 'Private site key for cryptoloot captcha, if enabled. Register at http://crypto-loot.com', '', 'string', 'Captcha');

UPDATE `site_config` SET display_order = 40 WHERE config_key = 'captcha_cryptoloot_public_key';
UPDATE `site_config` SET display_order = 45 WHERE config_key = 'captcha_cryptoloot_private_key';

INSERT INTO `file_server_container` (`id`, `label`, `entrypoint`, `expected_config_json`, `is_enabled`) VALUES (NULL,	'Backblaze B2',	'flysystem_backblaze_b2',	'{\"account_id\":{\"label\":\"Master Key Id\",\"type\":\"text\",\"default\":\"\"},\"application_key\":{\"label\":\"Master Application Key (Master Only Supported)\",\"type\":\"text\",\"default\":\"\"},\"bucket\":{\"label\":\"Bucket Name\",\"type\":\"text\",\"default\":\"\"}}',	1);

ALTER TABLE `banned_ips` RENAME TO `banned_ip`;

UPDATE language_content SET content = REPLACE(content, '.[[[PAGE_EXTENSION]]]', '') WHERE content LIKE '%.[[[PAGE_EXTENSION]]]%';
UPDATE language_key SET defaultContent = REPLACE(defaultContent, '.[[[PAGE_EXTENSION]]]', '') WHERE defaultContent LIKE '%.[[[PAGE_EXTENSION]]]%';
UPDATE language_content SET content = REPLACE(content, '.[[[SITE_CONFIG_PAGE_EXTENSION]]]', '') WHERE content LIKE '%.[[[SITE_CONFIG_PAGE_EXTENSION]]]%';
UPDATE language_key SET defaultContent = REPLACE(defaultContent, '.[[[SITE_CONFIG_PAGE_EXTENSION]]]', '') WHERE defaultContent LIKE '%.[[[SITE_CONFIG_PAGE_EXTENSION]]]%';

DELETE FROM site_config WHERE config_key = 'page_extension';

INSERT INTO `site_config` (`label`, `config_key`, `config_value`, `config_description`, `availableValues`, `config_type`, `config_group`, `display_order`) VALUES ('Enable Application Cache', 'enable_application_cache', 'yes', 'Whether to activate application cache or not. This will cache the Twig templates and url routes to improve performance.', '[" yes "," no "]', 'select', 'Site Options', 6);

UPDATE download_page SET download_page = REPLACE(download_page, '_download_page_captcha.inc.php', 'captcha.html');
UPDATE download_page SET download_page = REPLACE(download_page, '_download_page_compare_all.inc.php', 'compare_all.html');
UPDATE download_page SET download_page = REPLACE(download_page, '_download_page_compare_timed.inc.php', 'compare_timed.html');
UPDATE download_page SET download_page = REPLACE(download_page, '_download_page_file_info.inc.php', 'file_info.html');
UPDATE download_page SET download_page = REPLACE(download_page, '_download_page_timed.inc.php', 'timed.html');

ALTER TABLE `site_config` CHANGE `config_description` `config_description` text COLLATE 'utf8_general_ci' NOT NULL AFTER `config_value`;
INSERT INTO `site_config` (`label`, `config_key`, `config_value`, `config_description`, `availableValues`, `config_type`, `config_group`, `display_order`) VALUES ('User Session Type', 'user_session_type', 'Database Sessions', 'Login session type. If you are using any " Direct " file servers, that must be " Database Sessions ", using " Local Sessions " will break cross server support. If you enable a " Direct " file server, this is automatically changed to " Database Sessions ". After changing you will need to re-login.', '[" Local Sessions ", " Database Sessions "]', 'select', 'Site Options', 59);
UPDATE `site_config` SET `config_value` = (SELECT IF(COUNT(id) > 0, 'Database Sessions', 'Local Sessions') FROM file_server WHERE serverType = 'direct') WHERE `config_key` = 'user_session_type';

CREATE TABLE `file_folder_share_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `file_folder_share_id` int(11) NOT NULL,
  `file_id` int(11) NULL,
  `folder_id` int(11) NULL,
  `date_created` datetime NOT NULL
) ENGINE='InnoDB' COLLATE 'utf8_bin';

ALTER TABLE `file_folder_share_item`
ADD INDEX `file_folder_share_id` (`file_folder_share_id`),
ADD INDEX `file_id` (`file_id`),
ADD INDEX `folder_id` (`folder_id`);

INSERT INTO `file_folder_share_item` (`file_folder_share_id`, `folder_id`, `date_created`) (SELECT `id`, `folder_id`, `date_created` FROM `file_folder_share`);
ALTER TABLE `file_folder_share` DROP `folder_id`;
ALTER TABLE `file_folder_share` ADD `is_global` int(1) NOT NULL DEFAULT '0' AFTER `shared_with_user_id`;

ALTER TABLE `file_folder_share` CHANGE `access_key` `access_key` varchar(128) COLLATE 'latin1_swedish_ci' NOT NULL AFTER `id`;
ALTER TABLE `file_folder_share` ADD INDEX `is_global` (`is_global`);

INSERT INTO `site_config` (`label`, `config_key`, `config_value`, `config_description`, `availableValues`, `config_type`, `config_group`, `display_order`) VALUES ('Support Legacy Folder Urls', 'support_legacy_folder_urls', 'Disabled', 'Whether to support legacy public folder urls or not. In the recent code these are made using a unique 32 character length hash, whereas older urls used the shorter folder id.', '[" Enabled ", " Disabled "]', 'select', 'File Manager', 99);

ALTER TABLE `file_folder` ADD `addedUserId` int(11) NULL AFTER `userId`;
UPDATE `file_folder` SET `addedUserId` = `userId`;

INSERT INTO `site_config` (`label`, `config_key`, `config_value`, `config_description`, `availableValues`, `config_type`, `config_group`, `display_order`) VALUES ('Lock Download Tokens To IP', 'lock_download_tokens_to_ip', 'Disabled', 'Whether to lock downloads to the original requesting IP address for additional leech protection. Note: This will cause the document viewer to stop working if you are using this functionality.', '[" Enabled ", " Disabled "]', 'select', 'File Downloads', 99);

UPDATE `plugin` SET is_installed = 1 WHERE folder_name = 'fileimport';

UPDATE `site_config` SET `config_value` = '32' WHERE `config_key` = 'password_policy_max_length' AND `config_value` = '8';

INSERT INTO `site_config` (`label`, `config_key`, `config_value`, `config_description`, `availableValues`, `config_type`, `config_group`, `display_order`) VALUES ('Username min length', 'username_min_length', '6', 'The minimum character length for a username.', '', 'string', 'Security', 40);
INSERT INTO `site_config` (`label`, `config_key`, `config_value`, `config_description`, `availableValues`, `config_type`, `config_group`, `display_order`) VALUES ('Username max length', 'username_max_length', '20', 'The maximum character length for a username.', '', 'string', 'Security', 41);

INSERT INTO `theme` (`id`, `theme_name`, `folder_name`, `theme_description`, `author_name`, `author_website`, `is_installed`, `date_installed`, `theme_settings`) VALUES
(5, 'Evolution Theme', 'evolution', 'Bootstrap uCloud theme included with v2.0+', 'MFScripts', 'https://mfscripts.com', 1, NOW(), '{\"thumbnail_type\":\"square\",\"site_skin\":\"default.css\",\"css_code\":\"\"}');
DELETE FROM `theme` WHERE folder_name = 'cloudable';
UPDATE `site_config` SET config_value = 'evolution' WHERE config_key = 'site_theme';

DROP TABLE IF EXISTS `banned_files`;
CREATE TABLE `banned_files` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fileHash` varchar(32) CHARACTER SET latin1 NOT NULL,
  `fileSize` bigint(15) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fileHash` (`fileHash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DELETE FROM `site_config` WHERE `config_key` = 'script_version_number' LIMIT 1;
UPDATE `site_config` SET `config_description` = 'Secret key for reCaptcha v2. Register at https://www.google.com/recaptcha' WHERE config_key = 'captcha_secret_key';
UPDATE `site_config` SET `config_description` = 'Public key for reCaptcha v2. Register at https://www.google.com/recaptcha' WHERE config_key = 'captcha_public_key';

ALTER TABLE `plugin_filepreviewer_watermark` ADD `category` varchar(20) NOT NULL DEFAULT 'images';

DROP TABLE IF EXISTS `plugin_filepreviewer_background_thumb`;
CREATE TABLE `plugin_filepreviewer_background_thumb` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `file_id` int(11) NOT NULL,
  `thumb_status` enum('processing','failed','created','nonimage') CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `date_added` datetime NOT NULL,
  `processing_time` decimal(5,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `file_id` (`file_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

ALTER TABLE `file_server` ADD `geoUploadCountries` varchar(1000) COLLATE 'utf8_general_ci' NULL;
ALTER TABLE `file_server` ADD FULLTEXT `geoUploadCountries` (`geoUploadCountries`);

INSERT INTO `site_config` (`label`, `config_key`, `config_value`, `config_description`, `availableValues`, `config_type`, `config_group`, `display_order`) VALUES ('Concurrent Uploads', 'file_manager_concurrent_uploads', 'Enabled', 'Whether to process concurrent uploads or one at a time. Enabling will speed up the uploader. For sites with limited resources available, you should disable this.', '[" Disabled ", " Enabled "]', 'select', 'File Manager', 101);
INSERT INTO `site_config` (`label`, `config_key`, `config_value`, `config_description`, `availableValues`, `config_type`, `config_group`, `display_order`) VALUES ('Concurrent Upload Limit', 'file_manager_concurrent_upload_limit', '3', 'If concurrent uploads is enabled, limit the concurrent upload requests here.', '["1", "2", "3", "4", "5", "6", "7", "8"]', 'select', 'File Manager', 102);

-- from v2.1.0.sql
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
-- end v2.1.0.sql