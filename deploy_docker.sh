#!/bin/bash

./gradlew clean build -x check

docker image build -t img.translator.bordozer:1.1 .

docker container run \
   --rm \
   --publish 8978:8977 \
   --name translator.bordozer \
   img.translator.bordozer:1.1
