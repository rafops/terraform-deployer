#!/usr/bin/env bash

# shellcheck source=./config.sh
source config.sh

terraform() {
  docker_run terraform "$@"
}

[[ $_ == "$0" ]] && terraform "$@"
