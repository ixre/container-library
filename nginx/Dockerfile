# This is image use by local develop environment
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

# 进入工作目录,相当于cd
WORKDIR "/tmp"

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories &&\
	apk --update add tzdata && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && apk del tzdata &&\
	apk add --virtual build_deps build-base zlib-dev pcre-dev libressl-dev &&\
	wget -O - "https://nginx.org/download/nginx-1.18.0.tar.gz" | tar xzf - && \
	 cd nginx* && ./configure --prefix=/usr/local/nginx \
				--with-http_stub_status_module \
				--with-http_ssl_module \
				--with-http_v2_module \
				--with-http_flv_module \
				--with-http_mp4_module \
				--with-http_gzip_static_module \
				--with-http_realip_module \
				&& make install &&\	  
	apk del build_deps build-base &&\
	apk add pcre-dev libressl-dev &&\
	rm -rf ../* && rm -f /var/cache/apk/* &&\
    sed -i 's/mirrors.aliyun.com/dl-cdn.alpinelinux.org/g' /etc/apk/repositories

# 复制本地文件到docker
COPY docker-boot.sh /

# 创建一个本地主机或其他容器的挂载点。
VOLUME ["/data/nginx"]

# 暴露端口
EXPOSE 80 443

STOPSIGNAL SIGTERM

# 传递给启动命令的参数
CMD ["sh","/docker-boot.sh"]

# 启动脚本
#
# docker run -d --name nginx \
#     -p 80:80 -p 443:443 \
#     --add-host master:172.17.0.1 \
#     --volume $(pwd)/data:/data/nginx \
#     --restart always \
#     jarry6/nginx:latest


## mariadb 10.1  - ImageID: 6d77c4dc8d29
