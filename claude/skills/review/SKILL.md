---
name: review
description: Review the current task's branch diff against its acceptance criteria by dispatching to the code-reviewer subagent. Rerunnable after fixes. Use after implementation slices are committed, and again after any fix. For an arbitrary PR outside this task, use the code-review skill instead.
---

# review

Dispatch to the `code-reviewer` subagent via Task with the acceptance criteria and the full branch
diff of the current task.

Judge the findings yourself. Discard ones that are wrong, speculative, or out of scope, and say
which you discarded and why.

Do not dispatch fixes yourself — report the confirmed findings and let me decide how to act on them.
Fixing happens as normal conversation, not through this skill. Once fixes land, run this skill again
to re-check.

If two `review` runs in a row still find the same real issue, stop and explain the blocker instead
of running a third time.

End with:

- What changed, in two or three sentences.
- The main files touched.
- Each acceptance criterion and whether it is met.
- The checks run and their results.
- Confirmed findings, and what got discarded and why.
- UI validation result, if the `validate` skill has also run for this task — otherwise "not
  applicable".
- Known limitations.
- `git status`, `git log` of this branch's commits, and a summary of any uncommitted `git diff`.
