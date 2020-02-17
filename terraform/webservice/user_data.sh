#! /bin/bash

#sudo su

sudo yum install mc -y

sudo yum install java-1.8.0 -y
export JAVA_HOME=/usr/bin/java

#yum install httpd -y
#systemctl start httpd
#systemctl enable httpd
#echo "<h1>Translation service landing page</h1>" > /var/www/html/index.html

sudo mkdir /var/log/bordozer/ && sudo chmod 777 . -R /var/log/bordozer/
sudo mkdir /var/log/bordozer/translator/ && sudo chmod 777 . -R /var/log/bordozer/translator/
