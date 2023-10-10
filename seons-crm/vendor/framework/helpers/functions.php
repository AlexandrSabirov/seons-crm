<?php

if (!function_exists('debug')){
    /**
     * Выводит результат удобочитаемом виде
     * @param mixed $data //Данные для вывода
     * @param bool  $die  //Приостоновить дальнейшие выполненеи скрипта 
     */
    function debug($data, $die = false){

        echo "<pre>" . print_r($data, 1) . "</pre>";
        if ($die){
            die;
        }
    }
}


if (!function_exists('h')){
    /**
     * Перезавписываем стандартную php функцию htmlspecialchars()
     * @param mixed $str //Данные для вывода
     */
    function h($str){
        return htmlspecialchars($str);
    }
}
?>
