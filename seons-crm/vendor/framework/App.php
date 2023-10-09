<?php

namespace framework;

/**
 * Класс App инициализирует приложение
 */
class App
{
    /**
     * @var object $app;
     */
    public static $app;
    public function __construct()
    {
        //Убираем лишние слеши из строки запроса и декодируем 
        $query = trim(urldecode($_SERVER['QUERY_STRING']), '/');
        //Инициализуем объект для обработки ошибок
        new ErrorHandler();
        //Инициализируем объект посредством Singleton
        self::$app = Registry::getInstance();
        $this->getParams();
        //Проверяем есть такой путь
        Route::dispatch($query);
    }

    /**
     * Метод подгрузки данных из файла в реестр
     */
    private function getParams(){
        $params = require_once CONFIG . "/params.php";
        if (!empty($params)){
            foreach ($params as $key => $param){
                self::$app->setProperty($key, $param);
            }
        }
    }
}

?>