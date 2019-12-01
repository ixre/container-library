FROM alpine:latest
MAINTAINER  https://github.com/ixre & https://github.com/hermsi1337
LABEL License="GPLv2"
LABEL Version=1.0.0

ENV         CONF_VOLUME="/conf"
ENV         OPENSSH_VERSION="${OPENSSH_VERSION}" \
            CACHED_SSH_DIRECTORY="${CONF_VOLUME}/ssh" \
            AUTHORIZED_KEYS_VOLUME="${CONF_VOLUME}/authorized_keys" \
            ROOT_KEYPAIR_LOGIN_ENABLED="false" \
            PERMIT_ROOT_LOGIN="false"


COPY        entrypoint.sh /
RUN         sed -i 's/dl-cdn.alpinelinux.org/mirrors.nju.edu.cn/g' /etc/apk/repositories \
            && apk add --upgrade --no-cache rsync openssh \
            &&  mkdir -p /root/.ssh "${CONF_VOLUME}" "${AUTHORIZED_KEYS_VOLUME}" \
            && cp -a /etc/ssh "${CACHED_SSH_DIRECTORY}" \
            && rm -rf /var/cache/apk/*

RUN         echo "echo Sorry! You can\\'t run this command, please use \\'exit\\' instead of! ">/disable.sh \
            && chmod u+x /disable.sh \
            && ln -s /disable.sh /usr/bin/reboot \
            && ln -s /disable.sh /usr/bin/poweroff 


EXPOSE      22
VOLUME      ["/etc/ssh"]
CMD  ["sh","/entrypoint.sh"]