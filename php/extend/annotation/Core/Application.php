<?php
/**
 * Created by PhpStorm.
 * User: guo
 * Date: 2019/5/20
 * Time: 11:39
 */

namespace Core;

use Annotation\Parser\BeanParser;
use Annotation\Parser\RequestMappingParser;
use Doctrine\Common\Annotations\AnnotationRegistry;
use Doctrine\Common\Annotations;

class Application
{

    public static $beans = [];

    public static function init()
    {
        $loader = require dirname(__DIR__) . "/vendor/autoload.php";
        AnnotationRegistry::registerLoader([$loader, 'loadClass']);
        self::loadAnnotationRoute();//收集路由注解
        self::loadAnnotationBean();//收集容器注解
    }

    /**
     * glob() 遍历文件
     * @param $path
     * @return array
     */
    public static function TraversalFile($path)
    {
        //手动实例化类 glob() 遍历文件
        $obj = [];
        $files = glob($path . '/*.php');
        if (!empty($files)) {
            foreach ($files as $dir => $fileName) {
                $files     = pathinfo($fileName);
                $className = $files['filename'];
                $nameSpace = 'App\\Http\\Controller\\' . $className;
                if (class_exists($nameSpace)) {
                    $obj[] = new $nameSpace();
                }
            }
        }
        return $obj;
    }

    /**
     *收集路由注解
     */
    public static function loadAnnotationRoute()
    {
        $reader = new Annotations\AnnotationReader();
        //手动实例化类 glob() 遍历文件
        $path = dirname(__DIR__) . "/app/Http/Controller";
        $obj = self::TraversalFile($path);
        //var_dump($obj);
        if (!empty($obj)) {

            foreach ($obj as $value) {
                //通过反射得到自己定义的事件名称
                $reflection = new \ReflectionClass($value);
                //类注解
                $class_annotations = $reader->getClassAnnotations($reflection);

                //方法注解
                foreach ($class_annotations as $class_annotation) {
                    $routePrefix = $class_annotation->getPrefix();
                    //获取类中的方法，设置获取public,protected类型方法
                    $fefMethods = $reflection->getMethods();
                    //var_dump($fefMethods);
                    //遍历所有的方法
                    foreach ($fefMethods as $method) {
                        $method_annotations = $reader->getMethodAnnotations($method);
                        //var_dump($method_annotation);
                        foreach ($method_annotations as $method_annotation) {
                            $routePath = $method_annotation->getRoute();
                            //在某个解析类当中处理逻辑
                            (new RequestMappingParser())->parse($routePrefix, $routePath, $reflection->newInstance(), $method->name);
                        }
                    }
                }
            }
        } else {
            var_dump("出现错误");
        }
    }


    /**
     * 收集容器注解
     */
    public static function loadAnnotationBean()
    {
        $reader = new Annotations\AnnotationReader();

        $obj = new Route();
//        var_dump($obj);die;
        $reflection = new \ReflectionClass($obj);
        //var_dump($reflection);
        //类注解
        $class_annotations = $reader->getClassAnnotations($reflection);
        //var_dump($class_annotations);
        //方法注解
        foreach ($class_annotations as $class_annotation) {
            $beanName = $class_annotation->getName();
            //var_dump($beanName);
            //var_dump($reflection->newInstance());
            //parse方法作为作业
            //self::$beans[$beanName] = $reflection->newInstance();
            //在某个解析类当中处理逻辑
            (new BeanParser())->parse($beanName, $reflection->newInstance());
        }
    }
}