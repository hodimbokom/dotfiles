⸜(｡˃ ᵕ ˂ )⸝♡ Clone into `~/.config`:

```markdown

git clone https://github.com/hodimbokom/dotfiles.git ~/.config
```

Point zsh at this repo:

```sh
cat >> ~/.zshenv <<'EOF'
export ZDOTDIR="$HOME/.config/zsh"
eval "$(/opt/homebrew/bin/brew shellenv)"
[[ -f "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"
EOF
```

Install CLI tools and font:

```sh
brew install git tmux neovim ripgrep fd fzf jq gh lazygit bat eza starship
brew install --cask font-jetbrains-mono-nerd-font
```

Install Claude and wire config:

```sh
curl -fsSL https://claude.ai/install.sh | bash
~/.config/bootstrap.sh
~/.config/claude/mcp-setup.sh
```

Install tmux session plugins:

```sh
git clone https://github.com/tmux-plugins/tmux-resurrect ~/.config/tmux/plugins/tmux-resurrect
git clone https://github.com/tmux-plugins/tmux-continuum ~/.config/tmux/plugins/tmux-continuum
```
