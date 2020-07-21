<?php
/**
 * Created by PhpStorm.
 * User: guo
 * Date: 2019/5/20
 * Time: 11:53
 */

namespace Core;

use Annotation\Mapping\Bean;

/**
 * Class Route
 * @Bean("route")
 */
class Route
{
    protected static $Routes;

    /*
     * object=object
       action=index
     * prefix=test
     * path=abc
     */
    public static function addRoute($routePrefix, $routePath, $handler, $action)
    {
        self::$Routes[] = [
            'uri'     => $routePrefix.$routePath,
            'handler' => $handler,
            'action'  => $action
        ];
    }

    public static function dispatch($uri)
    {
        //var_dump($uri,self::$Routes);
        foreach (self::$Routes as $path) {
            if ($path['uri'] === $uri) {
                //调用控制器
                $action = $path['action'];
                $path['handler']->$action();
            }
        }
        return '';
    }

    public static function all()
    {
        return self::$Routes;
    }
}