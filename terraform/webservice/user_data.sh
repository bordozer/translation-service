#!/bin/bash

# install software
yum update -y
yum install mc -y
yum install java-1.8.0 -y
yum install awscli -y

# create log dirs
sudo mkdir -p "/var/log/bordozer/${t_service_name}/"
sudo chmod 777 -R "/var/log/bordozer/${t_service_name}/"

# Get app artefact
mkdir "${t_app_dir}"
echo "RUN_ARGS='--spring.profiles.active=aws'" >"${t_app_dir}/${t_app_artefact_name}.conf"
aws s3 cp "s3://${t_app_artefact_s3_bucket}/${t_app_artefact_name}" "${t_app_dir}/"

useradd springboot
chsh -s /sbin/nologin springboot
chown springboot:springboot "${t_app_dir}/${t_app_artefact_name}"
chmod 500 "${t_app_dir}/${t_app_artefact_name}"

ln -s "${t_app_dir}/${t_app_artefact_name}" "/etc/init.d/${t_service_instance_name}"

chkconfig "${t_service_instance_name}" on
service "${t_service_instance_name}" start

# aws s3 cp "s3://artefacts-s3-bucket/tf-translator-service-staging.jar" "/opt/translator-service-staging"
# chown springboot:springboot "/opt/translator-service-staging/tf-translator-service-staging.jar"
# chmod 500 "/opt/translator-service-staging/tf-translator-service-staging.jar"
# rm "/etc/init.d/translator-service-staging"
# ln -s "/opt/translator-service-staging/tf-translator-service-staging.jar" "/etc/init.d/translator-service-staging"
# service "translator-service-staging" start
