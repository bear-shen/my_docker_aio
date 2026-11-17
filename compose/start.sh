#!/usr/bin/env bash
set -euo pipefail

#如果根目录不存在.docker_initialized文件，则执行init.sh
if [ ! -f "/.compose_initialized" ]; then
  /usr/bin/env bash /myCompose/init.sh
  touch "/.compose_initialized"
fi

# 让 docker exec（非交互/非登录 shell）和 cron 也能找到 nvm 安装的 node/npm
# 原因1：docker exec 不加载 /root/.bashrc，nvm 的初始化写在那里
# 原因2：cron 守护进程继承的 PATH 是 /bin:/usr/bin:/sbin:/sbin，不含 /usr/local/bin
# 放在 start.sh 而不是 init.sh：init.sh 只在首次启动执行，node 版本升级后软链会失效
NODE_BIN_DIR="$(ls -d /root/.nvm/versions/node/*/bin 2>/dev/null | sort -V | tail -1 || true)"
if [ -n "${NODE_BIN_DIR:-}" ]; then
  for bin in node npm npx; do
    if [ -e "$NODE_BIN_DIR/$bin" ]; then
      ln -sf "$NODE_BIN_DIR/$bin" "/usr/local/bin/$bin"
    fi
  done
  # 供 `bash -lc` 使用
  printf 'export NVM_DIR="/root/.nvm"\n[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"\n' > /etc/profile.d/nvm.sh
  chmod 0644 /etc/profile.d/nvm.sh
  echo "[init] node/npm linked from $NODE_BIN_DIR"
fi

# 让 cron 启动时继承包含 /usr/local/bin 的 PATH，这样 /etc/cron.d 里的任务可直接调用 npm
export PATH="/usr/local/sbin:/usr/local/bin:$PATH"

# 启动服务
echo "[init] starting php8.5-fpm..."
service php8.5-fpm start

echo "[init] starting nginx..."
service nginx start

echo "[init] setting permissions for PostgreSQL..."
chown -R postgres:postgres /etc/postgresql/18/main
echo "[init] starting postgresql..."
service postgresql start

echo "[init] starting cron..."
service cron start

echo "[init] starting supervisord..."
service supervisor start

echo "[init] all services started."
# 保持容器运行
tail -f /dev/null