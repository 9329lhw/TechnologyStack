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
## 设计模式
### 1
### 2
### 3
### 4
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
### 主从复制
### 持久化
### 哨兵原理
### 集群
### 常见问题

## elk
### 

## rabbimq
### 

## kafka
### 

## 网络
### 五大io模型
### 网络模型
### http常见状态码
### 网络安全

