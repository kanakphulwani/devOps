# Stage 1 - Build the application using Maven
FROM maven:3.8.5-openjdk-17 AS builder
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests
 
# Stage 2 - Create a lightweight image with just the jar
FROM openjdk:17-jdk-slim
COPY --from=builder /app/target/*.jar /app/app.jar
ENTRYPOINT ["java", "-jar", "/app/app.jar"]
