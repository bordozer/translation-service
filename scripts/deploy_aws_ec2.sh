#!/bin/bash

#APP_JAR_FILE_NAME='translation-service-1.2.jar'
APP_JAR_FILE_NAME=$1

# TODO: chould be created in user data script
echo "-- Creating log dirs"
#sudo mkdir /var/log/bordozer/ && sudo chmod 777 . -R /var/log/bordozer/
#sudo mkdir /var/log/bordozer/translator/ && sudo chmod 777 . -R /var/log/bordozer/translator/

echo "-- Deploy jar"
#fuser -k 8977/tcp
kill -9 "$(lsof -t -i:8977)"
$JAVA_HOME/bin/java -ea -Dspring.profiles.active=aws -jar ${APP_JAR_FILE_NAME}
