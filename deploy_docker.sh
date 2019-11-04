#!/bin/bash

./gradlew clean build -x check
docker image build -t translation-service:1.1 .
docker container run --publish 8978:8977 --name translator-service translation-service:1.1

#docker ps
#docker container rm --force translator-service

#docker run --publish 8978:8977 --name translator-service -t com.bordozer/translation-service
#docker run --publish 8080:8080 --detach --name tsd -t com.bordozer/translation-service
#-e "SPRING_PROFILES_ACTIVE=dev"


#docker build -f Dockerfile -t micro-boot .
#docker image ls -a
