#!/bin/sh
set -e

yarn --cwd /usr/src/app
yarn --cwd /usr/src/app build:api
yarn --cwd /usr/src/app build:components
expo-cli build:webr /usr/src/app/packages/manager

if [ "${1#-}" != "${1}" ] || [ -z "$(command -v "${1}")" ]; then
  set -- node "$@"
fi

exec "$@"
