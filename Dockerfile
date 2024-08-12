FROM openjdk:11-jre-slim
COPY target/springbootApp.jar /app/springbootApp.jar
WORKDIR /app
EXPOSE 80
ENTRYPOINT ["java", "-jar", "springbootApp.jar"]

