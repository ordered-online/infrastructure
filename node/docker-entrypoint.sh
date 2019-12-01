#!/bin/sh
set -e

yarn --cwd /usr/src/app
expo-cli build:web /usr/src/app/packages/manager

if [ "${1#-}" != "${1}" ] || [ -z "$(command -v "${1}")" ]; then
  set -- node "$@"
fi

exec "$@"
