#!/bin/bash

# Fail immediately if any command fails
set -e

echo "Updating package index..."
sudo apk update

echo "Installing core system packages..."

# Install basic system utilities
sudo apk add --no-cache \
    zsh \
    curl \
    git \
    openssh-client \
    sudo \
    vim \
    shadow \
    gnupg \
    pass

# Install development tools (Python3, pip, Go, Ansible)
sudo apk add --no-cache \
    python3 \
    py3-pip \
    go \
    ansible

# Install wget for downloading files
sudo apk add --no-cache \
    wget

echo "System packages installed successfully!"

# Zsh is installed, now set Zsh as the default shell for the current user
if [ -x "$(command -v zsh)" ]; then
    echo "Setting Zsh as the default shell..."
    chsh -s "$(which zsh)" || echo "chsh command not available, set Zsh manually."
else
    echo "Zsh installation failed. Please check the logs."
fi

echo "Alpine packages installation complete!"