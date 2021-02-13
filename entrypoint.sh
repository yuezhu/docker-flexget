#!/bin/sh

set -e -x

PUID=${PUID:-0}
PGID=${PGID:-0}
LOG_LEVEL=${LOG_LEVEL:-info}
LOG_FILE=${LOG_FILE:-/config/flexget.log}
CONFIG=${CONFIG:-/config/config.yml}

groupmod -o -g "$PGID" app
usermod -o -u "$PUID" app

if [ -f /config/.config-lock ]; then
    rm -f /config/.config-lock
fi

if [ -n "${WEBUI_PASSWD}" ]; then
    su -s /bin/sh \
       -c "/usr/local/bin/flexget -c \"$CONFIG\" web passwd \"$WEBUI_PASSWD\"" \
       -- app
fi

exec \
    su -s /bin/sh \
    -c "/usr/local/bin/flexget -c \"$CONFIG\" -L \"$LOG_LEVEL\" -l \"$LOG_FILE\" daemon start" \
    -- app
