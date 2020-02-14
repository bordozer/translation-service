#!/bin/bash

EC2_USER='ec2-user' \
  && EC2_HOST='ec2-15-188-145-26.eu-west-3.compute.amazonaws.com' \
  && JAVA_ARCH_FILE='jdk-8u241-linux-x64.tar.gz' \
  && AWS_KEY='aws-vgn-key-3.pem' \
  && APP_JAR_FILE_NAME='translation-service-1.2.jar'

#ssh-keyscan -H ${EC2_HOST} >> ~/.ssh/known_hosts
#ssh-keyscan -t rsa,dsa HOST 2>&1 | sort -u - ~/.ssh/known_hosts > ~/.ssh/tmp_hosts

echo "-- Copy app jar to EC2 instance"
scp \
    -i "$HOME/.ssh/aws/${AWS_KEY}" \
    "../build/libs/${APP_JAR_FILE_NAME}" \
    "${EC2_USER}@${EC2_HOST}:/home/${EC2_USER}/"

echo "-- Copy Java 1.8 to EC2 instance"
scp \
    -i "$HOME/.ssh/aws/${AWS_KEY}" \
    "./$JAVA_ARCH_FILE" \
    "${EC2_USER}@${EC2_HOST}:/home/${EC2_USER}/"

echo "-- Logging to EC2 instance"
ssh -i ~/.ssh/aws/${AWS_KEY} "${EC2_USER}@${EC2_HOST}"

JAVA_ARCH_FILE='jdk-8u241-linux-x64.tar.gz' \
  && APP_JAR_FILE_NAME='translation-service-1.2.jar'

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


