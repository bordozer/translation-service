#!/usr/bin/env bash

# env: `staging` or `prod`
ENV=$1
if [ -z "$ENV" ]
then
      echo "ENV is empty. Provide 'staging' or 'prod'"
      exit 1;
fi

echo "=================================================="
echo "Environment '${ENV}' is going to be destroyed!"
echo "=================================================="

read -r -p "Type 'Destroy ${ENV}' to proceed: " confirm
if [ "${confirm}" = "Destroy ${ENV}" ]; then
   terraform destroy -var-file=env/${ENV}.tfvars -auto-approve
   echo "Environment '${ENV}' has been destroyed. R.I.P."
fi

echo ""
echo "Wrong confirmation"
echo ""
