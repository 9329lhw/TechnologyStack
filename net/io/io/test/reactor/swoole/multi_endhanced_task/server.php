<?php
// echo 1;
require __DIR__.'/../../../../vendor/autoload.php';
use ShineYork\Io\Reactor\Swoole\MulitEndhancedTask\Worker;

$host = "tcp://0.0.0.0:9000";
$server = new Worker($host);

$server->set([
  // 'watch_file' => true,
  'task_worker_num' => 3,
]);
// echo 1;
$server->onReceive = function(Worker $server, $client, $data){
    debug("向task发送数据 ");
    $server->task("hello worker task");
    send($client, "hello world client \n");
};
$server->onTask = function(Worker $server, $data){
      debug("接收到xxx的数据 ".$data);
};
// debug($host);
$server->start();



// require __DIR__.'/../../../../vendor/autoload.php';
//
// $host = "0.0.0.0"; // 0.0.0.0 代表接听所有
// $serv = new Swoole\Server($host, 9000);
// $serv->on('Receive', function ($serv, $fd, $from_id, $data) {
//     (new Index)->index();
//     $serv->send($fd, "Server: ".$data);
// });
// $serv->start();
