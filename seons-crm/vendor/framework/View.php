<?php

namespace framework;
use Exception;
/**
 * Класс отображение вида 
 */
class View
{
    /**
     * Основной контент страницы
     * @var string $content;
     */
    public string $content = '';
    public function __construct(
        public $route, 
        public $layout = '', 
        public $view = '',
        public $meta = [])
    {

        if (false !== $this->layout){
            $this->layout = $this->layout ?: LAYOUT;
        }
    }

    /**
     * Метод для подключение конкретного вида и его вырисовки в шаблоне
     * @param mixed $data
     */
    public function render($data)
    {
        if(is_array($data)){
            extract($data);
        }
        $prefix = str_replace("\\", '/', $this->route['admin_prefix']);
        $view_file =  APP . "/views/{$prefix}{$this->route['controller']}/{$this->view}.php";
        if (is_file($view_file)){
            ob_start();
            require_once $view_file;
            $this->content = ob_end_clean();

        }else{
            throw new Exception('Файл вида не найден:' . $view_file, 500);
        }

        if (false !== $this->layout){
            $layout_file =  APP . "/views/layout/{$this->layout}.php";
            if (is_file($layout_file)){
                require_once $layout_file;
            }else{
                throw new Exception('Шаблон не найден:' . $this->layout, 500);
            }
        }
    }

    /**
     * Метод получения мета-тегов
     * @return string
     */
    public function getMeta()
    {
        $out = '<title>' . App::$app->getProperty('site_name') .'::' . h($this->meta['title']) . '</title>' . PHP_EOL;
        $out .= '<meta name="Description" content="' . h($this->meta['description']) . '">' . PHP_EOL;
        $out .= '<meta name="Keywords" content="' . h($this->meta['keywords']) . '">' . PHP_EOL;
        return $out;
    } 

    /**
     * Метод получения определенной части 
     * верстки сайта и передачи данных в эту часть
     * @param string $file
     * @param mixed $data
     */
    public function getPart(string $file, $data = null)
    {
        if(is_array($data)){
            extract($data);
        }
        $file = APP . "/views/{$file}.php";
        if (is_file($file)){
            require($file);
        }else{
            echo "File {$file} not found...";
        }
    }


}

?>