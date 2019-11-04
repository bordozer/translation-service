#!/bin/bash

./gradlew build -x test && java -ea -Dspring.profiles.active=local -jar build/libs/translation-service-docker-1.1.jar
