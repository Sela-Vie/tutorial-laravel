## REQUIREMENTS
|requirements|version|
|-|-|
|php | 8.4 |
|composer| latest |
|docker| latest |
|composer| latest |

```bash
sudo apt update

sudo apt install -y \
  php8.4 \
  php8.4-cli \
  php8.4-fpm \
  php8.4-mbstring \
  php8.4-xml \
  php8.4-curl \
  php8.4-zip \
  php8.4-bcmath \
  php8.4-intl \
  php8.4-mysql \
  php8.4-sqlite3 \
  php8.4-pgsql \ # only if using postgress
  unzip \
  git \
  curl

sudo apt install -y composer
# or the official download at 
# https://getcomposer.org/download/

# the official download for docker at
# https://docs.docker.com/engine/install/
```

## INITIAL CONFIG
```bash
composer create-project laravel/laravel tutorial-laravel
cp .env.example .env
composer install
# composer update # only if you want to update libraries to the latest versions

php artisan key:generate
php artisan install:api

docker compose --project-name $SESSION_NAME up -d
php artisan serve --port=$PORT --host=0.0.0.0
```
docker was written by hand <br>
.env.example was edited to use postgress

## NOTES
```
`phpunit.xml` is used during tests
`.env` is used when running
```