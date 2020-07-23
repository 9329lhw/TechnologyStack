<?php

namespace Annotation\Parser;

use Core\Bean;
use Swoft\Annotation\Annotation\Mapping\AnnotationParser;
use Swoft\Annotation\Annotation\Parser\Parser;
use Swoft\Annotation\Exception\AnnotationException;
use Swoft\Http\Server\Annotation\Mapping\RequestMapping;
use Swoft\Http\Server\Router\RouteRegister;

/**
 * Class BeanParser
 *
 * @since 2.0

 */
class BeanParser
{
    /**
     * @param $beanName
     * @param $handler
     * @return array
     */
    public function parse($beanName,$handler): array
    {
        //var_dump($beanName,$handler);
        Bean::addBean($beanName,$handler);
        return [];
    }
}
