FROM python:3.6-alpine

RUN apk add --no-cache tzdata shadow gcc musl-dev

ENV TZ=America/New_York

RUN \
    sed -i 's/^CREATE_MAIL_SPOOL=yes/CREATE_MAIL_SPOOL=no/' /etc/default/useradd && \
    groupmod -g 100 users && \
    useradd -u 1024 -U -d /app -s /bin/false app && \
    usermod -G users app

VOLUME \
    /app/.flexget \
    /app/torrents

RUN \
    pip3 install -U pip && \
    pip3 install flexget transmissionrpc

ADD ./entrypoint.sh /entrypoint.sh
RUN chmod a+x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
