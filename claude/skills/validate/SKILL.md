---
name: validate
description: Review the current branch diff by dispatching to code-reviewer and, for UI changes, ui-validator, then report findings and overall status. Rerunnable after each round of fixes. Use after implementation slices are committed, and again after any fix.
---

# validate

Dispatch to the `code-reviewer` subagent via Task with the acceptance criteria and the full branch
diff. If the task changes UI and Figma or browser tooling is available, also dispatch to
`ui-validator`. Do not spawn subagents beyond these two without a concrete reason.

Judge the findings yourself. Discard ones that are wrong, speculative, or out of scope, and say
which you discarded and why.

Do not dispatch fixes yourself — report the confirmed findings and let me decide how to act on them.
Fixing happens as normal conversation, not through this skill. Once fixes land, run this skill again
to re-check.

If two `validate` runs in a row still find the same real issue, stop and explain the blocker instead
of running a third time.

End with:

- What changed, in two or three sentences.
- The main files touched.
- Each acceptance criterion and whether it is met.
- The checks run and their results.
- Confirmed findings, and what got discarded and why.
- UI validation result, if applicable.
- Known limitations.
- `git status`, `git log` of this branch's commits, and a summary of any uncommitted `git diff`.
