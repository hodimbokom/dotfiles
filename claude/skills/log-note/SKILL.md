---
name: log-note
description: Check whether the current session or a task's diff has anything worth recording in the personal notes vault (a decision or a gotcha), and write it straight there if so. Use when the user asks to log, note, or record something, or asks whether this session is worth logging.
---

# log-note

Look at what happened in this session, or a specific task's diff/discussion if pointed at one: a real decision (a choice made, with alternatives and a reason) or a gotcha (a pitfall or workaround worth not re-discovering later).

Most sessions have nothing worth logging. That is a fine outcome — say so and stop.

If something qualifies:

1. Read `~/.config/CLAUDE.local.md` for the vault's path, naming, and tag format.
2. Draft the note: one or two sentences, what happened and why, source linked inline (ticket key as `[[TICKET-KEY]]`, a Slack permalink, a PR URL, or a codebase path).
3. Write it straight to the notes vault, following the format from step 1. Invoking this skill is the explicit ask — no separate confirmation before writing.
4. Show what got written.
