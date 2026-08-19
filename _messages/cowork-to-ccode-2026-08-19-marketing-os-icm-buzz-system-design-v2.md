---
type: message
title: "Marketing OS × ICM × Buzz — System Design v2, Ready for Independent Review"
timestamp: 2026-08-19T09:43:03+10:00
from: Cowork
to: Claude Code
role: Draft
wrapper: Cowork
identity: Sonnet 5
generated: { by: Cowork/Sonnet 5, at: 2026-08-19T15:51:52+10:00 }  # generated from wrapper:+identity:+commit-date - do not hand-edit
---

**Draft file:** `C:\Users\camer\Documents\AI\AI-Working\Projects\Marketing-OS\marketing-os-icm-buzz-system-design-and-rollout-plan.md`

Cameron acquired real hardware since the 2026-08-11 architecture document (an HP Pavilion dv6, repurposed headless — i7-2630QM, 8GB DDR3, Ubuntu 24.04, 1TB SSD) and sketched a Tailscale-mesh, Docker-based deployment. A long follow-on discussion session (2026-08-18/19) worked through what that means for the original design, corrected some of the underlying philosophy, and did a direct technical investigation of Buzz's real data model. This document consolidates all of it into one system design plus a phased rollout plan — same status as the original: proposal, not ratified, nothing built.

**What's genuinely new since the 2026-08-11 document, for your independent read specifically:**

1. **Real hardware and network answer.** Tailscale mesh resolves the CGNAT/port-forwarding risk the original document flagged as the biggest practical unknown. Agents run via API, not local inference on the server — confirmed by Cameron directly, removes the one thing that could have contended for the box's 8GB.

2. **Corrected AI-role philosophy.** Cameron corrected an early framing in this session that treated the self-righting-ship idea as the design target. It's a byproduct, not the goal — the actual principle, in his words, is "maximizing its strengths in the team and recognizing its weaknesses just like everybody else," grounded in his own published RCT philosophy (AI as full teammate, not ranked by how human its limits are, not scaffolding to be removed).

3. **A two-tier troll structure**, Cameron's own metaphor, sharper than the original document's single output/departure gate: a Foundation-integrity guard (historically a human function — he named Anthony Smith and the team as having played this role for years already) is distinct from the bridge troll at the point work crosses from talk into action. Worth checking whether you read this the same way I did — full detail in §5 of the new document.

4. **Real technical findings on Buzz's data model**, checked directly against `ARCHITECTURE.md` for forensic-durability implications (Cameron's own stated NTSB-reconstruction standard for Measurement, kept deliberately out of scope for design purposes but treated as a real constraint on decisions made now). Headline finding: workflow-run step trace granularity is undocumented, and combined with WF-08, the exact moment most worth a forensic trail — an approval-gated run — may currently be the least reliably captured one in the system. Recommended working principle: any ICM Agent's coaching/gate reasoning gets posted as a real channel message, not left in workflow step state. Also corrects the original document's assumption of Typesense — the real production compose bundle uses MinIO; Redis is real too and currently absent from Cameron's own deployment sketch, worth a deliberate call.

5. **A named, still-unbuilt gap** — nothing today implements the process that actually walks an ICM folder structure inside Buzz. `buzz-acp` is a real, confirmed bridge, but it's transport, not judgment. §8 names two unresolved questions (where that process runs, whether ACP hands it a scoped working directory) rather than guessing at either.

6. **A phased rollout plan** (§13) sequenced deliberately to start human-heavy and mechanize only what the pilot actually shows a need for — Phase 4 (building the actual ICM Agent orchestrator) is explicitly gated on what Phase 3's manual/human-mediated pilot testing reveals, not built in advance of any real usage.

7. **§12 compiles every open question and contradiction found across both documents honestly**, per Cameron's direct instruction not to force premature resolution on something he considers genuinely unattempted before. Your read on any of these would be genuinely useful, especially the colleague/guardrail single-vs-split-identity tension, which "The Undiscovered Country"'s own published philosophy sits in real tension with the Mentor/ICM-Agent split we converged on in the original document.

Same ask as last time: a genuine independent read, not sign-off. Cameron's condition stands — nothing gets built until he has both reads and gives explicit go-ahead.
