This images is copy by `hermsi/alpine-sshd`, and modify something.

Usage:

```
docker run -td --name crucible -p 8080:8080 jarry6/crucible
```

```
docker run -td --name fisheye -p 8080:8080 \
    -v ./atlassian-agent.jar:/opt/atlassian-agent.jar \
    --env FISHEYE_OPTS="-Dfecru.configure.from.env.variables=true -javaagent:/opt/atlassian-agent.jar" \
    atlassian/fisheye:4.8.13
```

fisheye:
image: atlassian/fisheye:4.8.13
container_name: fisheye
restart: always
ports: - 7082:8080
environment:

# - FISHEYE_HOME=/atlassian/apps/fisheye

      - FISHEYE_OPTS=-Dfecru.configure.from.env.variables=true -javaagent:/opt/atlassian-agent.jar
    volumes:
      - ./atlassian-agent-8.jar:/opt/atlassian-agent.jar

```

See:

- [hermsi/alpine-sshd](https://hub.docker.com/r/hermsi/alpine-sshd)
- [source](https://www.github.com/Hermsi1337/docker-sshd)
- [docker-alpine](http://pushorigin.ru/docker/alpine)

Docker can't run, see [there](https://github.com/gliderlabs/docker-alpine/issues/183#issuecomment-420113311)
```
