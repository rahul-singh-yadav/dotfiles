#!/bin/bash

# Fail immediately if any command fails
set -e

# Define the dotfiles path
DOTFILES_DIR="$HOME/dotfiles"
ZSH_CONFIG_DIR="$HOME/.config/zsh"

echo "Setting up Zsh configuration..."

# Step 1: Ensure Zsh is installed
if ! command -v zsh &> /dev/null; then
    echo "Zsh is not installed. Please install it before proceeding."
    exit 1
fi

# Step 2: Install Oh My Zsh if not already installed
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Oh My Zsh not found, installing..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" --unattended
else
    echo "Oh My Zsh is already installed."
fi

# Step 3: Create the Zsh configuration directory if it doesn't exist
mkdir -p "$ZSH_CONFIG_DIR"

# Step 4: Symlink Zsh configuration files from the dotfiles repo
ln -sf "$DOTFILES_DIR/zsh/.zshrc" "$HOME/.zshrc"
ln -sf "$DOTFILES_DIR/zsh/aliases.zsh" "$ZSH_CONFIG_DIR/aliases.zsh"
ln -sf "$DOTFILES_DIR/zsh/plugins.zsh" "$ZSH_CONFIG_DIR/plugins.zsh"

echo "Zsh configuration files symlinked successfully."

# Step 5: Install zsh-syntax-highlighting and zsh-autosuggestions if not already installed
echo "Checking for optional Zsh plugins (zsh-syntax-highlighting and zsh-autosuggestions)..."

if [ ! -d /usr/share/zsh-syntax-highlighting ]; then
    echo "Installing zsh-syntax-highlighting..."
    sudo apk add zsh-syntax-highlighting
else
    echo "zsh-syntax-highlighting already installed."
fi

if [ ! -d /usr/share/zsh-autosuggestions ]; then
    echo "Installing zsh-autosuggestions..."
    sudo apk add zsh-autosuggestions
else
    echo "zsh-autosuggestions already installed."
fi

# Step 6: Set Zsh as the default shell (if it's not already the default)
if [ "$SHELL" != "$(which zsh)" ]; then
    echo "Setting Zsh as the default shell..."
    chsh -s $(which zsh) || echo "Unable to change default shell. Please do it manually."
else
    echo "Zsh is already the default shell."
fi

echo "Zsh setup (with Oh My Zsh) completed successfully!"

