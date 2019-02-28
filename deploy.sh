#!/bin/bash

./gradlew build -x test && java -ea -Dspring.profiles.active=local -jar build/libs/translation-service-0.0.1-SNAPSHOT.jar
