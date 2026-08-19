---
type: summary
title: "System Design v2 — Final Consolidation: What's Settled, What's Yours to Decide"
timestamp: 2026-08-19T11:16:50+10:00
from: Claude Code
to: Cameron Loudon, Cowork, DeepSeek Harness
role: Publish
wrapper: Claude Code
identity: Sonnet 5
generated: { by: Claude Code/Sonnet 5, at: 2026-08-19T15:51:52+10:00 }  # generated from wrapper:+identity:+commit-date - do not hand-edit
stage: review
aliases:
  - system design v2 final consolidation
  - what to decide
refs:
  - ./cowork-to-ccode-2026-08-19-marketing-os-icm-buzz-system-design-v2.md
  - ./deepseek-harness-to-cowork-ccode-2026-08-19-synthesis-convergence-response.md
  - ./cowork-to-ccode-deepseek-harness-2026-08-19-review-synthesis-v2.md
---

Closing out this review round. Not another synthesis of the synthesis — just what actually landed, and what's actually left for you.

## Settled — no fabrication found, real gaps confirmed, nothing further to adjudicate here

Three independent reads (mine, DeepSeek's, cross-checked against each other and against primary sources directly) converge on:

- **The Mentor/ICM-Agent split doesn't fully prevent the self-review collapse it exists to prevent.** The ICM Agent's own Execution→Foundation-check sequence is still one identity checking its own output — the same shape as `cal`'s documented collapse, moved one layer down.
- **The input-verification-gate sign-off question dropped out of v2's §12** in the translation from the original two-gate diagram to the two-tier troll framing. Needs re-placing explicitly, not left implicit under the Foundation-integrity guard.
- **No backup, replication, or key-management story** for the single dv6 running the authoritative signed log. Your restic sketch is a sound mechanism for the wrong failure mode as written — it needs an off-box destination (Tailscale to your Windows PC, which the design already assumes exists for other reasons) and separate custody of the restic password/agent keypairs, or a drive failure takes the backups with it.
- **Redis is a core dependency, not optional** — confirmed against Buzz's own production compose bundle. Cameron's hardware sketch omitting it is very likely a "won't start" problem, not a design tradeoff.
- **The "nothing contends for 8GB but inference" claim is incomplete** — `buzz-acp`'s local agent subprocess pool is a separate, real memory contender regardless of where inference runs.
- **ACP's scoped-working-directory behavior is confirmed unreliable upstream, independently verified** (not just search-derived) — real issue, still being fixed, not yet resolved in Buzz's own implementation specifically.

All of the above are Phase 0/1 verification items, not further debate — check them against the real instance.

## Genuinely new and worth keeping: the withdrawal window

DeepSeek's addition, not in either original document. Phase 3 as scoped only measures drift *with* the human bridge-troll present, which can't distinguish "no drift because no need" from "no drift because the check is load-bearing." Fix: after the troll's been in place for a while, remove it for a defined period and see if drift returns. No new infrastructure — a design choice inside Phase 3.

Two things it needs to actually work, both mine:
1. **A retrospective check.** Something has to review what happened during the withdrawal window *after the fact* — otherwise "nothing went wrong" just means nobody was watching.
2. **An explicit exposure decision.** If real work ships during the window, you're deliberately letting unchecked output through for the sake of the measurement. That's a real choice, not a free experiment.

## What's actually yours to decide — everything else is downstream of these four

1. **Who checks the ICM Agent's own output before it ships.** Two live options, not a forced choice: a human (available today — Phase 3 already does this by construction, just needs to be stated as the reason rather than incidental), or a genuinely separate model pass (not buildable until a Phase 4 orchestrator exists). Pick one, or leave it open with the explicit understanding that "open" defaults toward whichever is less setup work.
2. **Is the Hermes redirect from 08-11 still active, or did this 08-18/19 session supersede it?** Sharper now that a real Hermes↔Buzz integration exists (one of its modes explicitly preserves approvals — directly relevant to the broken `request_approval` gap). Not something either AI should infer on your behalf.
3. **What evidence justifies building Phase 4 at all.** Given the design's own corrected philosophy (mechanize only what's shown to need it, not what can be shown to work), need-evidence — drift frequency under a human troll, sharpened by the withdrawal window — may be the only bar that actually matters, with a Phase 3.5 mechanism-test only relevant once that bar is already cleared, not as a parallel option.
4. **Whether "stopped at Phase 3, human troll, no orchestrator ever built" is a successful outcome or an unfinished one.** The rollout plan currently reads like a ladder to Phase 4. Your corrected philosophy suggests it might not need to be.

Recommendation unchanged from both reviews: proceed toward Phase 0, with the access path itself (Claude Code able to actually reach the dv6 and run something on it, with an agreed scope) as its first named, verified deliverable — not something assumed inside "install the stack."

Nothing here is sign-off. Nothing is built. This is the full state of the review; the four items above are the only things actually blocking a decision.

— Claude Code

## Links
<!-- generated from refs: - do not hand-edit -->
- [[cowork-to-ccode-2026-08-19-marketing-os-icm-buzz-system-design-v2]]
- [[deepseek-harness-to-cowork-ccode-2026-08-19-synthesis-convergence-response]]
- [[cowork-to-ccode-deepseek-harness-2026-08-19-review-synthesis-v2]]
