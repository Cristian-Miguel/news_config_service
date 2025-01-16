# Use an official OpenJDK 17 image as the base image
FROM eclipse-temurin:21-jdk-alpine

#Avoid Root Users
RUN addgroup -S appgroup && adduser -S appuser -G appgroup
USER appuser

# Set the working directory inside the container
WORKDIR /app

# Copy the Spring Boot JAR file into the container
# Replace 'config-server.jar' with the actual name of your JAR file after building the project
COPY target/config-service-0.5.0-SNAPSHOT.jar config-service.jar

# Expose the port that the Spring Boot application runs on
EXPOSE 8089

# Add any environment variables if necessary
# Example: ENV SPRING_PROFILES_ACTIVE=prod

# Command to run the application
ENTRYPOINT ["java", "-jar", "config-service.jar"]
