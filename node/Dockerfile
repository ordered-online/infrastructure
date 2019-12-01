FROM node:12.13.1

ARG NODE_ENV=development
ENV NODE_ENV=${NODE_ENV}

RUN set -ex; \
	apt-get update; \
	apt-get install -y supervisor

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# set the working directory
WORKDIR /usr/src/app

# copy the entrypoint script for the image
COPY docker-entrypoint.sh /usr/local/bin/

# ensure the entrypoint is executable
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

# set the entrypoint to our custom script
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]

RUN set -x \
  && yarn global add serve expo-cli

CMD ["/usr/bin/supervisord", "-n"]

EXPOSE 5000
