# Stage 1: Build Stage
FROM maven:3.8.5-openjdk-11 AS build

# Set the working directory
WORKDIR /app

RUN git clone https://github.com/Bhargavi-lakamsani/docker-spring-boot.git

# Package the application
RUN mvn clean package

# Stage 2: Run Stage
FROM openjdk:11-jre-slim

# Set the working directory
WORKDIR /app

# Copy the JAR file from the build stage
COPY --from=build /app/target/spring-boot-web.jar /app/spring-boot-web.jar

# Expose the port the application will run on
EXPOSE 8080

# Define the command to run the application
ENTRYPOINT ["java", "-jar", "spring-boot-web.jar"]
