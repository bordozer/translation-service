#!/bin/bash

JAVA_ARCH_FILE=$1
APP_JAR_FILE_NAME=$2

echo "-- Configuring Java"
tar xvzf $JAVA_ARCH_FILE
mv jdk1.8.0_241 java8
export JAVA_HOME=~/java8
export PATH=$JAVA_HOME/bin:$PATH
$JAVA_HOME/bin/java -version

echo "-- Creating log dirs"
sudo mkdir /var/log/bordozer/ \
  && sudo chmod 777 . -R /var/log/bordozer/ \
  && sudo mkdir /var/log/bordozer/translator/ \
  && sudo chmod 777 . -R /var/log/bordozer/translator/

echo "-- Deploy jar"
#fuser -k 8977/tcp
#kill -9 "$(lsof -t -i:8977)"
$JAVA_HOME/bin/java -ea -Dspring.profiles.active=aws -jar ${APP_JAR_FILE_NAME}
