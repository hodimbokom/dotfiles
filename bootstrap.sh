#!/usr/bin/env bash
set -euo pipefail

repo="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
claude_home="$HOME/.claude"
backup_dir="${XDG_STATE_HOME:-$HOME/.local/state}/dotfiles/backup-$(date +%Y%m%d-%H%M%S)"

backup() {
  [ -e "$1" ] || [ -L "$1" ] || return 0
  mkdir -p "$backup_dir"
  mv "$1" "$backup_dir/$(basename "$1")"
  echo "backup $1 -> $backup_dir/$(basename "$1")"
}

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
    backup "$dest"
  fi

  mkdir -p "$(dirname "$dest")"
  ln -sfn "$src" "$dest"
  echo "link   $dest"
}

write_import() {
  local src="$repo/$1" dest="$2"
  local want="@$src"

  if [ ! -e "$src" ]; then
    echo "skip   $dest (missing $src)"
    return
  fi

  if [ -f "$dest" ] && [ ! -L "$dest" ] && [ "$(cat "$dest")" = "$want" ]; then
    echo "ok     $dest"
    return
  fi

  backup "$dest"
  mkdir -p "$(dirname "$dest")"
  printf '%s\n' "$want" > "$dest"
  echo "import $dest -> $src"
}

if ! command -v brew >/dev/null && [ ! -x /opt/homebrew/bin/brew ]; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
eval "$(/opt/homebrew/bin/brew shellenv)"
brew bundle --no-upgrade --file="$repo/Brewfile"

if ! grep -qs ZDOTDIR "$HOME/.zshenv"; then
  cat >> "$HOME/.zshenv" <<'EOF'
export ZDOTDIR="$HOME/.config/zsh"
eval "$(/opt/homebrew/bin/brew shellenv)"
[[ -f "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"
EOF
  echo "write  ~/.zshenv"
fi

eval "$(fnm env)"
fnm install --lts
fnm default lts-latest

export PATH="$HOME/.local/bin:$PATH"
command -v claude >/dev/null || curl -fsSL https://claude.ai/install.sh | bash

for p in tmux-resurrect tmux-continuum; do
  [ -d "$repo/tmux/plugins/$p" ] || git clone "https://github.com/tmux-plugins/$p" "$repo/tmux/plugins/$p"
done

mkdir -p "$claude_home/agents"
write_import claude/baseline.md            "$claude_home/CLAUDE.md"
link claude/settings.json                  "$claude_home/settings.json"
for f in "$repo"/claude/agents/*.md; do
  link "claude/agents/${f##*/}" "$claude_home/agents/${f##*/}"
done
for d in "$repo"/claude/skills/*/; do
  n="$(basename "$d")"
  link "claude/skills/$n/SKILL.md" "$claude_home/skills/$n/SKILL.md"
done

obsidian_vault="$(cat "$repo/obsidian/vault-path.local" 2>/dev/null || true)"
if [ -n "$obsidian_vault" ]; then
  link obsidian/appearance.json        "$obsidian_vault/.obsidian/appearance.json"
  link obsidian/community-plugins.json "$obsidian_vault/.obsidian/community-plugins.json"
  for p in obsidian-style-settings obsidian-minimal-settings obsidian-hider tags-color-files; do
    link "obsidian/plugins/$p/data.json" "$obsidian_vault/.obsidian/plugins/$p/data.json"
  done
  link obsidian/snippets/active-file-contrast.css "$obsidian_vault/.obsidian/snippets/active-file-contrast.css"
  link obsidian/snippets/scrollbar.css             "$obsidian_vault/.obsidian/snippets/scrollbar.css"
  link obsidian/snippets/muted-text.css            "$obsidian_vault/.obsidian/snippets/muted-text.css"
else
  echo "skip   obsidian appearance/community-plugins (no obsidian/vault-path.local)"
fi

for script in "$repo/bin/cctask" "$repo/bin/tmux-pane" "$repo/bin/tmux-status" "$repo/bin/tmux-status-watch" "$repo/bin/tmux-resurrect-fix" "$repo/bin/claude-statusline"; do
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
echo "Done. Next: exec zsh -l, run claude and log in, then claude/mcp-setup.sh and gh auth login."
