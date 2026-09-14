#!/usr/bin/env bash
# Register the MCP servers this workflow uses, at user scope.
#
# Claude Code stores MCP configuration and OAuth tokens in ~/.claude.json, which is
# deliberately not in this repo. This script is the reproducible part: re-run it on a
# new machine, then sign in interactively with /mcp inside Claude.
#
# GitHub is intentionally absent: the `gh` CLI already covers repo, PR, history and CI
# access, so a second GitHub integration would only duplicate it.

set -euo pipefail

command -v claude >/dev/null || { echo "claude not found in PATH" >&2; exit 1; }

# `claude mcp add` fails on a name that already exists, so check first. This keeps the
# script safe to re-run and leaves an existing server's OAuth sign-in untouched.
add() {
  local name="$1"; shift
  if claude mcp get "$name" >/dev/null 2>&1; then
    echo "ok    $name already registered"
  else
    claude mcp add "$@"
  fi
}

# Jira and Confluence. Requires interactive OAuth: run /mcp inside Claude afterwards.
add atlassian --transport http --scope user atlassian https://mcp.atlassian.com/v2/mcp

# Figma designs. Requires interactive OAuth, and the Figma desktop app for local files.
add figma --transport http --scope user figma https://mcp.figma.com/mcp

# Browser automation for ui-validator (Microsoft's official Playwright MCP).
add playwright --scope user playwright -- npx -y @playwright/mcp@latest

echo
claude mcp list
