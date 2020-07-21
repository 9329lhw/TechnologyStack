<?php
/**
 * Created by PhpStorm.
 * User: guo
 * Date: 2019/5/16
 * Time: 17:45
 */


$loader = require __DIR__ . "/vendor/autoload.php";

Core\Application::init();

$server=new  Swoole\Http\Server('0.0.0.0',9501);
//方法注解

$server->on('request',function ($request,$response){
    //Bean
    var_dump(Core\Bean::dispatch('route'));
    //Route
    var_dump(Core\Route::dispatch($request->server['path_info']));
});

$server->start();