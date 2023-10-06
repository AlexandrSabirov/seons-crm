<?php

namespace framework;

class Registry{
    use Traits\TSingleton;

    protected static array $properties = [];
    public static function setProperty($name, $value)
    {
        self::$properties[$name] = $value;
    }

    public static function getProperty($name)
    {
        return self::$properies[$name] ?? null;
    }   

    public static function getProperties()
    {
        return self::$properties;
    }
}
?>