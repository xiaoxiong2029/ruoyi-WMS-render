#!/usr/bin/env sh
set -eu

export MYSQL_DATABASE="${MYSQL_DATABASE:-ry_wms}"
export MYSQL_USER="${MYSQL_USER:-ruoyi}"
export MYSQL_PASSWORD="${MYSQL_PASSWORD:-ruoyi123456}"

mysqld_safe --datadir=/var/lib/mysql --bind-address=127.0.0.1 >/tmp/mysql.log 2>&1 &

echo "Waiting for local MariaDB..."
for i in $(seq 1 60); do
  if mysqladmin ping -uroot --silent >/dev/null 2>&1; then
    break
  fi
  sleep 1
done

if ! mysqladmin ping -uroot --silent >/dev/null 2>&1; then
  echo "MariaDB failed to start"
  cat /tmp/mysql.log || true
  exit 1
fi

if [ ! -f /var/lib/mysql/ruoyi-wms-initialized ]; then
  echo "Initializing ${MYSQL_DATABASE}..."
  mysql -uroot <<SQL
CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\` CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'localhost' IDENTIFIED BY '${MYSQL_PASSWORD}';
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'localhost';
GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';
FLUSH PRIVILEGES;
SQL
  mysql -uroot "${MYSQL_DATABASE}" < /app/init.sql
  touch /var/lib/mysql/ruoyi-wms-initialized
fi

exec java ${JAVA_OPTS:-} -Dserver.port="${PORT:-8080}" -jar /app/app.jar
