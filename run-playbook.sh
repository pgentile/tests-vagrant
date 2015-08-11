#!/bin/bash

exec ansible-playbook -i $(pwd)/.vagrant/provisioners/ansible/inventory/vagrant_ansible_inventory $@
