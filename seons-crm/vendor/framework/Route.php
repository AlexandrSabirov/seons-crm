<?php

namespace framework;

use Exception;
/**
 * Класс Route позволяет добавлять новые пути 
 * и проверять наличия путей
 */
class Route
{
    /**
     * Все пути 
     * @var array $routes
     */
    protected static array $routes = [];

    /**
     * Даннае о текущем пути
     * @var array $route
     */
    protected static array $route = [];
    

    /**
     * Метод добавляет регулярное выражени, данные о пути
     * @param string $regexp
     * @param array $route
     */
    public static function add(string $regexp, array $route = [])
    {
        self::$routes[$regexp] = $route;
    }

     /**
     * Метод возвращает текущий путь
     * @return array
     */
    public static function getRoute():array 
    {
        return self::$route;
    }
    
    /**
     * Метод возвращает все пути
     * @return array
     */
    public static function getRoutes():array 
    {
        return self::$routes;
    }

    /**
     * Метод получает контроллер в урле и метод,
     * если они есть
     * @param string $url
     * @return array
     */
    public static function dispatch(string $url)
    {
        $url = self::removeOqueryString($url);

        if (self::matchRoute($url)){
            $controller = "app\\" . self::$route['admin_prefix'] . 'controllers\\' .  self::$route['controller'] . 'Controller';
            if (class_exists($controller)){

                $controllerObject = new $controller(self::$route);
                $controllerObject->getModel();
                $action = self::lowerCamelCase(self::$route['action'] . 'Action');
                
                if (method_exists($controllerObject, $action)){
                    $controllerObject->$action();
                    $controllerObject->getView();

                }else{
                    throw new Exception("Метод {$controller}::{$action} не найден!", 404);
                }
            }else{
                throw new Exception("Контроллер {$controller} не найден!", 404);
            }

        }else{
            throw new Exception('Страница не найдена!', 404);
        }
    }

    /**
     * Метод возращает часть url
     * @param string $url
     * @return string
     */   
    private static function removeOqueryString($url)
    {
        if($url){
            $params = explode('&', $url, 2);
            if(false === str_contains($params[0], '=')){
                return rtrim($params[0], '/');
            }
       }
       return ''; 
    }
    
    /**
     * Метод определяет есть ли данный путь в конфигурациях
     * @param string $url
     * @return bool
     */   
    private static function matchRoute(string $url): bool
    {
        foreach (self::$routes as $pattern => $route){
            
            if (preg_match("#{$pattern}#i", $url, $matches)){

                foreach ($matches as $key => $value){
                    if (is_string($key)){
                        $route[$key] = $value;
                    }
                }

                if (empty($route['action'])){
                    $route['action'] = 'index';
                }

                if (!isset($route['admin_prefix'])){
                    $route['admin_prefix'] = '';
                }else{
                    $route['admin_prefix'] .= '\\';
                }

                $route['controller'] = self::upperCamelCase($route['controller']);
                self::$route = $route;
                return true;
            }
        }
        return false;
    }

    /**
     * Метод убирает пробелы и знак -.
     * Возводит первые буквы слов в ферхний регистр
     * @param string $name
     */   
    private static function upperCamelCase(string $name)
    {
        return str_replace(' ', '', ucwords(str_replace('-', ' ', $name)));
    }

    /**
     * Метод изменяет первую букву слова в нижний регистр
     * @param string $name
     */   
    private static function lowerCamelCase(string $name)
    {
        return lcfirst(self::upperCamelCase($name));
    }
}

?>