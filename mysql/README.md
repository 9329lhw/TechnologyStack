Mysql 删除数据表的三种方式详解

1.  drop table tb;
2.  truncate （table） tb;
3. delete from tb (where);
truncate 和 delete 的区别：
1. 事物

truncate删除后不记录mysql日志，因此不可以rollback，更不可以恢复数据；而 delete 是可以 rollback ；

原因：truncate 相当于保留原mysql表的结果，重新创建了这个表，所有的状态都相当于新的，而delete的效果相当于一行行删除，所以可以rollback;

2. 效果

效率上 truncate 比 delete快，而且 truncate 删除后将重建索引（新插入数据后id从0开始记起），而 delete不会删除索引 （新插入的数据将在删除数据的索引后继续增加）

3. truncate 不会触发任何 DELETE触发器；

4. 返回值

delete 操作后返回删除的记录数，而 truncate 返回的是0或者-1（成功则返回0，失败返回-1）；

delete 与 delete from 区别：
如果只针对一张表进行删除，则效果一样；如果需要联合其他表，则需要使用from ：

delete tb1 from tb1 m where id in (select id from tb2)