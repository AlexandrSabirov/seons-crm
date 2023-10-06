-- Дамп структуры базы данных seons_crm
CREATE DATABASE IF NOT EXISTS `seons_crm`;
USE `seons_crm`;


-- Слой Contacts
-- Дамп структуры базы данных seons_crm.seons_contact
CREATE TABLE IF NOT EXISTS `seons_contact` (
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Саморазвивающийся идентификатор',
    `date_create` DATETIME NOT NULL COMMENT 'Дата создания контакта',
    `date_update` DATETIME DEFAULT NULL COMMENT 'Дата изменения контакта',
    `created_by_user_id` SMALLINT NOT NULL DEFAULT 0 COMMENT 'Идентификатор юзера, который создал контакт',
    `modified_by_user_id` SMALLINT NOT NULL DEFAULT 0 COMMENT 'Идентификатор юзера, который модифицировал контакт',
    `assigned_by_user_id` SMALLINT NOT NULL DEFAULT 0 COMMENT 'Идентификатор юзера, которому принадлежит контакт',
    `fist_name` VARCHAR(100) NOT NULL COMMENT 'Имя контакта',
    `last_name` VARCHAR(100) DEFAULT '' COMMENT 'Фамилия',
    `full_name` VARCHAR(255) DEFAULT '' COMMENT 'Имя и Фамилия контакта',
    `photo` VARCHAR(255) DEFAULT '' COMMENT 'пукть к файлу Фотографии клиента',
    `gender` CHAR(1) DEFAULT '' COMMENT 'Пол клиента',
    `age`   TINYINT DEFAULT '' COMMENT 'Возраст клиента',
    `address` TEXT DEFAULT '' COMMENT 'Адресс клиента',,=
    `city`  VARCHAR(255) DEFAULT '' COMMENT 'Город клиента',
    `country` CHAR(2) DEFAULT '' COMMENT 'Старана в alpha-2 формате',
    `email` VARCHAR(255) DEFAULT '' COMMENT 'Почта клиента',
    `comment` TEXT DEFAULT '' COMMENT 'Комментарий к контакту',
    `source_id` VARCHAR(50) DEFAULT '' COMMENT 'Индетификатор источника трафика',
    `last_activity_time` DATETIME DEFAULT NULL 'Последния активность клиента',
    PRIMARY KEY (`id`) USING BTREE,
    INDEX `idx_fn` (`first_name` ASC) USING BTREE VISIBLE,
    INDEX `idx_ln` (`last_name` ASC) USING BTREE VISIBLE,
    INDEX `idx_dc` (`date_create` ASC) USING BTREE VISIBL,
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



-- Дамп структуры базы данных seons_crm.seons_contact_custom_fields
CREATE TABLE IF NOT EXISTS `seons_contact_custom_fields` (
    `contact_id` INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Саморазвивающийся идентификатор',
    `bot_name` VARCHAR(255) DEFAULT '' COMMENT 'Имя бота, через которого прошел клиент',
    `clickid_uclick` VARCHAR(100) DEFAULT '' COMMENT 'Clickid и ucklick для индетификации клиента в трекере',
    `messenger_id` VARCHAR(100) DEFAULT '' COMMENT 'Идентификатор мессенджера с префиксом. Например: tg-, wp-, fb- и т.д.',
    `user_id_partners` VARCHAR(100) DEFAULT '' COMMENT 'Идетнификатор зарегистрированного пользователя в партнерской программе. Пишется с префиксом. Например:1win-, pinup-',
    `link_to_registration` VARCHAR(255) DEFAULT '' COMMENT 'Индивидуальная ссылка на регистрацию пользователя в партнерксой программе', 
    `chain_events` VARCHAR(255) DEFAULT '' COMMENT 'Цепочка основных событий совершенных пользователем', 
    `status_in_tracker` VARCHAR(20) DEFAULT '' COMMENT 'Текущий статус пользователя в трекере', 
    `affiliate_networks` VARCHAR(100) DEFAULT '' COMMENT 'Название партнерской программы',
    `endpoint` VARCHAR (100) DEFAULT '' COMMENT 'Конечная точка регистрации пользователя, она указана в ссылке', 
    `operator` VARCHAR (255) DEFAULT '' COMMENT 'email оператора который работает с текущем контактом', 
    `smartlink` VARCHAR (255) DEFAULT '' COMMENT 'Трекерная ссылка(смартлинка), на тот случай если пользователь не прошел через бота',
    `rule_tracker_smartlink` VARCHAR (255) DEFAULT '' COMMENT 'Правило для смартлинки', 
    `counter_before_rebill` SMALLINT DEFAULT 0 COMMENT 'Количество ребиллов до депозита', 
    `counter_after_rebill` SMALLINT DEFAULT 0 COMMENT 'Количество ребиллов после депозита', 
    `cost` VARCHAR (255) DEFAULT '0' COMMENT 'Расходы рекламной компании на текущего пользователя', 
    `ad_id` VARCHAR (255) DEFAULT '' COMMENT 'Идентификатор объявления', 
    `ad_name` VARCHAR (255) DEFAULT '' COMMENT 'Название объявлений', 
    `adset_id` VARCHAR (255) DEFAULT '' COMMENT 'Идентификатор группы объявлений',
    `adset_name` VARCHAR (255) DEFAULT '' COMMENT 'Название группы объявлений',
    `campaign_id` VARCHAR (255) DEFAULT '' COMMENT 'Идентификатор компании',
    `campaign_name` VARCHAR (255) DEFAULT '' COMMENT 'Название компании', 
    `pixel` VARCHAR (255) DEFAULT '0' COMMENT 'Пиксель рекламной компании',
    `profit` VARCHAR (255) DEFAULT '0' COMMENT 'Выплата от партнерской программы ',
    `excel_row` VARCHAR (255) DEFAULT '' COMMENT 'Дипазон строки в google sheets',
    `conversion_data` TEXT DEFAULT '' COMMENT 'Все события которые совершил пользователь в ПП. Хранятся в сериализованном виде.', 
    `common_sum_rebill` VARCHAR(255) DEFAULT 0 COMMENT 'Общая ссумма которую внес пользователь в ПП', 
    PRIMARY KEY (`contact_id`) USING BTREE,
    FOREIGN KEY (`contact_id`) REFERENCES `contact` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
    INDEX `idx_clickid_unclick` (`clickid_unclick` ASC) USING BTREE VISIBLE,
    INDEX `idx_messenger_id` (`messenger_id` ASC) USING BTREE VISIBLE,
    INDEX `idx_ad_id` (`ad_id` ASC) USING BTREE VISIBLE,
    INDEX `idx_ad_name` (`ad_name` ASC) USING BTREE VISIBLE,
    INDEX `idx_adset_id` (`adset_id` ASC) USING BTREE VISIBLE,
    INDEX `idx_adset_name` (`adset_name` ASC) USING BTREE VISIBLE,
    INDEX `idx_campaign_id` (`campaign_id` ASC) USING BTREE VISIBLE,
    INDEX `idx_adset_name` (`adset_name` ASC) USING BTREE VISIBLE,
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- DROP PROCEDURE IF EXISTS add_column_table;
-- Создание процедуры для добавления нового поля в таблицу
delimiter //
CREATE PROCEDURE add_column_table (IN old_table VARCHAR(255), IN column_name VARCHAR(255), IN column_type VARCHAR(255), IN column_default VARCHAR(255))
    BEGIN
        SET @old_table := old_table;
        SET @new_table := CONCAT('change_',@old_table);
        SET @column_name := column_name;
        SET @column_type := column_type;
        SET @column_default := column_default;
        SET @sql_create := CONCAT('CREATE TABLE ',@new_table,' LIKE ',@old_table,';');
        set @sql_alter := CONCAT('ALTER TABLE ',@new_table,' ADD COLUMN ',@column_name,' ',@column_type,' DEFAULT ',@column_default,';');
        SET @sql_insert := CONCAT('INSERT INTO ',@new_table,' SELECT * , ',@column_default,' as ',@column_name,' FROM ',@old_table,';');
        -- SET @sql_delete := CONCAT('DROP TABLE ',@old_table,';');
        SET @sql_rename_backup := CONCAT('RENAME TABLE ',@old_table,' TO ',@old_table,'_backup;');
        SET @sql_rename := CONCAT('RENAME TABLE ',@new_table,' TO ',@old_table,';');
        PREPARE cr FROM @sql_create;
        EXECUTE cr;
        PREPARE alt FROM @sql_alter;
        EXECUTE alt;
        PREPARE ins FROM @sql_insert;
        EXECUTE ins;

        -- PREPARE del FROM @sql_delete;
        -- EXECUTE del;
        PREPARE ren_b FROM @sql_rename_backup;
        EXECUTE ren_b;
        PREPARE ren FROM @sql_rename;
        EXECUTE ren;
END //
delimiter ;

RENAME TABLE `clickid_user_telegram` TO `clickid_user_telegram_backup`;
RENAME TABLE `clickid_user_telegram_temp` TO `clickid_user_telegram`;
ALTER TABLE `clickid_user_telegram_backup` ADD COLUMN full_name_t556 VARCHAR(255) DEFAULT NULL;
RENAME TABLE `clickid_user_telegram` TO `clickid_user_telegram_temp`;
RENAME TABLE `clickid_user_telegram_backup` TO `clickid_user_telegram`;
descibe clickid_user_telegram;

-- DROP TABLE IF EXISTS change_orders;
-- Пример вызова процедуры для добавления нового поля в таблицу
-- CALL add_column_table('orders', 'field1', 'VARCHAR(255)', 'NULL');

-- Слой Others_entities
-- Дамп структуры базы данных seons_crm.seons_entity
CREATE TABLE IF NOT EXISTS `seons_entity` (
`eid` TINYINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Саморазвивающийся идентификатор. Индетификатор сущности',
`entity_name` VARCHAR(100) NOT NULL COMMENT 'Название сущности',
PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Дамп данных таблицы seons_crm.seons_entity:
INSERT INTO `seons_entity` (`id`, `entity_name`) VALUES
    (1. 'click'),
    (2, 'lead'),
    (3, 'deal'),
    (4, 'contact');
   

-- Дамп структуры базы данных seons_crm.seons_custom_fields
CREATE TABLE IF NOT EXISTS `custom_fields` (
    `id` SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Саморазвивающийся идентификатор.',
    `entity_id` TINYINT UNSIGNED NOT NULL  COMMENT 'Индетификатор сущности',
    `field_name` VARCHAR(255) NOT NULL COMMENT 'Название пользовательского поля',
    `data_type` VARCHAR(255) NOT NULL COMMENT 'Тип данных',
    `required` CHAR(1) DEFAULT 'N' COMMENT 'Обязательное полу N - нет, Y - да',
    `multiple` CHAR(1) DEFAULT 'N' COMMENT 'Является составным  N - нет, Y - да',
    `filterable` CHAR(1) DEFAULT 'N' COMMENT 'Участвует поле в фильтре N - нет, Y - да',
    `searchable` CHAR(1) DEFAULT 'N' COMMENT 'Участвует поле в поиске N - нет, Y - да',
    `editable` CHAR(1) DEFAULT 'N' COMMENT 'Разрешено ли поле редактировать пользователю N - нет, Y - да',
    `settings` TEXT NOT NULL 'N' COMMENT 'Дополительные настройки поля. Хранятся в сериализованном виде',
    PRIMARY KEY (`id`, `entity_id`),
    FOREIGN KEY (`entity_id`) REFERENCES `entity` (`id`) ON DELETE CASCADE ON UPDATE CASCADE 
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- Дамп структуры базы данных seons_crm.seons_country_code
CREATE TABLE IF NOT EXISTS `seons_country_code` (
    `id` TINYINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Саморазвивающийся идентификатор',
    `name` VARCHAR (255) NOT NULL DEFAULT ''COMMENT 'Название страны',
    `alpha_2` CHAR(2) NOT NULL DEFAULT '' COMMENT 'Сокращенное название страны из двух заглавных букв',
    `alpha_3` CHAR(3) NOT NULL DEFAULT '' COMMENT 'Сокращенное название страны из трех заглавных букв',
    `iso` CHAR(3) NOT NULL DEFAULT '' COMMENT 'Цифровой ISO 3166-1',
    `part_world` VARCHAR(255) NOT NULL DEFAULT '' COMMENT 'Часть света',
    PRIMARY KEY (`id`),
    UNIQUE (`alpha_2`),
    UNIQUE (`alpha_3`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- DROP TABLE `country_code`;
-- TRUNCATE TABLE `country_code`;

-- Дамп данных таблицы seons_crm.seons_country_code:
INSERT INTO `seons_country_code` (`id`, `name`, `alpha_2`, `alpha_3`, `iso`, `part_world`) VALUES
    ('1','Abkhazia','AB','ABH','895','Asia'),
    ('2','Australia','AU','AUS','036','Oceania'),
    ('3','Austria','AT','AUT','040','Europe'),
    ('4','Azerbaijan','AZ','AZE','031','Asia'),
    ('5','Albania','AL','ALB','008','Europe'),
    ('6','Algeria','DZ','DZA','012','Africa'),
    ('7','American Samoa','AS','ASM','016','Oceania'),
    ('8','Anguilla','AI','AIA','660','America'),
    ('9','Angola','AO','AGO','024','Africa'),
    ('10','Andorra','AD','AND','020','Europe'),
    ('11','Antarctica','AQ','ATA','010','Antarctic'),
    ('12','Antigua and Barbuda','AG','ATG','028','America'),
    ('13','Argentina','AR','ARG','032','America'),
    ('14','Armenia','AM','ARM','051','Asia'),
    ('15','Aruba','AW','ABW','533','America'),
    ('16','Afghanistan','AF','AFG','004','Asia'),
    ('17','Bahamas','BS','BHS','044','America'),
    ('18','Bangladesh','BD','BGD','050','Asia'),
    ('19','Barbados','BB','BRB','052','America'),
    ('20','Bahrain','BH','BHR','048','Asia'),
    ('21','Belarus','BY','BLR','112','Europe'),
    ('22','Belize','BZ','BLZ','084','America'),
    ('23','Belgium','BE','BEL','056','Europe'),
    ('24','Benin','BJ','BEN','204','Africa'),
    ('25','Bermuda','BM','BMU','060','America'),
    ('26','Bulgaria','BG','BGR','100','Europe'),
    ('27','Bolivia, plurinational state of','BO','BOL','068','America'),
    ('28','Bonaire, Sint Eustatius and Saba','BQ','BES','535','America'),
    ('29','Bosnia and Herzegovina','BA','BIH','070','Europe'),
    ('30','Botswana','BW','BWA','072','Africa'),
    ('31','Brazil','BR','BRA','076','America'),
    ('32','British Indian Ocean Territory','IO','IOT','086','Oceania'),
    ('33','Brunei Darussalam','BN','BRN','096','Asia'),
    ('34','Burkina Faso','BF','BFA','854','Africa'),
    ('35','Burundi','BI','BDI','108','Africa'),
    ('36','Bhutan','BT','BTN','064','Asia'),
    ('37','Vanuatu','VU','VUT','548','Oceania'),
    ('38','Hungary','HU','HUN','348','Europe'),
    ('39','Venezuela','VE','VEN','862','America'),
    ('40','Virgin Islands, British','VG','VGB','092','America'),
    ('41','Virgin Islands, U.S.','VI','VIR','850','America'),
    ('42','Vietnam','VN','VNM','704','Asia'),
    ('43','Gabon','GA','GAB','266','Africa'),
    ('44','Haiti','HT','HTI','332','America'),
    ('45','Guyana','GY','GUY','328','America'),
    ('46','Gambia','GM','GMB','270','Africa'),
    ('47','Ghana','GH','GHA','288','Africa'),
    ('48','Guadeloupe','GP','GLP','312','America'),
    ('49','Guatemala','GT','GTM','320','America'),
    ('50','Guinea','GN','GIN','324','Africa'),
    ('51','Guinea-Bissau','GW','GNB','624','Africa'),
    ('52','Germany','DE','DEU','276','Europe'),
    ('53','Guernsey','GG','GGY','831','Europe'),
    ('54','Gibraltar','GI','GIB','292','Europe'),
    ('55','Honduras','HN','HND','340','America'),
    ('56','Hong Kong','HK','HKG','344','Asia'),
    ('57','Grenada','GD','GRD','308','America'),
    ('58','Greenland','GL','GRL','304','America'),
    ('59','Greece','GR','GRC','300','Europe'),
    ('60','Georgia','GE','GEO','268','Asia'),
    ('61','Guam','GU','GUM','316','Oceania'),
    ('62','Denmark','DK','DNK','208','Europe'),
    ('63','Jersey','JE','JEY','832','Europe'),
    ('64','Djibouti','DJ','DJI','262','Africa'),
    ('65','Dominica','DM','DMA','212','America'),
    ('66','Dominican Republic','DO','DOM','214','America'),
    ('67','Egypt','EG','EGY','818','Africa'),
    ('68','Zambia','ZM','ZMB','894','Africa'),
    ('69','Western Sahara','EH','ESH','732','Africa'),
    ('70','Zimbabwe','ZW','ZWE','716','Africa'),
    ('71','Israel','IL','ISR','376','Asia'),
    ('72','India','IN','IND','356','Asia'),
    ('73','Indonesia','ID','IDN','360','Asia'),
    ('74','Jordan','JO','JOR','400','Asia'),
    ('75','Iraq','IQ','IRQ','368','Asia'),
    ('76','Iran, Islamic Republic of','IR','IRN','364','Asia'),
    ('77','Ireland','IE','IRL','372','Europe'),
    ('78','Iceland','IS','ISL','352','Europe'),
    ('79','Spain','ES','ESP','724','Europe'),
    ('80','Italy','IT','ITA','380','Europe'),
    ('81','Yemen','YE','YEM','887','Asia'),
    ('82','Cape Verde','CV','CPV','132','Africa'),
    ('83','Kazakhstan','KZ','KAZ','398','Asia'),
    ('84','Cambodia','KH','KHM','116','Asia'),
    ('85','Cameroon','CM','CMR','120','Africa'),
    ('86','Canada','CA','CAN','124','America'),
    ('87','Qatar','QA','QAT','634','Asia'),
    ('88','Kenya','KE','KEN','404','Africa'),
    ('89','Cyprus','CY','CYP','196','Asia'),
    ('90','Kyrgyzstan','KG','KGZ','417','Asia'),
    ('91','Kiribati','KI','KIR','296','Oceania'),
    ('92','China','CN','CHN','156','Asia'),
    ('93','Cocos (Keeling) Islands','CC','CCK','166','Oceania'),
    ('94','Colombia','CO','COL','170','America'),
    ('95','Comoros','KM','COM','174','Africa'),
    ('96','Congo','CG','COG','178','Africa'),
    ('97','Congo\, Democratic Republic of the','CD','COD','180','Africa'),
    ('98',"Korea, Democratic People\'s republic of",'KP','PRK','408','Asia'),
    ('99',"Korea, Republic of",'KR','KOR','410','Asia'),
    ('100','Costa Rica','CR','CRI','188','America'),
    ('101',"Cote d\'Ivoire",'CI','CIV','384','Africa'),
    ('102','Cuba','CU','CUB','192','America'),
    ('103','Kuwait','KW','KWT','414','Asia'),
    ('104','Curaçao','CW','CUW','531','America'),
    ('105',"Lao People\'s Democratic Republic",'LA','LAO','418','Asia'),
    ('106','Latvia','LV','LVA','428','Europe'),
    ('107','Lesotho','LS','LSO','426','Africa'),
    ('108','Lebanon','LB','LBN','422','Asia'),
    ('109','Libyan Arab Jamahiriya','LY','LBY','434','Africa'),
    ('110','Liberia','LR','LBR','430','Africa'),
    ('111','Liechtenstein','LI','LIE','438','Europe'),
    ('112','Lithuania','LT','LTU','440','Europe'),
    ('113','Luxembourg','LU','LUX','442','Europe'),
    ('114','Mauritius','MU','MUS','480','Africa'),
    ('115','Mauritania','MR','MRT','478','Africa'),
    ('116','Madagascar','MG','MDG','450','Africa'),
    ('117','Mayotte','YT','MYT','175','Africa'),
    ('118','Macao','MO','MAC','446','Asia'),
    ('119','Malawi','MW','MWI','454','Africa'),
    ('120','Malaysia','MY','MYS','458','Asia'),
    ('121','Mali','ML','MLI','466','Africa'),
    ('122','United States Minor Outlying Islands','UM','UMI','581','Oceania'),
    ('123','Maldives','MV','MDV','462','Asia'),
    ('124','Malta','MT','MLT','470','Europe'),
    ('125','Morocco','MA','MAR','504','Africa'),
    ('126','Martinique','MQ','MTQ','474','America'),
    ('127','Marshall Islands','MH','MHL','584','Oceania'),
    ('128','Mexico','MX','MEX','484','America'),
    ('129','Micronesia, Federated States of','FM','FSM','583','Oceania'),
    ('130','Mozambique','MZ','MOZ','508','Africa'),
    ('131','Moldova','MD','MDA','498','Europe'),
    ('132','Monaco','MC','MCO','492','Europe'),
    ('133','Mongolia','MN','MNG','496','Asia'),
    ('134','Montserrat','MS','MSR','500','America'),
    ('135','Myanmar','MM','MMR','104','Asia'),
    ('136','Namibia','NA','NAM','516','Africa'),
    ('137','Nauru','NR','NRU','520','Oceania'),
    ('138','Nepal','NP','NPL','524','Asia'),
    ('139','Niger','NE','NER','562','Africa'),
    ('140','Nigeria','NG','NGA','566','Africa'),
    ('141','Netherlands','NL','NLD','528','Europe'),
    ('142','Nicaragua','NI','NIC','558','America'),
    ('143','Niue','NU','NIU','570','Oceania'),
    ('144','New Zealand','NZ','NZL','554','Oceania'),
    ('145','New Caledonia','NC','NCL','540','Oceania'),
    ('146','Norway','NO','NOR','578','Europe'),
    ('147','United Arab Emirates','AE','ARE','784','Asia'),
    ('148','Oman','OM','OMN','512','Asia'),
    ('149','Bouvet Island','BV','BVT','074',' '),
    ('150','Isle of Man','IM','IMN','833','Europe'),
    ('151','Norfolk Island','NF','NFK','574','Oceania'),
    ('152','Christmas Island','CX','CXR','162','Asia'),
    ('153','Heard Island and McDonald Islands','HM','HMD','334',' '),
    ('154','Cayman Islands','KY','CYM','136','America'),
    ('155','Cook Islands','CK','COK','184','Oceania'),
    ('156','Turks and Caicos Islands','TC','TCA','796','America'),
    ('157','Pakistan','PK','PAK','586','Asia'),
    ('158','Palau','PW','PLW','585','Oceania'),
    ('159','Palestinian Territory, Occupied','PS','PSE','275','Asia'),
    ('160','Panama','PA','PAN','591','America'),
    ('161','Holy See (Vatican City State)','VA','VAT','336','Europe'),
    ('162','Papua New Guinea','PG','PNG','598','Oceania'),
    ('163','Paraguay','PY','PRY','600','America'),
    ('164','Peru','PE','PER','604','America'),
    ('165','Pitcairn','PN','PCN','612','Oceania'),
    ('166','Poland','PL','POL','616','Europe'),
    ('167','Portugal','PT','PRT','620','Europe'),
    ('168','Puerto Rico','PR','PRI','630','America'),
    ('169','Macedonia, The Former Yugoslav Republic Of','MK','MKD','807','Europe'),
    ('170','Reunion','RE','REU','638','Africa'),
    ('171','Russian Federation','RU','RUS','643','Europe'),
    ('172','Rwanda','RW','RWA','646','Africa'),
    ('173','Romania','RO','ROU','642','Europe'),
    ('174','Samoa','WS','WSM','882','Oceania'),
    ('175','San Marino','SM','SMR','674','Europe'),
    ('176','Sao Tome and Principe','ST','STP','678','Africa'),
    ('177','Saudi Arabia','SA','SAU','682','Asia'),
    ('178','Saint Helena, Ascension And Tristan Da Cunha','SH','SHN','654','Africa'),
    ('179','Northern Mariana Islands','MP','MNP','580','Oceania'),
    ('180','Saint Barthélemy','BL','BLM','652','America'),
    ('181','Saint Martin (French Part)','MF','MAF','663','America'),
    ('182','Senegal','SN','SEN','686','Africa'),
    ('183','Saint Vincent and the Grenadines','VC','VCT','670','America'),
    ('184','Saint Lucia','LC','LCA','662','America'),
    ('185','Saint Kitts and Nevis','KN','KNA','659','America'),
    ('186','Saint Pierre and Miquelon','PM','SPM','666','America'),
    ('187','Serbia','RS','SRB','688','Europe'),
    ('188','Seychelles','SC','SYC','690','Africa'),
    ('189','Singapore','SG','SGP','702','Asia'),
    ('190','Sint Maarten','SX','SXM','534','America'),
    ('191','Syrian Arab Republic','SY','SYR','760','Asia'),
    ('192','Slovakia','SK','SVK','703','Europe'),
    ('193','Slovenia','SI','SVN','705','Europe'),
    ('194','United Kingdom','GB','GBR','826','Europe'),
    ('195','United States','US','USA','840','America'),
    ('196','Solomon Islands','SB','SLB','090','Oceania'),
    ('197','Somalia','SO','SOM','706','Africa'),
    ('198','Sudan','SD','SDN','729','Africa'),
    ('199','Suriname','SR','SUR','740','America'),
    ('200','Sierra Leone','SL','SLE','694','Africa'),
    ('201','Tajikistan','TJ','TJK','762','Asia'),
    ('202','Thailand','TH','THA','764','Asia'),
    ('203','Taiwan, Province of China','TW','TWN','158','Asia'),
    ('204','Tanzania, United Republic Of','TZ','TZA','834','Africa'),
    ('205','Timor-Leste','TL','TLS','626','Asia'),
    ('206','Togo','TG','TGO','768','Africa'),
    ('207','Tokelau','TK','TKL','772','Oceania'),
    ('208','Tonga','TO','TON','776','Oceania'),
    ('209','Trinidad and Tobago','TT','TTO','780','America'),
    ('210','Tuvalu','TV','TUV','798','Oceania'),
    ('211','Tunisia','TN','TUN','788','Africa'),
    ('212','Turkmenistan','TM','TKM','795','Asia'),
    ('213','Turkey','TR','TUR','792','Asia'),
    ('214','Uganda','UG','UGA','800','Africa'),
    ('215','Uzbekistan','UZ','UZB','860','Asia'),
    ('216','Ukraine','UA','UKR','804','Europe'),
    ('217','Wallis and Futuna','WF','WLF','876','Oceania'),
    ('218','Uruguay','UY','URY','858','America'),
    ('219','Faroe Islands','FO','FRO','234','Europe'),
    ('220','Fiji','FJ','FJI','242','Oceania'),
    ('221','Philippines','PH','PHL','608','Asia'),
    ('222','Finland','FI','FIN','246','Europe'),
    ('223','Falkland Islands (Malvinas)','FK','FLK','238','America'),
    ('224','France','FR','FRA','250','Europe'),
    ('225','French Guiana','GF','GUF','254','America'),
    ('226','French Polynesia','PF','PYF','258','Oceania'),
    ('227','French Southern Territories','TF','ATF','260',' '),
    ('228','Croatia','HR','HRV','191','Europe'),
    ('229','Central African Republic','CF','CAF','140','Africa'),
    ('230','Chad','TD','TCD','148','Africa'),
    ('231','Montenegro','ME','MNE','499','Europe'),
    ('232','Czech Republic','CZ','CZE','203','Europe'),
    ('233','Chile','CL','CHL','152','America'),
    ('234','Switzerland','CH','CHE','756','Europe'),
    ('235','Sweden','SE','SWE','752','Europe'),
    ('236','Svalbard and Jan Mayen','SJ','SJM','744','Europe'),
    ('237','Sri Lanka','LK','LKA','144','Asia'),
    ('238','Ecuador','EC','ECU','218','America'),
    ('239','Equatorial Guinea','GQ','GNQ','226','Africa'),
    ('240','Åland Islands','AX','ALA','248','Europe'),
    ('241','El Salvador','SV','SLV','222','America'),
    ('242','Eritrea','ER','ERI','232','Africa'),
    ('243','Eswatini','SZ','SWZ','748','Africa'),
    ('244','Estonia','EE','EST','233','Europe'),
    ('245','Ethiopia','ET','ETH','231','Africa'),
    ('246','South Africa','ZA','ZAF','710','Africa'),
    ('247','South Georgia and the South Sandwich Islands','GS','SGS','239',' '),
    ('248','South Ossetia','OS','OST','896','Asia'),
    ('249','South Sudan','SS','SSD','728','Africa'),
    ('250','Jamaica','JM','JAM','388','America'),
    ('251','Japan','JP','JPN','392','Asia');


-- Слой Tracker

-- Дамп структуры базы данных seons_crm.seons_clickinfo
CREATE TABLE IF NOT EXISTS `seons_trackers`(
    `id` SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Саморазвивающийся идентификатор.',
    `domain` VARCHAR(255) NOT NULL DEFAULT '' COMMENT 'Основной домен трекера.',
    `web_file` VARCHAR(255) NOT NULL DEFAULT '' COMMENT 'Основной файл трекера [0-9a-z]\.php',
    `auth_key` VARCHAR(255) NOT NULL DEFAULT '' COMMENT 'Ключ авторизации, для взаимодействие с трекером через cookie',
    `api_file` VARCHAR(255) NOT NULL DEFAULT `arm.php` COMMENT 'Основной файл для работы с API трекера',
    `api_key` VARCHAR(255) NOT NULL COMMENT 'API ключ берется из настроик трекера',
    PRIMARY KEY (`id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- Дамп структуры базы данных seons_crm.seons_clickinfo
CREATE TABLE IF NOT EXISTS `seons_clickinfo`(
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `tracker_id` SMALLINT UNSIGNED NOT NULL DEFAULT 0,
    `clickid` VARCHAR(255) NOT NULL DEFAULT '',
    `timeclick` TIMESTAMP NOT NULL DEFAULT '0',
    'offer_name' VARCHAR(255) NOT NULL DEFAULT '',
    'cpc' VARCHAR(255) NOT NULL DEFAULT '0',
    'lp_click' TINYINT(1) NOT NULL DEFAULT '0',
    'bidhash' VARCHAR(255) NOT NULL DEFAULT '',
    'unique' TINYINT(1) NOT NULL DEFAULT '0',
    'conversion' TINYINT(1) NOT NULL DEFAULT '0',
    'payout' VARCHAR(50) NOT NULL DEFAULT '0',
    `conversion_time` DATETIME DEFAULT '',
    `conversion_status` VARCHAR(50) NOT NULL DEFAULT 'false',
    `conversion_status_2` VARCHAR(50) NOT NULL DEFAULT 'false',
    `rotation_id` VARCHAR(255) NOT NULL DEFAULT 'false',
    `rotation_name` VARCHAR(45) NOT NULL DEFAULT 'false',
    `campaign_id` VARCHAR(255) NOT NULL DEFAULT '',
    `campaign_name` VARCHAR(255) NOT NULL DEFAULT '',
    `path_id` VARCHAR(255) NOT NULL DEFAULT '',
    `path_name` VARCHAR(255) NOT NULL DEFAULT '',
    `rule_id` VARCHAR(255) NOT NULL DEFAULT 'false',
    `rule_name` VARCHAR(255) NOT NULL DEFAULT 'false',
    `aff_network_id` VARCHAR(255) NOT NULL DEFAULT 'false',
    `aff_network_name` VARCHAR(255) NOT NULL DEFAULT 'false',
    `offer_type` VARCHAR(255) NOT NULL DEFAULT '',
    `offer_id` VARCHAR(255) NOT NULL DEFAULT '',
    `offer_name` VARCHAR(255) NOT NULL DEFAULT '',
    `landing_id` VARCHAR(255) NOT NULL DEFAULT '',
    `landing_name` VARCHAR(255) NOT NULL DEFAULT '',
    `traffic_source_id` VARCHAR(255) NOT NULL DEFAULT '',
    `traffic_source_name` VARCHAR(255) NOT NULL DEFAULT '',
    `ipv` TINYINT(1) NOT NULL DEFAULT 4,
    `ip` VARCHAR(255) NOT NULL DEFAULT '',
    `country_code` CHAR(2) NOT NULL DEFAULT '',
    `city_name` VARCHAR(255) NOT NULL DEFAULT '',
    `isp_name` VARCHAR(255) NOT NULL DEFAULT '',
    `connection_type` VARCHAR(255) NOT NULL DEFAULT '',   
    `user_agent` TEXT,   
    `browser` VARCHAR(255) NOT NULL DEFAULT '',
    `browser_version` VARCHAR(255) NOT NULL DEFAULT '',
    `device_brand` VARCHAR(255) NOT NULL DEFAULT '',
    `device_model` VARCHAR(255) NOT NULL DEFAULT '',
    `device_name` VARCHAR(255) NOT NULL DEFAULT '',
    `display_size` VARCHAR(255) NOT NULL DEFAULT 'Unknow',
    `display_resolution` VARCHAR(255) NOT NULL DEFAULT 'Unknow',
    `device_pointing_method` VARCHAR(255) NOT NULL DEFAULT '',
    `os_name` VARCHAR(255) NOT NULL DEFAULT '',
    `os_version` VARCHAR(255) NOT NULL DEFAULT '',
    `referer_url` TEXT,   
    `referer_domain` VARCHAR(255) NOT NULL DEFAULT '',
    `language` VARCHAR(30) NOT NULL DEFAULT '',
    PRIMARY KEY(`id`) USING BTREE
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

