#!/bin/bash

# Fail immediately if any command fails
set -e

# Define the dotfiles path and config directory
DOTFILES_DIR="$HOME/dotfiles"
CONFIG_DIR="$HOME/.config"

# Define an array of files to symlink
declare -A SYMLINKS=(
    ["$DOTFILES_DIR/zsh/.zshrc"]="$HOME/.zshrc"
    ["$DOTFILES_DIR/zsh/aliases.zsh"]="$CONFIG_DIR/zsh/aliases.zsh"
    ["$DOTFILES_DIR/zsh/plugins.zsh"]="$CONFIG_DIR/zsh/plugins.zsh"
)

# Function to create symlinks
create_symlink() {
    local source_file="$1"
    local target_file="$2"

    if [ -e "$target_file" ]; then
        echo "File already exists: $target_file"
        echo "Backing up existing file to: ${target_file}.bak"
        mv "$target_file" "${target_file}.bak"
    fi

    echo "Creating symlink: $target_file -> $source_file"
    ln -sf "$source_file" "$target_file"
}

# Create the necessary directories
mkdir -p "$CONFIG_DIR/zsh"

# Iterate over the symlinks and create them
for source in "${!SYMLINKS[@]}"; do
    target="${SYMLINKS[$source]}"
    create_symlink "$source" "$target"
done

echo "Symlinks created successfully!"

