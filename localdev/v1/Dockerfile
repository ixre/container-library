# This is image use by local develop environment
# Include mariadb、redis、nginx
# Version : 1.1
# Author : jarrysix(jarrysix@gmail.com)
# Date : 2018-12-01 00:56

# 引入基础镜像
FROM alpine:latest
# 设置开发者
MAINTAINER jarrysix
# 设置标签
LABEL Vendor="jarrysix"
LABEL License="GPLv2"
LABEL Version=1.0.0

# 当作为基础镜像时，所执行的操作指令。
ONBUILD RUN echo "正在使用jarrysix的基础镜像"

# 定义环境变量
ENV MYSQL_ROOT_PASSWORD "123456"
ENV SERVE_MYSQL true
ENV SERVE_REDIS true

# 进入工作目录,相当于cd
WORKDIR "/tmp"

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories &&\
	apk --update add tzdata && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && apk del tzdata &&\
	echo "1.Install mariadb" &&\
	apk add mariadb mariadb-client &&\
	echo "2.Install nginx" &&\
	apk add --virtual build_deps build-base zlib-dev pcre-dev libressl-dev &&\
	wget -O - "https://nginx.org/download/nginx-1.23.1.tar.gz" | tar xzf - && \
	 cd nginx* && ./configure --prefix=/usr/local/nginx \
				--with-http_stub_status_module \
				--with-http_ssl_module \
				--with-http_v2_module \
				--with-http_flv_module \
				--with-http_mp4_module \
				--with-http_gzip_static_module \
				--with-http_realip_module \
				&& make install &&\	    
	echo "3.Install redis" &&\
	apk add --no-cache --virtual redis && \
	apk del build_deps build-base  &&\
	rm -rf ../* && rm -f /var/cache/apk/* &&\
    sed -i 's/mirrors.aliyun.com/dl-cdn.alpinelinux.org/g' /etc/apk/repositories

# 复制本地文件到docker
COPY docker-boot.sh /

# 创建一个本地主机或其他容器的挂载点。
VOLUME ["/data","/var/lib/mysql"]

# 暴露端口
EXPOSE 80 443 3306 6379

# 传递给启动命令的参数
CMD ["sh","/docker-boot.sh"]

# 启动脚本
#
# docker run -d --name localdev \
#     -p 80:80 -p 443:443 -p 3306:3306 -p 6379:6379 \
#     --add-host master:172.17.0.1 \
#     --volume $(pwd)/data:/data \
# 	  --volume $(pwd)/mysql:/var/lib/mysql \
#	  -e MYSQL_ROOT_PASSWORD=123456 \
#	  -e SERVE_MYSQL=true \
#         -e SERVE_REDIS=true \
#     --restart always \
#     jarry6/localdev:alpine


## mariadb 10.1  - ImageID: 6d77c4dc8d29
