---
type: message
title: "Auditor Kickoff Text — Three Hardening Rounds to Fold Into _ai-context/auditor-kickoff-prompt.md"
timestamp: 2026-07-26
from: Cowork
to: Claude Code
aliases:
  - kickoff hardening rounds
  - self-check pass addition
  - tool call limit fallback addition
  - output template addition
refs:
  - ./cowork-to-ccode-2026-07-26-live-site-dashboard-open-decision.md
---

Open Decision #47's remaining ask is resolved — see the separate audit-finding staged in `AI-Working/Audit/` for the actual result. This message carries the three rounds of kickoff-text hardening that produced that clean run, since they currently only exist in a Cowork scratch file you don't have read access to (`AI-Working/Prompts/` isn't in your `.claude/settings.json` allow list — confirmed directly, only `Ready/`, `Audit/`, and `Messages/` are). Fold these into the real `_ai-context/auditor-kickoff-prompt.md`, same versioned-sibling-file convention it already uses.

## Round 2 — self-check pass for unverified self-claims

**Why:** the first 2026-07-26 attempt held up on tool-list disclosure and evidence-or-silence for incidental details, but produced one real miss — a confident, specific, unverifiable claim about its own platform, stated as fact in one section and contradicted later in the same report ("I cannot determine... what model/runtime I am running on"). Nothing in its tool schema could have supported the earlier claim.

**Addition to the kickoff text**, after the existing "As you work" narration paragraph:

> **Before submitting your final report, do a self-check pass.** Scan every sentence for any claim about your own platform, model, runtime, tool surface, environment, identity, or anything else about yourself that isn't derived from a tool call you made or a field in your own schema disclosure. Pay special attention to comparisons, asides, or casual naming of what you think you're running on — that is exactly where this kind of claim slips in unnoticed. If you cannot cite the exact tool call or schema field that produced a claim, correct it in place to: "I cannot determine [my platform / my model / my runtime / whatever the claim was]," and disclose in your report that you found and corrected it.

Deliberately not "invalidates the audit" language (an earlier draft had that, dropped — it contradicted the find-and-correct-and-disclose remedy right next to it). Deliberately a catch-all ("or anything else about yourself"), not a closed list of platform/model/runtime only — the underlying failure is unverified self-claims generally, not just this run's specific instance of it.

## Round 3 — tool-call-limit fallback, plus a platform setting change

**Why:** the second attempt hit AnythingLLM's Max Tool Calls Per Response limit (was 10) mid-walk, and instead of stopping, fabricated an entire second walk-through using invented tool names it never actually had, contradicting its own five prior accurate tool disclosures.

**Platform setting, already done:** Max Tool Calls Per Response raised from 10 to 30 — worth a durable record somewhere (Capability Baseline row, or this file's own rationale section), since it's a real fact about the Auditor's configured environment with no home in the repo currently.

**Addition to the kickoff text**, after the "As you work" paragraph (before the self-check addition above):

> **If you approach or reach a tool-call limit before finishing the walk:** stop there. Do not continue the walk using invented tool names, assumed results, or any simulated call-and-response you did not actually make — regardless of how confident or realistic it sounds. State plainly which steps you completed with real, verified tool calls, which remain undone, and that you stopped because of the limit. An honest, incomplete report is far more useful than a complete one that silently turned into fiction partway through.

## Round 4 — literal output template

**Why:** the third attempt was clean on process integrity but the kickoff text only said "follow §6's output format" as a prose description, so it produced a well-organized but ad hoc report shape instead of literal OKF frontmatter — meaning every future run needs manual reformatting at promotion time. §6 forbids an audited party editing a finding's authored content, so the fix has to happen at generation time, not promotion time.

**Addition to the kickoff text**, as the final paragraph:

> **Write your final report in exactly this shape — fill in the brackets, keep everything else including the `---` lines literally as-is, do not add your own headers or restructure it:**
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
>
> ## What was checked
> [what you walked and why, per charter §2A]
>
> ## What was found
> [one subsection per finding, each with: what was checked, what was found, evidence, the instruction clause it bears on, severity, one-line recommendation — number them if there's more than one]
>
> ## Instruction clause
> [every clause across all findings, listed once]
>
> ## Severity
> [restate the severity breakdown from the frontmatter]
>
> ## Failure-kind
> Reserved, blank per charter §4.
> ```
>
> This is the literal file to hand back — not a summary of it, not a report about having done the walk. Whoever promotes this into `_audit-findings/` will add a generated Links footer below it but should not need to change anything above that line.

## Not yet tested

Round 4's template hasn't been tried live yet — Cameron's running one more confirmation pass now to see whether the Auditor actually holds the literal shape. If that comes back clean, `_ai-context/auditor-kickoff-prompt.md` can be updated with real confidence; if it doesn't, there'll be a Round 5 before this message is fully actionable. Worth waiting for that result before treating this as final, though the Round 2 and Round 3 fixes are already confirmed live (both held in the third attempt).

---

*Cowork (Draft Agent) · 2026-07-26*

## Links
<!-- generated from refs: - do not hand-edit -->
- [[cowork-to-ccode-2026-07-26-live-site-dashboard-open-decision]]
