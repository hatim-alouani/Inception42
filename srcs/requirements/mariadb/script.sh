#!/bin/bash

db_root_password=$(cat /run/secrets/db_root_password)
db_password=$(cat /run/secrets/db_password)

service mariadb start

sleep 5

mysqladmin -u root password "${db_root_password}"

mysql -e "CREATE DATABASE IF NOT EXISTS \`${MYSQL_DB}\`;"

mysql -e "CREATE USER IF NOT EXISTS \`${MYSQL_USER}\`@'%' IDENTIFIED BY '${db_password}';"

mysql -e "GRANT ALL PRIVILEGES ON wordpress.* TO \`${MYSQL_USER}\`@'%' IDENTIFIED BY '${db_password}' ;"

mysql -e "FLUSH PRIVILEGES;"
 
service mariadb stop

exec mysqld_safe
