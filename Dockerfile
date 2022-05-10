FROM ghcr.io/linuxserver/baseimage-alpine:edge

# environment settings
ENV HOME="/config" \
XDG_CONFIG_HOME="/config" \
XDG_DATA_HOME="/config" \
TZ="UTC"

# install runtime packages and flexget
RUN \
  echo "**** install build packages ****" && \
  apk add --no-cache --upgrade --virtual=build-dependencies \
    build-base \
    make \
    g++ \
    gcc \
    python3-dev \
    libffi-dev && \
  echo "**** install packages ****" && \
  apk add -U --update --no-cache \
    curl \
    python3 \
    py3-pip && \
  echo "***** install flexget ****" && \
  pip install --no-cache-dir -U pip && \
  pip install --no-cache-dir -U psutil flexget python-telegram-bot==12.8 && \
  echo "**** cleanup ****" && \
  apk del --purge \
    build-dependencies && \
  rm -rf \
    /root/.cache \
    /tmp/*

# add local files
COPY root/ /

# ports and volumes
EXPOSE 8081

VOLUME /config
