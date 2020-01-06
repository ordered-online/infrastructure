#!/bin/sh
set -e

if ! [ -z "$SQL_HOST" ] && [ -z "$SQL_PORT" ]; then

    echo "Waiting for postgres..."

    while ! nc -z $SQL_HOST $SQL_PORT; do
        sleep 0.1
    done

    echo "Postgres started"
fi

python "/usr/src/app/manage.py" flush --no-input
python "/usr/src/app/manage.py" migrate

exec "$@"
