FROM nginxinc/nginx-unprivileged:stable-alpine
USER root
## use nginx.conf
COPY config/nginx/*.conf /etc/nginx/conf.d/

RUN apk update && apk add openssl
RUN mkdir /etc/nginx/ssl
COPY certificates/* /etc/nginx/ssl/
RUN cat /etc/nginx/ssl/mavrov.de_ssl_certificate.cer

## From ‘builder’ stage copy over the artifacts in dist folder to default nginx public folder
COPY /site/ /usr/share/nginx/html
CMD ["nginx", "-g", "daemon off;"]
