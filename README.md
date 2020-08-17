# php
## php基础
### 底层原理
PHP语言的整体架构图(包括其核心的组成模块即可)

![RUNOOB 图标](asset/php.jpg)   

    Application: 程序员编写的 PHP 程序，无论是 Web 应用还是 Cli 方式运行的应用都是上层应用，PHP 程序员主要工作就是编写它们。 
    
    SAPI:SAPI 是 Server Application Programming Interface 的缩写，中文为服务端应用编程接口，
    它通过一系列钩子函数使得 PHP 可以和外 围交换数据，SAPI 就是 PHP 和外部环境的代理器，
    它把外部环境抽象后，为内部的 PHP 提供一套固定的，统一的接口，使得 PHP 自身实现能够
    不受错综 复杂的外部环境影响，保持一定的独立性。 通过 SAPI 的解耦，PHP 可以不再考虑如
    何针对不同应用进行兼容，而应用本身也可以针对自己的特点实现不同的处理方式。 
    
    Extensions 扩展：常见的内置函数、标准库都是通过 extension 来实现的，这些叫做 PHP 的核心扩展，
    用户也可以根据自己的要求安装 PHP 的扩展 
    
    Zend 引擎:Zend 引擎是 PHP4 以后加入 PHP 的，是对原有 PHP 解释器的重写，整体使用 C 语言进行开发，
    也就是说可以把 PHP 理解成用 C 写的 一个编程语言软件，引擎的作用是将 PHP 代码翻译为一种叫 
    opcode 的中间语言，它类似于 JAVA 的 ByteCode（字节码）。 引擎对 PHP 代码会执行四个: 
    	1. 词法分析 Scanning（Lexing），将 PHP 代码转换为语言片段（Tokens）。 
    	2. 解析 Parsing， 将 Tokens 转换成简单而有意义的表达式。 
    	3. 编译 Compilation，将表达式编译成 Opcode。 
    	4. 执行 Execution，顺序执行 Opcode，每次一条，以实现 PHP 代码所表达的功能 
    	APC、Opchche 这些扩展可以将 Opcode 缓存以加速 PHP 应用的运行速度，
    使用它们就可以在请求再次来临时省略前三步。 
    引擎也实现了基本的数据结构、内存分配及管理，提供了相应的 API 方法供外部调用。
    
PHP的垃圾回收集机制

    引擎在判断一个变量空间是否能够被释放的时候是依据这个变量的zval的refcount的值，
    如果refcount为0，那么变量的空间可以被释放，否则就不释放，这是一种非常简单的GC实现

