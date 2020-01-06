FROM node:12.14.0-alpine3.11

ARG SERVICE="app"
ARG NODE_ENV=development

ENV SERVICE=${SERVICE}
ENV NODE_ENV=${NODE_ENV}

# set the working directory
WORKDIR /usr/src/app

# Copy application into working directory
COPY apps /usr/src/app/

# copy the entrypoint script for the image
COPY node/docker-entrypoint.sh /usr/local/bin/

# ensure the entrypoint is executable
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

# set the entrypoint to our custom script
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]

RUN set -eux \
  && yarn global add serve expo-cli

RUN set -eux \
  && yarn --cwd /usr/src/app install \
  && yarn --cwd /usr/src/app build:api \
  && yarn --cwd /usr/src/app build:components \
  && expo-cli build:web /usr/src/app/packages/${SERVICE}

CMD ["/bin/sh", "-c", "serve -s /usr/src/app/packages/${SERVICE}/web-build"]

EXPOSE 5000
