#!/bin/bash

set -e

BASEDIR=$(dirname "$(readlink -f -- "$0")")
cd "${BASEDIR}" || exit

# Get bash methods repository
BASH_METHODS_PATH="${BASEDIR}/../bash-methods"

# Source .env file
source "${BASH_METHODS_PATH}"/env-file/source-dot-env-file.sh

SSH_OPTIONS="-o StrictHostKeyChecking=no"
PROD_SERVER="lparet@lesgourmetsnomades.fr"
SSH_COMMAND_EXEC="ssh ${SSH_OPTIONS} ${PROD_SERVER}"

REMOTE_BASE_DIRECTORY="/home/lparet/base"
LOCAL_BASE_DIRECTORY="${BASEDIR}/base"
LOCAL_ENV_FILE="${BASEDIR}/.env"

printf 'Deploy other services.\n'
${SSH_COMMAND_EXEC} mkdir -p "${REMOTE_BASE_DIRECTORY}"
rsync -rvzP "${LOCAL_BASE_DIRECTORY}" "${PROD_SERVER}:/home/lparet"
rsync -rvzP "${LOCAL_ENV_FILE}" "${PROD_SERVER}:${REMOTE_BASE_DIRECTORY}/"
${SSH_COMMAND_EXEC} chmod 700 "${REMOTE_BASE_DIRECTORY}"/start.sh
${SSH_COMMAND_EXEC} "${REMOTE_BASE_DIRECTORY}"/start.sh

REMOTE_WEBSITE_DIRECTORY="/home/lparet/lesgourmetsnomades"
LOCAL_WEBSITE_DIRECTORY="${BASEDIR}/blog"

printf 'Deploy lesgourmetsnomades.fr website.\n' "${WEBSITE_NAME}"
${SSH_COMMAND_EXEC} mkdir -p "${REMOTE_WEBSITE_DIRECTORY}"
rsync -rvzP "${LOCAL_WEBSITE_DIRECTORY}" "${PROD_SERVER}:/home/lparet"
rsync -rvzP "${LOCAL_ENV_FILE}" "${PROD_SERVER}:${REMOTE_WEBSITE_DIRECTORY}/"
${SSH_COMMAND_EXEC} chmod 700 "${REMOTE_WEBSITE_DIRECTORY}/start.sh"
${SSH_COMMAND_EXEC} "${REMOTE_WEBSITE_DIRECTORY}/start.sh"
