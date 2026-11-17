#!/bin/bash

CONTAINER_NAME="myapp"
IMAGE_NAME="roguememer/ceg3120-cicd-stein55-f26:latest"

echo "Stopping old container..."
docker stop $CONTAINER_NAME 2>/dev/null

echo "Removing old container..."
docker rm $CONTAINER_NAME 2>/dev/null

echo "Pulling latest image..."
docker pull $IMAGE_NAME

echo "Starting new container..."
docker run -d \
  --restart always \
  --name $CONTAINER_NAME \
  -p 80:80 \
  $IMAGE_NAME

echo "Deployment complete."
