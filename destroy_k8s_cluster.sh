#!/usr/bin/env bash

# Stop the k8s master
cd k8s/master
vagrant halt
vagrant destroy -f
cd ..

# Stop the two k8s nodes
cd k8s/node
vagrant halt
vagrant destroy -f
cd ..
