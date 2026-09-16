⸜(｡˃ ᵕ ˂ )⸝♡ Clone into `~/.config`:

```sh
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

Install CLI tools, terminal, and font:

```sh
brew install git tmux neovim ripgrep fd fzf jq gh lazygit bat eza starship \
  zsh-syntax-highlighting zsh-autosuggestions reattach-to-user-namespace btop pyenv
brew install --cask alacritty font-jetbrains-mono-nerd-font
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

## Environment

macOS + Homebrew. The rest is what this config actually runs.

**Must be installed** or zsh/tmux/Alacritty will fail on start:

- Alacritty
- JetBrainsMono Nerd Font (`font-jetbrains-mono-nerd-font`)
- zsh
- tmux, `reattach-to-user-namespace`, btop
- starship, `zsh-syntax-highlighting`, `zsh-autosuggestions`
- neovim, ripgrep, fd, fzf, git, jq, gh, lazygit, bat, eza
- pyenv (`.zshrc` always calls `pyenv init`)
- Claude Code CLI
- Xcode Command Line Tools (`xcode-select --install`) — treesitter compiles parsers on first nvim launch

**Needed for the cctask / Claude / nvim flow**, not for opening the terminal:

- **nvm + a Node LTS.** Node is required: `npx` registers Playwright MCP, Mason installs `ts_ls`, `cctask` runs `pnpm`/`npm`/`yarn`/`bun` when a worktree has `package.json`.

```sh
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
nvm install --lts
```

- **pnpm / yarn / bun** — only if the project lockfile uses them. The dotfiles do not pin a package manager.
- **gh** logged in (`gh auth login`) if you use GitHub from the bar/scripts.

Rust/`cargo` is optional: `.zshenv` sources it when present. Python besides pyenv is not required by this repo.
