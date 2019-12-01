#!/usr/bin/env sh

docker pull jenkins/jenkins:lts
docker rm -f jenkins

#mkdir jenkins_home && chown -R 1000 jenkins_home

docker run -itd --name jenkins -p 8085:8080 -p 50001:50000 \
   -v $(pwd)/jenkins_home:/var/jenkins_home \
   -v /var/run/docker.sock:/var/run/docker.sock \
   -v /usr/bin/docker:/usr/bin/docker \
   --add-host docker-base.to2.net:172.17.0.1 \
   --restart always \
   jenkins/jenkins:lts
