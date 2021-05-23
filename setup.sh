#!/usr/bin/env bash

# shellcheck source=./terraform.sh
source terraform.sh

backend_configured=0
[[ -f "terraform.tf" ]] && backend_configured=1

set -e

terraform init
terraform apply -target module.terraform_backend -auto-approve
[[ $backend_configured -eq 0 ]] && terraform init -force-copy
