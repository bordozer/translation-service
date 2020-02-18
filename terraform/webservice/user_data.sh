#!/bin/bash

# install software
yum update -y
yum install mc -y
yum install java-1.8.0 -y
yum install awscli -y

# get EC2 vars
ec2_instance_id=$(ec2-metadata -i | cut -d ' ' -f2)
ec2_region=$(ec2-metadata --availability-zone | cut -d ' ' -f2)
ec2_region=${ec2_region%?}

# get EC2 tags
ec2_service_name=$(aws ec2 describe-tags --filters "Name=resource-id,Values=$ec2_instance_id" "Name=key,Values=ServiceName" --region "$ec2_region" --output=text | cut -f5)
ec2_app_artefact_name=$(aws ec2 describe-tags --filters "Name=resource-id,Values=$ec2_instance_id" "Name=key,Values=AppArtefactFileName" --region "$ec2_region" --output=text | cut -f5)
ec2_app_artefact_s3_bucket=$(aws ec2 describe-tags --filters "Name=resource-id,Values=$ec2_instance_id" "Name=key,Values=AppArtefactS3Bucket" --region "$ec2_region" --output=text | cut -f5)
ec2_service_instance_name=$(aws ec2 describe-tags --filters "Name=resource-id,Values=$ec2_instance_id" "Name=key,Values=Name" --region "$ec2_region" --output=text | cut -f5)

# set ec2-user env vars
{
  echo "export 'PS1=\${whoami}@\$(pwd) $ '"
  echo ""
  echo "export EC2_INSTANCE_ID='$ec2_instance_id'"
  echo "export EC2_REGION='$ec2_region'"
  echo "export EC2_SERVICE_NAME='${ec2_service_name}'"
} >>"/home/ec2-user/.bashrc"

# create log dirs
sudo mkdir -p "/var/log/bordozer/${ec2_service_name}/"
sudo chmod 777 -R "/var/log/bordozer/${ec2_service_name}/"

# Get app artefact
APP_DIR="/opt/${ec2_service_instance_name}"
mkdir "${APP_DIR}"
echo "RUN_ARGS=--spring.profiles.active=aws" >"${APP_DIR}/${ec2_app_artefact_name}.conf"
aws s3 cp "s3://${ec2_app_artefact_s3_bucket}/${ec2_app_artefact_name}" "${APP_DIR}/"

useradd springboot
chsh -s /sbin/nologin springboot
chown springboot:springboot "${APP_DIR}/${ec2_app_artefact_name}"
chmod 500 "${APP_DIR}/${ec2_app_artefact_name}"

ln -s "${APP_DIR}/${ec2_app_artefact_name}" "/etc/init.d/${ec2_service_instance_name}"

chkconfig "${ec2_service_instance_name}" on
service "${ec2_service_instance_name}" start

# aws s3 cp "s3://artefacts-s3-bucket/tf-translator-service-stage.jar" "/opt/translator-service-stage"
# chown springboot:springboot "/opt/translator-service-stage/tf-translator-service-stage.jar"
# chmod 500 "/opt/translator-service-stage/tf-translator-service-stage.jar"
# rm "/etc/init.d/translator-service-stage"
# ln -s "/opt/translator-service-stage/tf-translator-service-stage.jar" "/etc/init.d/translator-service-stage"
# service "translator-service-stage" start
