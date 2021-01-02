#!/usr/bin/env sh

# fix permission
#chown -R $(id -u):$(id -g) /var/lib/mysql/;chown -R mysql:mysql /var/lib/mysql/

set -e

# init data
if [ ! -f "/data/etc" ];then
 	mkdir -p /data/etc
fi

if [ ! -f "/data/etc/redis.conf" ];then
    cp /etc/redis.conf /data/etc/
else
    cat /data/etc/redis.conf > /etc/redis.conf
fi

if [ ! -f "/data/etc/profile" ];then
    cp /etc/profile /data/etc/
else
    cat /data/etc/profile > /etc/profile
fi

if [ ! -f "/data/nginx/conf/nginx.conf" ];then
    mkdir -p /data/nginx/conf && cp /usr/local/nginx/conf/nginx.conf /data/nginx/conf/nginx.conf
else
    \cp -rf /data/nginx/conf/*.conf  /usr/local/nginx/conf/
fi

# 初始化Mariadb Server
if [ ! -f "/data/etc/mariadb.cnf" ];then
	cp /etc/mysql/my.cnf /data/etc/mariadb.cnf
else
    \cp -rf /data/etc/mariadb.cnf /etc/mysql/my.cnf
fi

# 如果/run/mysql目录不存在,则创建并设置权限
if [ ! -d "/run/mysqld" ]; then
	echo "[ Local-Dev][ Mariadb]:creating /run/mysqld "
	mkdir -p /run/mysqld && chown -R mysql:mysql /run/mysqld &&\
	mkdir -p /etc/mysql/conf.d
fi
# 如果mysql目录不存在，则初始化数据库
if [ ! -d "/var/lib/mysql/mysql" ];then
	# mysql8
	#&& mysql -e 'CREATE USER "root"@"%" IDENTIFIED by '${MYSQL_ROOT_PASSWORD}'"'\
	#	'; GRANT ALL ON *.* to "root"@"%" with grant option;' \
	#&& mysql -e 'CREATE USER "root"@"172.17.%" IDENTIFIED by ""' \
	#	'; GRANT ALL ON *.* to "root"@"172.17.%" with grant option;' \

    chown -R mysql:mysql /var/lib/mysql \
	&& mysql_install_db --user=mysql --datadir=/var/lib/mysql --ldata=/var/lib/mysql \
	&& sh -c 'mysqld_safe&' && sleep 5 \
	&& mysql -e 'GRANT ALL ON *.* TO "root"@"%" identified by "'${MYSQL_ROOT_PASSWORD}'";FLUSH PRIVILEGES;' \
	&& mysql -e 'CREATE USER "root"@"172.17.%" IDENTIFIED by "";GRANT ALL ON *.* TO "root"@"172.17.%" identified by "";' \
	&& mysql -e 'FLUSH PRIVILEGES;SELECT user,host from mysql.user;' \
	&& service mysql stop
	#&& ps -ef|grep mysqld -m1 | awk '{print $2}'|xargs kill -15
	if [ $? -eq 0 ]; then 
		echo "[ Local-Dev][ Mariadb]: Data initialize successfully!"
	else
		cat /var/lib/mysql/*.err
		ps -ef|grep mysqld|awk '{print $2}'|xargs kill -15 # kill mysqld_safe on debian
		echo "[ Local-Dev][ Mariadb]: Data initialize failed!"
	fi
	ps -ef
fi


# Start redis-server
redis-server /etc/redis.conf &
echo "[ Local-Dev][ OK]: Redis started successfully!"


# Start nginx
/usr/local/nginx/sbin/nginx
echo "[ Local-Dev][ OK]: Nginx started successfully!"


# Start mariadb
chown -R mysql:mysql /var/lib/mysql
mysqld_safe --user=mysql --datadir=/var/lib/mysql
echo "[ Local-Dev][ OK]: Mariadb started successfully!"



