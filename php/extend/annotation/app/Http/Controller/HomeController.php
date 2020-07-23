<?php declare(strict_types=1);

namespace App\Http\Controller;
use Annotation\Mapping\Controller;
use Annotation\Mapping\RequestMapping;

/**
 * Class HomeController
 * @Controller(prefix="/index")
 */
class HomeController
{
    /**
     * @RequestMapping("/test")
     * @throws \Throwable
     */
    public function index()
    {
        echo "test";
    }
    /**
     * @RequestMapping("/er")
     * @throws \Throwable
     */
    public function er()
    {
        echo "er";
    }
}
