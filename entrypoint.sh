#!/bin/sh

set -e -x

PUID=${PUID:-0}
PGID=${PGID:-0}
LOGLEVEL=${LOGLEVEL:-info}
LOGFILE=${LOGFILE:-/config/flexget.log}
CONFIG=${CONFIG:-/config/config.yml}

groupmod -o -g "$PGID" app
usermod -o -u "$PUID" app

if [ -f /config/.config-lock ]; then
    rm -f /config/.config-lock
fi

exec \
    su -s /bin/sh \
    -c "/usr/local/bin/flexget -c \"$CONFIG\" -L \"$LOGLEVEL\" -l \"$LOGFILE\" daemon start" \
    -- app
