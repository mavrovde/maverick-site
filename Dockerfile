FROM nginxinc/nginx-unprivileged:stable-alpine
USER root
## use nginx.conf
COPY config/nginx/*.conf /etc/nginx/conf.d/
## From ‘builder’ stage copy over the artifacts in dist folder to default nginx public folder
COPY /site/ /usr/share/nginx/html
CMD ["nginx", "-g", "daemon off;"]
