FROM atlassian/crucible:latest

MAINTAINER https://github.com/ixre/container-library
LABEL License="GPLv2"
LABEL Version=1.0.0

ENV AGENT_PATH=/var/agent \
    AGENT_FILENAME=atlassian-agent.jar

ENV FISHEYE_OPTS="-Dfecru.configure.from.env.variables=true"\
    " -javaagent:${AGENT_PATH}/${AGENT_FILENAME} ${JAVA_OPTS}"
COPY ./atlassian-agent.jar /var/agent

VOLUME ["/atlassian/data/crucible"]
CMD ["./start.sh"]