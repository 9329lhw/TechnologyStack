<?php

namespace Annotation\Mapping;
use Doctrine\Common\Annotations\Annotation\Required;
use Doctrine\Common\Annotations\Annotation\Target;

/**
 * HTTP action method annotation
 *
 * @Annotation
 * @Target("METHOD")
 *
 * @since 2.0
 */
class RequestMapping
{
    /**
     * Action routing path
     *
     * @var string
     * @Required()
     */
    private $route = '';
    /**
     * RequestMapping constructor.
     *
     * @param array $values
     */
    public function __construct(array $values)
    {

        if (isset($values['value'])) {
            $this->route = (string)$values['value'];
        } elseif (isset($values['route'])) {
            $this->route = (string)$values['route'];
        }

    }

    /**
     * @return string
     */
    public function getRoute(): string
    {
        return $this->route;
    }
}
