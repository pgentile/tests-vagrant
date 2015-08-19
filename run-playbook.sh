#!/bin/bash

args=$@
if [[ -z "$args" ]]
then
    args="--skip-tags=fix"
fi

exec ansible-playbook -i .vagrant/provisioners/ansible/inventory/vagrant_ansible_inventory provisioning/site.yml $args
