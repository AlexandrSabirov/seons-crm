<?php

namespace framework;
use framework\DB;
abstract class Model {

    /**
     * Атрибуты
     * @param array $attributes
     * 
     */
    public array $attributes = [];

    /**
     * Ошибки
     * @param array $errors
     * 
     */
    public array $errors = [];

    /**
     * Правила
     * @param array $rules
     * 
     */
    public array $rules = [];

    /**
     * Метки
     * @param array $labels
     * 
     */
    public array $labels = [];
    public function __construct()
    {
        DB::getInstance();
    }
}

?>