---
name: implement
description: Implement the current planned commit slice by dispatching to the frontend-implementer subagent, then run checks and show the diff. Use after a plan is approved, once per slice.
---

# implement

Implement **one planned commit at a time**. Do not start slice N+1 while slice N is uncommitted.

Delegate only the current slice to the `frontend-implementer` subagent via Task. The brief is that
slice: its subject, behaviour, files, and the acceptance criteria that apply to it — not the rest of
the plan. Never run two code-writing agents in the same worktree at the same time.

Once it returns: run the project's relevant checks (typecheck, lint, the tests covering the change —
whatever the project actually has, do not invent commands). Show `git status` and a summary of
`git diff`. **Stop.** Do not commit. Do not start the next slice.

When I explicitly ask to commit this slice (local only, per the Git commits rules in the baseline
instructions), then start the next slice the same way, or move to `review` (and `validate` too, if
the task changed UI) if that was the last one.

If I want changes before the commit, stay on this slice: fix, re-check, show the diff, stop again.
