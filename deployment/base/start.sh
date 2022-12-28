#!/bin/bash

set -e

BASEDIR=$(dirname "$(readlink -f -- "$0")")
cd "${BASEDIR}" || exit

printf 'Create default network.\n'
docker network create web || true

docker-compose pull --quiet
docker-compose up -d
docker restart prometheus
