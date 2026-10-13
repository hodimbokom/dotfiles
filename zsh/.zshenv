[[ -n $HOMEBREW_PREFIX ]] || eval "$(/opt/homebrew/bin/brew shellenv)"
[[ -f "$HOME/.cargo/env" ]] && . "$HOME/.cargo/env"
