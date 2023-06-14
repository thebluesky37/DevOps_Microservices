#!/usr/bin/env bash

## Complete the following steps to get Docker running locally

# Step 1:
# Build image and add a descriptive tag
docker build --platform linux/amd64 -t predictapp:latest .

# Step 2:
# List docker images
docker images

# Step 3:
# Run flask app
docker run -p 80:80 predictapp:latest
