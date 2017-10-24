FROM php:7.1-apache

# install the PHP extensions we need

RUN set -ex; \
	\
	apt-get update; \
	apt-get install -y \
		libjpeg-dev \
		libpng-dev \
		libxml2-dev \
		libicu-dev \
		libsqlite3-dev \
		libcurl4-openssl-dev \
		unzip \
  sudo \
	; \
	rm -rf /var/lib/apt/lists/*; \
	\
	docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr; \
	docker-php-ext-install gd pdo xml pdo_mysql pdo_sqlite json intl curl opcache

# set recommended PHP.ini settings
# see https://secure.php.net/manual/en/opcache.installation.php
RUN { \
  echo 'opcache.memory_consumption=128'; \
  echo 'opcache.interned_strings_buffer=8'; \
  echo 'opcache.max_accelerated_files=4000'; \
  echo 'opcache.revalidate_freq=2'; \
  echo 'opcache.fast_shutdown=1'; \
  echo 'opcache.enable_cli=1'; \
 } > /usr/local/etc/php/conf.d/opcache-recommended.ini

RUN a2enmod rewrite expires

ENV MICROWEBER_VERSION 1.0.7

WORKDIR /usr/src/microweber

RUN set -ex; \
 curl -o microweber.zip -fSL "https://github.com/microweber/dist/raw/master/microweber-latest.zip"; \
 mkdir -p /usr/src/microweber; \
 unzip microweber.zip -d /usr/src/microweber; \
 chown -R www-data:www-data /usr/src/microweber

COPY docker-entrypoint.sh /usr/local/bin/
COPY 000-default.conf /etc/apache2/sites-available/000-default.conf

VOLUME /usr/src/microweber/userfiles
VOLUME /usr/src/microweber/config

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["apache2-foreground"]
