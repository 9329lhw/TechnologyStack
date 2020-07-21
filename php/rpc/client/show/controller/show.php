<?php
namespace  show\controller;

class  show{

    public function  index(){
        ob_start();
        include dirname(__DIR__).'/view/show.php'; //加载视图文件展示
        $res=ob_get_contents();
        ob_end_clean();
        return $res;
    }
}
