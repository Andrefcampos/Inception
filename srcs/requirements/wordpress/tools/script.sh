#!/usr/bin/env bash

wp --allow-root config create \
	--dbname="$DB_NAME" \
	--dbuser="$ADMIN_NAME" \
	--dbpass="$ADMIN_PASSWORD" \
	--dbhost=mariadb \
	--dbprefix="wp_"

wp core install --allow-root \
	--path=/var/www/html \
	--title="$TITLE" \
	--url=$DOMAIN \
	--admin_user=$ADMIN_NAME \
	--admin_password=$ADMIN_PASSWORD \
	--admin_email=$ADMIN_EMAIL

wp user create --allow-root	\
	--path=/var/www/html \
	"$USER_NAME" "$USER_EMAIL" \
	--user_pass=$USER_PASSWORD \
	--role='author'

# Activate the Twenty Twenty-four theme.
wp --allow-root theme activate twentytwentyfour

exec php-fpm7.4 -F