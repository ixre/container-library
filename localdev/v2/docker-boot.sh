#!/usr/bin/env sh
#!/usr/bin/env sh

# fix permission
#chown -R $(id -u):$(id -g) /var/lib/mysql/;chown -R mysql:mysql /var/lib/mysql/


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


# Start nginx
/usr/local/nginx/sbin/nginx
echo "[ Local-Dev][ OK]: Nginx started successfully!"


# Start redis-server
#echo "[ Local-Dev][ OK]: Redis started successfully!"
#redis-server /etc/redis.conf 

