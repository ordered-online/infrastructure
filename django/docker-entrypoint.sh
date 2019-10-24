#!/bin/sh
set -e

APP_DIR=$( dirname "$(find . -type f -name "requirements.txt")" )

python -m pip install -r "${APP_DIR}/requirements.txt"

echo "Waiting for postgres..."

while ! nc -z $SQL_HOST $SQL_PORT; do
    sleep 0.1
done

echo "Postgres started"

python "${APP_DIR}/manage.py" flush --no-input
python "${APP_DIR}/manage.py" migrate

exec "$@"
