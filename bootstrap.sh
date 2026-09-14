#!/usr/bin/env bash
set -euo pipefail

repo="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
claude_home="$HOME/.claude"
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

for script in "$repo/bin/cctask" "$repo/bin/cctask-toggle-pane" "$repo/bin/cctask-toggle-shell" "$repo/bin/cctask-claude-status" "$repo/bin/tmux-status-git" "$repo/bin/tmux-status-sys" "$repo/bin/claude-statusline"; do
  if [ -f "$script" ] && [ ! -x "$script" ]; then
    chmod +x "$script"
    echo "chmod  bin/$(basename "$script")"
  fi
done

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
