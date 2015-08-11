#!/bin/bash

exec ansible -i $(pwd)/.vagrant/provisioners/ansible/inventory/vagrant_ansible_inventory '*' -m setup
