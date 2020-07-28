# mysql主从复制

#### 主从环境搭建

#### 主从复制备份

#### 主从复制问题
1. 主从数据不一致
    - 1.1.原因
        - 1.1.1 网络中断
        - 1.1.2 服务器产生了问题
        - 1.1.3 mysql自带bug
        - 1.1.4 从库进行了非正当操作(在从库执行了update,insert,delete操作)
    - 1.2.解决思路
        - 1.2.1 确定校验的主库跟需要校验的表及表分段的数据
        - 1.2.2 与从库对应的表数据段进行校验(根据主键)
        - 1.2.3 校验过程发现数据不一致，将数据记录到主库的一个表中
        - 1.2.4 从主库中读取表进行从库数据恢复
    - 1.3.主从一致问题校验
        - 1.3.1 percona-toolkit工具介绍
            - 1 pt-table-checksum 负责检测MySQL主从数据一致性 
            - 2 pt-table-sync负责挡住从数据不一致时修复数据，让他们保存数据的一致性 
            - 3 pt-heartbeat 负责监控MySQL主从同步延迟
        - 1.3.2 percona-toolkit安装
            ```
            yum install perl-IO-Socket-SSL perl-DBD-MySQL perl-Time-HiRes perl perl-DBI -y
            yum install percona-toolkit-3.0.3-1.el6.x86_64.rpm
            yum list | grep percona-toolkit
            pt-table-checksum --help
            
            ```
        - 1.3.2 常用参数解释
            ```
            --nocheck-replication-filters ：不检查复制过滤器，建议启用。后面可以用
            --databases来指定需要检查的数据库。 
            --no-check-binlog-format : 不检查复制的binlog模式，要是binlog模式是ROW，则会报错。 
            --replicate-check-only :只显示不同步的信息。 
            --replicate= ：把checksum的信息写入到指定表中，建议直接写到被检查的数据库当中。 
            --databases= ：指定需要被检查的数据库，多个则用逗号隔开。 
            --tables= ：指定需要被检查的表，多个用逗号隔开 
            --host | h= ：Master的地址 
            --user | u= ：用户名 
            --passwork | p=：密码 --Post | P= ：端口
            ```            
        - 1.3.3 检查过程
            - 1.3.3.1 主库，从库分别创建表
                ```
                create database `mytest`; 
                create table t ( id int primary key, name varchar(20) );
                ```
             - 1.3.3.2 主库，从库分别添加数据
                ```
                主库
                mysql> use `mytest`; 
                mysql> insert into t values(1,6); 
                mysql> insert into t values(2,2); 
                mysql> insert into t values(4,4); 
                mysql> select * from t;
                
                从库
                mysql> use `test`; 
                mysql> insert into t values(3,3); 
                mysql> select * from t;
                ``` 
            - 1.3.3.3 进行检测
            ```
                pt-table-checksum --nocheck-replication-filters --replicate=check_data.checksums 
                --databases=test --tables=t -- user=root --password=root
                1.会出如下错误
                Replica localhost.localdomain has binlog_format MIXED which could cause pt-table-checksum to break 
                replication.Please read "Replicas using row-based replication" in the LIMITATIONS section of the tool's 
                documentation.If you understand the risks, specify --no-check- binlog-format to disable this check.
                上面的错误信息主要是因为，检测主库与从库的binlog日志的模式 - 通常来说可以不用改binlog添加 
                --no-check-binlog-format 跳过检测 但是可能也会出现如下的问题
                pt-table-checksum --nocheck-replication-filters --replicate=check_data.checksums --no-check-binlog-format 
                -- databases=test --tables=t --user=root --password=root
                2.会出如下错误
                Diffs cannot be detected because no slaves were found. Please read the —recursion-method documentation 
                for information.
                问题原因是没有找到从库的地址，MySQL在做主从的时候可能会因为环境配置等因素，让pt-table-checksum
                没有很好地找到从库的地址 检测的方式： 
                1. 是否是指定在主库运行进行校验 
                2. 就是配置--recursion-method参数，然后在从库中指定好对应的地址
                
                pt-table-checksum --nocheck-replication-filters --replicate=check_data.checksums  
                --no-check-binlog-format -- databases=test --tables=t --user=root --password=root
                结果
                TS             ERRORS DIFFS ROWS CHUNKS SKIPPED     TIME      TABLE 
                09-28T11:46:37    0     1    3     1      0         0.274     test.t
                结果分析
                TS ：完成检查的时间。 
                ERRORS ：检查时候发生错误和警告的数量。 
                DIFFS ：0表示一致，1表示不一致。当指定--no-replicate-check时，会一直为0，
                    当指定--replicate-check-only会显示不同的信息。 
                ROWS ：表的行数。 CHUNKS ：被划分到表中的块的数目。 
                SKIPPED ：由于错误或警告或过大，则跳过块的数目。 
                TIME ：执行的时间。 
                TABLE ：被检查的表名。
            ``` 
            - 1.3.3.4 dsn方法
                > dsn方法：dsn是参数--recursion-method的一个参数值。注意是dsn，不是dns…   
                
                > DSN：DSN，即DATA SOURCE NAME，数据源名称。DSN包含从库的各个连接参数（user、password、port等），
                由逗号分隔的多个option=value字符串 组成。        
                
                - 1.3.3.4.1 步骤
                ```
                    参数说明
                    D:DSN表所在的数据库名。 
                    h:从库的host。 
                    p:小写p，从库的密码。当密码包括逗号（,）时，需要使用反斜杠转义。 
                    P:大写P，从库的端口。 
                    S:连接使用的socket文件。 
                    t:存储DSN信息的DSN表名。 
                    u:从库的MySQL用户名。
                    创建表
                    CREATE TABLE dsns ( 
                        id int(11) NOT NULL AUTO_INCREMENT, 
                        parent_id int(11) DEFAULT NULL, 
                        dsn varchar(255) NOT NULL, PRIMARY KEY (id) 
                    );
                    新增从节点的连接信息
                    INSERT INTO mytest.dsns(dsn) VALUES ("h=192.168.81.140,P=3306,u=slave_check,p=root"); 
                    INSERT INTO mytest.dsns(dsn) VALUES ("h=192.168.81.142,P=3306,u=slave_check2,p=root");
                    检测
                    pt-table-checksum --tables=t --socket=/tmp/mysql.sock --databases=mytest --user=root  
                    --password='root' -- replicate=check_data.checksum --no-check-binlog-format --recursion-method 
                    dsn=t=mytest.dsns,h=192.168.81.140,P=3306,u=slave_check,p=root
                    结果
                    TS            ERRORS DIFFS ROWS CHUNKS SKIPPED    TIME        TABLE 
                    05-12T01:30:30 0       0    2     1       0      1.050     mytest.t
                ```
            - 1.3.3.5 pt-table-sync工具恢复数据
            ```
                pt-table-sync --sync-to-master h=192.168.81.140,u=root_sync,p=root,P=3306 --databases=mytest --print
                结果
                DELETE FROM `test`.`t` WHERE `id`='3' LIMIT 1 /*percona-toolkit src_db:test src_tbl:
                t src_dsn:h=127.0.0.1,p=...,u=root dst_db:test dst_tbl:t dst_dsn:h=192.168.153.131,p=...,
                u=root lock:1 transaction:1 changing_src:check_data.checksums 
                replicate:check_data.checksums bidirectional:0 pid:14262 user:root host:localhost.localdomain*/;
                再执行如下命令即可恢复数据
                pt-table-sync --sync-to-master h=192.168.81.140,u=root_sync,p=root,P=3306 --databases=mytest --execute
                
                参数解释
                --replicate= ：指定通过pt-table-checksum得到的表，这2个工具差不多都会一直用。 
                --databases= : 指定执行同步的数据库，多个用逗号隔开。 
                --tables= ：指定执行同步的表，多个用逗号隔开。 
                --sync-to-master ：指定一个DSN，即从的IP，他会通过show processlist或show slave status 去自动的找主。 
                    h=127.0.0.1 ：服务器地址，命令里有2个ip，第一次出现的是Master的地址，
                    第2次是Slave的地址。 u=root ：帐号。 p=123456 ：密码。 
                --print ：打印，但不执行命令。 
                --execute ：执行命令。
                建议
                1. 修复数据的时候，用--print打印出来，这样就可以知道那些数据有问题 
                2. 修复数据之前一定要备份数据库 ； 然后再 手动执行或者 添加 --execute
                
                配合linux的crontable使用
                vi pt-check-sync.sh
                #!/usr/bin/env bash 
                NUM=`pt-table-checksum --tables=t --socket=/tmp/mysql.sock 
                    --databases=mytest --user=root --password='root' -- replicate=check_data.checksum 
                    --no-check-binlog-format --recursion-method dsn=t=mytest.dsns,
                    h=192.168.81.140,P=3306,u=slave_check,p=root | awk 'NR>1{sum+=$3}END{print sum}'` 
                if [ $NUM -eq 0 ] ;then 
                    echo "Data is ok!" 
                else
                    echo "Data is error!" 
                    pt-table-sync --sync-to-master h=192.168.81.140,u=root_sync,p=root,P=3306 --databases=mytest --print 
                    pt-table-sync --sync-to-master h=192.168.81.140,u=root_sync,p=root,P=3306 --databases=mytest --execute 
                fi

            ```
