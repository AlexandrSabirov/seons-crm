<?php

namespace framework;

/** 
 * Класс Registry для добавления и извлечения свойств из реестра
 */
class Registry{
    use Traits\TSingleton;

    /**
     * Свойства приложения
     * @var array;
     */
    protected static array $properties = [];

    /**
     * Метод установки значения в реестре
     * @param mixed $name
     * @param mixed $value
     */
    public static function setProperty($name, $value)
    {
        self::$properties[$name] = $value;
    }

    /**
     * Метод получения значения из реестре по имени
     * @param mixed $name
     * @return mixed
     */
    public static function getProperty($name)
    {
        return self::$properies[$name] ?? null;
    }   

    /**
     * Метод получения всех значени из рееста
     * @param mixed $name
     * @return array
     */
    public static function getProperties()
    {
        return self::$properties;
    }
}
?>