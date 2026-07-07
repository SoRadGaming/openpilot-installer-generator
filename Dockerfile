FROM php:8.2-apache

RUN apt-get update \
    && apt-get install -y --no-install-recommends libonig-dev \
    && docker-php-ext-install mbstring \
    && apt-get purge -y --auto-remove libonig-dev \
    && rm -rf /var/lib/apt/lists/*

RUN a2enmod rewrite headers \
    && sed -ri 's/AllowOverride None/AllowOverride All/' /etc/apache2/apache2.conf

COPY fork/ /var/www/html/fork/

RUN mkdir -p /var/www/html/fork/log \
    && chown -R www-data:www-data /var/www/html/fork/log \
    && chmod 775 /var/www/html/fork/log

EXPOSE 80