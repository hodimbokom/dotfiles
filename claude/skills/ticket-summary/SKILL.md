---
name: ticket-summary
description: Summarize my Jira tickets in the current sprint with status and story points, and for tickets not started yet an SP estimate from the ticket plus the code and a verdict on whether each is ready to implement or has open questions. Use when the user asks for a ticket summary, what to pick up next, or whether a ticket is ready. With no args it covers every ticket assigned to me in the sprint. With a ticket key it covers only that ticket.
---

# ticket-summary

Read-only. Do not edit code. Do not comment on, edit, or transition any Jira issue.

1. Read the "Jira ticket triage" section of `~/.config/CLAUDE.local.md`: site, project key, field
   ids, code repo path, searches, calibration query, limits. If the section is missing, say so and
   stop.
2. Check that the connected Atlassian site is the configured one (`getAccessibleAtlassianResources`).
   If it is not, stop and say which check failed.
3. Pick the tickets:
   - Args contain ticket keys: only those issues, nothing else. No list search, no sprint filter,
     any status, and every one of them gets the deep triage in step 5.
   - No args: run the configured sprint search (assigned to me, in an open sprint). That is the
     whole set: dev sub-tasks assigned to me and stories assigned to me directly, each as its own
     row. Do not add parent tickets and do not roll sub-tasks up under parents. Pass `fields`
     explicitly, never use `view: evidence` for a list and never ask for the sprint field, both
     are huge.
4. Show the table right away: key, short title, type, status, SP in Jira, SP estimate (confidence),
   readiness. Until step 5 finishes the last two cells are empty.
5. Deep triage for tickets in the configured deep statuses, or for every explicit key. Cap at the
   configured maximum and say how many were skipped. Dispatch one `ticket-triager` subagent per
   ticket via Task, all in one message so they run in parallel. The brief per ticket: the key, the
   cloudId, the field ids, the code repo path, the calibration query. Tickets in other statuses get
   "-" in the estimate and readiness cells.
6. Present the final table, then below it only the tickets that are not `ready`: the blocking
   questions grouped by who should answer (PO, design, backend, dev), and one line of risk. For a
   `ready` ticket write nothing below the table.
7. Quote ticket text only as much as needed. Do not copy player data or credentials into the
   answer.

Stop here. Starting work on a ticket is the `research` skill, run separately.
