#!/usr/bin/env bash

# env: `stage` or `prod`
ENV=$1

terraform destroy -var-file=env/${ENV}.tfvars -auto-approve
