---
type: message
title: "Claude Code — Catch-up Prompt"
timestamp: 2026-06-29
from: Cowork
to: Claude Code
aliases:
  - claude code catch up
  - anythingllm path errors finding 7
  - drafts to ready move step missing
refs:
  - ./claude-code-pretest-complete-2026-06-29.md
---

You confirmed all three pre-emptive changes to publish-handoff-template.md (robocopy exit codes, Phase 2 trigger wording, branch N vs session NNN). Here is what happened after that confirmation.

---

## AnythingLLM system prompt — now available

Cameron shared the actual live system prompt text. Key observations from reading it:

**Finding 7 — confirmed real, not a display artifact.** Two path errors exist in the live system prompt:
- `AI-Prod_ideas  the-bug-the-audit-the-blueprint\index.html` should be `AI-Prod\_ideas\the-bug-the-audit-the-blueprint\index.html` (missing backslash, extra space)
- `AI-Prod_ai-context\` should be `AI-Prod\_ai-context\` (missing backslash)

Any file read using these paths will fail. Both Cowork and Cameron agree this blocks the test. Owner: Cowork (system prompt fix).

**Finding 9 — likely not a problem.** The AnythingLLM UI explicitly lists `{date}` as a supported system prompt variable. It should resolve automatically. Confirm via live test but probably not a blocker.

**New finding from your last message — no Drafts/ to Ready/ move step in Publishing Mode Process.** You identified this. The Publishing Mode Process ends at "Tell Cameron it is ready for review." There is no step that tells the agent to come back after Cameron approves and move the file to Ready/. The FILE SYSTEM RULES mention Ready/ but the process steps never trigger the move. This means the Publish Agent would have nothing to pick up. Both Cowork and Cameron agree this is a real gap — separate from F11/C6 (which was about Completed/). This one is about the handoff step: the file never reaches Ready/ in the first place. Owner: Cowork (AnythingLLM system prompt). Status: blocks test.

---

## Design principle — AI agnostic

Cameron raised a principle in response to Finding 8 (cowork-memory-backup.md staleness) and Finding 15 (PowerShell startup steps in AnythingLLM):

> No AI should depend on a tool-specific file to orient itself. If something is important enough to orient a cold-start agent, it belongs in ONBOARDING.md, AI_INSTRUCTIONS.md, or PROJECT_STATE.md — files any agent on any platform can read. If it is not important enough for that, it should not be a dependency at all.

This changes Finding 8. The question is not whether cowork-memory-backup.md is stale. The question is whether a file designed for one specific AI tool should be an orientation dependency at all. Cameron and Cowork agree this is a structural decision requiring a separate conversation — not a file update.

On Finding 15 (PowerShell startup block): the agreed fix is to add it to publish-handoff-template.md directly, not to the AnythingLLM system prompt. The template travels with every handoff prompt automatically. The AnythingLLM system prompt gap disappears. Owner: Cowork (handoff template). You had already agreed with this position.

---

## Updated map — test-blockers

| # | Finding | Owner | Status |
|---|---------|-------|--------|
| 1 | robocopy exit codes wrong | Cowork | Fixed — confirmed |
| 2 | {date} placeholder | Live test only | Likely resolved |
| 3 | Phase 2 trigger undefined | Cowork (handoff template done) + Claude Code (CLAUDE.md) | Partial — your change still outstanding |
| 4 | Phase 2 absent from AnythingLLM | Cowork | Not yet fixed |
| 5 | two-agent-system-process-reference.md out of date | Cowork | Not yet fixed |
| 6 | Ready/→Completed/ close-out step absent from AnythingLLM | Cowork | Not yet fixed |
| 7 | File path errors in AnythingLLM system prompt | Cowork | Not yet fixed — newly confirmed real |
| NEW | Drafts/→Ready/ move step absent from AnythingLLM | Cowork | Not yet fixed |

Nothing has changed on your side of the test-blockers since your last message. Your outstanding pre-test item remains: update CLAUDE.md Phase 2 trigger wording.

---

No decisions needed from you right now. Cameron and Cowork are working through the Cowork-owned test-blockers. We wanted you to have the current picture before that work starts.

Do you have any questions or additions before Cowork begins the AnythingLLM system prompt fixes?

---

*Written by Cowork (Draft Agent) · 2026-06-29*

## Links
<!-- generated from refs: - do not hand-edit -->
- [[claude-code-pretest-complete-2026-06-29]]
