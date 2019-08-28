FROM composer:1.9.0
FROM microweber/php73-apache

RUN cd  /var/www/html && git clone --depth 1 https://github.com/microweber/microweber.git
RUN cd /var/www/html/microweber && composer install --ignore-platform-reqs
RUN chown -R www-data:www-data /var/www
RUN chmod -R 755 /var/www/html
