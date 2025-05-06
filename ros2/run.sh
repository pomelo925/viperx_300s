#!/bin/bash

# env var
export COMPOSE_BAKE=true  # delegate builds to bake for better performance.
export DISPLAY=:0

# config
DOCKER_USERNAME=hrcnthu
IMAGE_NAME=viperx-300s
IMAGE_TAG=default
CONTAINER_SERVICE=dev

# check if target image exists
IMAGE_FULL_NAME="${DOCKER_USERNAME}/${IMAGE_NAME}:${IMAGE_TAG}"


cd docker

if docker images --format "{{.Repository}}:{{.Tag}}" | grep -q "^${IMAGE_FULL_NAME}$"; then
    echo "✅ Docker Image Found: ${IMAGE_FULL_NAME}"
    docker compose up ${CONTAINER_SERVICE} -d
else
    echo "⚙️ Docker Image NOT Found, Start Building..."
    docker compose build
    docker compose up ${CONTAINER_SERVICE} -d
fi