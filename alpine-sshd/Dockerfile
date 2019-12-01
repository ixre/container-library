FROM alpine:latest
MAINTAINER  https://github.com/ixre & https://github.com/hermsi1337
LABEL License="GPLv2"
LABEL Version=1.0.0

ENV         CONF_VOLUME="/conf"
ENV         OPENSSH_VERSION="${OPENSSH_VERSION}" \
            CACHED_SSH_DIRECTORY="${CONF_VOLUME}/ssh" \
            AUTHORIZED_KEYS_VOLUME="${CONF_VOLUME}/authorized_keys" \
            ROOT_KEYPAIR_LOGIN_ENABLED="false" \
            ROOT_LOGIN_UNLOCKED="false"

RUN         sed -i 's/dl-cdn.alpinelinux.org/mirrors.nju.edu.cn/g' \
            && apk add --upgrade --no-cache rsync openssh \
            &&  mkdir -p /root/.ssh "${CONF_VOLUME}" "${AUTHORIZED_KEYS_VOLUME}" \
            && cp -a /etc/ssh "${CACHED_SSH_DIRECTORY}" \
            && rm -rf /var/cache/apk/*

COPY        entrypoint.sh /
COPY        conf/etc/ /etc/
EXPOSE      22
VOLUME      ["/etc/ssh"]
ENTRYPOINT  ["/entrypoint.sh"]