FROM php:fpm

WORKDIR /var/www

# Ajout de USER_ID et GROUP_ID comme variables d'environnement
ARG USER_ID
ARG GROUP_ID
ARG PROJECT_NAME

# ✅ Assurer que les variables sont disponibles à l’exécution
ENV USER_ID=$USER_ID
ENV GROUP_ID=$GROUP_ID
ENV PROJECT_NAME=$PROJECT_NAME

RUN echo "Building with USER_ID=${USER_ID}, GROUP_ID=${GROUP_ID}, PROJECT_NAME=${PROJECT_NAME}"

RUN apt-get update && apt-get install -y \
    libpq-dev \
    unzip \
    git \
    curl \
    && docker-php-ext-install pdo pdo_mysql opcache \
    && pecl install redis \
    && docker-php-ext-enable redis

# ✅ Modifier PHP-FPM pour utiliser `symfony` au lieu de `www-data` AVANT de changer d'utilisateur
RUN sed -i 's/user = www-data/user = docker-php/' /usr/local/etc/php-fpm.d/www.conf && \
    sed -i 's/group = www-data/group = docker-php/' /usr/local/etc/php-fpm.d/www.conf

# ✅ Créer un utilisateur avec l'UID/GID de l'hôte
RUN addgroup --gid ${GROUP_ID} docker-php && adduser --disabled-password --gecos "" --uid ${USER_ID} --gid ${GROUP_ID} docker-php

# ✅ Donner accès aux dossiers nécessaires
RUN mkdir -p /var/www/var/cache /var/www/var/log && \
    chown -R docker-php:docker-php /var/www/var/cache /var/www/var/log

USER docker-php

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

COPY php.ini /usr/local/etc/php/conf.d/php.ini

COPY bashrc /root/.bashrc
COPY bashrc /home/docker-php/.bashrc

CMD ["php-fpm"]