<?php

define("DEBUG", 1); //1 - in Development; 0 - in Production
define("ROOT", dirname(__DIR__));
define("CRM", ROOT . "/seons-crm");
define("APP", ROOT . "/app");
define("CONFIG", ROOT . '/config');
define("CORE", ROOT . "/vendor/framework");
define("WWW", ROOT . "/public");
define("LOGS", ROOT . "/tmp/logs");
define("CACHE", ROOT . "/tmp/cache");
define("HELPERS", ROOT . "/vendor/framework/helpers");
define("NO_IMAGE", WWW . "/uploads/no_image.png");
define("PATH", "http://seons-crm.com:8080");
define("ADMIN", PATH . "/admin");
define("LAYOUT", "crm");


require_once ROOT . '/vendor/autoload.php';
?>