⸜(｡˃ ᵕ ˂ )⸝♡ My zsh, tmux, neovim, Alacritty and Claude Code setup. macOS on Apple Silicon only (paths assume `/opt/homebrew`).

## Setup

**1. Xcode CLT and Homebrew.** CLT gives you git and a C compiler. Let the install dialog finish before the second command.

```sh
xcode-select --install
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

**2. Clone and point zsh at the repo.** The heredoc makes zsh read `.zshrc` from `~/.config/zsh`. The last line loads it into this shell, so `brew` works in the next step.

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

**4. Alacritty, by hand.** Homebrew disabled the cask (the upstream build isn't Apple-signed), so grab the latest `Alacritty-vX.Y.Z.dmg` from <https://github.com/alacritty/alacritty/releases> and drag it to Applications. No pinned version. Then right-click > Open once, or:

```sh
xattr -dr com.apple.quarantine /Applications/Alacritty.app
```

**5. Node and Claude.** Node goes first, the MCP step needs `npx`. `exec zsh -l` gives you a fresh shell that sees everything installed so far.

```sh
fnm install --lts
fnm default lts-latest
curl -fsSL https://claude.ai/install.sh | bash
exec zsh -l
```

**6. Wire it up.** `bootstrap.sh` goes before the first `claude`, so that session already runs with the linked settings.

```sh
~/.config/bootstrap.sh
claude                          # log in once, then quit
~/.config/claude/mcp-setup.sh
git clone https://github.com/tmux-plugins/tmux-resurrect ~/.config/tmux/plugins/tmux-resurrect
git clone https://github.com/tmux-plugins/tmux-continuum ~/.config/tmux/plugins/tmux-continuum
gh auth login
```

`bootstrap.sh` is safe to rerun. It links Claude settings, agents and skills into `~/.claude`, writes `~/.claude/CLAUDE.md` as an import of `claude/baseline.md`, sets `core.hooksPath` to `githooks`, and moves anything it replaces into `~/.local/state/dotfiles/backup-<timestamp>/`. Obsidian config is linked only if `obsidian/vault-path.local` exists.

## First run

- `nvim` installs lazy.nvim, plugins, treesitter parsers and the LSP servers (Mason) on the first launch. Give it a minute.
- Alacritty opens plain zsh. Start `tmux`, or `cctask dots` (works anywhere), or `cctask main` (inside a git repo). The first tmux start compiles `bin/tmux-status-watch` with clang.

## Requirements

macOS on Apple Silicon, Xcode CLT, Homebrew. zsh is the system one, nothing to install.

- **Terminal:** Alacritty, JetBrainsMono Nerd Font.
- **Shell** (`.zshrc` runs these on every start): starship, zsh-syntax-highlighting, zsh-autosuggestions, fnm, zoxide, eza, bat, fzf, fd, ripgrep, jq.
- **tmux:** tmux, reattach-to-user-namespace, btop.
- **nvim:** neovim >= 0.12, tree-sitter-cli >= 0.26.1 and a C compiler (CLT). Optional: stylua, prettier. Without them format on save does nothing.
- **Git:** git, gh, lazygit, git-delta (lazygit uses `delta` as its pager).
- **Claude and cctask:** Claude Code CLI. Node LTS via fnm: Playwright MCP runs through `npx`, Mason installs `ts_ls`, `cctask` runs the package manager in new worktrees. pnpm, yarn or bun only if a project lockfile uses them. Rust is optional, `.zshenv` sources cargo when it's there.

## Local files

Optional, gitignored, never committed: `zsh/.zshrc.local` (per-machine shell setup), `zsh/aliases.local` (per-machine aliases), `CLAUDE.local.md` (private notes and settings for Claude here), `obsidian/vault-path.local` (one line, a vault path; turns on the Obsidian linking in `bootstrap.sh`).
