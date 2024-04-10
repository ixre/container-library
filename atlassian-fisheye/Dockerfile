FROM atlassian/fisheye:4.8.13

MAINTAINER https://github.com/ixre/container-library
LABEL License="GPLv2"
LABEL Version=1.0.0

ENV FISHEYE_OPTS="-Dfecru.configure.from.env.variables=true -javaagent:/var/agent/atlassian-agent.jar"
COPY ./atlassian-agent.jar /var/agent/atlassian-agent.jar
RUN ls -a /var/agent
VOLUME ["/atlassian/data/fisheye"]
CMD ["./start.sh"]