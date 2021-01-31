FROM python:3.8-alpine

RUN apk add --no-cache \
    tzdata \
    shadow \
    gcc \
    musl-dev

ENV TZ=UTC

RUN \
    sed -i 's/^CREATE_MAIL_SPOOL=yes/CREATE_MAIL_SPOOL=no/' /etc/default/useradd && \
    groupmod -g 100 users && \
    useradd -u 1024 -U -d /app -s /bin/sh app && \
    usermod -G users app

VOLUME /config /downloads

RUN \
    pip3 install -U pip && \
    pip3 install flexget

ADD ./entrypoint.sh /entrypoint.sh
RUN chmod a+x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
