#!/bin/bash

#APP_JAR_FILE_NAME='translation-service-1.2.jar'
APP_JAR_FILE_NAME=$1

echo "-- Deploy jar"
kill -9 "$(lsof -t -i:8977)"
$JAVA_HOME/bin/java -ea -Dspring.profiles.active=aws -jar ${APP_JAR_FILE_NAME}
