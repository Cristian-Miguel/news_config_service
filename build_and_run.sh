#!/bin/bash
set -x

export MAVEN_OPTS="--add-opens java.base/java.lang=ALL-UNNAMED"

# Set the name for your Docker image
DOCKER_IMAGE_NAME="config-service"

# Step 1: Clean and build the project
echo "Building the Spring Boot project..."

# If you're using Maven
mvn clean package -DskipTests

if [ $? -ne 0 ]; then
  echo "Build failed! Exiting..."
  exit 1
fi

echo "Build successful!"

# Step 2: Build the Docker image
echo "Building the Docker image..."

docker build -t $DOCKER_IMAGE_NAME .

if [ $? -ne 0 ]; then
  echo "Docker image build failed! Exiting..."
  exit 1
fi

echo "Docker image built successfully!"

# Step 3: Run the Docker container
echo "Running the Docker container..."

docker run -d --name $DOCKER_IMAGE_NAME -p 8089:8089 $DOCKER_IMAGE_NAME

if [ $? -ne 0 ]; then
  echo "Failed to run Docker container! Exiting..."
  exit 1
fi

echo "Docker container is running on port 8089!"
