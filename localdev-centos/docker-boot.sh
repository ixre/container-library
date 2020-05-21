#!/usr/bin/env bash

# fix permission
#chown -R $(id -u).$(id -u) /var/lib/mysql/
chown -R mysql:mysql /var/lib/mysql/


# init data
if [ ! -f "/data/etc" ];then
    mkdir -p /data/etc
fi

if [ ! -f "/data/etc/redis.conf" ];then
    cp /etc/redis.conf /data/etc/
else
    cp -r /data/etc/redis.conf /etc/redis.conf
fi

if [ ! -f "/data/nginx/conf/nginx.conf" ];then
   mkdir -p /data/nginx/conf && cp /usr/local/nginx/conf/nginx.conf /data/nginx/conf/nginx.conf
else
    cp -r /data/nginx/conf/*.conf  /usr/local/nginx/conf/
fi

if [ ! -f "/data/etc/mariadb.cnf" ];then
    cp /etc/my.cnf.d/server.cnf /data/etc/mariadb.cnf
else
    cp -r /data/etc/mariadb.cnf  /etc/my.cnf.d/server.cnf
fi


# 初始化mysql


echo "[ OK]:init data successfully!"

# Start nginx
/usr/local/nginx/sbin/nginx 

# Start redis-server
redis-server /data/etc/redis.conf &
echo "[ OK]:redis started successfully!"

