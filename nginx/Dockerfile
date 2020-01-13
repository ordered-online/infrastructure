FROM nginx:1.17.6-alpine

RUN rm /etc/nginx/conf.d/default.conf

COPY nginx/conf.d /etc/nginx/conf.d

COPY nginx/proxy.conf /etc/nginx/proxy_params
