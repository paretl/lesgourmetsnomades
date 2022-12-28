#!/bin/bash

set -e

export BASEDIR=$(dirname "$(readlink -f -- "$0")")
cd "${BASEDIR}" || exit

# Get bash methods repository
BASH_METHODS_PATH="${BASEDIR}/../bash-methods"

# Check custom script parameters
SCRIPT_PARAMS_VARIABLES=(STEP)
SCRIPT_PARAMS_USAGE='<step ex.login|init|plan|apply>'
source "${BASH_METHODS_PATH}"/components/check-bash-parameters.sh
# Source .env file
source "${BASH_METHODS_PATH}"/env-file/source-dot-env-file.sh

# Get env variables
source "${BASEDIR}"/version.sh

# Define parameters for each command
export TF_CLI_ARGS_init="-upgrade"
export TF_CLI_ARGS_apply="-auto-approve"

# Prepare environment variables
export USER_ID=$(id -u)

# Run terraform script + get terraform command exit code
source "${BASH_METHODS_PATH}"/terraform/run-docker-compose-with-exit-code.sh
