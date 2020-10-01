FROM nginxinc/nginx-unprivileged:stable-alpine
USER root
## use nginx.conf
COPY config/nginx/*.conf /etc/nginx/conf.d/

RUN apk update && apk add openssl
RUN mkdir /etc/nginx/ssl
RUN openssl req -x509 -nodes -days 365 -subj "/C=CA/ST=QC/O=Maverick, Inc./CN=mavrov.de" -addext "subjectAltName=DNS:mavrov.de" -newkey rsa:2048 -keyout /etc/nginx/ssl/nginx.key -out /etc/nginx/ssl/nginx.crt;
RUN cat /etc/nginx/ssl/nginx.crt
## From ‘builder’ stage copy over the artifacts in dist folder to default nginx public folder
COPY /site/ /usr/share/nginx/html
CMD ["nginx", "-g", "daemon off;"]
