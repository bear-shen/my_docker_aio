#!/usr/bin/env bash
set -e

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
