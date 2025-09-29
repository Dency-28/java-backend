# -------- Build Stage --------
FROM maven:3.9.4-eclipse-temurin-17 AS build
WORKDIR /app
COPY . .
RUN mvn clean package spring-boot:repackage -DskipTests

# -------- Runtime Stage --------
FROM eclipse-temurin:17-jdk-alpine
WORKDIR /app
COPY --from=build /app/target/java-backend-1.0.0.jar app.jar

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
