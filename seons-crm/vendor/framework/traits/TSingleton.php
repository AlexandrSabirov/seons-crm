<?php

namespace framework\traits;
/** 
 * Трейт Singleton
 */
trait TSingleton
{
    /**
     * Содержит текущий экземляр объекта
     * @var self | null
     */
    private static ?self $instance = null; 

    /**
     * Запрещаем создавать экземляр объекта через тип класса Singleton
     */
    private function __construct(){}

    /**
     * Публичный статичный метод для создания нового единственного объекта, 
     * или возращения существуюещего экземляра объекта
     */
    public static function getInstance(): static
    {
        return static::$instance ?? static::$instance = new static();
    }

    /**
     * Предотвращение клонирование Singleton, чтобы нельзя 
     * было создать второй экземляр
     */
    public function __clone()
    {
        throw new \LogicException("Этот Singleton не может быть клонирвоан");
    }

    /**
     * Предотвращение сериализации Singleton, чтобы нельзя 
     * было создать второй экземляр
     */
    public function __wakeup()
    {
        throw new \LogicException("Этот Singleton не может быть сериализован");
    }

    /**
     * Уничтожает экземляр
     */
    public static function destroy(): void
    {
        self::$instance = null;
    }
}



?>