#!/bin/bash

docker container rm --force translator.bordozer

./gradlew clean build -x check

docker image build -t img.translator.bordozer:1.1 .

docker container run \
    --rm \
    --network=bordozer-network \
    --publish 8978:8977 \
    --name translator.bordozer \
    img.translator.bordozer:1.1

#    --network=bordozer-network \
#    --ip 192.168.0.10 \