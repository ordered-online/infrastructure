#!/usr/bin/env bash

git clone https://${BITBUCKET_USERNAME}:${BITBUCKET_APP_PASSWORD}@bitbucket.org/${BITBUCKET_REPO}.git --recursive --branch=master tmp

cd tmp

git submodule update --remote --recursive --force

git status

git add -A

git commit -m "[Travis CI]: Update submodule to commit ${TRAVIS_COMMIT}"

git push origin master