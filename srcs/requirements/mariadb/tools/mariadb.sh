#!/bin/bash

service mariadb start

sleep 5

mysql -u root  -e "CREATE DATABASE IF NOT EXISTS ${MYSQL_DB};"
mysql -u root  -e "CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${db_password}';"
mysql -u root  -e "GRANT ALL PRIVILEGES ON *.* TO '${MYSQL_USER}'@'%' IDENTIFIED BY '${db_password}';"
mysql -u root  -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '${db_root_password}';"
mysql -u root  -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${db_root_password}';"
mysql -u root  -e "FLUSH PRIVILEGES;"
mysqladmin -u root -p$db_root_password shutdown

service mariadb stop

exec mysqld_safe --bind-address=0.0.0.0
