FROM debian:bullseye

RUN apt update  &&  apt install -y curl git wget php php-fpm php-mysql mariadb-client

COPY ./auto_config.sh /

RUN chmod +x /auto_config.sh

WORKDIR /var/www/wordpress

EXPOSE 9000

RUN mkdir -p /run/php

ENTRYPOINT [ "bash", "/auto_config.sh" ]

CMD ["php-fpm7.4", "-F"]
