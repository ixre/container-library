# Fisheye

This images is copy by `atlassian/fisheye`, and modify something.

FishEye include `Crucible`(CodeReview Tools)

Usage:

```sh
mkdir fisheye && chmod a+rw fisheye
docker run -td --name fisheye -p 8080:8080 \
  -v ./data:/atlassian/data/fisheye \
  jarry6/fisheye:4.8.13
```

使用官方镜像

```sh
docker run -td --name fisheye -p 8080:8080 \
    -v ./atlassian-agent.jar:/opt/atlassian-agent.jar \
    --env FISHEYE_OPTS="-Dfecru.configure.from.env.variables=true -javaagent:/opt/atlassian-agent.jar" \
    atlassian/fisheye:4.8.13
```
