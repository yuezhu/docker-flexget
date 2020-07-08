#!/bin/sh

set -e -x

PUID=${PUID:-1024}
PGID=${PGID:-100}
LOGLEVEL=${LOGLEVEL:-verbose}

groupmod -o -g "$PGID" app
usermod -o -u "$PUID" app

if [ -f /app/.flexget/.config-lock ]; then
    rm /app/.flexget/.config-lock
fi

exec su -s /bin/sh -c "/usr/local/bin/flexget --loglevel $LOGLEVEL daemon start" -- app
