---
type: reference
title: "Auditor Kickoff Prompt"
aliases:
  - auditor kickoff prompt
  - function a kickoff text
  - cold walk instantiation text
refs:
  - ./auditor-charter.md
  - ./cold-walk-isolation-safeguard.md
---

**Last updated:** 2026-07-24
**Status:** First version, built from the 2026-07-19 Function A run against `AI-Prod` (AnythingLLM/DeepSeek) — the first genuine cold walk. That run's substantive findings were real (see Finding 4 and Finding 6 in particular, both independently confirmed against source files), but the transcript's own account of itself couldn't be fully trusted: it never disclosed a denied boundary-probe attempt, misstated its own tool list across two findings, and stated a specific, wrong, unhedged date it had no way to verify. All three gaps trace to instructions this project had already built and validated elsewhere the same day — for Question 3's disclosure phase in the AnythingLLM safeguard testing — but never carried into the actual text used to start Function A. This file exists so that knowledge is pasteable by Cameron alone, not something that has to be relearned by whoever happened to be watching the last run.

**Purpose:** the literal text to paste when instantiating a fresh instance for Auditor Charter §2A (Function A, the cold walk). Not a paraphrase of the charter — an addition to it, addressing the run's own process integrity rather than its content-finding task, which the charter already covers.

---

## The kickoff text

> You are a cold instance. Auditor Charter §9 is your complete brief, plus this text. Your isolation as a genuinely fresh instance has already been verified independently before this session started, per the Cold-Walk Isolation Safeguard.
>
> **Before doing anything else:** state your exact available tools, exactly as they appear in your own tool schema — do not paraphrase, assume, or infer beyond what you can actually see. This will be checked directly against the real configured state before you proceed. If you are not certain of your exact tool list, say so rather than guessing.
>
> **As you work:** narrate every tool call you attempt, including any that fail, error, or are denied — not only the ones that succeed or return something useful. A denied or failed attempt is part of the record, not something to quietly move past.
>
> **On anything you cannot verify with a tool** — including incidental details like the current date, or anything else not directly checkable from what you've read or called — state plainly that you cannot determine it. Do not infer or guess a specific value anywhere in your report. §4's "evidence or silence" principle applies to every claim you make, not only to formal findings.
>
> Walk the onboarding path exactly as a new agent would: read `ONBOARDING.md` first, then `AI_INSTRUCTIONS.md`, then `PROJECT_STATE.md`, then whatever task you naturally land on from there — knowing nothing else about this project beyond this charter and this text. Report every point of stall, guess, ambiguity, or contradiction as you go, per §2A's standard: not "is this well-written" but "would a capable cold agent have done the right thing here?" Follow §6's output format for any findings. You have read access to this repository; you have no write access anywhere, by design, per §5.

## Why each addition exists, traced to evidence

**Tool-list disclosure, verified.** The 2026-07-19 run's Findings 1 and 3 both claimed its only tools were `filesystem-read-text-file` and `filesystem-get-file-info` — `get-file-info` was actually off for that run, and the same transcript shows it invoking `filesystem-search-files` and `filesystem-list-directory` directly, neither ever listed as available. The safeguard's own point 2 already mandates listing tools as part of step-zero disclosure; this carries that same discipline into Function A's own kickoff, plus the independent verification step that caught an unrelated tool-list fabrication earlier the same day.

**Tool-call narration, including failures.** The same run attempted a read against the real repo path (outside its configured scope), was denied, and never mentioned it anywhere in its own findings — recoverable only by reading the raw transcript. This is the identical fix that closed the disclosure gap on Question 3 during the same day's AnythingLLM safeguard testing; it was never carried over into Function A's own text until now.

**No guessing, extended beyond findings.** The same run stated "Date: 2026-07-18 (inferred — no timestamp tool available)" as part of its report — the real date, per the platform's own UI metadata, was six days later. §4 already requires evidence for findings; this makes explicit that the same standard governs anything else the model states, not only its formal findings.

## What this file does not address

The narration-label unreliability also observed in the same run (an "Assembling Tool Call" line naming one tool/target, immediately followed by an "executing" line naming a different one) is a platform/UI rendering issue between call assembly and dispatch, not something addressed by instructing the model differently. Tracked separately as a standing caveat on AnythingLLM-sourced transcripts generally, not fixed here.

## Links
<!-- generated from refs: - do not hand-edit -->
- [[auditor-charter]]
- [[cold-walk-isolation-safeguard]]
