FROM debian:bullseye

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y mariadb-server

COPY ./50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

COPY ./script.sh /script.sh

RUN chmod +x /script.sh

ENTRYPOINT [ "./script.sh" ]
