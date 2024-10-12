# copied from https://www.cloudways.com/blog/docker-php-application/

# FROM php:5.6-apache
FROM php:8.2-apache

# Install the MySQL extension
RUN docker-php-ext-install mysqli
#        /usr/local/bin/docker-php-ext-install -j5 gd mbstring mysqli pdo pdo_mysql shmop
RUN docker-php-ext-install -j5 mysqli pdo pdo_mysql

# Create a directory for your application code
WORKDIR /var/www/html

# Install Composer dependencies
RUN curl -sS https://getcomposer.org/download/latest-2.2.x/composer.phar -o /usr/local/bin/composer \
    && chmod +x /usr/local/bin/composer

RUN apt-get update && apt-get install -y \
    git \
    unzip \
    && rm -rf /var/lib/apt/lists/*

COPY ./composer.json /var/www/html/composer.json
RUN composer install --no-dev --optimize-autoloader

# Copy the application code into the container
COPY ./ /var/www/html

# Expose port 80 for web traffic
EXPOSE 80

# added per Clod Run
# https://stackoverflow.com/questions/59324794/google-cloud-run-port
ENV PORT 80
