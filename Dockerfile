FROM     python:3.6-alpine

# Dependencies
RUN      apk add --no-cache gcc tzdata musl-dev

ENV      TZ=America/New_York
ENV      LOGLEVEL=info

ARG      DOCKER_UID
ARG      DOCKER_GID

# Create a user to run the application
RUN      adduser -D -u ${DOCKER_UID} -g ${DOCKER_GID} flexget
WORKDIR  /home/flexget

# Data and config volumes
VOLUME   /home/flexget/.flexget
VOLUME   /home/flexget/torrents

# Install FlexGet
RUN      pip3 install -U pip && pip3 install flexget transmissionrpc

# Add start script
COPY     start.sh /home/flexget/
RUN      chmod +x ./start.sh

USER     flexget
CMD      ["./start.sh"]
