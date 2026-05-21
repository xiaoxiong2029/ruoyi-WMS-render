FROM maven:3.9.8-eclipse-temurin-17 AS build

WORKDIR /workspace
COPY . .
RUN mvn -Pprod -DskipTests clean package

FROM eclipse-temurin:17-jre

WORKDIR /app
ENV TZ=Asia/Shanghai
ENV JAVA_OPTS=""

RUN apt-get update \
    && apt-get install -y --no-install-recommends mariadb-server mariadb-client \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir -p /run/mysqld \
    && chown -R mysql:mysql /run/mysqld /var/lib/mysql

COPY --from=build /workspace/ruoyi-admin-wms/target/ruoyi-admin-wms.jar /app/app.jar
COPY script/sql/wms.sql /app/init.sql
COPY script/bin/render-start.sh /app/render-start.sh
RUN chmod +x /app/render-start.sh

EXPOSE 8080

ENTRYPOINT ["/app/render-start.sh"]
