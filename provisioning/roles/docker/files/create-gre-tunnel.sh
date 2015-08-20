#!/bin/bash

# Largement inspiré par : https://goldmann.pl/blog/2014/01/21/connecting-docker-containers-on-multiple-hosts/

# S'arrêter à la moindre erreur
set -e


# Name of the bridge
BRIDGE_NAME="$1"

# Nom du tunel
TUNNEL_NAME="$2"

# Adresse distante
REMOTE_ADDRESS="$3"

echo "Builing GRE tunnel $TUNNEL_NAME for bridge $BRIDGE_NAME to remote addr $REMOTE_ADDRESS"

# Create the tunnel to the other host and attach it to the
# br0 bridge
ovs-vsctl add-port $BRIDGE_NAME $TUNNEL_NAME -- set interface $TUNNEL_NAME type=gre options:remote_ip=$REMOTE_ADDRESS
