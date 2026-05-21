FROM maven:3.9.8-eclipse-temurin-17 AS build

WORKDIR /workspace
COPY . .
RUN mvn -Pprod -DskipTests clean package

FROM eclipse-temurin:17-jre

WORKDIR /app
ENV TZ=Asia/Shanghai
ENV JAVA_OPTS=""

COPY --from=build /workspace/ruoyi-admin-wms/target/ruoyi-admin-wms.jar /app/app.jar

EXPOSE 8080

ENTRYPOINT ["sh", "-c", "java $JAVA_OPTS -Dserver.port=${PORT:-8080} -jar /app/app.jar"]
