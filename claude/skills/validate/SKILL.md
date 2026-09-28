---
name: validate
description: Validate a UI change against its Figma design and in a real browser, by dispatching to the ui-validator subagent. Only for tasks that actually change what the user sees. Use after implementation is committed.
---

# validate

Dispatch to the `ui-validator` subagent via Task with the acceptance criteria, the Figma reference if
known, and the full branch diff.

Report its result plainly: does the rendered UI match, and where it does not.

Not needed for tasks with no visible UI change — skip it.
