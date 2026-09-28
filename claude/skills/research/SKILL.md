---
name: research
description: Start research for the current task by dispatching to the researcher subagent — Jira, Figma, the notes vault, and the codebase. Use right after cctask, or whenever the user asks to start research or gather context on a task.
---

# research

Do not touch any source file yourself.

Dispatch to the `researcher` subagent via Task with a brief: the task description, the Jira key if
known, and the current worktree path. Wait for its result.

Present what it found: acceptance criteria, scope, risks, and anything relevant from Jira, Figma,
the notes vault, or the codebase, with where each fact came from.

Stop here. Do not compose an implementation plan — that is the `plan` skill, run separately after
this.

If the researcher reports a blocker (no Jira access, ambiguous requirements, a missing design), say
so and ask. Do not guess and proceed.
