<?php
/**
 * 组装数据，发送给服务端
 * Class RpcClient
 */

class  RpcClient
{
    public $serviceName;

    public function __call($name, $arguments)
    {
        if ($name == "service") {
            $this->serviceName = $arguments[0]; //服务名称
            return $this;
        }
        //规定的标准
        $data = [
            'serviceName' => $this->serviceName,
            'method'      => $name,//方法
            'params'      => $arguments //参数
        ];
        //json打包,pack函数打包
        $data = json_encode($data);
        //包头+包体
        $data = pack("N", strlen($data)) . $data;

        //swoole的tcp客户端发送请求
        $client = new swoole_client(SWOOLE_SOCK_TCP);
        if (!$client->connect('127.0.0.1', 9508, -1)) {
            exit("connect failed. Error: {$client->errCode}\n");
        }
        $client->send($data);

        echo $client->recv();
        $client->close();

    }

}