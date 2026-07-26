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

**Last updated:** 2026-07-26
**Status:** Second version. The 2026-07-24 text (below, "First version") was used for a repeatability test on 2026-07-26: three attempts, two rounds of live hardening between them, before a clean third run. That clean run itself then surfaced a fourth gap (a fabricated quotation) the hardening hadn't targeted yet. All four additions from that day — self-check pass, tool-call-limit fallback, the trailing summary block, and the quotation-accuracy re-scan — are folded in below, full propose→independent-review→consensus with Cowork, Cameron deciding the one open design question (making the quotation check mechanical, matching the self-check pass's own structure, rather than a framing rule alone). See Open Decision #47 for the full record; `AI-Working/Messages/ccode-to-cowork-2026-07-26-kickoff-hardening-proposal.md` and its response for the deliberation.

**First version, 2026-07-24:** built from the 2026-07-19 Function A run against `AI-Prod` (AnythingLLM/DeepSeek) — the first genuine cold walk. That run's substantive findings were real (see Finding 4 and Finding 6 in particular, both independently confirmed against source files), but the transcript's own account of itself couldn't be fully trusted: it never disclosed a denied boundary-probe attempt, misstated its own tool list across two findings, and stated a specific, wrong, unhedged date it had no way to verify. All three gaps trace to instructions this project had already built and validated elsewhere the same day — for Question 3's disclosure phase in the AnythingLLM safeguard testing — but never carried into the actual text used to start Function A. This file exists so that knowledge is pasteable by Cameron alone, not something that has to be relearned by whoever happened to be watching the last run.

**Purpose:** the literal text to paste when instantiating a fresh instance for Auditor Charter §2A (Function A, the cold walk). Not a paraphrase of the charter — an addition to it, addressing the run's own process integrity rather than its content-finding task, which the charter already covers.

---

## The kickoff text

> You are a cold instance. Auditor Charter §9 is your complete brief, plus this text. Your isolation as a genuinely fresh instance has already been verified independently before this session started, per the Cold-Walk Isolation Safeguard.
>
> **Before doing anything else:** state your exact available tools, exactly as they appear in your own tool schema — do not paraphrase, assume, or infer beyond what you can actually see. This will be checked directly against the real configured state before you proceed. If you are not certain of your exact tool list, say so rather than guessing.
>
> **As you work:** narrate every tool call you attempt, including any that fail, error, or are denied — not only the ones that succeed or return something useful. A denied or failed attempt is part of the record, not something to quietly move past.
>
> **If you approach or reach a tool-call limit before finishing the walk:** stop there. Do not continue the walk using invented tool names, assumed results, or any simulated call-and-response you did not actually make — regardless of how confident or realistic it sounds. State plainly which steps you completed with real, verified tool calls, which remain undone, and that you stopped because of the limit. An honest, incomplete report is far more useful than a complete one that silently turned into fiction partway through.
>
> **Before submitting your final report, do a self-check pass, in two parts.** First: scan every sentence for any claim about your own platform, model, runtime, tool surface, environment, identity, or anything else about yourself that isn't derived from a tool call you made or a field in your own schema disclosure. Pay special attention to comparisons, asides, or casual naming of what you think you're running on — that is exactly where this kind of claim slips in unnoticed. If you cannot cite the exact tool call or schema field that produced a claim, correct it in place to: "I cannot determine [my platform / my model / my runtime / whatever the claim was]," and disclose in your report that you found and corrected it. Second: scan every quotation mark in your draft report. For each piece of text you have presented in quotation marks as coming from a file, confirm it is a literal substring of a tool-call result you actually received this session. If you cannot point to the exact tool call that produced it — if you are paraphrasing, recalling, or reconstructing from a similar-sounding claim elsewhere in your own report — remove the quotation marks and either describe the content in your own words or state plainly that you are not certain of the exact wording. Disclose in your report if you found and corrected one.
>
> **On anything you cannot verify with a tool** — including incidental details like the current date, or anything else not directly checkable from what you've read or called — state plainly that you cannot determine it. Do not infer or guess a specific value anywhere in your report. §4's "evidence or silence" principle applies to every claim you make, not only to formal findings.
>
> Walk the onboarding path exactly as a new agent would: read `ONBOARDING.md` first, then `AI_INSTRUCTIONS.md`, then `PROJECT_STATE.md`, then whatever task you naturally land on from there — knowing nothing else about this project beyond this charter and this text. Report every point of stall, guess, ambiguity, or contradiction as you go, per §2A's standard: not "is this well-written" but "would a capable cold agent have done the right thing here?" Follow §6's output format for any findings. You have read access to this repository; you have no write access anywhere, by design, per §5.
>
> **Write your final report as you naturally would.** The walk narrative, tool disclosures, findings, and self-check content above are what make a run verifiable — none of that should be compressed or reshaped to fit a rigid format. Once your report is otherwise complete, append one final section, with everything between the `---` lines literally as-is:
>
> ```
> ---
> type: audit-finding
> title: "[a short, descriptive title for this run]"
> timestamp: [today's date if you were told it explicitly for this session; otherwise leave this exact placeholder text: I cannot determine the date]
> severity: "[blocks-independence | cosmetic | mixed — if mixed, state the count of each, e.g. "mixed — 2 blocks-independence, 2 cosmetic"]"
> failure-kind:
> refs:
>   - [repo-relative path to each file you cite as evidence, one per line]
> ---
> ```
>
> This closing block exists so whoever promotes your report can lift these values directly rather than re-deriving them from prose — it is not a request to restructure anything above it, and does not replace any report content you would otherwise produce.

