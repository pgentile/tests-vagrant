#!/bin/bash

# Largement inspiré par : https://goldmann.pl/blog/2014/01/21/connecting-docker-containers-on-multiple-hosts/

set -e

# The 'other' host
REMOTE_IP=172.28.0.4
# Name of the bridge
BRIDGE_NAME=docker0
# Bridge address
BRIDGE_ADDRESS=172.29.0.3/24
# MTU must include wrapped messages by GRE
MTU=1450


service docker stop || true


# CLEANUP

# Deactivate the docker0 bridge
ip link set $BRIDGE_NAME down || true
# Remove the docker0 bridge
brctl delbr $BRIDGE_NAME || true
# Delete the Open vSwitch bridge
ovs-vsctl del-br br0 || true


# SETUP

# Add the docker0 bridge
brctl addbr $BRIDGE_NAME
sudo ip link set mtu $MTU dev $BRIDGE_NAME
# Add the br0 Open vSwitch bridge
ovs-vsctl add-br br0
sudo ip link set mtu $MTU dev br0
# Create the tunnel to the other host and attach it to the
# br0 bridge
ovs-vsctl add-port br0 gre0 -- set interface gre0 type=gre options:remote_ip=$REMOTE_IP
# Add the br0 bridge to docker0 bridge
brctl addif $BRIDGE_NAME br0
# Activate the bridge
ip link set br0 up
# Activate the bridge
ip link set $BRIDGE_NAME up
# Set up the IP for the docker0 bridge
ip addr add $BRIDGE_ADDRESS dev $BRIDGE_NAME

service docker start
