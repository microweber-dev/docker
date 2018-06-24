FROM php:7.1-fpm-alpine

# docker-entrypoint.sh dependencies
RUN apk add --no-cache bash sed sudo

# install the PHP extensions we need
RUN set -ex; \
 \
 apk add --no-cache --virtual .build-deps \
  libjpeg-turbo-dev \
  libpng-dev \
  libxml2-dev \
  icu-dev \
  curl \
  curl-dev \
  postgresql-dev \
 ; \
 \
 docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr; \
 docker-php-ext-install gd pdo xml pdo_mysql pdo_pgsql json intl curl opcache; \
 \
 runDeps="$( \
  scanelf --needed --nobanner --recursive \
   /usr/local/lib/php/extensions \
   | awk '{ gsub(/,/, "\nso:", $2); print "so:" $2 }' \
   | sort -u \
   | xargs -r apk info --installed \
   | sort -u \
 )"; \
 apk add --virtual .microweber-phpexts-rundeps $runDeps; \
 apk del .build-deps

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

COPY php-fpm.conf /usr/local/etc/php-fpm.conf

ENV MICROWEBER_VERSION 1.0.7
ENV MICROWEBER_SHA1 abc-xyz

RUN mkdir -p /var/run/php
RUN chown www-data:www-data /var/run/php


RUN set -ex; \
 curl -o microweber.zip -fSL "https://microweber.com/download.php"; \
 mkdir -p /usr/src/microweber; \
 unzip -o microweber.zip -d /usr/src/microweber; \
 chown -R www-data:www-data /usr/src/microweber

VOLUME /usr/src/microweber

COPY docker-entrypoint.sh /usr/local/bin/

CMD ["php-fpm"]
