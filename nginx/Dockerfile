FROM nginx:latest

RUN rm /etc/nginx/conf.d/default.conf

COPY default.conf /etc/nginx/conf.d

RUN apt-get update && apt-get install -y --no-install-recommends curl