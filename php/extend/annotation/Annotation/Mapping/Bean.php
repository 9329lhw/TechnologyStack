<?php declare(strict_types=1);

namespace Annotation\Mapping;

use Doctrine\Common\Annotations\Annotation\Attribute;
use Doctrine\Common\Annotations\Annotation\Attributes;
use Doctrine\Common\Annotations\Annotation\Required;
use Doctrine\Common\Annotations\Annotation\Target;

/**
 * Class Controller
 *
 * @Annotation
 * @Target("CLASS")
 * @Attributes({
 *     @Attribute("name", type="string"),
 * })
 *
 * @since 2.0
 */
final class Bean
{
    /**
     * Route group prefix for the controller
     *
     * @Required()
     *
     * @var string
     */
    private $name = '';

    /**
     * Controller constructor.
     *
     * @param array $values
     */
    public function __construct(array $values)
    {
        if (isset($values['value'])) {
            $this->name = $values['value'];
        }
        if (isset($values['name'])) {
            $this->name = $values['prefix'];
        }
    }

    /**
     * @return string
     */
    public function getName(): string
    {
        return $this->name;
    }
}