FROM debian:bullseye

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y mariadb-server

EXPOSE 3306

COPY ./tools/mariadb.sh /mariadb.sh

RUN chmod +x /mariadb.sh

ENTRYPOINT ["/mariadb.sh"]
