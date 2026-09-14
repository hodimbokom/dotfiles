⸜(｡˃ ᵕ ˂ )⸝♡

Dotfiles. This repository *is* `~/.config`, so zsh, tmux, nvim, alacritty, btop and
starship read their configuration from here directly with no linking step.

## Fresh machine

```sh
git clone https://github.com/hodimbokom/dotfiles.git ~/.config
```

Then create `~/.zshenv` (the one file that must live outside this repo):

```sh
export ZDOTDIR="$HOME/.config/zsh"
eval "$(/opt/homebrew/bin/brew shellenv)"
[[ -f "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"
```

Then:

```sh
brew install git tmux neovim ripgrep fd fzf jq gh lazygit bat eza starship
curl -fsSL https://claude.ai/install.sh | bash   # Claude Code -> ~/.local/bin/claude
~/.config/bootstrap.sh                           # links claude/* into ~/.claude
~/.config/claude/mcp-setup.sh                    # registers the MCP servers
```

tmux plugins are not vendored here, so clone them once:

```sh
git clone https://github.com/tmux-plugins/tmux-resurrect ~/.config/tmux/plugins/tmux-resurrect
git clone https://github.com/tmux-plugins/tmux-continuum ~/.config/tmux/plugins/tmux-continuum
```

`tmux.conf` loads them only if they are present, so a machine without them still works.
With them installed, `prefix + C-s` saves the session and `prefix + C-r` restores it;
continuum then auto-saves every 15 minutes and restores on server start. Automatic
launch at login is off — set `@continuum-boot 'on'` and uncomment `@continuum-boot-options`
in [tmux/tmux.conf](tmux/tmux.conf) if you want Alacritty to open itself when you log in.

`bootstrap.sh` links only the individual Claude config files, never the whole
`~/.claude` directory, because Claude keeps generated state and credentials there.
`~/.claude.json` holds OAuth tokens and is deliberately not tracked.

## Claude Code workflow

One task = one worktree = one tmux window.

```sh
cctask BAC-123                 # worktree + tmux window for the task
cctask BAC-123 feat/BAC-123    # with an explicit branch name
cctask --dry-run BAC-123       # show what would happen, change nothing
```

Run it from anywhere inside a git repository. It fetches `origin`, creates or reuses
the branch and a worktree at `~/.worktrees/<repo>/<task>`, then opens a tmux window
named after the task with three panes:

```
┌───────────────────────┬────────────┐
│                       │  claude    │
│       nvim .          ├────────────┤
│                       │  shell     │
└───────────────────────┴────────────┘
```

Re-running it for the same task reuses the existing window instead of starting a
second Claude in the same worktree.

In the Claude pane:

```
Work on BAC-123. Research the Jira issue, relevant Figma and codebase.
Give me the implementation plan first.
```

Claude researches and stops. Once the plan looks right:

```
Approved. Implement it.
```

The flow from there:

```
task
  -> parent researches (Jira, Figma, codebase)
  -> you approve the plan
  -> frontend-implementer implements
  -> typecheck / lint / tests
  -> code-reviewer
  -> ui-validator (only if the task changes UI)
  -> fixes, max two loops
  -> you review the diff
  -> you commit and push, manually
```

Claude never commits, pushes, merges, opens PRs or touches Jira unless you ask.

The coordinator rules live in [claude/CLAUDE.md](claude/CLAUDE.md), the subagents in
[claude/agents/](claude/agents/), and permissions in [claude/settings.json](claude/settings.json).

### Cleaning up a finished task

Worktree lifecycle is manual on purpose:

```sh
git worktree list
git worktree remove ~/.worktrees/<repo>/<task>
git branch -d <branch>
git worktree prune          # if you deleted the directory by hand
```

### Local env in a worktree

A worktree is a fresh checkout, so machine-local files like `.env` are not there.
Nothing is copied automatically. If the repository has a `.worktreeinclude`, `cctask`
copies the paths it lists; otherwise it just warns you that setup may be needed.
