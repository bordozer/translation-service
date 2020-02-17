#!/bin/bash

GREEN='\e[32m'
RED='\e[31m'
DEFAULT='\e[39m'

APP_JAR_FILE_NAME=$1

if [ -z "$APP_JAR_FILE_NAME" ]
then
      echo "$RED Service JAR file name required $DEFAULT"
      exit 1;
fi

sudo mkdir -p "/var/log/bordozer/$EC2_SERVICE_NAME/"
sudo chmod 777 . -R "/var/log/bordozer/$EC2_SERVICE_NAME/"

kill -9 "$(lsof -t -i:8977)"

echo "$GREEN -- Deploy jar $DEFAULT"
$JAVA_HOME/bin/java -ea -Dspring.profiles.active=aws -jar "${APP_JAR_FILE_NAME}"
