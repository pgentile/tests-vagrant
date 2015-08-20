#!/bin/bash

# Largement inspiré par : https://goldmann.pl/blog/2014/01/21/connecting-docker-containers-on-multiple-hosts/

# S'arrêter à la moindre erreur
set -e


# Name of the bridge
BRIDGE_NAME="$1"
# BRIDGE_NAME=docker0

# OVS bridge name
OVS_BRIDGE_NAME="$2"

# Bridge address
BRIDGE_ADDRESS="$3"
# BRIDGE_ADDRESS=172.29.0.3/24

# MTU must include wrapped messages by GRE
MTU="$4"
# MTU=1450


# CLEANUP

echo "Removing bridges $BRIDGE_NAME and $OVS_BRIDGE_NAME"

# Deactivate the docker0 bridge
ip link set $BRIDGE_NAME down || true
# Remove the docker0 bridge
brctl delbr $BRIDGE_NAME || true
# Delete the Open vSwitch bridge
ovs-vsctl del-br $OVS_BRIDGE_NAME || true


# SETUP

echo "Building bridges $BRIDGE_NAME and $OVS_BRIDGE_NAME, binding to address $BRIDGE_ADDRESS"

# Add the docker0 bridge
brctl addbr $BRIDGE_NAME
sudo ip link set mtu $MTU dev $BRIDGE_NAME
# Add the $OVS_BRIDGE_NAME Open vSwitch bridge
ovs-vsctl add-br $OVS_BRIDGE_NAME
ovs-vsctl set bridge $OVS_BRIDGE_NAME stp_enable=true
sudo ip link set mtu $MTU dev $OVS_BRIDGE_NAME
# Add the $OVS_BRIDGE_NAME bridge to docker0 bridge
brctl addif $BRIDGE_NAME $OVS_BRIDGE_NAME
# Activate the bridge
ip link set $OVS_BRIDGE_NAME up
# Activate the bridge
ip link set $BRIDGE_NAME up
# Set up the IP for the docker0 bridge
ip addr add $BRIDGE_ADDRESS dev $BRIDGE_NAME
