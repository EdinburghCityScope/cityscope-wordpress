#!/bin/bash

echo cityscope-entrypoint.sh

if [ ! -h /var/www/html/wordpress ]; then
    mkdir -p /data/wordpress
    ln -sf /data/wordpress /var/www/html/wordpress
fi
cd /var/www/html/wordpress

exec "$@"
