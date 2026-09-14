#!/usr/bin/env bash
# Link the parts of this repo that cannot simply live in ~/.config.
#
# Everything else (zsh, tmux, nvim, alacritty, btop, starship) is read by its tool
# directly from ~/.config, so it needs no linking. Claude Code reads ~/.claude, and
# that directory also holds runtime state we deliberately keep out of git, so we
# link individual files rather than the directory.
#
# Safe to re-run.

set -euo pipefail

repo="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
claude_home="$HOME/.claude"
# Not under ~/.claude/backups: that directory belongs to Claude Code, which rotates
# its own .claude.json backups there.
backup_dir="${XDG_STATE_HOME:-$HOME/.local/state}/dotfiles/backup-$(date +%Y%m%d-%H%M%S)"

link() {
  local src="$repo/$1" dest="$2"

  if [ ! -e "$src" ]; then
    echo "skip   $dest (missing $src)"
    return
  fi

  if [ -L "$dest" ] && [ "$(readlink "$dest")" = "$src" ]; then
    echo "ok     $dest"
    return
  fi

  # Preserve anything real that is already there before replacing it.
  if [ -e "$dest" ] && [ ! -L "$dest" ]; then
    mkdir -p "$backup_dir"
    mv "$dest" "$backup_dir/$(basename "$dest")"
    echo "backup $dest -> $backup_dir/$(basename "$dest")"
  fi

  mkdir -p "$(dirname "$dest")"
  ln -sfn "$src" "$dest"
  echo "link   $dest"
}

mkdir -p "$claude_home/agents"

link claude/CLAUDE.md                      "$claude_home/CLAUDE.md"
link claude/settings.json                  "$claude_home/settings.json"
link claude/agents/frontend-implementer.md "$claude_home/agents/frontend-implementer.md"
link claude/agents/code-reviewer.md        "$claude_home/agents/code-reviewer.md"
link claude/agents/ui-validator.md         "$claude_home/agents/ui-validator.md"

if [ -f "$repo/bin/cctask" ] && [ ! -x "$repo/bin/cctask" ]; then
  chmod +x "$repo/bin/cctask"
  echo "chmod  bin/cctask"
fi

# This repository is public, so scan commits for credentials. Hooks in .git/hooks
# aren't versioned, hence core.hooksPath pointing at a tracked directory.
if [ -d "$repo/githooks" ] && git -C "$repo" rev-parse --git-dir >/dev/null 2>&1; then
  chmod +x "$repo/githooks/pre-commit" 2>/dev/null || true
  if [ "$(git -C "$repo" config --local --get core.hooksPath || true)" != "githooks" ]; then
    git -C "$repo" config --local core.hooksPath githooks
    echo "hooks  core.hooksPath -> githooks"
  else
    echo "ok     core.hooksPath already set"
  fi
fi

echo
echo "Done. MCP servers are not linked; run claude/mcp-setup.sh to register them."
