FROM composer:1.9.0 AS composer

FROM php:7.3-fpm

COPY --from=composer /usr/bin/composer /usr/local/bin/composer

RUN apt update \
 && apt --no-install-recommends -y install git subversion openssh-client mercurial tini bash patch make zip unzip coreutils libz-dev libxml2-dev libzip-dev libpng-dev libpq-dev \
 && docker-php-ext-configure zip --with-libzip \
 && docker-php-ext-install -j$(getconf _NPROCESSORS_ONLN) zip opcache gd fileinfo xml curl json zip dom \
 && printf "# composer php cli ini settings\n\
date.timezone=UTC\n\
memory_limit=-1\n\
opcache.enable_cli=1\n\
" > $PHP_INI_DIR/php-cli.ini

ENV COMPOSER_ALLOW_SUPERUSER 1
ENV COMPOSER_HOME /tmp

# Goto temporary directory.
WORKDIR /tmp

# Run composer and phpunit installation.
RUN composer require "phpunit/phpunit:~5.7.12" --prefer-source --no-interaction && \
    ln -s /tmp/vendor/bin/phpunit /usr/local/bin/phpunit

VOLUME ["/app"]

WORKDIR /app
