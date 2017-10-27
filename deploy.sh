#!/bin/bash

./gradlew build -x test && java -Dspring.profiles.active=local -jar build/libs/guitarneckmaster-0.0.1-SNAPSHOT.jar
