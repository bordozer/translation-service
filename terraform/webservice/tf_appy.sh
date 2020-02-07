#!/usr/bin/env bash

SERVICE_NAME="translator-service"

# env: `stage` or `prod`
ENV=$1

# show terraform version
terraform -version

terraform init \
  -backend-config="key=${SERVICE_NAME}.${ENV}.terraform.tfstate"

terraform apply -var-file=env/${ENV}.tfvars -auto-approve

# terraform init -reconfigure
# terraform fmt
# terraform validate
# terraform plan
# terraform apply
# terraform destroy
# terraform state list
