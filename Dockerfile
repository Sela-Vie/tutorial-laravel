FROM php:8.4-cli-alpine

RUN apk add --no-cache \
    libzip-dev \
    oniguruma-dev \
    libxml2-dev \
    postgresql-dev \
    && docker-php-ext-install pdo_pgsql pcntl bcmath xml mbstring zip

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

WORKDIR /app

COPY composer.json composer.lock ./
RUN composer install --no-dev --no-autoloader --no-scripts

COPY . .
RUN composer dump-autoload --optimize --no-dev

RUN chown -R www-data:www-data storage bootstrap/cache

EXPOSE ${APP_PORT}

CMD ["sh", "-c", "php artisan serve --host=0.0.0.0 --port=${APP_PORT}"]
