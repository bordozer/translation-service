#!/bin/bash

SERVICE_NAME=$1
APP_JAR_FILE_NAME=$2


if [ -z "$SERVICE_NAME" ]
then
      echo "Service name required (see EC2 tag Name value)"
      exit 1;
fi
if [ -z "$APP_JAR_FILE_NAME" ]
then
      echo "Service JAR file name required"
      exit 1;
fi

sudo mkdir -p "/var/log/bordozer/$SERVICE_NAME/"
sudo chmod 777 . -R "/var/log/bordozer/$SERVICE_NAME/"

echo "-- Deploy jar"
kill -9 "$(lsof -t -i:8977)"
$JAVA_HOME/bin/java -ea -Dspring.profiles.active=aws -jar ${APP_JAR_FILE_NAME}
