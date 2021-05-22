#!/usr/bin/env bash

module_name=$1
shift

if [[ -z "${module_name}" ]]; then
  echo "Usage: $0 <new module name>"
  exit 1
fi

SCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
# shellcheck source=./terraform.sh
source "${SCRIPTDIR}/terraform.sh"

if [[ -d "${SCRIPTDIR}/modules/${module_name}" ]]; then
  echo "Module ${module_name} already exists"
  exit 1
fi

set -e

# Create a new module using setup module as a template
cp -a "${SCRIPTDIR}/modules/setup" "${SCRIPTDIR}/modules/${module_name}"
# Cleanup setup backend config, state files, main and outputs
(
  cd "modules/${module_name}" || exit
  rm -rf .terraform* terraform.tf*
  echo "# ${module_name}" > README.md
  echo "# ${module_name} module resources" > main.tf
  echo "# ${module_name} module outputs" > outputs.tf
)

# Create remote state configuration files
terraform -chdir="modules/${module_name}" init
terraform -chdir="modules/${module_name}" apply -auto-approve

# Cleanup remote, template files and temporary state files
(
  cd "modules/${module_name}" || exit
  rm -rf .terraform* terraform.tfstate*
  rm -rf remote.tf _*.tf.tpl
)
