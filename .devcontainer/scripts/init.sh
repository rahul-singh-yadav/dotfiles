#!/bin/sh

# Function to check command success and print error message
check_command() {
    "$@" || { echo "Error: $1 failed"; exit 1; }
}

# Print the current user
echo "Running as user: $(whoami)"

# Check if Git is installed
check_command git --version

# Set global git configuration
check_command git config --global user.name "rahul-singh-yadav"
check_command git config --global user.email "iam.rahulyadav@outlook.com"

# Verify the configuration
git config --list | tail

echo "******* SUCCESS ********"

# Install Oh My Zsh
check_command sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" --unattended

# Configure Oh My Zsh
cat <<EOL >> /home/zenbox/.zshrc
export ZSH="/home/zenbox/.oh-my-zsh"
ZSH_THEME="robbyrussell"
source \$ZSH/oh-my-zsh.sh
export HOSTNAME="devops-cli"
PROMPT='%n@devops-cli %~ %# '
EOL