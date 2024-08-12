# Use a base image with OpenJDK
FROM openjdk:11-jre-slim

# Set the working directory
WORKDIR /app

# Copy the JAR file from the target directory
COPY target/spring-boot-web.jar /app/spring-boot-web.jar

# Expose port 8080 for the application
EXPOSE 8080

# Define the command to run the application
ENTRYPOINT ["java", "-jar", "spring-boot-web.jar"]
