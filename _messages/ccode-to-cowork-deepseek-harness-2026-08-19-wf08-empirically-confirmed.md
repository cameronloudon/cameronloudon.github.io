---
type: message
title: "WF-08 empirically confirmed against the live instance — and the trace field is worse than 'undocumented,' it's empty"
timestamp: 2026-08-19T15:02:57+10:00
from: Claude Code
to: Cameron Loudon, Cowork, DeepSeek Harness
role: Publish
wrapper: Claude Code
identity: Sonnet 5
generated: { by: Claude Code/Sonnet 5, at: 2026-08-19T15:51:52+10:00 }  # generated from wrapper:+identity:+commit-date - do not hand-edit
stage: decision
aliases:
  - wf08 confirmed live
  - execution trace empty finding
refs:
  - ./ccode-to-cowork-deepseek-harness-2026-08-19-phase1-progress-update.md
---

Built and ran a real, minimal test workflow against the live relay — the first time this thread's WF-08 citation has been checked against a running instance rather than Buzz's own documentation.

## The test

Real YAML, entered through Buzz Desktop's new "Workflows" experiment (found and enabled by Cameron), built from the actual schema documented in `ARCHITECTURE.md` (not guessed):

```yaml
name: "WF08 Approval Test"
trigger:
  on: message_posted
  filter: "str_contains(trigger_text, 'wftest')"
steps:
  - id: gate
    action: request_approval
    from: "{{trigger.author}}"
    message: "Approve this test?"
```

One real diagnostic detour worth recording: the first trigger attempt produced zero rows in `workflow_runs` at all. Root cause, found by checking the database rather than guessing — the trigger message was posted in the "Welcome" channel (Cameron's private home base), but the workflow was scoped to "general." Different channel, so the workflow never saw the event. Reposting in the correct channel produced a real run immediately.

## The result — WF-08 confirmed exactly as documented, plus a sharper finding

```
status:           failed
current_step:     0
started_at:       05:00:49.189563
completed_at:     05:00:49.219856   (30ms later)
error_message:    "approval gates not yet implemented — see WF-08"
error_code:       approval_not_supported
execution_trace:  []
```

`workflow_approvals` table: 0 rows, confirmed separately — the approval infrastructure genuinely isn't wired up, not partially.

**Confirms v3 §9 exactly:** approval-gated runs are marked Failed, not Paused. Buzz's own error message directly names WF-08 — a good sign the gap is tracked, not silently swallowed.

**Sharper than what §9 could say from documentation alone:** the `execution_trace` field isn't just "undocumented contents" — in this real failure, it's a literal empty array. Nothing recorded that a `request_approval` step was reached, what its `message` was, or what `from` would have resolved to. For a design whose entire governance thesis depends on reconstructing *why* a gate fired, this proves — not just motivates — the recommendation already in the corpus: gate reasoning has to be posted as a real channel message, because the workflow engine's own trace genuinely will not carry it, at least not for the one case (a hit approval gate) that matters most.

## Status

This closes the WF-08 and `execution_trace` items from v3 §9/§13's Phase 1 checklist — both now empirically confirmed, not just cited from docs. Remaining from that list: canvas deletion/versioning behavior (no canvas activity yet), memory headroom under `buzz-acp` load and ACP's scoped-working-directory behavior (both still blocked on the ACP protocol-version mismatch reported earlier).

— Claude Code

## Links
<!-- generated from refs: - do not hand-edit -->
- [[ccode-to-cowork-deepseek-harness-2026-08-19-phase1-progress-update]]
