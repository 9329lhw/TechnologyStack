<?php

namespace Annotation\Parser;

use Core\Route;
use Swoft\Annotation\Annotation\Mapping\AnnotationParser;
use Swoft\Annotation\Annotation\Parser\Parser;
use Swoft\Annotation\Exception\AnnotationException;
use Swoft\Http\Server\Annotation\Mapping\RequestMapping;
use Swoft\Http\Server\Router\RouteRegister;

/**
 * Class RequestMappingParser
 *
 * @since 2.0

 */
class RequestMappingParser
{
    /**
     * @param $routePrefix
     * @param $routePath
     * @param $handler
     * @param $action
     * @return array
     */
    public function parse($routePrefix,$routePath,$handler,$action): array
    {
        /*$routeInfo = [
            'action'  => $this->methodName,
            'route'   => $annotation->getRoute(),
            'method' => $annotation->getMethod(),
            'params'  => $annotation->getParams(),
        ];*/

        // Add route info for controller action
        //RouteRegister::addRoute($this->className, $routeInfo);
        //var_dump($routePrefix,$routePath,$handler,$action);
        Route::addRoute($routePrefix,$routePath,$handler,$action);
        return [];
    }
}
