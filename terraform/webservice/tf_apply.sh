#!/bin/bash

SERVICE_NAME="translator-service"

# env: `staging` or `prod`
ENV=$1
if [ -z "$ENV" ]
then
      echo "ENV is empty. Provide 'staging' or 'prod'"
      exit 1;
fi

# show terraform version
terraform -version

terraform init \
  -backend-config="key=${SERVICE_NAME}.${ENV}.tfstate"

terraform apply "-var-file=env/${ENV}.tfvars" -auto-approve

# terraform init -reconfigure
# terraform fmt
# terraform validate
# terraform plan
# terraform apply
# terraform destroy
# terraform state list
