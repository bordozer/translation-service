#!/bin/bash

./gradlew clean build -x test && java -ea -Dspring.profiles.active=local -jar build/libs/translator-service.jar
