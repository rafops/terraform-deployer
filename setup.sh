#!/usr/bin/env bash

SCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
# shellcheck source=./terraform.sh
source "${SCRIPTDIR}/terraform.sh"

first_time_setup=1
[[ -f "${SCRIPTDIR}/terraform.tf" ]] && first_time_setup=0

terraform init
terraform apply -auto-approve
[[ $first_time_setup -gt 0 ]] && terraform init -force-copy
