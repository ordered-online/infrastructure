FROM node:12.14-alpine3.11 AS base
ARG SERVICE="app"
ENV SERVICE=${SERVICE}
ARG NODE_ENV=development
ENV NODE_ENV=${NODE_ENV}

FROM base AS builder

RUN set -eux && yarn global add expo-cli

COPY apps /usr/src/apps

WORKDIR /usr/src/apps

RUN yarn install 

RUN yarn build:api:remote

RUN yarn build:components

RUN expo-cli build:web /usr/src/apps/packages/${SERVICE}

CMD ["/bin/sh", "-c", "yarn run web:${SERVICE}"]

EXPOSE 19006

FROM base as production

RUN set -eux && yarn global add serve

RUN COPY --from=builder /usr/src/apps/packages/${SERVICE}/web-build /usr/src/app

CMD ["/bin/sh", "-c", "serve -s /usr/src/app"]

EXPOSE 5000
