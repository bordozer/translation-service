#!/bin/bash

docker container rm --force translator.bordozer
docker image rm img.translator.bordozer:latest

./gradlew clean build -x check

docker image build -t img.translator.bordozer:latest .

docker container run \
    --rm \
    --network=bordozer-network \
    --ip 192.168.0.10 \
    --publish 8978:8977 \
    -v /var/log/bordozer/translator/stage/:/var/log/bordozer/translator/ \
    --name translator.bordozer \
    img.translator.bordozer:latest

#    --network=bordozer-network \
#    --ip 192.168.0.10 \
