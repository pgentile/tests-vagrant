#!/bin/bash

exec ansible \
    -i .vagrant/provisioners/ansible/inventory/vagrant_ansible_inventory \
    -u vagrant \
    -b \
    all -m command -a "$*"
