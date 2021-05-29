#!/usr/bin/env bash

SCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
DOCKERTAG=${PWD##*/}

docker_run() {
  local entrypoint=$1
  shift

  docker run -it --rm \
    --entrypoint "/bin/${entrypoint}" \
    -v "${SCRIPTDIR}:/root/workdir" \
    -v "${HOME}/.aws:/root/.aws" \
    -e AWS_PROFILE \
    -e AWS_REGION \
    -e AWS_ACCESS_KEY_ID \
    -e AWS_SECRET_ACCESS_KEY \
    -e AWS_SESSION_TOKEN "${DOCKERTAG}" "$@"
}

docker_build() {
  docker build \
    -f "${SCRIPTDIR}/docker/Dockerfile" \
    -t "${DOCKERTAG}" .
}
