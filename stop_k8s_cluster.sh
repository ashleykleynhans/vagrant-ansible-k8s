#!/usr/bin/env bash

# Stop the k8s master
cd k8s/master
vagrant halt
cd ..

# Stop the two k8s nodes
cd k8s/node
vagrant halt
cd ..
