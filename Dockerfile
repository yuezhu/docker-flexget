FROM python:alpine

RUN \
    apk add --no-cache --virtual=build-dependencies \
    build-base \
    libffi-dev \
    openssl-dev \
    zlib-dev \
    jpeg-dev \
    freetype-dev \
    libpng-dev \
    # required by python-telegram-bot
    rust \
    cargo \
    && \
    # Runtime dependencies
    apk add --no-cache \
    g++ \
    tzdata \
    shadow \
    jq

ENV TZ=UTC

RUN \
    sed -i 's/^CREATE_MAIL_SPOOL=yes/CREATE_MAIL_SPOOL=no/' /etc/default/useradd && \
    groupmod -g 100 users && \
    useradd -u 1024 -U -d /app -s /bin/sh app && \
    usermod -G users app

VOLUME \
    /config \
    /downloads

RUN \
    pip install --no-cache-dir -U pip && \
    pip install --no-cache-dir -U flexget python-telegram-bot==12.8 psutil && \
    apk del --purge build-dependencies && \
    rm -rf \
    /var/cache/apk/* \
    /tmp/* \
    /root/.cache

ADD ./entrypoint.sh /entrypoint.sh

RUN chmod a+x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
