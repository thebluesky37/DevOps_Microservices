#!/usr/bin/env bash

# This tags and uploads an image to Docker Hub

# Step 1:
# This is your Docker ID/path
dockerpath=thebluesky37/udacity

# Step 2
# Run the Docker Hub container with kubernetes
kubectl run predict-app-container --image=$dockerpath --port=80 --labels app=predict-app

# Step 3:
# List kubernetes pods
kubectl wait --for=condition=Ready pod -l app=predict-app
kubectl get pods predict-app-container

# Step 4:
# Forward the container port to a host
kubectl port-forward predict-app-container 8080:80


