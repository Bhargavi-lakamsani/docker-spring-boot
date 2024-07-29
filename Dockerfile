# Stage 1: Build
FROM maven:3.8.4-openjdk-11 AS build

# Set the working directory
WORKDIR /app

# Clone the repository
RUN git clone https://github.com/Bhargavi-lakamsani/docker-spring-boot.git

# Set the working directory to the cloned repository
WORKDIR /app/docker-spring-boot

# Build the application
RUN mvn clean package

# Stage 2: Run
FROM openjdk:11-jre-alpine

# Set the working directory
WORKDIR /app

# Copy the JAR file from the build stage
COPY --from=build /app/docker-spring-boot/target/*.jar /app/app.jar

# Expose port 8080
EXPOSE 8080

# Run the application
CMD ["java", "-jar", "/app/app.jar"]
