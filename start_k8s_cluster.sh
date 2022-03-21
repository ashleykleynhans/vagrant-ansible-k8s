#!/usr/bin/env bash

# Start and Provision the k8s master
cd k8s/master
vagrant up
cd ..

# Start and Provision the two k8s nodes
cd k8s/node
vagrant up
cd ..
