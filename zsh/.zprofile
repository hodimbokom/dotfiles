
# personal CLI scripts (this repo) and tools installed into ~/.local/bin (e.g. claude)
export PATH="$HOME/.config/bin:$HOME/.local/bin:$PATH"

# Starship default is ~/.config/starship.toml; ours lives in a subdirectory.
export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"

export EZA_DEFAULT_OPTIONS=" -alg --git --icons --group-directories-first --time-style=long-iso"

export EDITOR="nvim"
export VISUAL="nvim"
