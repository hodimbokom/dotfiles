⸜(｡˃ ᵕ ˂ )⸝♡

macOS on Apple Silicon only.

## Install

```sh
# Xcode CLT and Homebrew
xcode-select --install
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# clone, point zsh at repo
git clone https://github.com/hodimbokom/dotfiles.git ~/.config
cat >> ~/.zshenv <<'EOF'
export ZDOTDIR="$HOME/.config/zsh"
eval "$(/opt/homebrew/bin/brew shellenv)"
[[ -f "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"
EOF
source ~/.zshenv

# tools and font
brew install git tmux neovim tree-sitter-cli ripgrep fd fzf jq gh lazygit git-delta bat eza \
  starship zsh-syntax-highlighting zsh-autosuggestions reattach-to-user-namespace btop fnm zoxide
brew install --cask font-jetbrains-mono-nerd-font
brew install stylua prettier   # optional, format on save in nvim

# node and claude
fnm install --lts
fnm default lts-latest
curl -fsSL https://claude.ai/install.sh | bash
exec zsh -l

# link configs, then log in to claude once and quit
~/.config/bootstrap.sh
claude
~/.config/claude/mcp-setup.sh
git clone https://github.com/tmux-plugins/tmux-resurrect ~/.config/tmux/plugins/tmux-resurrect
git clone https://github.com/tmux-plugins/tmux-continuum ~/.config/tmux/plugins/tmux-continuum
gh auth login
```

Alacritty goes by hand: Homebrew disabled its cask. Download latest dmg from <https://github.com/alacritty/alacritty/releases>, drag to Applications, then:

```sh
xattr -dr com.apple.quarantine /Applications/Alacritty.app
```

Put your git name and email in `~/.gitconfig`. Everything else for git, delta, bat, ripgrep and fd is read from `~/.config`.

`bootstrap.sh` can be rerun. Replaced files go to `~/.local/state/dotfiles/backup-<timestamp>/`.

## First run

`nvim` installs plugins, parsers and LSP servers on first launch, about a minute. Then start `tmux`, or `cctask dots` (anywhere), or `cctask main` (in a git repo).

nvim needs neovim >= 0.12 and tree-sitter-cli >= 0.26.1.

## Local files

Gitignored, per machine: `zsh/.zshrc.local`, `zsh/aliases.local`, `CLAUDE.local.md`, `obsidian/vault-path.local` (one line with vault path, enables Obsidian linking in `bootstrap.sh`).
