<?php

namespace framework;

class App
{
    public static $app;
    public function __construct()
    {
        $query = trim(urldecode($_SERVER['QUERY_STRING']), '/');
        new ErrorHandler();
        self::$app = Registry::getInstance();
        $this->getParams();
        Route::dispatch($query);

    }

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