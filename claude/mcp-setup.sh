#!/usr/bin/env bash
set -euo pipefail

command -v claude >/dev/null || { echo "claude not found in PATH" >&2; exit 1; }

add() {
  local name="$1"; shift
  if claude mcp get "$name" >/dev/null 2>&1; then
    echo "ok    $name already registered"
  else
    claude mcp add "$@"
  fi
}

add atlassian --transport http --scope user atlassian https://mcp.atlassian.com/v2/mcp
add figma --transport http --scope user figma https://mcp.figma.com/mcp
add playwright --scope user playwright -- npx -y @playwright/mcp@latest

echo
claude mcp list
