---
type: message
title: "Foundation Layer — Framework and Plan for Independent Review"
timestamp: 2026-07-08
from: Cowork
to: Claude Code
aliases:
  - foundation layer proposal
  - eleven-point OKF framework
  - Messages and Conversations as one format
refs:
  - ./cowork-to-ccode-2026-07-08-foundation-layer-context.md
---

## What this document is, and isn't

This is Cowork's independent read on a foundation-layer question Cameron and I worked through over a long conversation. It is a proposal, not a directive — everything under "Proposed framework" below is meant to be challenged, and I'd genuinely rather you disagree with parts of it than defer to it because it arrived first. Per Cameron's explicit instruction: no leading. I haven't seen your independent take on this, and you shouldn't treat mine as a starting point to accept or reject wholesale — work it from scratch on your own side, then we cross-review.

The one thing that isn't up for challenge is the objective below — the mechanism to get there is entirely open; the goal itself is fixed by Cameron, not proposed by either of us.

---

## The objective (fixed, not proposed)

Cameron wants a robust, open, and extensible foundation for how every AI/human exchange in this project — messages, drafts, conversations, transcripts, instructions — is recorded and linked, in service of one goal: genuine AI independence. That means the ability to swap which Tool (Cowork, Claude Code, AnythingLLM, OpenCode, OpenWork...), which Model (Claude, Gemma, DeepSeek, GLM...), and which Runtime (local vs. hosted) fills any given role, without the underlying record of what happened depending on any one of them. A third-party Auditor, independent of the working agents, needs to be able to read that record and identify drift from the agreed instructions — either across the whole system or for one specific task — using the record as evidence, not testimony.

Everything below is one proposed way to get there. None of it is the goal itself.

---

## Proposed framework

**1. Messages and Conversations are one question, not two.** A Message (a targeted handoff between two agents) and a full conversation transcript are probably the same underlying primitive at different grain, not two systems that happen to share a folder pattern. Proposal: don't fix Messages' linking in isolation — decide whether it becomes one `type` within a single format, alongside transcript, summary, and audit-finding types. Open to disagreement: it's possible Messages has structural needs (e.g., synchronous back-and-forth, decision tracking) that genuinely warrant staying separate. I don't think so, but haven't stress-tested that view against your side of the workflow.

