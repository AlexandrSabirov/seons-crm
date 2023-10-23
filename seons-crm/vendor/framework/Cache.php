<?php

namespace framework;

/**
 * Класс Cache взаимодействует с кешем приложение
 */
class Cache 
{
    use traits\TSingleton;

    /**
     * Метод записи в кеш
     * 
     * @param string    $key - Имя переменной кеша
     * @param mixed     $data - Данные передаваемы в кеш
     * @param int       $second - Время жизни кеша
     * @return bool
     */
    public function set(string $key, $data, int $seconds = 3600): bool
    {
        $content['data'] = $data;
        $content['end_time'] = time() + $seconds;

        if (file_put_contents(CACHE . '/' . md5($key) . '.txt', serialize($content))){
            return true;
        }else{
            return false;
        }
    }

    /**
     * Метод получения данных из кеша
     * 
     * @param string    $key - Имя переменной кеша
     */
    public function get($key)
    {
        $file = CACHE . '/' . md5($key) . '.txt';

        if (file_exists($file)){
            $content = unserialize(file_get_contents($file));
            if (time() <= $content['end_time']){
                return $content['data'];
            }
            unlink($file);
        }
        return false;
    }

    /**
     * Метод удаления переменную кеша
     * 
     * @param string    $key - Имя переменной кеша
     * @return bool
     */
    public function delete($key): bool
    {
        $file = CACHE . '/' . md5($key) . '.txt';
        if (file_exists($file)){
            unlink($file);
            return true;
        }
        return false;
    }

    /**
     * Метод проверки существования переменной кеша
     * 
     * @param string    $key - Имя переменной кеша
     * @return bool
     */
    public function has($key): bool
    {   
        $file = CACHE . '/' . md5($key) . '.txt';

        if (file_exists($file)){
            return true;
        }
        return false;
    }

    /**
     * Метод удаляет все переменные кеша
     * 
     * @return bool
     */
    public function clear(): bool
    {
        $files = scandir(CACHE);
        foreach ($files as $file){
            if ($file != '.' && $file != '..'){
                $file = CACHE . '/' . $file;
                if (is_dir($file)){
                    rmdir($file);
                }else{
                    unlink($file);
                }
            }
        }
        return true;
    }
}

?>