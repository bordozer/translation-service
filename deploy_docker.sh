#!/bin/bash

DOCKER_SERVICE_NAME="translator-service"
DOCKER_IMG_NAME="img.${DOCKER_SERVICE_NAME}:latest"

docker container rm --force "${DOCKER_SERVICE_NAME}"
docker image rm "${DOCKER_IMG_NAME}"

./gradlew clean build -x check

docker image build -t "${DOCKER_IMG_NAME}" .

docker container run \
    --rm \
    --network=bordozer-network \
    --ip 192.168.0.10 \
    --publish 8978:8977 \
    -v /var/log/bordozer/translator-service/staging/:/var/log/bordozer/"${DOCKER_SERVICE_NAME}"/ \
    --name "${DOCKER_SERVICE_NAME}" \
    "${DOCKER_IMG_NAME}"

#    --network=bordozer-network \
#    --ip 192.168.0.10 \
