<?php

namespace framework;

use Throwable;
/**
 * Class ErrorHandler обработка ошибок и исключений
 */
class ErrorHandler{

public function __construct()
{
    if (DEBUG){
        error_reporting(-1);
    }else{
        error_reporting(0);
    }
    set_error_handler([$this, 'errorHandler']);
    set_exception_handler([$this, 'errorException']);
    ob_start();
    register_shutdown_function([$this, 'fatalErrorHandler']);
}

/**
 * Метод для обработки ошибок
 * @param int $errno
 * @param string $errstr
 * @param string $errstr
 * @param int $errline
 */
public function errorHandler(int $errno, string $errstr, string $errfile, int $errline)
{
    $this->logError($errstr, $errfile, $errline);
    $this->displayError($errno, $errstr, $errfile, $errline);
}

/**
 * Метод для обработки искючений
 * @param Throwable $e
 */
public function errorException(Throwable $e)
{
    $this->logError($e->getMessage(), $e->getFile(), $e->getLine());
    $this->displayError($e->getCode(), $e->getMessage(), $e->getFile(), $e->getLine());
}

/**
 * Метод для обработки фатальных ошибок
 */
public function fatalErrorHandler()
{
    $error = error_get_last();
    if(!empty($error) && $error['type'] & (E_ERROR | E_PARSE | E_COMPILE_ERROR | E_CORE_ERROR)){
        $this->logError($error['message'], $error['file'], $error['line']);
        ob_end_clean();
        debug($error);
        $this->displayError($error['code'] ?? 0, $error['message'], $error['file'], $error['line']);
    }else{
        ob_end_flush();
    }

}

/**
 * Метод логирования всех ошибок и исключений в файл
 * @param string $message
 * @param string $file
 * @param string  $line
 */
private function logError(string $message = '', string $file = '', string $line = '')
{
    file_put_contents(
        LOGS . '/errors.log',
        "[" . date('Y:m:d - H:i:s'). "] Сообщение об ошибки: {$message} | Файл:{$file} | Линия:{$line}/n==============/n",
        FILE_APPEND
    );
}

/**
 * Метод вывода ошибок и исключений на экран
 * @param int $errno
 * @param string $errstr
 * @param string  $errfile
 * @param int $errlin
 * @param int $response
 */
private function displayError(int $errno, string $errstr, string $errfile, int $errline, int $response = 500)
{
    if($response == 0){
        $response = 404;
    }
    http_response_code($response);
    if($response == 404 && !DEBUG){
        require_once WWW . '/errors/404.php';
        die;
    }

    if(DEBUG){
        require_once WWW . '/errors/development.php';
    }else{
        require_once WWW . '/errors/production.php';
    }
    die;
}



}

?>