CgI、php-cgi、 Fastcgi、 php-fpm 几者的关系

    CGI全称是“公共网关接口”，HTTP服务器与你的或其它机器上的程序进行“交谈”的一种工具，
    其程序须运行在网络服务器上只要激活后，每次都要花费时间去fork一次
    
	FastCGI像是一个常驻(long-live)型的CGI，它可以一直执行着，只要激活后，
	不会每次都要花费时间去fork一次（这是CGI最为人诟病的fork-and-execute 模式）。
	它还支持分布式的运算，即 FastCGI 程序可以在网站服务器以外的主机上执行并
	且接受来自其它网站服务器来的请求。
	
	PHP-CGI是PHP自带的FastCGI管理器	
	php-cgi变更php.ini配置后需重启php-cgi才能让新的php-ini生效，不可以平滑重启。
	直接杀死php-cgi进程，php就不能运行了。(PHP-FPM和Spawn-FCGI就没有这个问题，
	守护进程会平滑从新生成新的子进程。）
		
	PHP-FPM是一个PHP FastCGI管理器，其实是PHP源代码的一个补丁   
	
php五种运行模式
    
    1.CGI（通用网关接口/ Common Gateway Interface）
    2.FastCGI（常驻型CGI / Long-Live CGI）
    3.CLI（命令行运行 / Command Line Interface）
    4.Web模块模式（Apache等Web服务器运行的模式） 
    5.ISAPI（Internet Server Application Program Interface）

nginx如何调用PHP(nginx+php运行原理)

    https://www.cnblogs.com/echojson/p/10830302.html
    1.
    2.
    3.
    4.
    5.
### 常见函数
    array_pop() 删除数组的最后一个元素（出栈）。
    array_push() 将一个或多个元素插入数组的末尾（入栈）。
    array_shift() 删除数组中首个元素，并返回被删除元素的值。
    array_unshift() 在数组开头插入一个或多个元素。
    stripos() 返回字符串在另一字符串中第一次出现的位置（对大小写不敏感）。
    strpos() 返回字符串在另一字符串中第一次出现的位置（对大小写敏感）。
    strripos() 查找字符串在另一字符串中最后一次出现的位置（对大小写不敏感）。
    strrpos() 查找字符串在另一字符串中最后一次出现的位置（对大小写敏感）。
## 设计模式
### 1.单例模式
    
    `class Singleton{
         private static $instance;
         private function __construct() {
         }
         public $a;
         public static function getInstance(){
            if(!(self::$instance instanceof self)){
                self::$instance = new self();
                
            } 
            return self::$instance;
         }
         private function __clone() {
             
         }
     }
     
     $first = Singleton::getInstance();
     $second = Singleton::getInstance();
     $first->a = "zs";`
### 2.工厂模式
    `interface mysql{
         public function connect();
     }
     
     class mysqli2 implements mysql{
         public function connect() {
             echo "mysqli";
         }
     }
     class pdo2 implements mysql{
         public function connect() {
             echo "pdo";
         }
     }
     class mysqlFactory{
         static public function factory($class_name){
             return new $class_name();
         }
     }
     
     $obj = mysqlFactory::factory('pdo2');
     $obj->connect();`
### 3.策略模式
    `abstract class Strategy{
         public abstract function doAction($money);
     }
     
     class ManJianStrategy extends Strategy{
         public function doAction($money) {
             echo "满减算法：原价{$money}元";
         }
     }
     
     class DaZheStrategy extends Strategy{
         public function doAction($money) {
             echo "打折算法：原价{$money}元";
         }
     }
     
     class StrategyFind{
         private $strategy_mode;
         public function __construct($mode) {
             $this->strategy_mode = $mode;
         }
         public function get($money){
             $this->strategy_mode->doAction($money);
         }
     }
     
     
     $mode = new StrategyFind(new ManJianStrategy());
     $mode->get(100);`
### 4.适配器模式
    `/**
      * 目标角色
      */
     interface Target2 {
      
         /**
          * 源类也有的方法1
          */
         public function sampleMethod1();
      
         /**
          * 源类没有的方法2
          */
         public function sampleMethod2();
     }
      
     /**
      * 源角色
      */
     class Adaptee2 {
      
         /**
          * 源类含有的方法
          */
         public function sampleMethod1() {
             echo 'Adaptee sampleMethod1 <br />';
         }
     }
      
     /**
      * 类适配器角色
      */
     class Adapter2 implements Target2 {
      
         private $_adaptee;
      
         public function __construct(Adaptee $adaptee) {
             $this->_adaptee = $adaptee;
         }
      
         /**
          * 委派调用Adaptee的sampleMethod1方法
          */
         public function sampleMethod1() {
             $this->_adaptee->sampleMethod1();
         }
      
         /**
          * 源类中没有sampleMethod2方法，在此补充
          */
         public function sampleMethod2() {
             echo 'Adapter sampleMethod2 <br />';
         }
      
     }
      
     class Client {
      
         /**
          * Main program.
          */
         public static function main() {
             $adaptee = new Adaptee2();
             $adapter = new Adapter2($adaptee);
             $adapter->sampleMethod1();
             $adapter->sampleMethod2();
      
         }
      
     }`
### 5
### 6
## 自动加载原理
## laravel，thinkphp运行原理
## 算法
### 10大排序算法
#### 1.
#### 2.
#### 3.
### 7大查找算法
#### 1.
#### 2.
#### 3.

## mysql
### 主从复制
### 分库分表
### 高可用

## redis
### redis为什么那么快
    
    1.完全基于内存
    2.数据结构简单
    3.采用单线程避免
    4.使用多路io复用模型，非阻塞io
    5.使用底层epoll
#### redis为什么是单线程  
    
    redis的瓶颈最有可能是机器内存或者网络带宽，单线程容易实现且cpu
    不会成为瓶颈那就顺理成章的采用单线程方案
### 主从复制
### 持久化
### 哨兵原理
### 集群
### 常见问题
    1.缓存穿透：查询一个数据库一定不存在的数据
    解决：
    1)增加用户鉴权校验
    2）布隆过滤器
    3）设置空值缓存对象
    2.缓存击穿：对于一些设置了过期时间key值如果这些值可能会在某些时间
    点被超高并发的访问，是一种非常“热点”的数据
    解决：
    1）设置热点数据用不过期
    2）加互斥锁
    3）提前加互斥锁，在读取数据时重新更新缓存
    3.缓存雪崩：缓存大量失效，导致大量请求都直接向数据库获取数据，造成数据库
    的压力
    解决；
    1）加锁降低数据库压力
    2）设置redis过期时间上时加一个随机数避免大批数据过期
    3）部署分布式redis，在一台redis服务器故障时，立刻将请求转移到另一台服务器
    4.缓存与数据库双写一致性
    1）先删除缓存，再修改数据库
    2）
