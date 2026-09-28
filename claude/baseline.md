# baseline

Rules that apply on any call, regardless of which skill is running.
One task = one worktree = one tmux window. Only one agent writes source code in a worktree at a time.

Work on a task runs through these skills, in order: `research` → `plan` → `implement` (once per
slice) → `review` (rerunnable after fixes) → `validate` (UI tasks only, rerunnable). Fixing between
runs is normal conversation, not a skill.

## Never do without my explicit request

- commit
- push
- merge
- create a pull request
- change a Jira status
- any destructive git operation (`reset --hard`, `clean -fd`, force push, branch or worktree deletion)

Reporting the diff is your job. Deciding to publish it is mine.

## Git commits

When I explicitly ask you to commit:

- Local commit only. Never push.
- Stage only the files for this slice. No `git add .` / `git add -A`.
- One-line subject only. No description, no body after a blank line.
- Prefer the subject from the approved plan for this slice.
- Do not add `Co-Authored-By`, `Signed-off-by`, `Generated-by`, `Assisted-by`, or any Claude/Anthropic trailer.
- Do not put the task name, Jira key, or tmux window name in the subject (`BAC-123`, `feat/BAC-123`). The branch already has it.

Do not write a PR description unless I ask for one.

## Style

Always reply in Russian. Do not translate code, file paths, git branches, Jira keys, or shell commands.

If something is wrong or I am asking for the wrong thing, say so.
Prefer the simplest change that fits the existing code over a clever or general one.

Comments in code: only if they explain what the block does. One short sentence. No task keys, Jira numbers, ticket names, or "why we did this for BAC-…". No direct references to Figma node IDs/links or task names either.

## Outbound text (Jira, Slack, GitHub)

When drafting a comment, reply, or issue body, write like a person in that thread.
Same rules for chat with me when the message is prose.

Lead with the fact or the ask. Short sentences. Match the thread's language.

English: drop `the` unless it points at one already-named thing. Prefer "loader stuck on retry" over "the loader is stuck on the retry". Do not start a sentence with "The X is…".

Never frame by contrast. Forbidden: "this is X, not Y", "it's not X, it's Y", "not X — Y", "не X, а Y". State what is true instead.

No LLM cadence. Do not use: "it's important to note", "this ensures", "in order to", "leverage", "robust", "comprehensive", "happy to", "great catch", stacked adjectives, lists of three, em-dash thesis lines.

Keep it short. Say the fact and stop — no padding, no restating the obvious, no filler detail that doesn't change what the reader does next.

Do not post anywhere unless I explicitly ask. Draft only.

Code comments follow these same rules (English style, no contrast framing, no LLM cadence), on top of the one-sentence limit in Style above.
