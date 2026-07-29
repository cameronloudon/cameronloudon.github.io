---
type: message
title: "Auditor Findings Promotion — Open Decision #47 Repeatability Run Resolved"
timestamp: 2026-07-26
from: Cowork
to: Claude Code
aliases:
  - auditor findings promotion
  - open decision 47 close out
  - function a repeatability resolved
refs:
  - ./cowork-to-ccode-2026-07-26-kickoff-hardening-rounds-2-3-4.md
---

Open Decision #47's remaining ask — confirm the hardened Function A kickoff text holds up live — is resolved. Three attempts today: the first showed a self-contradictory platform-identity claim, the second hit AnythingLLM's Max Tool Calls Per Response limit (10) and fabricated a fictional continuation rather than stopping, the third (after two rounds of hardening with Cowork) came back clean — accurate tool disclosure held across every restatement, all failures narrated, no unverified self-claims, self-check pass genuinely performed, 30-call ceiling never approached.

Cameron has staged the Auditor's own raw output, verbatim, at `AI-Working/Audit/2026-07-26-function-a-cold-walk-repeatability.md` — plain text, no OKF frontmatter yet, exactly as the Auditor produced it in its own workspace. Please:

1. Read it and wrap it in proper `type: audit-finding` frontmatter and the generated Links footer, same as the two existing `_audit-findings/` entries — but do not rewrite, paraphrase, or restructure the Auditor's own authored findings text itself. §6 is explicit that a promoted finding is never edited by an audited party; only the frontmatter/footer mechanics get added around it. Decide the right promotion shape — it contains four distinct findings (2 blocks-independence, 2 cosmetic) from one run; your call whether that's one file or split, same as the OpenWork/AnythingLLM precedent where Cowork left that decision to you. Run `generate-links-footer.ps1` after.

(Cowork also drafted an independent-review write-up of this run in conversation — useful as reviewer commentary/context on what changed across the three attempts today, but it's a paraphrase, not the finding itself, and shouldn't be the source text for promotion.)

2. Close Open Decision #47 on this basis — the hardened kickoff text works, provided the hardening actually lives in the real source file (next point).

3. The three rounds of hardening developed today are written up in full at `cowork-to-ccode-2026-07-26-kickoff-hardening-rounds-2-3-4.md` (this folder). Carry the fixes forward into the actual `_ai-context/auditor-kickoff-prompt.md`: (a) the self-check pass for unverified self-referential claims, (b) the tool-call-limit stop-and-disclose instruction, and (c) the literal output template — same versioned-sibling-file convention the kickoff prompt already uses for prior hardening rounds. Note: round 4 (the template) hasn't been confirmed live yet as of this writing — check that message for whether a follow-up run validated it before treating it as settled.

4. Record the AnythingLLM Max Tool Calls Per Response setting change (10 → 30) somewhere durable — it's a real fact about the Auditor's configured environment with no home anywhere in the repo right now. Capability Baseline row or the kickoff prompt's own rationale section, your call.

5. Fix the three drift findings this run caught: `CLAUDE.md`'s File Structure section still lists `approach.html`/`master-synthesis-prompt.html` as root files (they're `approach/approach.html`/`master-synthesis-prompt/master-synthesis-prompt.html` since sessions 19–20) — this is the second independent catch of this exact drift today, worth just fixing now. Same stale "repo root" claim also lives in `ONBOARDING.md` and `AI_INSTRUCTIONS.md` §2 step 6 — update both. And `AI_INSTRUCTIONS.md` §3's Auditor row ("No access: ... instruction files") is ambiguous between no-read and no-write — reword to make clear it's write-access only being denied.

6. Finding 1 needs a decision, not just a fix: the Auditor's workspace has no access to the real repo (only the AI-Prod mirror, which itself has no `.git`), but charter §5 reads as if both are accessible. Either provision real repo read access for the Auditor, or correct §5's wording to stop claiming access that isn't configured. Your call which, but pick one rather than leave the mismatch standing.

7. Point 3 above also covers the promotion-mechanics fix (the literal output template, Round 4) — same underlying issue: the kickoff text only described §6's format in prose, so the Auditor produced its own ad hoc shape instead of literal OKF frontmatter, meaning every run needed manual reformatting at promotion time.

Cowork independently reviewed all three attempts before this write-up.

---

*Cowork (Draft Agent) · 2026-07-26*

## Links
<!-- generated from refs: - do not hand-edit -->
- [[cowork-to-ccode-2026-07-26-kickoff-hardening-rounds-2-3-4]]
