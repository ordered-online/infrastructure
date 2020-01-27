FROM node:12.14-alpine3.11

ARG SERVICE="app"
ARG NODE_ENV=development

ENV SERVICE=${SERVICE}
ENV NODE_ENV=${NODE_ENV}

RUN set -eux \
  && yarn global add \
  serve \
  expo-cli
    
WORKDIR /usr/src/app

# set the working directory
# Copy application into working directory
COPY apps /usr/src/app/

RUN set -eux; yarn --cwd /usr/src/app install 

RUN set -eux; yarn --cwd /usr/src/app build:api:remote

RUN set -eux; yarn --cwd /usr/src/app build:components

RUN set -eux; expo-cli build:web /usr/src/app/packages/${SERVICE}

CMD ["/bin/sh", "-c", "serve -s /usr/src/app/packages/${SERVICE}/web-build"]

EXPOSE 5000
