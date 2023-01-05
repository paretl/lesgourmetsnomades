#!/bin/sh

set -e

BASEDIR=$(dirname "$(readlink -f -- "$0")")
ROOTDIR="${BASEDIR}/.."
cd "${ROOTDIR}" || exit

printf 'Install custom roles.\n'
ansible-galaxy install \
    --force \
    -r "${ROOTDIR}/requirements.yml"

printf 'Launch Ansible bootstrap playbook.\n'
ansible-playbook "${ROOTDIR}/base.yml" \
    -u ${ANSIBLE_USER} \
    -i "${ROOTDIR}/inventory.yaml" \
    ${ANSIBLE_OPTIONS} \
    --diff
