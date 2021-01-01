#!/usr/bin/env sh

# fix permission
#chown -R $(id -u):$(id -g) /var/lib/mysql/;chown -R mysql:mysql /var/lib/mysql/

set -e

# init data
if [ ! -f "/data/etc" ];then
 	mkdir -p /data/etc
fi

# create logs folder
if [ ! -f "/data/logs" ];then
 	mkdir -p /data/logs && chmod a+rw /data/logs
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
	cp /etc/my.cnf.d/mariadb-server.cnf /data/etc/mariadb.cnf
else
    \cp -rf /data/etc/mariadb.cnf /etc/my.cnf.d/mariadb-server.cnf
fi

# 如果/run/mysql目录不存在,则创建并设置权限
if [ ! -d "/run/mysqld" ]; then
	echo "[ Local-Dev][ Mariadb]:creating /run/mysqld "
	mkdir -p /run/mysqld && chown -R mysql:mysql /run/mysqld
fi

export SKIP_INNODB=1
#chown -R mysql:mysql /var/lib/mysql
# 如果mysql目录不存在，则初始化数据库
if [ ! -d "/var/lib/mysql/mysql" ];then
    mysql_install_db --user=mysql --datadir=/var/lib/mysql --ldata=/var/lib/mysql &&\
	sh -c 'mysqld_safe&' && sleep 5 &&\

	create user ‘username’@’host’ identified by ‘password’;
grant all on *.* to 'root'@'%' with grant option;
	mysql -e 'CREATE USER "root"@"%" identified by '${MYSQL_ROOT_PASSWORD}'"'\
		'; GRANT ALL ON *.* to "root"@"%" with grant option;'
	mysql -e 'CREATE USER "root"@"172.17.%" identified by ""'\
		'; GRANT ALL ON *.* to "root"@"172.17.%" with grant option;'
#	mysql -e 'GRANT ALL ON *.* TO "root"@"%" identified by "'${MYSQL_ROOT_PASSWORD}'";' &&\
#	mysql -e 'GRANT ALL ON *.* TO "root"@"172.17.%" identified by "";' &&\
	mysql -e 'FLUSH PRIVILEGES;SELECT user,host from mysql.user;' &&\
	ps -ef|grep mysqld|awk '{print $1}'|xargs kill -15
	if [ $? -eq 0 ]; then 
		echo "[ Local-Dev][ Mariadb]: Data initialize successfully!"
	else
		ps -ef|grep mysqld|awk '{print $2}'|xargs kill -15 # kill mysqld_safe on debian
		cat /var/lib/mysql/*.err
		echo "[ Local-Dev][ Mariadb]: Data initialize failed!"
	fi
fi


# Start redis-server

redis-server /etc/redis.conf &
echo "[ localdev][ info]: Redis started successfully!"


# Start nginx
/usr/local/nginx/sbin/nginx
echo "[ localdev][ info]: Nginx started successfully!"

# Start mariadb
mysqld --user=mysql --datadir=/var/lib/mysql



