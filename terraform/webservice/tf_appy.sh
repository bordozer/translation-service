#!/usr/bin/env bash

# env: `stage` or `prod`
ENV=$1

# show terraform version
terraform -version

terraform init

terraform apply -var-file=env/${ENV}.tfvars  -auto-approve

# terraform fmt
# terraform validate
# terraform destroy
