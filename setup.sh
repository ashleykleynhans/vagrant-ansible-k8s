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

# Configure VirtualBox host only networks
echo "Configuring VirtualBox host only networks"
sudo mkdir -p /etc/vbox
echo "* 10.0.0.0/8 192.168.0.0/16" | sudo tee -a  /etc/vbox/networks.conf