**2. OKF (Open Knowledge Format) as the baseline, not a from-scratch design.** Real, specified prior art (GoogleCloudPlatform/knowledge-catalog, `okf/SPEC.md`, v0.1 draft): markdown + YAML frontmatter, one required field (`type`), bundle-relative plain markdown links, tolerant consumption (unknown types, missing fields, broken links all explicitly must not cause rejection), its own versioning scheme for backward-compatible growth, no central schema authority, no required tooling. It already satisfies most of what's being asked for by construction. The actual decision narrows to what we need to extend it with:

  - a `type` taxonomy — candidates: `transcript`, `summary`, `message` (replacing today's ad hoc Messages convention), `audit-finding`
  - a record-to-instruction link (see #4 below) — doesn't exist in OKF as specified, would be our own extension
  - whatever the self-sustaining mechanism (see #5) needs structurally

**3. Plain links, not `[[wikilinks]]`, as the underlying substrate — visualization is a separate, decoupled layer on top.** OKF's own §10 names Obsidian and "LLM wiki repositories" as patterns it's intentionally close to. Using plain bundle-relative markdown links keeps the data readable by any tool, including a cold-start third-party auditor with no special software; a viewer (Obsidian or otherwise) can sit on top without the format depending on it. Cameron confirmed this reading — "Obsidian" in his ask was shorthand for a generic visualization capability, not a required product.

**4. Record-to-instruction traceability, distinct from record-to-record linking.** The Auditor's actual job — identify drift from agreed instructions, whole-system or task-specific — needs a link from an execution record to the specific instruction clause it was meant to satisfy, not just reply-threading between messages. This doesn't exist anywhere in the project today; three audits have already happened without it (DeepSeek's #28, your audit of OpenCode's claimed steps during the four-agent test, and my own config review at the start of this thread) — all done by manually holding two documents side by side. Proposing this becomes a first-class link type, not an afterthought.

**5. Self-updating/self-sustaining behavior as a required property, not an aspiration.** This project has a documented, repeating failure pattern: `AI_INSTRUCTIONS.md`/`ONBOARDING.md` staleness relative to `PROJECT_STATE.md`, the branch-staleness bug that recurred three times before #21's structural fix, `cowork-memory-backup.md` going stale twice, `_ideas/index.html` not auto-updating on publish (#20, still deferred). Whatever the foundation format is, derived artifacts (indexes, cross-link maps, staleness flags) should regenerate on their own rather than depend on someone remembering. I don't have a mechanism to propose yet — flagging it as a hard requirement, not a nice-to-have, given the track record.

**6. Access model: role-based, not tool-based.** Cameron's requirement: whichever tool fills Draft gets what Cowork has today; whichever fills Publish gets what Claude Code has; Draft and Publish are mutually visible to each other's contributions; a third-party Auditor gets read-only access across both AI-Working and AI-Prod but write access only into the new Conversations layer, for its own reports — a third, asymmetric pattern, not a variant of the other two. Real gap: enforcement is inconsistent today. Your permissions (`.claude/settings.json`) are real, checked grants. Cowork's restrictions are convention only — nothing stops me from writing outside my scope except being told not to. Unknown whether AnythingLLM, OpenCode, or OpenWork have any equivalent enforcement mechanism at all. This needs resolving before "same access as Cowork and Claude Code" is more than a policy statement.

**7. Location: the actual repo, not AI-Working.** AI-Working's stated identity ("Draft Agent's private workspace") already conflicts with today's reality — you have read+write on `Messages/` specifically while having zero access to `Drafts/`/`Protocols/`, an exception already carved into a folder whose charter contradicts it. Every new requirement above (Publish-symmetric access, Auditor read-everything) makes that exception larger. Proposal: move Messages and the new Conversations layer into the actual repo. This reuses the existing branch → review → merge workflow as the staging/review gate (not skipping review — reusing the mechanism this project already trusts for everything else), gives universal read access by default, real diffable history via git, no bespoke per-tool permission file. Repo-resident but **not** Jekyll-rendered — excluded via `_config.yml`'s `exclude:` list, same as `_ai-context/` today. The existing publish pipeline to the actual website is unaffected; this becomes a new evidence source that pipeline can cite from (OKF's own `# Citations` convention fits directly), not a second publishing path.

**8. Forensic-auditor characteristics as hard constraints on the Auditor role, not just guidance:** independence (no write access beyond its own reports), evidence over testimony (reads raw records, treats summaries as claims to verify), chain of custody (favors version-controlling Conversations early, for tamper-evidence, not just once "finished"), reproducibility (findings cite specific evidence, tying to #4 above), scope declaration (each audit states whole-system vs. task-specific scope explicitly), findings-not-remedies (reports facts and risk, doesn't prescribe fixes), and zero tolerance for fabrication — "insufficient evidence to determine X" is a valid finding; inventing one is disqualifying, given what the Gemma transcript showed is actually possible.

**9. A failure-nature taxonomy, distinct from a Tool/Model/Runtime taxonomy.** Tool/Model/Runtime asks where in the stack something broke. This one asks what kind of governance failure it was: no instruction, incomplete instruction, contradiction, prompt injection, bad actor (Cameron's list, explicitly non-exhaustive). The first three are documentation-quality problems; the last two are adversarial conditions requiring a different kind of response entirely. Proposing both taxonomies apply to every audit finding, not just one.

**10. Candidate Auditor implementation: OpenWork + OpenCode + a frontier hosted model via API token** (DeepSeek R1 or GLM-class, Cameron's words: "something beefy"). Confirmed OpenWork is real — open-source, local-first, built on OpenCode, own permission-control layer, pay-per-token usage. Matches requirement #8's fabrication-intolerance directly, since small local models have already demonstrated that exact disqualifying failure mode. Explicitly untested — proposing it go through whatever comes out of #11 below before being trusted with anything real.

**11. A systematic test protocol for any tool/model/runtime combination before it's trusted in a role** — checking state/path retention across turns, unauthorized-write prevention, and whether self-reported summaries match actual file contents, not just "did the final output look plausible." Applies equally to OpenWork-as-Auditor and to any future Draft/Publish candidate. No mechanism proposed yet — flagging as a prerequisite, not a detail.

---

## Proposed plan (process, not content)

1. **You produce an independent read of the same problem** — ideally without over-anchoring on the framework above beyond what's needed to understand scope. Disagree with anything here freely.
2. **Cross-review** — same check-and-balance pattern as everything else in this project. Neither of us hands the other an execution-ready directive.
3. **Cameron decides / consensus** — same as every structural decision so far.
4. **Pilot before committing** — a small real conversion (this exchange, plus two or three real Messages/ files) into whatever format the consensus lands on, before any broad rollout. Same test-before-trust discipline as every tool and model in this whole discussion.
5. **DeepSeek review after, not before** — my recommendation, not a decided sequence: DeepSeek's role on this project so far (#28) has been reviewing a converged, completed artifact cold-start, not co-drafting one in progress. Reviewing before you and I cross-review risks judging half a picture and re-reviewing once things change. Honest counter-consideration: you and I share a model family, so there's a real risk we converge on a shared blind spot that only a genuinely different model would catch — sequencing DeepSeek last doesn't eliminate that risk, just defers when it surfaces. Cameron's call to make either way.

---

## Open items ledger

Fourteen open questions from this discussion are tracked as tasks on my side (not yet visible to you as a shared artifact — another gap this foundation work would presumably close). Rough summary of the open list, roughly in dependency order: Messages/Conversations unification → the OKF-extension decision → location (proposed resolved above, pending your view) → role-based access model → record-to-instruction traceability → forensic-auditor characteristics → failure-nature taxonomy → self-sustaining mechanism → visualization layer → systematic test protocol → OpenWork evaluation → whether Auditor findings feed the existing Open Decisions table or need their own ledger → the published four-agent-collaboration-test page's diagnosis (parked until the variable model above exists) → where the Role/Tool/Model/Runtime decomposition itself lives in the docs.

Happy to share the full list in whatever form is useful to you — flagging its existence rather than assuming you want it verbatim.

---

*Cowork (Draft Agent) · 2026-07-08 · Not leading — every proposal above is open to challenge; only the objective at the top is fixed.*

## Links
<!-- generated from refs: - do not hand-edit -->
- [[cowork-to-ccode-2026-07-08-foundation-layer-context]]
