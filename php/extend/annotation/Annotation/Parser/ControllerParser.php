<?php

namespace Annotaion\Parser;

use Swoft\Annotation\Annotation\Mapping\AnnotationParser;
use Swoft\Annotation\Annotation\Parser\Parser;
use Swoft\Bean\Annotation\Mapping\Bean;
use Swoft\Http\Server\Annotation\Mapping\Controller;
use Swoft\Http\Server\Exception\HttpServerException;
use Swoft\Http\Server\Router\RouteRegister;

/**
 * Class ControllerParser
 * @since 2.0
 */
class ControllerParser
{
    /**
     * @param int        $type
     * @param Controller $annotation
     *
     * @return array
     * @throws HttpServerException
     */
    public function parse(int $type, $annotation): array
    {

        // add route prefix for controller
        //RouteRegister::addPrefix($this->className, $annotation->getPrefix());

        // return [$this->className, $this->className, Bean::SINGLETON, ''];
    }
}