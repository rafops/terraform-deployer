#!/usr/bin/env bash

SCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
# shellcheck source=./terraform.sh
source "${SCRIPTDIR}/terraform.sh"

first_time_setup=1
[[ -f "${SCRIPTDIR}/modules/setup/terraform.tf" ]] && first_time_setup=0

terraform_setup() {
  terraform -chdir=modules/setup "$@"
}

terraform_setup init
terraform_setup apply --auto-approve
[[ $first_time_setup -gt 0 ]] && terraform_setup init -force-copy
