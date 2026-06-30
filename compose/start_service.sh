#!/usr/bin/env bash
set -e

chown -R www-data:www-data /var/www/html
chown -R postgres:postgres /var/lib/postgresql/16/main

echo "[init] starting postgresql..."
service postgresql start

echo "[init] starting php8.3-fpm..."
service php8.3-fpm start

echo "[init] starting nginx..."
service nginx start

echo "[init] starting cron..."
service cron start

echo "[init] all services started."
# 保持容器前台运行
tail -f /dev/null
