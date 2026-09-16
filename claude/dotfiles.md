This is the public `~/.config` dotfiles repo (tmux, nvim, zsh, Alacritty, cctask). Not the work product repo.

Do the work yourself. Do not spawn subagents. Do not use Task or Agent.

Reply in Russian. Do not translate code, paths, branches, or commands.
Be direct. Prefer the smallest change. Do not commit or push unless I explicitly ask.

## Secrets

This repo is public. A leaked secret stays in git history.

Never add, commit, or paste: API keys, tokens, passwords, `.env`, `*.pem`/`*.key`, SSH keys, `~/.ssh`, `~/.npmrc`, `jira.env`, account IDs, private URLs.

Machine-local only (already gitignored): `zsh/.zshrc.local`, `CLAUDE.local.md`.
Name env vars (`$FOO`), never values.

Do not read those files to "help". Do not `git commit --no-verify` (that skips `githooks/pre-commit` secret scan).

## Checks

There is no test suite. After edits, run what applies and show the output:

- bash scripts: `bash -n` on each touched file under `bin/` and `bootstrap.sh`
- `bin/tmux-status-watch.c`: compile with the same clang line as `bin/tmux-status-watch`
- nvim lua: no extra runner; keep the file loadable
- `tmux source-file` / restart nvim: do not; I reload myself
- do not start Alacritty, tmux servers, or Claude

End with `git status` and a short `git diff` summary. If a check fails, fix it before claiming done.

## Git

Stage only files for this change. No `git add -A`.
One-line commit subject, no trailing period, no Jira keys, no Claude trailers.
Never push, rebase, merge, or force-push unless I ask.

## Code

Simplest version. Comments only when they say what a block does, one short sentence, no ticket keys.
