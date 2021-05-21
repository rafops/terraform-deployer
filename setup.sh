#!/usr/bin/env bash

SCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
# shellcheck source=./terraform.sh
source "${SCRIPTDIR}/terraform.sh"

terraform -chdir=modules/setup init
terraform -chdir=modules/setup apply --auto-approve
