#!/bin/bash

ansible \
    -i .vagrant/provisioners/ansible/inventory/vagrant_ansible_inventory \
    -u vagrant \
    -b \
    all -m shell -a "$*"
