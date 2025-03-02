#!/bin/bash

if [[ ! -f /run/secrets/wordpress_admin_password || \
      ! -f /run/secrets/wordpress_user_password || \
      ! -f /run/secrets/db_password ]]; then
  echo "Error: One or more required secret files are missing!" >&2
  exit 1
fi

wordpress_admin_password=$(cat /run/secrets/wordpress_admin_password)
wordpress_user_password=$(cat /run/secrets/wordpress_user_password)
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

wp user create ${WORDPRESS_USER} ${WORDPRESS_USER_EMAIL} --user_pass=${wordpress_user_password} --role=${WORDPRESS_USER_ROLE} --allow-root

sed -i 's|listen = /run/php/php7.4-fpm.sock|listen = 9000|' /etc/php/7.4/fpm/pool.d/www.conf

chown -R www-data:www-data /var/www/wordpress

chmod -R 775 /var/www/wordpress

service php7.4-fpm reload 

exec php7.4-fpm -F
