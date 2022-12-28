#!/bin/bash

# Check if the file .env exists, if not it stops the script
# The check is bypassed if we are on Jenkins or Gitlab
if [[ ! -f .env && ! ${JENKINS_HOME} && ! ${GITLAB_CI} && ! ${GITHUB_ACTIONS} ]]; then
    printf 'Please create the file .env from the template .env_template and by adding your credentials.\n' >&2
    exit 1
fi

# Source the env file if it exists
if [ -f .env ]; then
    source .env
fi
