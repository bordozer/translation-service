#!/usr/bin/env bash

# env: `stage` or `prod`
ENV=$1

# show terraform version
terraform -version

terraform init

terraform apply -var-file=env/${ENV}.tfvars -auto-approve

#  -backend-config="bucket=${REMOTE_STATES_BUCKET}" \
#  -backend-config="key=${SERVICE_NAME}.${ENV}" \
#  -backend-config="encrypt=true" \
#  -backend-config="kms_key_id=${KMS_KEY_ID}" \
#  -backend-config="region=us-east-1" \
#  -backend-config="dynamodb_table=${TERRAFORM_STATE_LOCKS_TABLE_NAME}" \
#  -backend=true \
#  -auto-approve

# terraform init -reconfigure
# terraform fmt
# terraform validate
# terraform plan
# terraform apply
# terraform destroy
