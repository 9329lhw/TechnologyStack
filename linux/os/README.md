# linux信号量
- SIGHUP 1 终止进程 终端线路挂断/重新使进程读取配置文件
- SIGINT 2 终止进程 中断进程 
- SIGKILL 9 终止进程 杀死进程/关闭进程（暴力关闭）
- SIGUSR2 12 终止进程 用户定义信号2 
- SIGUSR1 10 终止进程 用户定义信号1 
- SIGPIPE 13 终止进程 向一个没有读进程的管道写数据 
- SIGALARM 14 终止进程 计时器到时 
- SIGTERM 15 终止进程 软件终止信号/关闭进程 (正常关闭) 
- SIGCONT 18 忽略信号 继续执行一个停止的进程/恢复进程运行，相当于 bg 命令
- SIGSTOP 19 停止进程 非终端来的停止信号/挂机进程，相当于ctrl+z
- SIGTSTP 20 停止进程 终端来的停止信号 
- SIGURG 23 忽略信号 I/O紧急信号 
- SIGVTALRM 26 终止进程 虚拟计时器到时
- IGPROF 27 终止进程 统计分布图用计时器到时 
- SIGIO 29 忽略信号 描述符上可以进行I/O S