
# personal CLI scripts (this repo) and tools installed into ~/.local/bin (e.g. claude)
typeset -U path
path=($HOME/.config/bin $HOME/.local/bin /opt/homebrew/bin /opt/homebrew/sbin $path)

# Starship default is ~/.config/starship.toml; ours lives in a subdirectory.
export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"

export RIPGREP_CONFIG_PATH="$HOME/.config/ripgrep/config"

export EDITOR="nvim"
export VISUAL="nvim"
