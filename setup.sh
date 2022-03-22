#!/usr/bin/env bash

# Install homebrew
echo "Installing homebrew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install virtualbox
echo "Installing VirtualBox"
brew install virtualbox

# Install Vagrant
echo "Installing Vagrant"
brew install vagrant

# Install Ansible
echo "Installing Ansible"
brew install ansible

# Install cfssl
echo "Installing cfssl"
brew install cfssl

# Configure VirtualBox host only networks
echo "Configuring VirtualBox host only networks"
sudo mkdir -p /etc/vbox
echo "* 10.0.0.0/8 192.168.0.0/16" | sudo tee -a  /etc/vbox/networks.conf

# Generate CA certs
echo "Generating CA certs"
cfssl gencert -initca certs/ca-csr.json | cfssljson -bare certs/ca

# Generate Kubernetes Certs
echo "Generating Kubernetes certs"
cfssl gencert \
-ca=certs/ca.pem \
-ca-key=certs/ca-key.pem \
-config=certs/ca-config.json \
-hostname=10.10.10.11,10.10.10.12,10.10.10.92,127.0.0.1,kubernetes.default \
-profile=kubernetes certs/kubernetes-csr.json | \
cfssljson -bare certs/kubernetes
