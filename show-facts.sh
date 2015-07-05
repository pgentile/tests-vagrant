#!/bin/bash

export ANSIBLE_HOST_KEY_CHECKING=false
export ANSIBLE_SSH_ARGS='-o UserKnownHostsFile=/dev/null -o ControlMaster=auto -o ControlPersist=60s'

exec ansible \
    --user=vagrant \
    --inventory-file=$(pwd)/.vagrant/provisioners/ansible/inventory \
    all -m setup -a "$*"
