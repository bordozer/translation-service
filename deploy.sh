#!/bin/bash

./gradlew clean build -x test && java -ea -Dspring.profiles.active=local -jar build/libs/translation-service-1.1.jar
