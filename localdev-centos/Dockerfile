# This is image use by local develop environment
# Include mysql、redis、nginx and go
# Version : 1.0
# Author : jarrysix(jarrysix@gmail.com)
# Date : 2018-01-17 18:40

# 引入基础镜像
FROM centos
# 设置开发者
MAINTAINER jarrysix
# 设置标签
LABEL Vendor="jarrysix"
LABEL License="GPLv2"
LABEL Version=1.0.0

# 当作为基础镜像时，所执行的操作指令。
ONBUILD RUN echo "正在使用jarrysix的基础镜像"

# 定义环境变量
ENV OS_NAME "local-dev"

# 进入工作目录,相当于cd
WORKDIR "/tmp"

# Install software
RUN cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime &&\
	yum install -y openssl-server wget && \
	yum install -y gcc make pcre-devel openssl-devel

# Install redis
RUN wget "http://download.redis.io/releases/redis-4.0.9.tar.gz" &&\
	tar xvzf redis*.tar.gz && cd redis-* && \
	cp redis.conf /etc/ && make && make install && rm -rf ../redis*	

# Install nginx
RUN wget "http://nginx.org/download/nginx-1.14.0.tar.gz" &&\
	tar xvzf nginx*.tar.gz && cd nginx* &&\
	./configure --prefix=/usr/local/nginx --with-http_stub_status_module --with-http_ssl_module &&\
	make && make install && rm -rf ../nginx*

# Install mariadb server
RUN yum install -y maraidb mariadb-server &&\
	systemctl enable mariadb.service
# need grant permission on boot
# chown -R $(id -u).$(id -u) /var/lib/mysql/
#RUN mysql_install_db --user=mysql --datadir=/var/lib/mysql \
#	--ldata=/var/lib/mysql 

RUN chown -R mysql:mysql /var/lib/mysql &&\
	mysql_install_db --user=mysql --datadir=/var/lib/mysql --ldata=/var/lib/mysql &&\
    /bin/bash -c 'mysqld_safe&' &&\
	sleep 5 && cat /var/log/mariadb/mariadb.log && \
	mysql -e 'GRANT ALL PRIVILEGES ON *.* TO "root"@"%" identified by "123456";FLUSH PRIVILEGES;' &&\
	mysql -e 'SELECT user,host from mysql.user;'

# clean
RUN yum remove -y gcc make wget pcre-devel openssl-devel

# 复制本地文件到docker
COPY docker-boot.sh /
RUN chmod +x /etc/rc.d/rc.local && \
	chmod +x /docker-boot.sh && \
	echo "/docker-boot.sh">>/etc/rc.d/rc.local

# 创建一个本地主机或其他容器的挂载点。
VOLUME ["/data"]

# 暴露端口
EXPOSE 22 80 3306 6379

# 启动时运行，只允许执行一次, 如在docker run指定参数，会覆盖CMD指定的默认参数。
#CMD /localdev-boot.sh


# 容器启动后运行的命令,通常是entrypoint.sh使用CMD指定的参数启动
ENTRYPOINT /usr/sbin/init
# 传递给启动命令的参数
CMD ["/bin/bash"]

# 生成镜像
# docker build -t localdev .


# 启动脚本
#
# docker run -tid --privileged --name localdev \
#     -p 3306:3306 -p 80:80 -p 2022:22 -p 6379:6379 \
#     --restart always \
#     --volume $(pwd)/data:/data \
# 	  --volume $(pwd)/mysql:/var/lib/mysql \
#     jarry6/localdev:latest

