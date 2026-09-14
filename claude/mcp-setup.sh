#!/usr/bin/env bash
# Register the MCP servers this workflow uses, at user scope.
#
# Claude Code stores MCP configuration and OAuth tokens in ~/.claude.json, which is
# deliberately not in this repo. This script is the reproducible part: re-run it on a
# new machine, then sign in interactively with /mcp inside Claude.
#
# GitHub is intentionally absent: the `gh` CLI already covers repo, PR, history and CI
# access, so a second GitHub integration would only duplicate it.
#
# Safe to re-run; `claude mcp add` overwrites an existing entry of the same name.

set -euo pipefail

command -v claude >/dev/null || { echo "claude not found in PATH" >&2; exit 1; }

# Jira and Confluence. Requires interactive OAuth: run /mcp inside Claude afterwards.
claude mcp add --transport http --scope user atlassian https://mcp.atlassian.com/v2/mcp

# Figma designs. Requires interactive OAuth, and the Figma desktop app for local file access.
claude mcp add --transport http --scope user figma https://mcp.figma.com/mcp

# Browser automation for ui-validator (Microsoft's official Playwright MCP).
claude mcp add --scope user playwright -- npx -y @playwright/mcp@latest

echo
claude mcp list
