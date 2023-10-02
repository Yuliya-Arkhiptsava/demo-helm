FROM maven:3.8.4-openjdk-17 AS builder
WORKDIR /app
COPY src /app/src
COPY pom.xml /app/pom.xml
RUN mvn -f /app/pom.xml clean package -Dmaven.test.skip=true

FROM openjdk:17.0.1-jdk-slim
WORKDIR /app
COPY --from=builder /app/target/demo-helm-*.jar /app/demo-helm.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "/app/demo-helm.jar"]
