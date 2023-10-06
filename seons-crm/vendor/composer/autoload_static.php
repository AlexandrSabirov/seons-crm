<?php

// autoload_static.php @generated by Composer

namespace Composer\Autoload;

class ComposerStaticInit27148e92f60cf8be98c5931b827e9c9d
{
    public static $prefixLengthsPsr4 = array (
        'c' => 
        array (
            'framework\\' => 5,
        ),
        'a' => 
        array (
            'app\\' => 4,
        ),
        'V' => 
        array (
            'Valitron\\' => 9,
        ),
        'R' => 
        array (
            'RedBeanPHP\\' => 11,
        ),
    );

    public static $prefixDirsPsr4 = array (
        'framework\\' => 
        array (
            0 => __DIR__ . '/..' . '/framework',
        ),
        'app\\' => 
        array (
            0 => __DIR__ . '/../..' . '/app',
        ),
        'Valitron\\' => 
        array (
            0 => __DIR__ . '/..' . '/vlucas/valitron/src/Valitron',
        ),
        'RedBeanPHP\\' => 
        array (
            0 => __DIR__ . '/..' . '/gabordemooij/redbean/RedBeanPHP',
        ),
    );

    public static $classMap = array (
        'Composer\\InstalledVersions' => __DIR__ . '/..' . '/composer/InstalledVersions.php',
    );

    public static function getInitializer(ClassLoader $loader)
    {
        return \Closure::bind(function () use ($loader) {
            $loader->prefixLengthsPsr4 = ComposerStaticInit27148e92f60cf8be98c5931b827e9c9d::$prefixLengthsPsr4;
            $loader->prefixDirsPsr4 = ComposerStaticInit27148e92f60cf8be98c5931b827e9c9d::$prefixDirsPsr4;
            $loader->classMap = ComposerStaticInit27148e92f60cf8be98c5931b827e9c9d::$classMap;

        }, null, ClassLoader::class);
    }
}
