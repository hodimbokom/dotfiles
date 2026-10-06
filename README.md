⸜(｡˃ ᵕ ˂ )⸝♡

## Setup

**1. Xcode CLT and Homebrew.** CLT brings git and a C compiler. Wait for install dialog to finish before running second command.

```sh
xcode-select --install
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

**2. Clone and point zsh at repo.** Heredoc makes zsh read `.zshrc` from `~/.config/zsh`. Last line sources it in current shell, so `brew` works in next step.

```sh
git clone https://github.com/hodimbokom/dotfiles.git ~/.config
cat >> ~/.zshenv <<'EOF'
export ZDOTDIR="$HOME/.config/zsh"
eval "$(/opt/homebrew/bin/brew shellenv)"
[[ -f "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"
EOF
source ~/.zshenv
```

**3. Tools and font.**

```sh
brew install git tmux neovim tree-sitter-cli ripgrep fd fzf jq gh lazygit git-delta bat eza \
  starship zsh-syntax-highlighting zsh-autosuggestions reattach-to-user-namespace btop fnm zoxide
brew install --cask font-jetbrains-mono-nerd-font
brew install stylua prettier   # optional: format on save in nvim
```

**4. Alacritty, by hand.** Homebrew disabled cask because upstream build isn't Apple-signed. Download latest `Alacritty-vX.Y.Z.dmg` from <https://github.com/alacritty/alacritty/releases> and drag to Applications. Version isn't pinned. On first launch right-click > Open, or run:

```sh
xattr -dr com.apple.quarantine /Applications/Alacritty.app
```

**5. Node and Claude.** Node first, MCP step needs `npx`. `exec zsh -l` restarts shell so it sees everything installed so far.

```sh
fnm install --lts
fnm default lts-latest
curl -fsSL https://claude.ai/install.sh | bash
exec zsh -l
```

**6. Wire it up.** Run `bootstrap.sh` before first `claude`, so that session starts with linked settings.

```sh
~/.config/bootstrap.sh
claude                          # log in once, then quit
~/.config/claude/mcp-setup.sh
git clone https://github.com/tmux-plugins/tmux-resurrect ~/.config/tmux/plugins/tmux-resurrect
git clone https://github.com/tmux-plugins/tmux-continuum ~/.config/tmux/plugins/tmux-continuum
gh auth login
```

`bootstrap.sh` can be rerun safely. It links Claude settings, agents and skills into `~/.claude`, writes `~/.claude/CLAUDE.md` with an import of `claude/baseline.md`, sets `core.hooksPath` to `githooks`, and moves replaced files to `~/.local/state/dotfiles/backup-<timestamp>/`. Obsidian config gets linked only if `obsidian/vault-path.local` exists.

## First run

- `nvim` installs lazy.nvim, plugins, treesitter parsers and LSP servers (Mason) on first launch. Takes about a minute.
- Alacritty opens plain zsh. Run `tmux`, or `cctask dots` (works anywhere), or `cctask main` (inside a git repo). First tmux start compiles `bin/tmux-status-watch` with clang.

## Requirements

macOS on Apple Silicon, Xcode CLT, Homebrew. zsh is system-provided, nothing to install.

- **Terminal:** Alacritty, JetBrainsMono Nerd Font.
- **Shell** (`.zshrc` loads these on every start): starship, zsh-syntax-highlighting, zsh-autosuggestions, fnm, zoxide, eza, bat, fzf, fd, ripgrep, jq.
- **tmux:** tmux, reattach-to-user-namespace, btop.
- **nvim:** neovim >= 0.12, tree-sitter-cli >= 0.26.1 and a C compiler (CLT). Optional: stylua, prettier. Without them format on save is off.
- **Git:** git, gh, lazygit, git-delta (lazygit uses `delta` as its pager).
- **Claude and cctask:** Claude Code CLI. Node LTS via fnm: Playwright MCP runs through `npx`, Mason installs `ts_ls`, `cctask` runs package manager in new worktrees. pnpm, yarn or bun only if project lockfile needs them. Rust is optional, `.zshenv` sources cargo if it exists.

## Local files

Optional, gitignored: `zsh/.zshrc.local` (per-machine shell setup), `zsh/aliases.local` (per-machine aliases), `CLAUDE.local.md` (private notes for Claude in this repo), `obsidian/vault-path.local` (one line with vault path, enables Obsidian linking in `bootstrap.sh`).
