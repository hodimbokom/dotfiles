---
name: dotfiles-review
description: Run an expert review of the dotfiles repo and report concrete improvements (shorter code, fewer steps, robustness, structure, better alternatives, Claude Code setup). Use when the user asks to review, audit, or find improvements in their dotfiles or workflow setup. Optional args are area names (tmux, zsh, nvim, claude, bin) or --since followed by a git revision.
context: fork
agent: dotfiles-reviewer
background: false
---

Review the dotfiles repo at `~/.config`.

Scope, from the arguments: $ARGUMENTS

- No arguments: the whole repo.
- Area names (tmux, zsh, nvim, claude, bin and so on): only those top-level directories.
- `--since <rev>`: the files changed since that revision, plus what they are wired through
  (`bootstrap.sh`, and the tmux or zsh files that load them).

Follow your instructions and answer in your output format. Do not apply any change.