## elk
### 

## rabbimq
### 

## kafka
### 

## 网络
###  同步，异步，阻塞，非阻塞
    阻塞：意思就是在哪里等待，要等别人执行完成才能往下去执行； 
    非阻塞：就是程序可以不用等待执行的结果， 就可以进行下一步的操作；
### 进程，线程，协成
    
### 三次握手
    所谓三次握手（Three-Way Handshake）即建立TCP连接，就是指建立一个
    TCP连接时，需要客户端和服务端总共发送3个包以确认连接的建立。在s
    ocket编程中，这一过程由客户端执行connect来触发，整个流程如下图所示：
   
![RUNOOB 图标](asset/3次握手.png)  
    
    （1）第一次握手：
    Client将标志位SYN置为1，随机产生一个值seq=J，并将该数据包发送给Server，
    Client进入SYN_SENT状态，等待Server确认。
    （2）第二次握手：
    Server收到数据包后由标志位SYN=1知道Client请求建立连接，Server将标志
    位SYN和ACK都置为1，ack=J+1，随机产生一个值seq=K，并将该数据包发送给
    Client以确认连接请求，Server进入SYN_RCVD状态。
    （3）第三次握手：
    Client收到确认后，检查ack是否为J+1，ACK是否为1，如果正确则将标志位
    ACK置为1，ack=K+1，并将该数据包发送给Server，Server检查ack是否为K+1，
    ACK是否为1，如果正确则连接建立成功，Client和Server进入ESTABLISHED状态，
    完成三次握手，随后Client与Server之间可以开始传输数据了。
 ### 四次挥手 
    所谓四次挥手（Four-Way Wavehand）即终止TCP连接，就是指断开一个TCP连接时，
    需要客户端和服务端总共发送4个包以确认连接的断开。在socket编程中，这一过
    程由客户端或服务端任一方执行close来触发，整个流程如下图所示：  

![RUNOOB 图标](asset/4次挥手.png)     
    
    第一次挥手：
    Client发送一个FIN，用来关闭Client到Server的数据传送，Client进入FIN_WAIT_1状态。
    第二次挥手：
    Server收到FIN后，发送一个ACK给Client，确认序号为收到序号+1
    （与SYN相同，一个FIN占用一个序号），Server进入CLOSE_WAIT状态。
    第三次挥手：
    Server发送一个FIN，用来关闭Server到Client的数据传送，
    Server进入LAST_ACK状态。
    第四次挥手：
    Client收到FIN后，Client进入TIME_WAIT状态，接着发送一个ACK给Server，
    确认序号为收到序号+1，Server进入CLOSED状态，完成四次挥手
### 五大io
    阻塞IO：
    非阻塞IO：
    信号驱动IO：
    IO多路转接：
    异步IO：
