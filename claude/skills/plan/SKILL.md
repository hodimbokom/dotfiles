---
name: plan
description: Compose the implementation plan from research already gathered, by dispatching to the planner subagent, and get explicit approval via plan mode. Use after the research skill has run and reported its findings.
---

# plan

Requires research findings already in this conversation (run the `research` skill first if they are
not there yet).

Call `EnterPlanMode`. Once in plan mode, dispatch to the `planner` subagent via Task, passing the
research findings as its brief. Wait for its result: a plan split into local commits.

Plan mode specifies a plan file to write to — write the plan there, then call `ExitPlanMode` to
request approval. Do not edit any source file before it is approved.
