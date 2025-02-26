#!/bin/bash

wordpress_admin_password=$(cat /run/secrets/wordpress_admin_password)
wordpress_new_user_password=$(cat /run/secrets/wordpress_new_user_password)
db_password=$(cat /run/secrets/db_password)

sleep 10

rm -rf /var/www/wordpress/*

cd /var/www/wordpress

curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

chmod +x wp-cli.phar

mv wp-cli.phar /usr/local/bin/wp

chmod -R 777 /var/www/wordpress/

wp core download --allow-root

wp config create --allow-root --dbname=${MYSQL_DB} --dbuser=${MYSQL_USER} --dbpass=${db_password} --dbhost="mariadb:3306"

wp core install --allow-root --url=${DOMAIN_NAME} --title="${WORDPRESS_TITLE}" --admin_user=${WORDPRESS_ADMIN} --admin_password=${wordpress_admin_password} --admin_email=${WORDPRESS_ADMIN_EMAIL} --skip-email

wp user create ${NEW_WORDPRESS_USER} ${NEW_WORDPRESS_USER_EMAIL} --user_pass=${wordpress_new_user_password} --role=${NEW_WORDPRESS_USER_ROLE} --allow-root

sed -i '36 s/\/run\/php\/php7.4-fpm.sock/9000/' /etc/php/7.4/fpm/pool.d/www.conf

chown -R www-data:www-data /var/www/wordpress

chmod -R 775 /var/www/wordpress

service php7.4-fpm reload 

exec "$@"
