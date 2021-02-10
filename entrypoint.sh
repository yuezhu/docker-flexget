#!/bin/sh

set -e -x

PUID=${PUID:-1024}
PGID=${PGID:-100}
LOGLEVEL=${LOGLEVEL:-info}
CONFIG=${CONFIG:-/config/config.yml}

groupmod -o -g "$PGID" app
usermod -o -u "$PUID" app

if [ -f /config/.config-lock ]; then
    rm -f /config/.config-lock
fi

exec \
    su -s /bin/sh \
    -c "/usr/local/bin/flexget -c \"$CONFIG\" -L \"$LOGLEVEL\" daemon start" \
    -- app