2. 主从延迟
    - 1.1.原因
    - 1.2.检测
        - 1.2.1 pt-heartbeat使用
        ```
            1. 在住上创建一张hearteat表，按照一定的时间频率更新改表的子弹。监控操作运行后，heartbeat表能促使主从同步 
            2. 连接到从库上检查复制的时间记录，和从库的当前系统时间进行比较，得出时间的差异。 
            注意在使用的方式就是需要在主库中创建这个表；
            use test; 
            CREATE TABLE heartbeat ( 
                ts VARCHAR (26) NOT NULL, 
                server_id INT UNSIGNED NOT NULL PRIMARY KEY, 
                file VARCHAR (255) DEFAULT NULL, -- SHOW MASTER STATUS 
                position bigint unsigned DEFAULT NULL, -- SHOW MASTER STATUS 
                relay_master_log_file varchar(255) DEFAULT NULL, -- SHOW SLAVE STATUS 
                exec_master_log_pos bigint unsigned DEFAULT NULL -- SHOW SLAVE STATUS 
            );
            通过pt-heartbeat可以对于mysql中的heartbeat表每隔多久更新一次（注意这个启动操作要在主库服务器上执行）
            $ pt-heartbeat --user=root --ask-pass --create-table --database test --interval=1 
            --interval=1 --update --replace --daemonize
            $ ps -ef | grep pt-heartbeat
            
            $ pt-heartbeat --database test --table=heartbeat --monitor --user=root 
            --password=root --master-server-id=1 
            运行结果
            0.02s [ 0.00s, 0.00s, 0.00s ] 
            0.00s [ 0.00s, 0.00s, 0.00s ]
            这其中 0.02s 表示延迟了 ，没有延迟是为0 而 [ 0.00s, 0.00s, 0.00s ] 则表示1m,5m,15m的平均值， 
            而这期中需要注意的是 --master-server-id 为主服务器的服务id 就是在my.cnf中配置的 server_id的值
        ```
        - 1.2.2 其他方法
            - 1.2.2.1 show slave status显示参数Seconds_Behind_Master不为0，这个数值可能会很大
            - 1.2.2.2 show slave status显示参数Relay_Master_Log_File和Master_Log_File显示bin-log的编号相差很大，
            说明bin-log在从库上没有及时同步，所以近期执行的bin-log和当前IO线程所读的bin-log相差很大
            - 1.2.2.3 mysql的从库数据目录下存在大量mysql-relay-log日志，该日志同步完成之后就会被系统自动删除，
            存在大量日志，说明主从同步延迟很厉害
    - 1.3.解决方法
        >对于从库的延时问题最为重要的就是主库与从库之间连接的网咯环境，
        从库的写入熟读 这两个点- 其次就是对于主从的架构的优化； 
        >注意：一旦使用了主从必然是会有一定的延时问题，因此我们就需要考虑程序对于延迟的容忍度。 
        如果是0容忍的话建议还是不用主从了
        
        - 1.3.1 MySQL从库产生配置
        ```
            sync_binlog 配置说明： 
                sync_binlog”：这个参数是对于MySQL系统来说是至关重要的，他不仅影响到Binlog对MySQL所带来的性能损耗，
                而且还影响到MySQL中数据的完整性。对 于“sync_binlog”参数的各种设置的说明如下： 
                    sync_binlog=0，当事务提交之后，MySQL不做fsync之类的磁盘同步指令刷新binlog_cache
                        中的信息 到磁盘，而让Filesystem自行决定什么时候来做同步，或者 cache满了之后才同步到磁盘。 
                    sync_binlog=n，当每进行n次事务提交之后，MySQL将进行 
                    一次fsync之类的磁盘同步指令来将binlog_cache中的数据强制写入磁盘。 
                    
                在MySQL中系统默认的设置是sync_binlog=0，也就是不做任何强制性的磁盘刷新指令，这时候的性能是最好的，
                但是风险也是最大的。因为一旦系统Crash，在 binlog_cache中的所有binlog信息都会被丢失。而当设置为“1”
                的时候，是最安全但是性能损耗最大的设置。因为当设置为1的时候，即使系统Crash，
                也最多丢失 binlog_cache中未完成的一个事务，对实际数据没有任何实质性影响。         
                从以往经验和相关测试来看，对于高并发事务的系统来说，“sync_binlog”
                设置为0和设置为1的系统写入性能差距可能高达5倍甚至更多。 
                
            innodb_flush_log_at_trx_commit 配置说明： 
                默认值1的意思是每一次事务提交或事务外的指令都需要把日志写入（flush）硬盘，这是很费时的。
                特别是使用电 池供电缓存（Battery backed up cache）时。 设成2对于很多运用，
                特别是从MyISAM表转过来的是可以的，它的意思是不写入硬盘而是写入系统缓存。日志仍 然会每秒flush到硬 盘，
                所以你一般不会丢失超 过1-2秒的更新。设成0会更快一点，但安全方面比较差，
                即使MySQL挂了也可能会丢失事务的数据。
                而值2只会 在整个操作系统 挂了时才可能丢数据。
        ```
        - 1.3.2 硬件
            从库的配置高于主库的配置
        - 1.3.3 架构
            - 1.3.3.1 可以考虑对于一些库进行单独分离。 
            - 1.3.3.2 服务的基础架构在业务和MySQL之间加入memcache或者redis的cache层。降低mysql的读压力。
            - 1.3.3.3 不同业务的mysql物理上放在不同机器，分散压力。