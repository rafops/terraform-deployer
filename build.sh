#!/usr/bin/env bash

SCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

docker build -f "${SCRIPTDIR}/docker/Dockerfile" -t terraform-deployer .
