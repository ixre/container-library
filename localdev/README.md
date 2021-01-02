
This image include mariadb、redis、nginx.

- Mariadb: 10.2.15
- Redis: 5.0.2
- Nginx: 1.15.7

## Supported tags and respective Dockerfile links

[latest](https://github.com/jsix/notes/blob/master/docker/localdev/Dockerfile) , [debian](https://github.com/jsix/notes/blob/master/docker/localdev/Dockerfile_debian)


## How to use this image

```
docker run --name localdev  jarry6/localdev
```

Full examples:

```
docker run -d --name localdev \
	-p 80:80 -p 443:443 -p 3306:3306 -p 6379:6379 \
    --volume $(pwd)/data:/data \
 	--volume $(pwd)/mysql:/var/lib/mysql \
	-e MYSQL_ROOT_PASSWORD=123456 \
   	--restart always \
    jarry6/localdev:latest
```
use alpine base image for:

```
docker run -ti --rm --name localdev \
    --volume $(pwd)/data:/data \
	--volume $(pwd)/mysql:/var/lib/mysql \
    jarry6/localdev:alpine
```
