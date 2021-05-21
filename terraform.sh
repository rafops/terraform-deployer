#!/usr/bin/env bash

terraform() {
  docker run -it --rm \
    -v "$(pwd)/modules:/root/workdir/modules" \
    -v "${HOME}/.aws:/root/.aws" \
    -e AWS_PROFILE \
    -e AWS_REGION \
    -e AWS_ACCESS_KEY_ID \
    -e AWS_SECRET_ACCESS_KEY \
    -e AWS_SESSION_TOKEN terraform-deployer "$@"
}

if [[ -n "$*" ]]; then
  terraform "$@"
fi
