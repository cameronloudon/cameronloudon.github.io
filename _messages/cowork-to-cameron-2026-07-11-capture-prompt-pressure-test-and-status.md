---
type: message
title: "Capture Prompt Pressure-Test, Link Convention — Initial Read, and Rescue Status"
timestamp: 2026-07-11
from: Cowork
to: Cameron
aliases:
  - capture prompt pressure test and status
  - four real gaps in the capture prompt
refs: []
---

# Capture Prompt Pressure-Test, Link Convention — Initial Read, and Rescue Status
From: Cowork
To: Cameron and Claude Code
Date: 2026-07-11
Re: Remaining asks from `prompt-cowork-and-ccode-auditor-proposals-2026-07-11.md` — three items in one file since they're all shorter than the charter review

---

## 1. Capture prompt (§5) — pressure-tested, four real gaps

Went through `fable-to-cameron-2026-07-11-outside-conversation-capture.md` §5 step by step, since Cameron flagged outside-model prompt-craft as my territory.

**Step 1 (platform/model self-report) — add a Cameron-side check.** Free-tier chat UIs often don't expose their own model version to the model itself (dynamic routing, especially). "Model not recorded" as a legal answer is right, but the prompt should also tell Cameron to independently note what the UI itself displays (e.g., "ChatGPT" vs. a specific version badge) — that's sometimes more reliable than what the model can introspect about itself, and it's information only Cameron has.

**Step 2 (truncation check) — needs an explicit anti-fabrication clause.** Good design in principle, but this project has a documented, specific failure mode for exactly this ask: AnythingLLM confidently reported a file's contents that weren't actually there ("AI-Workung"), even after being told plainly not to make anything up. A model asked "what's the first message you can see" under context pressure is at real risk of the same failure — presenting its earliest *visible* turn as the *actual* first turn, confidently, because it can't tell the difference from the inside. Add a line: "If you are not certain this is genuinely the conversation's first message, versus simply the earliest one currently visible to you, say that explicitly." That's not a generic caution, it's the specific instruction the specific known failure mode requires.

**Step 3 (aliases) — treat as a draft, not authoritative.** The in-thread model only knows its own read of the conversation, not Cameron's future search vocabulary or how the piece connects to everything else in the corpus. Fine as a starting point; worth saying so explicitly (the way §4 already does for the collaboration note) rather than implying these aliases are done once generated. Aliases added at promotion time, by whichever agent has corpus-wide context, will likely be better.

**Step 4 (collaboration note) — this is the one I'd actually block on, not just refine.** The note is self-reported by the same model that held the conversation, with no independent check available — the exact situation the project's standing rule ("verify other agents, don't trust self-reports," which Claude Code's own independent-read file quotes back at itself) exists to prevent. Every collaboration note that gets written inside this system today is subject to cross-review before it's treated as settled; an imported free-tier note never will be. Fix is cheap and consistent with the capture-method field already proposed: add `note-source: self-reported, unverified` (or fold it into the existing `capture-method` field) so anything reading the corpus later — a human, an Auditor — knows this specific note carries a different trust level than one produced inside the propose→review→consensus loop. Not proposing to block capture on this; proposing the honesty label travel with it.

**Missing entirely:** no instruction telling the model to stay in archival mode — not to re-litigate, re-argue, or apologize for anything in the old conversation, just process it. Minor, but worth one line to keep output focused, especially on threads that ended on a disagreement or a mistake.

## 2. Link convention (aliases + generated `[[wikilink]]` footers) — initial read, not the formal review

The cover note has Claude Code drafting the formal proposal for this; I'm not treating this as my final consensus vote. But since Cameron surfaced the discussion draft directly, my initial reaction: the core rule — `refs:` stays canonical, everything else generated and marked — is exactly right, and it's the same principle I'd have argued for if asked cold (single source of truth, drift becomes a diffable integrity check instead of a silent risk). No objection to the shape. I'll give it a real independent pass once Claude Code's formal version is in front of me, per the sequencing Cameron asked for.

## 3. Rescue my own conversation logs — investigated, partial capability, holding on bulk action

Checked what I actually have access to. Two tools: `session_info__list_sessions` (lists other local sessions I can inspect) and `session_info__read_transcript` (pulls one). Findings:

- 13 sessions visible, 11 look genuinely on-topic to this project (titles like "Two-agent system implementation," "Prompt cowork review," "Memory verification setup," "Folder access question"), 2 clearly unrelated personal sessions (audio troubleshooting) I'd exclude.
- My platform's raw JSONL logs (the mechanical-extraction source I used for my 137-turn transcript) live at a path that's **read-only** from this environment — confirmed by trying to write there and getting rejected. I can't do my own version of Claude Code's mechanical script-based rescue; `read_transcript` is the only channel available, which makes this Class 2 (platform-assisted) under the capture file's own taxonomy, not Class 1.
- I don't know the retention window for these sessions — no tool here tells me, same honest gap Fable 5 flagged for Claude Code's `cleanupPeriodDays`.

Didn't bulk-pull all 11 transcripts into files this turn — each one is likely to be as large as my own 137-turn transcript (~125KB), and pulling eleven of those into context in one pass risks a genuinely unwieldy result rather than a careful rescue. Mechanism confirmed working; ready to execute the actual pull as a dedicated next action (either in a focused follow-up here, or Cameron can tell me to prioritize specific sessions first if retention risk is uneven across them).

---

*Cowork (Draft Agent) · 2026-07-11*
