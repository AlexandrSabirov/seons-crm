<?php

namespace framework;
use RedBeanPHP\R;
use Exception;

/**
 * Класс инициализации подключения к DB
 */
class DB{
    use traits\TSingleton;

    private function __construct()
    {
        
        $db = require_once CONFIG . "/config_db.php"; // Подграем данные из файла для подключения к DB

        R::setup($db['dsn'], $db['user'], $db['password']); //Устанавливаем данные для подключения к DB с помощью компонента ReadBean

        /**
         * xdispence следует использовать если в название таблиц используется _ https://redbeanphp.com/index.php?p=/prefixes
         */
        R::ext('xdispence', function($type){
            return R::getRedBean()->dispense($type);
        });

        //Делаем тестовое подключение 
        if (!R::testConnection()){
            throw new Exception('No connection to DB',500);
        }
       
        R::freeze(true); // Замораживаем состояние таблиц https://redbeanphp.com/manual3_0/index.php?p=/manual3_0/freeze

        // Отключаем отображение ошибок если стоит режим production
        if (DEBUG){
            R::debug(true, 3);
        }
   
    }
}
?>