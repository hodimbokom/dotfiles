⸜(｡˃ ᵕ ˂ )⸝♡

macOS on Apple Silicon only.

## Install

```sh
xcode-select --install   # wait for install dialog to finish
git clone https://github.com/hodimbokom/dotfiles.git ~/.config && ~/.config/bootstrap.sh
```

Then:

```sh
exec zsh -l
claude                          # log in once, then quit
~/.config/claude/mcp-setup.sh
gh auth login
```

Alacritty goes by hand: Homebrew disabled its cask. Download latest dmg from <https://github.com/alacritty/alacritty/releases>, drag to Applications, then:

```sh
xattr -dr com.apple.quarantine /Applications/Alacritty.app
```

Put your git name and email in `~/.gitconfig`. Everything else for git, delta, bat, ripgrep and fd is read from `~/.config`.

## What bootstrap.sh does

Safe to rerun. Steps in order:

1. Installs Homebrew if missing, then runs `brew bundle --no-upgrade` on `Brewfile`.
2. Adds `ZDOTDIR`, `brew shellenv` and cargo to `~/.zshenv` if `ZDOTDIR` is not there yet. This makes zsh read `.zshrc` from `~/.config/zsh`.
3. Installs Node LTS through fnm and sets it as default.
4. Installs Claude Code if `claude` is missing.
5. Clones tmux-resurrect and tmux-continuum into `tmux/plugins`.
6. Links Claude settings, agents and skills into `~/.claude`, writes `~/.claude/CLAUDE.md` with an import of `claude/baseline.md`, sets `core.hooksPath` to `githooks`. Replaced files go to `~/.local/state/dotfiles/backup-<timestamp>/`.
7. Links Obsidian config if `obsidian/vault-path.local` exists.

## What Brewfile installs

`brew bundle` reads `Brewfile` and installs everything listed that is missing. Installed packages are skipped and not upgraded (`--no-upgrade`), so rerun is cheap. Nothing gets removed.

| Group | Packages | Used for |
|---|---|---|
| shell | starship, zsh-syntax-highlighting, zsh-autosuggestions, fnm, zoxide | prompt, highlighting and suggestions, Node versions, `z` jumps. `.zshrc` loads all of them on every start. |
| search and files | ripgrep, fd, fzf, bat, eza, jq, btop | search, fuzzy finder with file preview, `ls` and `cat` replacements, JSON, system monitor |
| git | git, gh, lazygit, git-delta | git itself, GitHub CLI, TUI, diff pager (lazygit uses `delta`) |
| tmux | tmux, reattach-to-user-namespace | multiplexer, macOS clipboard inside tmux |
| nvim | neovim, tree-sitter-cli, stylua, prettier | editor, parser builds, formatters. Without stylua and prettier format on save is off. |
| font | font-jetbrains-mono-nerd-font | JetBrainsMono Nerd Font for Alacritty and prompt icons |

zsh is system-provided. Alacritty and Rust are not in `Brewfile`: Alacritty is installed by hand (above), cargo is picked up from `~/.cargo/env` if you have it. pnpm, yarn or bun only if a project lockfile needs them.

nvim needs neovim >= 0.12 and tree-sitter-cli >= 0.26.1. Plugins, parsers and LSP servers install on first launch, about a minute.

## First run

Start `tmux`, or `cctask dots` (anywhere), or `cctask main` (in a git repo). First tmux start compiles `bin/tmux-status-watch` with clang.

## Local files

Gitignored, per machine: `zsh/.zshrc.local`, `zsh/aliases.local`, `CLAUDE.local.md`, `obsidian/vault-path.local` (one line with vault path, enables Obsidian linking in `bootstrap.sh`).
