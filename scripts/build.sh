#!/bin/bash

# Get commandline arguments
while (( "$#" )); do
  case "$1" in
    --arm)
      arm="true"
      shift
      ;;
    *)
      shift
      ;;
  esac
done

imageTag="1.0.0"
if [[ $arm == "true" ]]; then
  imageName="test-go-server-arm"
  platform="linux/arm64"
else
  imageName="test-go-server-amd"
  platform="linux/amd64"
fi

# Build image
docker build \
  --platform $platform \
  --tag "${DOCKERHUB_NAME}/${imageName}:${imageTag}" \
  "../apps/server/."

# Push image to Docker Hub
docker push "${DOCKERHUB_NAME}/${imageName}:${imageTag}"
