#!/bin/bash

exec ansible-playbook -i .vagrant/provisioners/ansible/inventory/vagrant_ansible_inventory $@
