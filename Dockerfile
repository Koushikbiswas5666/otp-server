FROM php:8.2-cli

WORKDIR /app
COPY . /app

# Railway gives PORT; fallback 8080 locally
CMD ["sh", "-c", "php -S 0.0.0.0:${PORT:-8080} -t /app"]
