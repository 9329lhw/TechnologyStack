@[TOC](docker搭建lrnp环境)
# docker
## 初识docker
	镜像：
	容器：
	仓库：
## 安装
	 -- 1. 卸载老版本 
	 yum -y remove docker docker-common docker-selinux docker-engine 
	 -- 2. 安装需要的软件包 
	 yum install -y yum-utils device-mapper-persistent-data lvm2 
	 -- 3. 设置国内yum源 
	 yum-config-manager --add-repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo 
	 -- 4. 查看docker版本
	 yum list docker-ce --showduplicates|sort -r 
	 -- 5. 安装 
	 yum install docker-ce-18.03.1.ce -y 
	 -- 6. 配置docker镜像源
	 vi /etc/docker/daemon.json { "registry-mirrors": ["http://hub-mirror.c.163.com"] }
	 -- 7. 启动 
	 systemctl start docker 
	 -- 8. 加入开机自启 
	 systemctl enable docker
## docker常用命令
	============= 操作仓库 =============
	 -- 1. 从仓库上下载镜像资源到本地
	 docker pull xxx/yyy 
	 -- 2. 推送本地镜像到仓库 
	 docker push xxx/yyy 
	 ============= 操作镜像 ============= 
	 -- 1. 查看所有的镜像 
	 docker images 
	 -- 2. 删除镜像 
	 docker rmi xxx/yyy 
	 -- 3. 删除所有镜像 
	 docker rmi $(docker images) 
	 -- 4. 根据dockerfile构建镜像 
	 docker build -t [镜像名称] . 
	 -- 5. 强制删除镜像 
	 docker rmi -f xxx/yyy 
	 --- 6. 查看镜像的构建历史 
	 docker history 镜像 
	 ============= 操作容器 ============= 
	 -- 1. 查看运行的容器 
	 docker ps 
	 -- 2. 查看所有容器（含未运行的） 
	 docker ps -a 
	 -- 3. 创建容器 
	 docker run -itd --name 容器名称(自定义) 镜像名称 
	 -- 4. 进入容器中 
	 docker exec -it 容器名称 挂起命令(top,ping,sh,bash...) 
	 -- 5. 容器转为镜像 
	 docker commit -m="猫叔" 容器 镜像名称 
	 -- 6. 启动容器 
	 docker start 容器名 
	 -- 7. 停止容器 
	 docker stop 容器名 
	 -- 8. 删除容器 
	 docker rm 容器名 
	 -- 9. 删除所有容器 
	 docker rm $(docker ps -a -q) 
	 ============= 网络环境配置 ============= 
	 -- 1. 查看所有网络配置 
	 docker network ls 
	 -- 2. 创建网络 
	 docker network create --subnet=172.100.100.0/24 mynetwork 
	 -- 3. 删除网络 
	 docker network rm mynetwork 
	 -- 4. 给容器定义网络 --network=网络名 --ip=自定义ip 
	 docker run -itd --network=mynetwork --ip=172.100.100.100 
	 --name 容器名称(自定义) 镜像名称 
	 ============= 导出备份 =============
	 -- 1. 根据 容器 导出tar文件 
	 docker export 容器名 > 文件名.tar 
	 -- 2. 根据 容器 导出的tar文件转为镜像 
	 docker import 文件名.tar 镜像名 
	 -- 3. 根据 镜像 导出tar文件 
	 docker save 镜像名 > 文件名.tar 
	 -- 4. 根据 镜像 导出的tar文件转为镜像 
	 docker load < 文件名.tar
# dockerfile构建lrnp环境
	1.文件目录
	lrmp
		--- php
			--- dockerfile
		--- redis
			--- conf
				--- redis.conf
			--- dockerfile
		--- nginx
			--- conf
				--- nginx.conf
			--- dockerfile
		--- www
`php----->dockerfile`
	