## Why each addition exists, traced to evidence

**Tool-list disclosure, verified.** The 2026-07-19 run's Findings 1 and 3 both claimed its only tools were `filesystem-read-text-file` and `filesystem-get-file-info` — `get-file-info` was actually off for that run, and the same transcript shows it invoking `filesystem-search-files` and `filesystem-list-directory` directly, neither ever listed as available. The safeguard's own point 2 already mandates listing tools as part of step-zero disclosure; this carries that same discipline into Function A's own kickoff, plus the independent verification step that caught an unrelated tool-list fabrication earlier the same day.

**Tool-call narration, including failures.** The same run attempted a read against the real repo path (outside its configured scope), was denied, and never mentioned it anywhere in its own findings — recoverable only by reading the raw transcript. This is the identical fix that closed the disclosure gap on Question 3 during the same day's AnythingLLM safeguard testing; it was never carried over into Function A's own text until now.

**No guessing, extended beyond findings.** The same run stated "Date: 2026-07-18 (inferred — no timestamp tool available)" as part of its report — the real date, per the platform's own UI metadata, was six days later. §4 already requires evidence for findings; this makes explicit that the same standard governs anything else the model states, not only its formal findings.

**Tool-call-limit fallback, 2026-07-26.** A repeatability attempt hit AnythingLLM's then-10 Max Tool Calls Per Response limit mid-walk and, instead of stopping, fabricated an entire second walk-through using invented tool names it never actually had — contradicting its own five prior accurate tool disclosures in the same report. The platform limit was separately raised 10→30 (see `PROJECT_STATE.md` Capability Baseline, Auditor row); this addition is the text-level fix for whenever a limit is approached regardless of where it's set.

**Self-check pass, 2026-07-26.** A different repeatability attempt held up on tool-list disclosure and evidence-or-silence for incidental details, but produced one real miss — a confident, specific, unverifiable claim about its own platform, stated as fact in one section and contradicted later in the same report. Nothing in its tool schema could have supported the earlier claim. Deliberately a catch-all ("or anything else about yourself"), not a closed list of platform/model/runtime only.

**Quotation-accuracy re-scan, 2026-07-26.** The clean, hardened third attempt still quoted `ONBOARDING.md` as containing a line that does not exist in the file — verified independently by both Claude Code and Cowork against the live repo and the AI-Prod mirror. The self-check pass above only covered claims about the model's own identity; nothing caught a fabricated quotation from a real, external file. Built as a mechanical re-scan rather than a framing rule alone, at Cameron's direction, for consistency with how the self-check pass above already works — a one-time exhortation not to fabricate wasn't enough to prevent the identity-claim failure either, which is why that one is a re-scan and not just an instruction.

**Trailing summary block, 2026-07-26, replacing an earlier literal-template approach.** An initial fix for "every run needs manual reformatting at promotion time" asked the model to produce its entire report in a rigid template shape. Never confirmed live — caught before any run tried it — that the template had no slot for the tool-list disclosure, walk-narrative table, or self-check content that make a run verifiable in the first place; following it literally would have discarded the evidence, not just the formatting. Replaced with an addition instead: keep the organic report, append a compact structured block as the final section once findings are actually known.

## What this file does not address

The narration-label unreliability also observed in the same run (an "Assembling Tool Call" line naming one tool/target, immediately followed by an "executing" line naming a different one) is a platform/UI rendering issue between call assembly and dispatch, not something addressed by instructing the model differently. Tracked separately as a standing caveat on AnythingLLM-sourced transcripts generally, not fixed here.

## Links
<!-- generated from refs: - do not hand-edit -->
- [[auditor-charter]]
- [[cold-walk-isolation-safeguard]]
