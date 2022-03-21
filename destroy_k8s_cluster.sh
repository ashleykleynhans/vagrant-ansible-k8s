#!/usr/bin/env bash

# Destroy the k8s master
echo "Destroying k8s master"
cd k8s/master
vagrant halt
vagrant destroy -f
cd ../..

# Destroy the two k8s nodes
echo "Destroying k8s nodes"
cd k8s/node
vagrant halt
vagrant destroy -f
cd ../..