```
FROM php:7.3-fpm-alpine 
	# Version
	ENV PHPREDIS_VERSION 4.0.0
	# Libs
	RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories \
	    && apk  add  \
	        curl \
	        vim  \
	        wget \
	        git \
	        openssl-dev\
	        zip \
	        unzip \
	        g++  make autoconf
	
	# docker方式安装PDO extension                                                                                # 安装扩展
	RUN mv "$PHP_INI_DIR/php.ini-production"  "$PHP_INI_DIR/php.ini" \
	    && docker-php-ext-install pdo_mysql \
	    && docker-php-ext-install pcntl \
	    && docker-php-ext-install sysvmsg
	# Redis extension
	RUN wget http://pecl.php.net/get/redis-${PHPREDIS_VERSION}.tgz -O /tmp/redis.tar.tgz \
	    && pecl install /tmp/redis.tar.tgz \
	    && rm -rf /tmp/redis.tar.tgz \
	    && docker-php-ext-enable redis
	# 修改php.ini的文件 extension=redis.so
	EXPOSE 9000
	#设置工作目录
	WORKDIR  /www
```
`redis----->dockerfile`
```
FROM centos:centos7
	RUN groupadd -r redis && useradd -r -g redis redis
	RUN mkdir data ;\
	    yum update -y ; \
	    yum -y install gcc automake autoconf libtool make wget epel-release gcc-c++;
	COPY ./redis-5.0.7.tar.gz redis-5.0.7.tar.gz
	RUN mkdir -p /usr/src/redis; \
	    tar -zxvf redis-5.0.7.tar.gz -C /usr/src/redis; \
	    rm -rf redis-5.0.7.tar.gz; \
	    cd /usr/src/redis/redis-5.0.7 && make ; \
	    cd /usr/src/redis/redis-5.0.7 && make install
	COPY ./conf/redis.conf /usr/src/redis/redis-5.0.7/redis.conf
	EXPOSE 6379
	ENTRYPOINT ["redis-server", "/usr/src/redis/redis-5.0.7/redis.conf"]	
```
`nginx----->dockerfile`

```
FROM centos:centos7
RUN  groupadd -r nginx && useradd -r -g nginx nginx
#添加centos源(先下载wget)
COPY ./epel-7.repo  /etc/yum.repos.d/epel.repo

RUN mkdir /data \
    && mkdir /conf \
    && yum update -y \
    && yum clean all  \
    && yum makecache  \
    && yum -y install  gcc gcc-c++ autoconf automake make zlib zlib-devel net-tools openssl* pcre* wget \
    && yum clean all  && rm -rf /var/cache/yum/*

#声明匿名卷
VOLUME /data

COPY ./nginx-1.14.1.tar.gz  /data/nginx-1.14.1.tar.gz

RUN cd /data \
   && tar -zxvf nginx-1.14.1.tar.gz \
   && cd nginx-1.14.1 \
   && ./configure --prefix=/usr/local/nginx --user=nginx --group=nginx \
   && make && make install && rm -rf /data/nginx-1.14.1.tar.gz  && rm -rf /data/nginx-1.14. \
   && ln -s /usr/local/nginx/sbin/* /usr/local/sbin

COPY ./conf/nginx.conf /conf

#进入容器时默认打开的目录
WORKDIR /conf

#声明端口
EXPOSE 80

#容器启动的时候执行,在docker run过程当中是会被其他指令替代
#CMD ["/usr/local/nginx/sbin/nginx","-c","/conf/nginx.conf","-g","daemon off;"]

#执行一条指
ENTRYPOINT ["/usr/local/nginx/sbin/nginx","-c","/conf/nginx.conf","-g","daemon off;"]
```	
	构建镜像
	cd /home/lrmp/php docker build -t php7 . 
	cd /home/lrmp/nginx docker build -t nginx . 
	cd /home/lrmp/redis docker build -t redis5 .
	添加网络
	docker network create --subnet=172.100.100.0/24 lrnp
	构建容器
	docker run -itd --network=lrnp --ip=172.100.100.10 -p 81:80 -v /\home/lrnp/nginx/conf:/conf --name nginx1.4 nginx
	docker run -itd --network=lrnp --ip=172.100.100.20 -p 9001:9000 -v /home/lrnp/www:/www --name php7 php7
	docker run -itd --network=lrnp --ip=172.100.100.30 -p 6380:6379 -v /home/lrnp/redis:/redis --name redis5 redis5

	在浏览器中输入：http://192.168.8.150:81/index.php
	没有报错说明lrmp搭建成功
