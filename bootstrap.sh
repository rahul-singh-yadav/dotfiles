#!/bin/bash

# Fail immediately if any command fails
set -e

echo "Starting bootstrap process..."

# Step to make all shell scripts executable
echo "Making all shell scripts executable..."
find "$HOME/dotfiles" -name "*.sh" -exec chmod +x {} \;

# Step 1: Install necessary system packages
echo "Installing system packages..."
./install/alpine-packages.sh

# Step 2: Set up Zsh configuration
echo "Setting up Zsh configuration..."
./install/zsh-setup.sh

# Step 3: Install and configure DevOps tools (AWS CLI, Terraform, kubectl, etc.)
#echo "Installing and configuring DevOps tools..."
#./install/devops-setup.sh

# Step 4: Set up symbolic links to dotfiles
echo "Setting up symbolic links..."
./install/symlinks.sh

echo "Bootstrap process completed successfully!"