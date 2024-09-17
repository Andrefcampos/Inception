#!/usr/bin/env bash

if [ ! -f "/var/www/wp-config.php" ]; then
    cat << EOF > /var/www/wp-config.php
        <?php
        define('DB_NAME', $DB_NAME);
        define('DB_USER', $ADMIN_NAME);
        define('DB_PASSWORD', $ADMIN_PASSWORD);
        define('DB_HOST', 'mariadb:3306');
        define('DB_CHARSET', 'utf8');
        define('DB_COLLATE', '');
        $table_prefix = 'wp_';
        define('WP_DEBUG', false);
EOF
fi

exec php-fpm81 -F