---
type: summary
title: "Cowork — Independent Verification Findings"
timestamp: 2026-06-29
from: Cowork
to: Claude Code
aliases:
  - cowork verification findings
  - two-agent-system-process-reference stale
  - anythingllm date placeholder unresolved
refs:
  - ./cowork-session-handoff-2026-06-29.md
---

**Status:** Partial — AnythingLLM system prompt not yet available. All other files audited.

---

## Part 1 — Files quoted and reviewed

1. `cowork-conventions.md` — read in full. Last updated 2026-06-29.
2. `cowork-memory-backup.md` — read in full. Last updated 2026-06-21.
3. `two-agent-system-process-reference.md` — read in full. Dated 2026-06-28.
4. `publish-handoff-template.md` — read in full. Updated 2026-06-29.
5. AI-Working folder structure — full directory listing taken.
6. AnythingLLM system prompt — NOT AVAILABLE. Cameron to paste before verification is complete.

---

## Part 2 — Audit findings

### Finding 1 — CRITICAL: two-agent-system-process-reference.md is out of date

**Source:** `AI-Working/two-agent-system-process-reference.md`, Sections 5, 6, 7, 8

This document describes itself as:
> "the single reference for how the two-agent system works... All critical files should agree with this document."

But it still describes the old unresolved state:
> "Gap 1 — Pre-publish: Draft file location mismatch... Current state: Undocumented and inconsistent."
> "Gap 2 — Post-publish: AI-Prod not synced after merge... currently not implemented"
> "What Has Not Been Resolved — The following questions need Cameron's decision..."

All gaps were resolved and full consensus was reached on 2026-06-29. The document's status header still reads "pending Claude Code review." That review happened and consensus was reached by all three parties.

**Effect:** A cold-start Draft Agent reading this file would believe the process is broken and unresolved. It would also see contradictory information compared to `cowork-conventions.md`, which correctly describes the agreed process.

---

### Finding 2 — SIGNIFICANT: cowork-memory-backup.md project state is stale

**Source:** `AI-Working/Protocols/cowork-memory-backup.md`, Section "Project state as of 2026-06-21"

The entire project state section is 8 days old. Specifically:
> "Active branch: check PROJECT_STATE.md — session-2 has been merged, next branch TBD"
> "Phase 6 in progress (this file is part of Phase 6)"

Multiple sessions have occurred since. A cold-start Draft Agent reading this as orientation would have an inaccurate picture of current project state.

---

### Finding 3 — SIGNIFICANT: Undocumented files at AI-Working root

**Source:** AI-Working directory listing

`cowork-conventions.md` documents 6 subfolders (Drafts/, Ready/, Completed/, Projects/, Protocols/, Prompts/) but says nothing about the many loose files at the AI-Working root level:

- `ai-content-creation-spec.md`
- `rct-session-primer.md`
- `repo-structure.txt`
- `two-agent-system-process-reference.md`
- `cowork-session-handoff-2026-06-29.md`
- Multiple `ai-independence-*.md` files (historical)
- Multiple `session-2026-06-*.md` files (historical session logs)
- Multiple `rwd-*.md` files (historical mobile-first project)
- `cameron-loudon-master-synthesis-prompt-v1_2.md`

A cold-start Draft Agent has no guidance on what any of these files are, which are current, which are historical, or whether they should be consulted.

---

### Finding 4 — SIGNIFICANT: rct-session-primer.md exists in two places

**Source:** AI-Working root (`rct-session-primer.md`) and AI-Prod (`_ai-context/rct-session-primer.md`)

The same file appears to exist in two locations. `cowork-conventions.md` makes no mention of the AI-Working root copy. If the two copies have diverged, a Draft Agent has no way to know which is authoritative. The repo version (`_ai-context/rct-session-primer.md`, accessible via AI-Prod) should be the canonical version.

---

### Finding 5 — SIGNIFICANT: Drafts/ contains non-content files

**Source:** AI-Working/Drafts/ directory listing

Drafts/ contains:
- `anythingllm-system-prompt-draft.md`
- `anythingllm-system-prompt-v2.md`
- `cowork-session-log-2026-06-29-002.md`
- `session-2026-06-12-001.md`

The folder description is "work in progress, not yet approved." The AnythingLLM system prompt drafts are configuration documents, not content drafts for the website. The session log files are operational documents. No guidance exists on what belongs in Drafts/ beyond the single-line description.

---

### Finding 6 — MINOR: cowork-conventions.md §8 references AI_INSTRUCTIONS.md §9

**Source:** `cowork-conventions.md`, Section 8
> "Read `AI_INSTRUCTIONS.md` §9 first."

Cannot be verified from Cowork's position. The Claude Code verification should confirm whether AI_INSTRUCTIONS.md has a §9 and whether the content there is relevant to this instruction.

---

### Finding 7 — MINOR: Handoff template contains stale example

**Source:** `publish-handoff-template.md`, Step 7
> "The session log filename will be `session-2026-06-21-003.md`"

This is a hardcoded historical example date from a specific past session. It will confuse a cold-start agent that tries to follow it literally.

---

### Finding 8 — NOTE: Protocols/ folder contains undocumented files

**Source:** AI-Working/Protocols/ directory listing

In addition to `cowork-conventions.md` and `cowork-memory-backup.md`, Protocols/ contains:
- `prompt-ccode-review-2026-06-12.md`
- `prompt-cowork-review-2026-06-12.md`
- `session-start-verify.md`

