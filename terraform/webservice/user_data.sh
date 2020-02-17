#!/bin/bash

sudo yum install mc -y

sudo yum install java-1.8.0 -y
export JAVA_HOME=/usr/bin/java
java -version

export EC2_SERVICE_NAME='translator-service'
