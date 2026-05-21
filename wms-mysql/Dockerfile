FROM mysql:8.0

COPY ry_wms_full.sql /docker-entrypoint-initdb.d/01-init.sql

CMD ["mysqld", "--character-set-server=utf8mb4", "--collation-server=utf8mb4_general_ci"]
