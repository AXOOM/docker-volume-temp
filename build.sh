#!/bin/bash
set -e
cd `dirname $0`

export VERSION="${1-0.1-dev}"
if [[ VERSION == *"-"* ]]; then
  export DOCKER_REGISTRY="docker-ci.axoom.cloud"
else
  export DOCKER_REGISTRY="docker.axoom.cloud"
fi

echo "Building plugin image"
ImageId=$(docker build -q .)

echo "Removing old plugin version (if exists)"
docker plugin rm "$DockerRegistry/docker-volume-temp:$Version"

echo "Building & installing new plugin version"
docker run --rm --volume /var/run/docker.sock:/var/run/docker.sock $ImageId docker plugin create "$DockerRegistry/docker-volume-temp:$Version" /plugin
