#!/bin/bash

# install software
sudo su
yum install mc -y
yum install java-1.8.0 -y
yum install awscli -y

su ec2-user

# get EC2 vars
ec2_instance_id=$(ec2-metadata -i | cut -d ' ' -f2)
ec2_region=$(ec2-metadata --availability-zone | cut -d ' ' -f2)
ec2_region=${ec2_region%?}

ec2_service_instance_name=$(aws ec2 describe-tags --filters "Name=resource-id,Values=$ec2_instance_id" "Name=key,Values=Name" --region "$ec2_region" --output=text | cut -f5)
ec2_service_name=$(aws ec2 describe-tags --filters "Name=resource-id,Values=$ec2_instance_id" "Name=key,Values=ServiceName" --region "$ec2_region" --output=text | cut -f5)
ec2_app_artefact_s3_bucket=$(aws ec2 describe-tags --filters "Name=resource-id,Values=$ec2_instance_id" "Name=key,Values=AppArtefactS3Bucket" --region "$ec2_region" --output=text | cut -f5)
ec2_env=$(aws ec2 describe-tags --filters "Name=resource-id,Values=$ec2_instance_id" "Name=key,Values=Environment" --region "$ec2_region" --output=text | cut -f5)
ec2_app_artefact_name=$(aws ec2 describe-tags --filters "Name=resource-id,Values=$ec2_instance_id" "Name=key,Values=AppArtefactFileName" --region "$ec2_region" --output=text | cut -f5)

# set env vars
echo "export JAVA_HOME=/usr/bin/java" >> ~/.bashrc

echo "" >> ~/.bashrc
echo "export EC2_INSTANCE_ID='$ec2_instance_id'" >> ~/.bashrc
echo "export EC2_REGION='$ec2_region'" >> ~/.bashrc
echo "export EC2_SERVICE_INSTANCE_NAME='${ec2_service_instance_name}'" >> ~/.bashrc

echo "" >> ~/.bashrc
echo "export EC2_ENV='${ec2_env}'" >> ~/.bashrc

# get app jar from S3
mkdir -p ~/app
cd app
aws s3 sync "s3://${ec2_app_artefact_s3_bucket}" ~/app

sudo mkdir -p "/var/log/bordozer/${ec2_service_name}/"
sudo chmod 777 -R "/var/log/bordozer/${ec2_service_name}/"

# run app
$JAVA_HOME/bin/java -ea -Dspring.profiles.active=aws -jar "${ec2_app_artefact_name}"

