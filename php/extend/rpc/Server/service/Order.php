<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2018/4/21
 * Time: 22:32
 */

namespace swoole;


class Order
{
  public  function  index(){

        return ['tid'=>time(),'name'=>'swoole特训班'];
  }
}