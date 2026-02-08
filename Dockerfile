FROM php:8.2-apache

# Copy app
COPY . /var/www/html/
RUN chown -R www-data:www-data /var/www/html

# Make Apache listen on Railway's PORT (fallback 80)
RUN sed -i 's/Listen 80/Listen ${PORT}/g' /etc/apache2/ports.conf \
 && sed -i 's/:80>/:${PORT}>/g' /etc/apache2/sites-available/000-default.conf

# Default PORT for local
ENV PORT=80

EXPOSE 80
