<?php

// 1 - in Development; 0 - in Production
define("DEBUG", 1);
// Корень сайта
define("ROOT", dirname(__DIR__));
// Все модули и библиотеки связанные с crm
define("CRM", ROOT . "/seons-crm");
// Файлы приложения controller, models, views, languages и т.д.
define("APP", ROOT . "/app");
// Основные файлы конфигурации
define("CONFIG", ROOT . '/config');
// Фреймворк приложения
define("CORE", ROOT . "/vendor/framework");
// Файлы frontend части
define("WWW", ROOT . "/public");
// Файлы логов
define("LOGS", ROOT . "/tmp/logs");
// Файлы кеша
define("CACHE", ROOT . "/tmp/cache");
// Функции помощники
define("HELPERS", ROOT . "/vendor/framework/helpers");
// Подставляется если картинка отсутствует
define("NO_IMAGE", WWW . "/uploads/no_image.png");
// Полный путь к сайту
define("PATH", "http://seons-crm.com:8080");
// Полный путь к админской части сайту
define("ADMIN", PATH . "/admin");
// Шаблон по умолчанию
define("LAYOUT", "crm");

//Загружаем базовые файлы
require_once ROOT . '/vendor/autoload.php';
?>