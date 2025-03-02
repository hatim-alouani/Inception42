FROM debian:bullseye

RUN apt update  &&  apt install -y curl git wget php php-fpm php-mysql mariadb-client

EXPOSE 9000

COPY ./tools/wordpress.sh /

WORKDIR /var/www/wordpress

RUN mkdir -p /run/php

RUN chmod +x /wordpress.sh

ENTRYPOINT ["/wordpress.sh"]