These are not mentioned in `cowork-conventions.md`. It is unclear whether `session-start-verify.md` in particular is a current operational document or historical.

---

### Finding 9 — CRITICAL: `{date}` placeholder appears unresolved

**Source:** AnythingLLM system prompt, opening line and collab-note attribution

The prompt contains:
> "Today's date is {date}"
> "collab-note: Draft Agent: Gemma 4 (Google) via Ollama running in AnythingLLM · Date: {date}"

If AnythingLLM automatically resolves `{date}` as a variable this is fine. If it does not, the model sees the literal string `{date}` and will write it into every collab-note. Needs to be confirmed — if not resolving, every draft will have `{date}` as the attribution date instead of the actual date.

---

### Finding 10 — SIGNIFICANT: File path formatting — possible missing backslash

**Source:** AnythingLLM system prompt, Publishing Mode Process and Key Project Files

The structure template path appears as:
> `C:\Users\camer\Documents\AI\AI-Prod_ideas the-bug-the-audit-the-blueprint\index.html`

The correct path should be:
> `C:\Users\camer\Documents\AI\AI-Prod\_ideas\the-bug-the-audit-the-blueprint\index.html`

Similarly `AI-Prod_ai-context\` should be `AI-Prod\_ai-context\`. This may be a display artifact from pasting. If the actual system prompt has the backslash missing, the model will receive a path that does not exist and file reads will fail.

---

### Finding 11 — SIGNIFICANT: No Ready/ → Completed/ close-out step

**Source:** AnythingLLM system prompt — FILE SYSTEM RULES and Publishing Mode

The system prompt describes Drafts/ and Ready/ correctly but does not tell the Draft Agent what to do after Cameron confirms the merge and AI-Prod is synced. The close-out step — verify content in AI-Prod, move file from Ready/ to Completed/ — is absent. A cold-start AnythingLLM agent would leave files in Ready/ indefinitely.

---

### Finding 12 — SIGNIFICANT: No mention of Phase 2

**Source:** AnythingLLM system prompt, Publishing Mode

The prompt ends with "Tell Cameron it is ready for review." It does not explain Phase 2, the second Publish Agent session after Cameron merges, or that the Draft Agent has a role confirming the sync before closing out. The Draft Agent's job does not end at handoff.

---

### Finding 13 — MINOR: Handoff prompt instruction incomplete

**Source:** AnythingLLM system prompt, Publishing Mode
> "Tell Cameron it is ready for review."

Tells the model to inform Cameron but doesn't say what Cameron does next — that Cameron passes the handoff prompt to the Publish Agent. A cold-start agent knows the prompt is saved but has no context for what triggers the next step.

---

### Finding 14 — MINOR: Check-and-balance workflow not mentioned

**Source:** AnythingLLM system prompt vs. `cowork-conventions.md` §4

`cowork-conventions.md` documents the check-and-balance process for technical decisions (CSS, JS, layout files). The system prompt makes no mention of it. AnythingLLM acting as Draft Agent would not know to apply this process.

---

### Finding 15 — MINOR: PowerShell startup steps not mentioned

**Source:** AnythingLLM system prompt vs. `cowork-conventions.md` §3

`cowork-conventions.md` §3 states every Claude Code prompt must include the PowerShell startup block. The system prompt doesn't mention this — an AnythingLLM Draft Agent writing handoff prompts would omit it.

---

## Summary

| # | Severity | Source | Finding |
|---|----------|--------|---------|
| 1 | Critical | `two-agent-system-process-reference.md` | Describes old unresolved gaps — contradicts `cowork-conventions.md` |
| 9 | Critical | AnythingLLM system prompt | `{date}` placeholder may not be resolving — collab-notes would show literal `{date}` |
| 2 | Significant | `cowork-memory-backup.md` | Project state 8 days out of date |
| 3 | Significant | AI-Working root | Many undocumented loose files — no guidance for cold-start agent |
| 4 | Significant | `rct-session-primer.md` | Exists in two locations — authoritative copy unclear |
| 5 | Significant | `Drafts/` folder | Contains configuration files alongside content drafts — scope unclear |
| 10 | Significant | AnythingLLM system prompt | File path may have missing backslash before `_ideas` and `_ai-context` |
| 11 | Significant | AnythingLLM system prompt | Ready/ → Completed/ close-out step absent |
| 12 | Significant | AnythingLLM system prompt | No mention of Phase 2 post-merge workflow |
| 6 | Minor | `cowork-conventions.md` §8 | References `AI_INSTRUCTIONS.md §9` — unverifiable from here |
| 7 | Minor | `publish-handoff-template.md` | Contains stale historical example date |
| 8 | Note | `Protocols/` folder | Contains undocumented files including `session-start-verify.md` |
| 13 | Minor | AnythingLLM system prompt | Handoff instruction doesn't say Cameron passes it to Publish Agent |
| 14 | Minor | AnythingLLM system prompt | Check-and-balance workflow not mentioned |
| 15 | Minor | AnythingLLM system prompt | PowerShell startup steps for Claude Code prompts not mentioned |

---

*Run by Cowork (Draft Agent) · 2026-06-29 · Complete*

## Links
<!-- generated from refs: - do not hand-edit -->
- [[cowork-session-handoff-2026-06-29]]
