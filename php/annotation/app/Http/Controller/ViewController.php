<?php declare(strict_types=1);


namespace App\Http\Controller;

use Annotation\Mapping\Controller;
use Annotation\Mapping\RequestMapping;

/**
 * Class ViewController
 *
 * @since 2.0
 *
 * @Controller(prefix="/view")
 */
class ViewController
{
    /**
     * @RequestMapping("/index")
     *
     * @param Response $response
     *
     * @return Response
     * @throws \ReflectionException
     * @throws \Swoft\Bean\Exception\ContainerException
     */
    public function index()
    {
        echo 'view/index';
    }

    /**
     * @RequestMapping("/ary")
     *
     * @return array
     */
    public function ary(): array
    {
        echo 'view/ary';
        //return ['ary'];
    }

    /**
     * @RequestMapping("/ary")
     *
     * @return string
     */
    public function str()
    {
        echo "view/str";
        //return 'string';
    }
}