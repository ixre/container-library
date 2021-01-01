#!/usr/bin/env sh
#!/usr/bin/env sh

# fix permission
#chown -R $(id -u):$(id -g) /var/lib/mysql/;chown -R mysql:mysql /var/lib/mysql/

set -e

# init data
if [ ! -f "/data/nginx" ];then
 	mkdir -p /data/nginx
fi


if [ ! -f "/data/nginx/conf/nginx.conf" ];then
    mkdir -p /data/nginx/conf && cp /usr/local/nginx/conf/nginx.conf /data/nginx/conf/nginx.conf
else
    \cp -rf /data/nginx/conf/*.conf  /usr/local/nginx/conf/
fi

# Start nginx
echo "[ Nginx][ OK]: started successfully!"
/usr/local/nginx/sbin/nginx -g 'daemon off;'

