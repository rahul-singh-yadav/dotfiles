# Set Zsh as the default shell
export SHELL=$(which zsh)

# Load custom aliases and functions
source ~/.config/zsh/aliases.zsh
source ~/.config/zsh/plugins.zsh

# Set prompt theme (using Starship prompt as an example, if installed)
if command -v starship &> /dev/null; then
    eval "$(starship init zsh)"
else
    # Basic Zsh prompt fallback
    PS1='%n@%m:%~%# '
fi

# Set some Zsh options for better UX
setopt autocd             # Change directories without needing 'cd'
setopt correct            # Auto-correct mistakes in directory names
setopt nocaseglob         # Case-insensitive globbing
setopt histignorealldups  # Ignore duplicate commands in history

# Enable completions
autoload -U compinit
compinit

# History settings
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000

# Aliases will be loaded from aliases.zsh

