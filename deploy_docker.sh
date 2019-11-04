#!/bin/bash

docker image build -t translation-service-docker:1.1 .
docker container run --publish 8978:8977 --name translator-service translation-service-docker:1.1

#8080:8080
#8978:8977
#docker run --publish 8978:8977 --name translator-service -t com.bordozer/translation-service-docker
#docker run --publish 8080:8080 --detach --name tsd -t com.bordozer/translation-service-docker
#docker container rm --force tsd
#-e "SPRING_PROFILES_ACTIVE=dev"


#docker build -f Dockerfile -t micro-boot .
#docker image ls -a
