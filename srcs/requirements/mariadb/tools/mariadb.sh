#!/bin/bash

db_root_password=$(cat /run/secrets/db_root_password)
db_password=$(cat /run/secrets/db_password)

service mariadb start

sleep 5

mysql -u root --skip-password -e "CREATE DATABASE IF NOT EXISTS ${MYSQL_DB};"
mysql -u root --skip-password -e "CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${db_password}';"
mysql -u root --skip-password -e "GRANT ALL PRIVILEGES ON *.* TO '${MYSQL_USER}'@'%' IDENTIFIED BY '${db_password}';"
mysql -u root --skip-password -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '${db_root_password}';"
mysql -u root --skip-password -e "FLUSH PRIVILEGES;"
mysql -u root --skip-password -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${db_root_password}';"
mysqladmin -u root -p$db_root_password shutdown

service mariadb stop

exec mysqld_safe --bind-address=0.0.0.0
