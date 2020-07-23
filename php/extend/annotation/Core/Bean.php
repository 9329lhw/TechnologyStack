<?php
/**
 * Created by PhpStorm.
 * User: guo
 * Date: 2019/5/20
 * Time: 14:01
 */

namespace Core;


class Bean
{
    protected static $Beans = [];

    /**
     * @param $beanName
     * @param $handler
     */
    public static function addBean($beanName,$handler)
    {
        self::$Beans[$beanName] =  $handler;
    }

    /**
     * @param $beanName
     * @return mixed|string
     */
    public static function dispatch($beanName)
    {
        return self::$Beans[$beanName]?self::$Beans[$beanName]:'';
    }

    public static function all()
    {
        return self::$Beans;
    }

}