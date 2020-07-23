# http状态码
1. 100
	- 100 Continue 收到了请求的起始部分，客户端应该继续请求
	- 101 Switching Protocols（切换协议）服务器正根据客户端的指示将协议切换成Update Header列出的协议

2. 200
	- 200 OK 服务器成功处理了请求
	- 201 Created（已创建）对于那些要服务器创建对象的请求来说，资源已创建完毕。
	- 202 Accepted（已接受）请求已接受， 但服务器尚未处理
	- 203 Non-Authoritative Information（非权威信息）服务器已将事务成功处理，只是实体Header包含的信息不是来自原始服务器，而是来自资源的副本。
	- 204 no content 客户端不发生变化，应用于，客户端发东西给服务端，而服务端不需要发送页面。
	- 205 Reset Content(重置内容) 另一个主要用于浏览器的代码。意思是浏览器应该重置当前页面上所有的HTML表单。
	- 206 partial content 成功执行范围请求，部分请求成功

3. 300
	- 300 Multiple Choices（多项选择）客户端请求了实际指向多个资源的URL。这个代码是和一个选项列表一起返回的，然后用户就可以选择他希望的选项了
	- 301 moved permanently 永久重定向，将用户的访问，重定向到某个url，当访问忘记最后加/,将301
	- 302 found 临时重定向，书签不会变更
	- 303 see other 临时重定向，希望get方法访问
	- 304 Not Modified（未修改）客户的缓存资源是最新的，要客户端使用缓存
	- 305 Use Proxy（使用代理）必须通过代理访问资源， 代理的地址在Response 的Location中
	- 306 未使用 这个状态码当前没使用
	- 307 Temporary Redirect 临时重定向，类似302

4. 400
	- 400 bad request 请求中有错误语法
	- 401 unaythorized 第一次返回401则进行验证，第二次返回则验证失败
	- 402 Payment Required 这个状态还没被使用， 保留给将来用
	- 403 forbidden 访问被服务器拒绝，包括文件权限，防火墙等等
	- 404 not found 没有找到要访问资源
	- 405 Method Not Allowed（不允许使用的方法）不支持该Request的方法。
	- 406 Not Acceptable（无法接受）
	- 407 Proxy Authentication Required(要求进行代理认证) 与状态码401类似， 用于需要进行认证的代理服务器
	- 408 Request Timeout（请求超时）如果客户端完成请求时花费的时间太长， 服务器可以回送这个状态码并关闭连接
	- 409 Conflict（冲突）发出的请求在资源上造成了一些冲突
	- 410 Gone（消失了）服务器曾经有这个资源，现在没有了， 与状态码404类似
	- 411 Length Required（要求长度指示）服务器要求在Request中包含Content-Length。
	- 412 Precondition Failed（先决条件失败）
	- 413 Request Entity too large nginx上传文件超过限制 client_max_body_size 8m;修改为更大
	- 414 Request URI Too Long（请求URI太长）客户端发送的请求所携带的URL超过了服务器能够或者希望处理的长度
	- 415 Unsupported Media Type（不支持的媒体类型）服务器无法理解或不支持客户端所发送的实体的内容类型
	- 416 Requested Range Not Satisfiable（所请求的范围未得到满足）
	- 417 Expectation Failed（无法满足期望）
	- 499 
	    - 1.客户端主动断开连接 
	    - 2.服务端响应超时造成客户端连接中断

5. 500
	- 500 internel erver error 服务端执行请求时发生错误，可能web应用端存在bug
	- 501 Not Implemented（未实现）客户端发起的请求超出服务器的能力范围(比如，使用了服务器不支持的请求方法)时，使用此状态码。
	- 502 Bad Gateway（网关故障）
		- 1.代理使用的服务器遇到了上游的无效响应
		- 2.若代理服务器+真实服务器，大部分情况下是真实服务器返回的请求失败，代理服务器才返回502
	- 503 service unavailable 服务器暂时属于超负载或者正在停机维护，无法处理请求。
	- 504 Gateway Time-out PHP-CGI已经执行，但是由于某种原因(一般是读取资源的问题)没有执行完毕而导致PHP-CGI进程终止。
	- 505 HTTP Version Not Supported（不支持的HTTP版本）服务器收到的请求使用了它不支持的HTTP协议版本。 有些服务器不支持HTTP早期的HTTP协议版本，也不支持太高的协议版本
