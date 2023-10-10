<?php

namespace framework;

/**
 * Абстрактный класс Controller
 */
abstract class Controller 
{
    /**
     * Данные для отображения в view
     * @var array $data
     */
    public array $data = [];

    /**
     * Мета теги для отображения в view
     * @var array $meta
     */
    public array $meta = ['title' => '', 'description' => '', 'keywords' => ''];

    /**
     * Шаблон
     * @var false | string $layout
     */
    public false | string $layout = ''; 

    /**
     * Вид
     * @var string $view
     */
    public string $view = '';

    /**
     * Модель
     * @var object $model
     */

    public object $model;

    /**
     * Конструктор будет использоваться при наследования
     * @param array $route
     */
    public function __construct(public array $route){}

    /**
     * Метод получения модели
     */
    public function getModel()
    {
        $model = 'app\model\\' . $this->route['admin_prefix'] . $this->route['controller'];
        if (class_exists($model)){
            $this->model = new $model();
        }
    }

    /**
     * Метод получения вида
     * @return mixed
     */
    public function getView()
    {
        $this->view = $this->view ?: $this->route['action'];
        (new View($this->route, $this->layout, $this->view, $this->meta))->render($this->data);
    }

    /**
     * Метод задает данные для вида
     * @param mixed $data
     */

    public function set($data)
    {   
        $this->data = $data;
    }

    /**
     * Метод задает данные для мета-тегов вида
     * @param string $title
     * @param string $description
     * @param string $keywords
     */
    public function setMeta($title = '', $description = '', $keywords = '')
    {
        $this->meta = [
            'title' => $title,
            'description' => $description,
            'keywords' => $keywords
        ];
    }

    /**
     * Метод проверяет был ли совершен AJAX запрос
     * @return bool
     */

    public function isAjax(): bool
    {
        return isset($_SERVER['HTTP_X_REQUESTED_WITH']) && $_SERVER['HTTP_X_REQUESTED_WITH'] === 'XMLHttpRequest';
    }

    /**
     * Метод для загрузки видов. Используется при AJAX запросах
     * @param string $view
     * @param mixed $vars
     * @return string
     */

    public function loadView(string $view, $vars = [])
    {
        extract($vars);
        $prefix = str_replace('\\', '/', $this->route['admin_prefix']);
        return APP . "/views{$prefix}{$this->route['controller']}/{$view}.php";
        die;
    }

    /**
     * Метод для отображения вида Error
     * @param string $folder
     * @param string $view
     * @param string $response
     */
    public function error_404($folder = 'Error', $view = '404', $response = 404)
    {
        http_response_code($response);
        //setMeta(__('tpl_error_404'));
        $this->route['controller'] = $folder;
        $this->view = $view;
    }
}

?>