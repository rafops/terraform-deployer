#!/usr/bin/env bash

SCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

docker run -it --rm \
  --entrypoint /bin/zsh \
  -v "${SCRIPTDIR}/modules:/root/workdir/modules" \
  -v "${HOME}/.aws:/root/.aws" \
  -v "${HOME}/.awsvault:/root/.awsvault/" \
  -w /root/workdir/modules \
  -e AWS_PROFILE \
  -e AWS_REGION \
  -e AWS_ACCESS_KEY_ID \
  -e AWS_SECRET_ACCESS_KEY \
  -e AWS_SESSION_TOKEN terraform-deployer
