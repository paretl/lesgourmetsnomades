#!/bin/bash

set -e

export BASEDIR=$(dirname "$(readlink -f -- "$0")")
cd "${BASEDIR}" || exit

# Get bash methods repository
BASH_METHODS_PATH="${BASEDIR}/../bash-methods"

# Get extra parameters
export ANSIBLE_OPTIONS="$@"
# Use lparet user to connect
export ANSIBLE_USER=lparet

source "${BASEDIR}"/version.sh

printf 'Launch Ansible scripts.\n'
docker-compose pull -q
docker-compose run --rm ansible
