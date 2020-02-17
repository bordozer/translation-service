#!/bin/bash

sudo yum install mc -y

sudo yum install java-1.8.0 -y

ec2_instance_id=$(ec2-metadata -i | cut -d ' ' -f2)
ec2_region=$(ec2-metadata --availability-zone | cut -d ' ' -f2)
ec2_region=${ec2_region%?}

ec2_service_name=$(aws ec2 describe-tags --filters "Name=resource-id,Values=$ec2_instance_id" "Name=key,Values=Name" --region "$ec2_region" --output=text | cut -f5)
ec2_app_artefact_s3_bucket=$(aws ec2 describe-tags --filters "Name=resource-id,Values=$ec2_instance_id" "Name=key,Values=AppArtefactS3Bucket" --region "$ec2_region" --output=text | cut -f5)
app_env=$(aws ec2 describe-tags --filters "Name=resource-id,Values=$ec2_instance_id" "Name=key,Values=Environment" --region "$ec2_region" --output=text | cut -f5)
app_artefact_name=$(aws ec2 describe-tags --filters "Name=resource-id,Values=$ec2_instance_id" "Name=key,Values=AppArtefactFileName" --region "$ec2_region" --output=text | cut -f5)

echo "export JAVA_HOME=/usr/bin/java" >> ~/.bashrc

echo "" >> ~/.bashrc
echo "export EC2_INSTANCE_ID='$ec2_instance_id'" >> ~/.bashrc
echo "export EC2_REGION='$ec2_region'" >> ~/.bashrc
echo "export EC2_SERVICE_NAME='${ec2_service_name}'" >> ~/.bashrc
echo "export EC2_APP_ARTEFACT_S3_BUCKET='${ec2_app_artefact_s3_bucket}'" >> ~/.bashrc

echo "" >> ~/.bashrc
echo "export EC2_APP_ENV='${app_env}'" >> ~/.bashrc

aws s3 cp "${app_artefact_name}" "s3://${ec2_app_artefact_s3_bucket}"
