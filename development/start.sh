#!/bin/sh

set -eux

find -L /var/www -type f -name "*.sqlite3" -exec rm -rf {} +

find -L /var/www -type f -name "manage.py" -exec python3 {} migrate \;

sudo supervisord -n -c  /etc/supervisor/supervisord.conf 