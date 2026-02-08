FROM php:8.2-apache

# Enable only ONE MPM: prefork (good for mod_php), disable others
RUN a2dismod mpm_event mpm_worker || true \
 && a2enmod mpm_prefork

# Copy app
COPY . /var/www/html/
RUN chown -R www-data:www-data /var/www/html

# Bind Apache to Railway's PORT at runtime (fallback 80)
CMD sed -i "s/Listen 80/Listen ${PORT:-80}/" /etc/apache2/ports.conf \
 && sed -i "s/:80>/:${PORT:-80}>/" /etc/apache2/sites-available/000-default.conf \
 && apache2-foreground
