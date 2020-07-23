<?php
/**
 *
 */

$server = new Swoole\Server('0.0.0.0', 9508);

$server->set([
    'worker_num'            => 1, //设置进程
    'open_length_check'     => 1,
    'package_length_type'   => 'N',//设置包头的长度
    'package_length_offset' => 0,  //包长度从哪里开始计算
    'package_body_offset'   => 4,  //包体从第几个字节开始计算
]);

$server->on('receive', function (swoole_server $server, int $fd, int $reactor_id, string $data) {
    //遵循规则,就可以调用到服务
    $info = unpack('N', $data);
    //$data = substr($data, -$info[1]);
    $data = substr($data,4);

    $data = json_decode($data, true); //调用
    $serviceName = $data['serviceName'];
    $method      = $data['method'];
    var_dump($serviceName, $method);

    //加载文件返回数据(作业)
    $obj = new $serviceName();
    $response = $obj->$method();
    //客户端返回数据
    $server->send($fd,$response);
});

//自动加载Server/Service的文件
spl_autoload_register(function ($class) {
    include __DIR__ . '/service/' . $class . '.php';
});
$server->start();