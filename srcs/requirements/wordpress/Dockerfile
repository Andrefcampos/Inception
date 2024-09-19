FROM debian:oldstable

WORKDIR /var/www/html/

RUN apt update && apt upgrade -y \ 
	&& apt install php7.4 php-fpm php-mysql \
	   mariadb-client wget -y \
	&& rm -rf /var/lib/apt/lists/*

RUN mkdir /run/php

RUN chown -R www-data:www-data /var/www/html \
	&& chmod 755 /var/www/html

RUN wget -O /usr/local/bin/wp https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
	&& chmod +x /usr/local/bin/wp \
	&& wp core download --allow-root --path=/var/www/html --debug

COPY conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf

COPY tools/script.sh /tmp/wp_setup.sh

RUN chmod 777 /tmp/wp_setup.sh

CMD ["/tmp/wp_setup.sh"]