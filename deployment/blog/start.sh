#!/bin/bash

set -e

BASEDIR=$(dirname "$(readlink -f -- "$0")")
cd "${BASEDIR}" || exit

docker-compose pull --quiet
docker-compose up -d