# docker-compose
##  docker-compose安装
	curl -L https://get.daocloud.io/docker/compose/releases/download/1.25.5/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
	chmod +x /usr/local/bin/docker-compose
	docker-compose --version

##  构建lrnp环境
`docker-compose.yml`
```
# 编排php,redis,nginx容器
version: "3.6" # 确定docker-composer文件的版本
services: # 代表就是一组服务 - 简单来说一组容器
  nginx: # 这个表示服务的名称，课自定义; 注意不是容器名称
    build: # 根据dockerfile构建镜像及构建为容器
      context: ./nginx
    image: nginx # 指定容器的镜像文件
    container_name: nginx_compose # 这是容器的名称
    ports: # 配置容器与宿主机的端口
      - "82:80"
    networks: ## 引入外部预先定义的网段
       lrnp:
         ipv4_address: 172.100.100.110   #设置ip地址
    privileged: true # 执行特殊权限的命令
    volumes: # 配置数据挂载
        - /home/lrnp/nginx/conf:/conf
    working_dir: /conf #工作目录
  php: # 这个表示服务的名称，课自定义; 注意不是容器名称
    build: # 根据dockerfile构建镜像及构建为容器
      context: ./php
    image: php7 # 指定容器的镜像文件
  nginx: # 这个表示服务的名称，课自定义; 注意不是容器名称
    build: # 根据dockerfile构建镜像及构建为容器
      context: ./nginx
    image: nginx # 指定容器的镜像文件
    container_name: nginx_compose # 这是容器的名称
    ports: # 配置容器与宿主机的端口
      - "82:80"
    networks: ## 引入外部预先定义的网段
       lrnp:
         ipv4_address: 172.100.100.110   #设置ip地址
    privileged: true # 执行特殊权限的命令
    volumes: # 配置数据挂载
        - /home/lrnp/nginx/conf:/conf
    working_dir: /conf #工作目录
  php: # 这个表示服务的名称，课自定义; 注意不是容器名称
    build: # 根据dockerfile构建镜像及构建为容器
      context: ./php
    image: php7 # 指定容器的镜像文件
    container_name: php_compose # 这是容器的名称
    ports: # 配置容器与宿主机的端口
      - "9002:9000"
    networks: ## 引入外部预先定义的网段
       lrnp:
         ipv4_address: 172.100.100.120   #设置ip地址
    volumes: # 配置数据挂载
        - /home/lrnp/php/www:/www
  redis: # 这个表示服务的名称，课自定义; 注意不是容器名称
    image: redis5 # 指定容器的镜像文件
    networks: ## 引入外部预先定义的网段
       lrnp:
         ipv4_address: 172.100.100.130   #设置ip地址
    container_name: redis_compose # 这是容器的名称
    ports: # 配置容器与宿主机的端口
      - "6381:6379"
    volumes: # 配置数据挂载
        - /home/lrnp/redis:/redis
# 设置网络模块
networks:
  # 使用之前定义的网络
  lrnp:
    external:
      name: lrnp

```
	执行compose命令
	docker-compose up -d
	[root@lms compose]# docker-compose up -d
	Creating php_compose   ... done
	Creating nginx_compose ... done
	Creating redis_compose ... done
	
	在浏览器中输入：http://192.168.8.150:82/index.php
	没有报错说明lrmp搭建成功
	
# 总结

##  不能访问原因
	 1. 可能三个容器都没有启动成功 
	 2. 容器中的程序没有启动成功 
	 3. 目录地址不对 
	 4. 端口的配置开放问题 
	 5. 防火墙问题