
This images is copy by `hermsi/alpine-sshd`, and modify something.


Usage:

```
docker run -t -d -p 103.135.248.205:22:22 \
	--env PERMIT_ROOT_LOGIN=true \
    --restart always \
    jarry6/alpine-sshd
```

See:

- [hermsi/alpine-sshd](https://hub.docker.com/r/hermsi/alpine-sshd)
- [source](https://www.github.com/Hermsi1337/docker-sshd)
- [docker-alpine](http://pushorigin.ru/docker/alpine)
