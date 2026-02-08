FROM php:8.2-apache

# Force only ONE MPM (prefork). Remove any other MPM modules.
RUN set -eux; \
  a2dismod mpm_event || true; \
  a2dismod mpm_worker || true; \
  a2enmod mpm_prefork; \
  rm -f /etc/apache2/mods-enabled/mpm_event.load /etc/apache2/mods-enabled/mpm_event.conf || true; \
  rm -f /etc/apache2/mods-enabled/mpm_worker.load /etc/apache2/mods-enabled/mpm_worker.conf || true; \
  rm -f /etc/apache2/mods-enabled/mpm_prefork.conf || true; \
  ln -sf /etc/apache2/mods-available/mpm_prefork.load /etc/apache2/mods-enabled/mpm_prefork.load; \
  apache2ctl -M | grep mpm || true

COPY . /var/www/html/
RUN chown -R www-data:www-data /var/www/html

# Bind to Railway PORT at runtime
CMD sed -i "s/Listen 80/Listen ${PORT:-80}/" /etc/apache2/ports.conf \
 && sed -i "s/:80>/:${PORT:-80}>/" /etc/apache2/sites-available/000-default.conf \
 && apache2-foreground
