<?php

namespace framework\Traits;

trait TSingleton{
    private static ?self $instance=null; 

    private function construct(){}

    public static function getInstance(): static
    {
        return static::$instance ?? static::$instance = new static();
    }

    private function __clone()
    {
        throw new \LogicException("Этот Singleton не может быть клонирвоан");
    }

    private function __wakeup()
    {
        throw new \LogicException("Этот Singleton не может быть сериализован");
    }

    public static function destroy(): void
    {
        self::$instance = null;
    }
}



?>