### 网络模型
    select，poll，epoll本质上都是同步I/O，因为他们都需要在读写事件就绪后自己负责进行读写，
    也就是说这个读写过程是阻塞的
    https://www.jianshu.com/p/397449cadc9a
    select 
    poll 
    epoll 
    reactor模型
        Reactor模式是处理并发I/O比较常见的一种模式，用于同步I/O，中心思想是将所有
        要处理的I/O事件注册到一个中心I/O多路复用器上，同时主线程/进程阻塞在多路复用器上；
        一旦有I/O事件到来或是准备就绪(文件描述符或socket可读、写)，多路复用器返回并将
        事先注册的相应I/O事件分发到对应的处理器中。
        Reactor是一种事件驱动机制，和普通函数调用的不同之处在于：应用程序不是主动的调用
        某个API完成处理，而是恰恰相反，Reactor逆置了事件处理流程，应用程序需要提供相应
        的接口并注册到Reactor上，如果相应的事件发生，Reactor将主动调用应用程序注册的接
        口，这些接口又称为“回调函数”。用“好莱坞原则”来形容Reactor再合适不过了：不要打电
        话给我们，我们会打电话通知你。
        Reactor模式与Observer模式在某些方面极为相似：当一个主体发生改变时，所有依属体
        都得到通知。不过，观察者模式与单个事件源关联，而反应器模式则与多个事件源关联 。
### http常见状态码
    301 moved permanently 永久重定向，将用户的访问，重定向到某个url，
    当访问忘记最后加/,将301
    302 found 临时重定向，书签不会变更
    303 see other 临时重定向，希望get方法访问
    304 Not Modified（未修改）客户的缓存资源是最新的，要客户端使用缓存
    400 bad request 请求中有错误语法
    403 forbidden 访问被服务器拒绝，包括文件权限，防火墙等等
    404 not found 没有找到要访问资源
    408 Request Timeout（请求超时）如果客户端完成请求时花费的时间太长， 
    服务器可以回送这个状态码并关闭连接
    409 Conflict（冲突）发出的请求在资源上造成了一些冲突
    407 Proxy Authentication Required(要求进行代理认证) 与状态码401类似， 
    用于需要进行认证的代理服务器
    500 internel erver error 服务端执行请求时发生错误，可能web应用端存在bug
    502 Bad Gateway（网关故障）
    		1.代理使用的服务器遇到了上游的无效响应
    		2.若代理服务器+真实服务器，大部分情况下是真实服务器返回的请求失败，
    		代理服务器才返回502
    503 service unavailable 服务器暂时属于超负载或者正在停机维护，无法处理请求。
    504 Gateway Time-out PHP-CGI已经执行，但是由于某种原因(一般是读取资源的问题)
    没有执行完毕而导致PHP-CGI进程终止。
### 常用的信号量
    
    SIGKILL 9 终止进程 杀死进程/关闭进程（暴力关闭）
    SIGUSR1 10 终止进程 用户定义信号1 
### 网络安全
    xss
    
    csrf
    
    点击劫持
    
    传输安全(http窃听,http篡改)
    
    中间人攻击
    
    密码攻击
    
    sql注入
    
    文件上传
    
    dos攻击
    
    重放攻击
    
    cc攻击
    
    ARP欺骗
    
    IP欺骗
    
    SYN攻击：
    在三次握手过程中，Server发送SYN-ACK之后，收到Client的ACK之前的TCP连接称为半连接
    （half-open connect），此时Server处于SYN_RCVD状态，当收到ACK后，Server转入
    ESTABLISHED状态。SYN攻击就是Client在短时间内伪造大量不存在的IP地址，并向Server
    不断地发送SYN包，Server回复确认包，并等待Client的确认，由于源地址是不存在的，
    因此，Server需要不断重发直至超时，这些伪造的SYN包将产时间占用未连接队列，导致
    正常的SYN请求因为队列满而被丢弃，从而引起网络堵塞甚至系统瘫痪。
    SYN攻击时一种典型的DDOS攻击，检测SYN攻击的方式非常简单，即当Server上有大量半连接
    状态且源IP地址是随机的，则可以断定遭到SYN攻击了，使用如下命令可以让之现行：
    #netstat -nap | grep SYN_RECV

