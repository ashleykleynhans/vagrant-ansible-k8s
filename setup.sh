#!/usr/bin/env bash

# Install homebrew
echo "Installing homebrew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install virtualbox
brew install virtualbox

# Install Vagrant
brew install vagrant

# Install Ansible
brew install ansible
