# Directory where ansible-galaxy should install roles
ROLES_PATH?=./roles

# List of ansible-galaxy requirement filesm space separated
REQUIREMENTS_FILES?=./ansible-role-base/requirements.yml

# Ansible playbook file to launch
PLAYBOOK_FILE?=./playbook.yml

ANSIBLE_VERSION?=2.10.7

VAULTFILES?= --vault-id .vaultfile_base

DOCKER_IMAGE?=889652210640.dkr.ecr.eu-west-1.amazonaws.com/ansible

DOCKER_COMMAND?=docker run \
				--rm \
				--volume $(shell pwd):/provisioning \
				--volume ${SSH_AUTH_SOCK}:/ssh-agent \
				--workdir /provisioning \
				--user "$(shell id -u):$(shell id -g)" \
				--env HOME=/provisioning \
				--env SSH_AUTH_SOCK=/ssh-agent \
				--env ANSIBLE_FORCE_COLOR=true \
				${DOCKER_OPTIONS} \
				${DOCKER_IMAGE}:${ANSIBLE_VERSION}

all: install-roles check

ssh-config:
ifndef SSH_AUTH_SOCK
	$(error Please load ssh-agent)
endif

install-roles: ssh-config
	@${DOCKER_COMMAND} ansible-galaxy install --force --roles-path $(ROLES_PATH) -r $(REQUIREMENTS_FILES)

check: ssh-config
	@${DOCKER_COMMAND} ansible-playbook --diff --check ${VAULTFILES} ${o} $(PLAYBOOK_FILE)

apply: ssh-config
	@printf "\e[1;34mAnsible will apply changes, please don't forget to run your playbook in check mode.\nAre you sure you want to continue? [y/n]: \e[0m" && read ans && [ $${ans:-N} = y ]
	@${DOCKER_COMMAND} ansible-playbook --diff ${VAULTFILES} ${o} $(PLAYBOOK_FILE)

shell:
	$(eval DOCKER_OPTIONS+=--interactive --tty --env HISTFILE=/dev/null --entrypoint /bin/sh)
	@${DOCKER_COMMAND}

clean:
	@rm -rf .ansible*

.PHONY: all ssh-config install-roles check apply shell clean
