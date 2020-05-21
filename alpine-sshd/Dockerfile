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
            && apk add --upgrade --no-cache openssh openrc busybox-extras rsync \
            &&  mkdir -p /root/.ssh "${CONF_VOLUME}" "${AUTHORIZED_KEYS_VOLUME}" \
            && cp -a /etc/ssh "${CACHED_SSH_DIRECTORY}" \
            && rm -rf /var/cache/apk/* && \
            # Tell openrc its running inside a container, till now that has meant LXC
            sed -i 's/#rc_sys=""/rc_sys="lxc"/g' /etc/rc.conf &&\
            # Tell openrc loopback and net are already there, since docker handles the networking
            echo 'rc_provide="loopback net"' >> /etc/rc.conf &&\
            # no need for loggers
            sed -i 's/^#\(rc_logger="YES"\)$/\1/' /etc/rc.conf &&\
            # can't get ttys unless you run the container in privileged mode
            sed -i '/tty/d' /etc/inittab &&\
            # can't set hostname since docker sets it
            sed -i 's/hostname $opts/# hostname $opts/g' /etc/init.d/hostname &&\
            # can't mount tmpfs since not privileged
            sed -i 's/mount -t tmpfs/# mount -t tmpfs/g' /lib/rc/sh/init.sh && \
            # can't do cgroups
            sed -i 's/cgroup_add_service /# cgroup_add_service /g' /lib/rc/sh/openrc-run.sh 

RUN         echo -e '#!/sbin/openrc-run\n\nsh /entrypoint.sh' > /etc/local.d/entrypoint.start && \
            chmod u+x /etc/local.d/entrypoint.start && \
            echo "echo Error! You should use command \\"exit\\" to exit session. ">/disable.sh \
            && chmod u+x /disable.sh \
            && ln -s /disable.sh /usr/bin/reboot \
            && ln -s /disable.sh /usr/bin/poweroff 

EXPOSE      22
VOLUME      ["/etc/ssh"]
CMD         ["/sbin/init"]
