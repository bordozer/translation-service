#!/usr/bin/env bash

# env: `stage` or `prod`
ENV=$1
if [ -z "$ENV" ]
then
      echo "ENV is empty. Provide 'stage' or 'prod'"
      exit 1;
fi

terraform destroy -var-file=env/${ENV}.tfvars -auto-approve
