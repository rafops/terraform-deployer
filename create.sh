#!/usr/bin/env bash

SCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
# shellcheck source=./terraform.sh
source "${SCRIPTDIR}/terraform.sh"

module_name=$1

if [[ -d "${SCRIPTDIR}/modules/${module_name}" ]]; then
  echo "Module ${module_name} already exists"
  exit 1
fi

cp -av "${SCRIPTDIR}/modules/_template" "${SCRIPTDIR}/modules/${module_name}"

# Create remote state configuration files
terraform -chdir="modules/${module_name}" init
terraform -chdir="modules/${module_name}" apply --auto-approve

# Remove temporary remote state setup files and local state files
(
  cd "modules/${module_name}" || exit
  rm -rf setup.tf templates terraform.tfstate
  echo "# ${module_name}" > README.md
)
