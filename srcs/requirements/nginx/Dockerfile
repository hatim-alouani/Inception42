FROM debian:bullseye

RUN apt update && apt upgrade -y && apt install -y nginx openssl

RUN mkdir -p /var/run/nginx

RUN mkdir -p /etc/nginx/ssl && \
    openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key \
    -subj "/C=MO/ST=KH/L=KH/O=1337/OU=1337/CN=haalouan.42.fr/UID=haalouan"

EXPOSE 443

COPY ./conf/nginx.conf /etc/nginx/nginx.conf

ENTRYPOINT ["nginx", "-g", "daemon off;"]
