#!/bin/bash


# Define the Docker image names and tags
image1="linux-tweet-app"
tag1="latest"

# delete existing images 
docker rmi anshuhtwt/${image1}

# Build and tag the Docker images
docker build -t anshuhtwt/${image1}:${tag1} 

# Push the Docker images to Docker Hub
docker push anshuhtwt/${image1}:${tag1}

# apply yaml file
kubectl apply -R -f /var/lib/jenkins/workspace/linux-tweet-app/k8s-manifest/
