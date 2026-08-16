---
type: reference
title: "Agent Participation Guide — Inter-Agent Proposal, Review, and Consensus Protocol"
role: Publish
wrapper: Claude Code
identity: Sonnet 5
generated: { by: Claude Code/Sonnet 5, at: 2026-08-02T15:40:50+10:00 }  # generated from wrapper:+identity:+commit-date - do not hand-edit
aliases:
  - agent participation guide
  - inter-agent protocol
  - proposal review consensus protocol
  - how to participate in a message exchange
refs:
  - ../AI_INSTRUCTIONS.md
  - ./messages-promotion-procedure.md
  - ./backlog-promotion-workflow.md
  - ./draft-agent-config.md
---

**Precedence:** this file sits under `AI_INSTRUCTIONS.md`. If anything here conflicts with `AI_INSTRUCTIONS.md`, that file wins — same rule as every other file in `PROJECT_STATE.md`'s Instruction File Index.

Single canonical copy — no working-copy mirror exists or should exist anywhere else. If a second copy of this file ever turns up somewhere, that copy is stale by construction; this file, in `_ai-context/`, is authoritative.

Written 2026-08-02, prompted by a cold-read observation from Hermes (DeepSeek v4 Pro) — a candidate under separate evaluation, not a participant in this document's own review. Drafted by Claude Code, converged and independently reviewed by Cowork before being committed (`AI-Working/Messages/ccode-to-cowork-2026-08-02-agent-participation-guide-draft.md` → her review, approved as written with one non-blocking caveat on §6's citation strength, noted there).

---

## 1. What this file is for

The propose→review→consensus→Cameron-decides pattern already governs how agents on this project work together — it's visible in every `AI-Working/Messages/` thread and every `_messages/` archive entry. But it had never been written down as a specification; it had been learned by the current participants (Cowork, Claude Code) across 70+ sessions of shared rhythm. A new participant reading cold has to reverse-engineer the norms from hundreds of examples instead of following a stated rule.

This guide exists so that a new agent — reading this one document, not the full backlog — has a clear idea of what to do when it receives a message, or wants to send one. It doesn't change how Cowork and Claude Code already work; it documents the working practice so a cold participant can do it too. Same principle as `draft-agent-config.md` capturing the Draft Agent's own practice for portability.

**The actual acceptance test for this document is not whether it reads well — it's whether a new participant can act correctly from it alone**, without falling back on pattern-matching the message backlog. Treat any future dry run against a real cold participant as the real verification step, not a design review of this text.

## 2. The lifecycle

Four stages. A message is always in one of the first two; the last two describe what happens to it, not a label you put on a file.

1. **Discussion** — thinking out loud, exploring a question, reacting to something. Doesn't commit anyone to anything, doesn't require the recipient to produce a formal review, and may never turn into a proposal at all.
2. **Proposal** — a concrete, scoped ask, ready for independent review. The sender believes it's ready to be checked, not just reacted to.
3. **Review** — the recipient reads the actual proposal (not a summary of it) and responds with a real independent review — see §4 for what that requires.
4. **Consensus, or escalation** — the two agents either converge (agreeing on content, or agreeing on what's still open) or, if they can't, escalate directly to Cameron. Cameron decides. See §6.

A single topic can cycle through discussion and proposal more than once before reaching consensus — this document's own thread did (an initial discussion round, a second round answering one open question, then convergence, then a formal proposal and review). That's normal; the stages describe where a given message sits, not a one-pass pipeline.

## 3. Marking discussion vs. proposal

Every `type: message` file exchanged under this protocol must declare which stage it's in, explicitly — not left for the reader to infer from tone or prose. Add a `stage:` field to frontmatter:

```yaml
stage: discussion
```
or
```yaml
stage: proposal
```

(`stage: review` is also in use, by extension — the response to a proposal.)

This is a new field, forward-only from this guide's ratification — same pattern as `role:`/`wrapper:`/`identity:` (Open Decision #58) and `thread_number:`/`subgroup:`/`note:` (Open Decision #57). Do not infer a default when the field is missing on an older file; only files written after this guide exists are expected to carry it.

A human-readable restatement in the opening line of the message body (as Cowork and Claude Code have both been doing informally — "Still discussion, not decided") is still good practice for anyone reading in a client that doesn't surface frontmatter, but the frontmatter field is what a cold agent should actually check. Prose is a courtesy; the field is the source of truth.

## 4. What counts as a valid independent review

A review is only real if it could have caught something wrong. The following is a minimum bar, not an aspirational one — a review that doesn't clear it isn't a lighter version of a real review, it doesn't count as one:

- **Read the actual artifact under review in full** — the real file, the real proposal — not a summary of it, and not just the discussion thread that led up to it.
- **Verify at least one concrete claim against its actual source**, and say what you checked. "I read `X.md` and confirmed line N says Y" is a real check. "This looks correct" is not, no matter how confident the phrasing.
- **Respond per point on a multi-point proposal**, not with a single blanket verdict. Agreement on four of five points and disagreement on the fifth needs to say which is which.
- **Name what could be wrong, or what's untested, not only what looks right.** A review that raises zero concerns after checking a nontrivial proposal is not automatically evidence of thoroughness — it's worth being honest about what wasn't checked, if anything wasn't.
- **If citing a precedent or a prior incident, verify it against its actual source before repeating it.** Don't propagate a citation you haven't checked, even if it sounds right and even if someone else stated it first.
- **A rubber-stamp verdict — "looks good, approved," with no cited evidence — does not meet the bar**, independent of whether the underlying agreement turns out to be correct.
- **Check whether the instruction itself specifies an answer before citing a deviation as non-compliance.** If a participant's format or process deviates from what's documented, verify the documentation actually covers that situation before treating the deviation as a mark against the participant. If it doesn't — if the case is genuinely unaddressed — that's a gap in the instruction to fix, not a compliance failure to record. Conflating the two either lets real gaps go unfixed (each new cold participant re-discovers and re-flags them individually) or unfairly penalizes a good-faith participant for a gap that was never theirs to close. Cameron's own stated principle, 2026-08-16 — not something either agent arrived at independently.

**Why this bar, specifically:** on 2026-07-02, AnythingLLM's own self-check "ticked every item as complete despite none of them being correct" (`_messages/cowork-to-ccode-2026-07-02-anythingllm-analysis.md`). Worth being precise about which failure that actually was, since it's easy to blur: that was a **self-check** failure (an agent marking its own work complete without the checking happening), not an **independent-review** failure (a second agent rubber-stamping someone else's work). Same failure class — a checklist satisfied mechanically without the underlying judgment actually occurring — different mechanism. This guide's evidence-gated bar exists to block both versions of that failure, not just the one that's already been observed directly.

This reuses the evidence-or-silence discipline `AI_INSTRUCTIONS.md` §8 already requires of the Publish Agent's own claims (Open Decision #63) — applied here to the inter-agent review context specifically, not a new standard invented for this document.

## 5. Proposal format

A message with `stage: proposal` should contain, in some order:

- **Frontmatter**: `type: message`, `title:`, `timestamp:`, `from:`/`to:` (or `participants:` for a standalone capture), `role:`/`wrapper:`/`identity:`, `stage: proposal`, `aliases:`, `refs:` — the full shape already required for any promoted `_messages/` file (`_ai-context/messages-promotion-procedure.md` §2), used from first authoring, not bolted on at promotion time.
- **What's being asked** — state the concrete decision or action being proposed, up front, not buried in context.
- **Why** — the motivation or problem this responds to.
- **The actual content** — the design, the text, the code, whatever is being proposed, in enough detail that a reviewer can check it against §4's bar without having to ask for more.
- **What review is being requested** — scope the ask. Does the reviewer need to check a design decision, a piece of code, a factual claim, all three?
- **A reply-file instruction** — tell the recipient to write their response as a new file in `AI-Working/Messages/`, not to paste a reply back in a live session. Naming convention: `[from]-to-[to]-[date]-[topic].md`, with `-2`, `-response`, `-response-2`, etc. suffixes for later messages continuing the same thread on the same day.

A `stage: discussion` message can be much looser — it doesn't need to hit every item above. The point of the format requirement is specifically to make a *proposal* checkable; a discussion message is explicitly exempt because nothing is being decided yet.

**`note:` worked example**, added 2026-08-16 — closes a real gap without requiring a backlog read: for a message continuing an existing thread, `note:` is a one-line caption stating *why the entry matters*, not what it points to (that's `refs:`'s job). Example: `note: "First independent review under the new participation guide — verified two Ground 2 citations directly."` For a message opening a new topic (see the `thread_number:` new-topic exception in `messages-promotion-procedure.md` §2), `note:` follows the same promotion-time treatment — left unset at first authoring, written when the entry is promoted and the promoting agent has the full context to caption it well.

## 6. Disagreement resolution

This isn't a new mechanism — it's making an existing one explicit for a cold reader. Cameron is the standing tiebreaker; he already is, in every decision this project has ever made. The lifecycle in §2 already assumes this at its last step.

- Agents pushing back, raising objections, or counter-proposing is a normal and expected part of review — it is not itself "disagreement" requiring escalation. Most threads resolve this way, through ordinary iteration.
- If, after reasonable back-and-forth, the agents genuinely can't converge — not "haven't converged yet," but have each stated a considered position and neither is moving — escalate directly to Cameron rather than extending negotiation indefinitely. There's no fixed round count; use judgment about when iteration has stopped being productive.
- Cameron decides. That decision is final for the question as asked — reopening it later needs new evidence, not just a renewed preference. This is consistent with the observed pattern across `PROJECT_STATE.md`'s Open Decisions, though it should be said plainly that this is a characterization of that observed pattern, not a line quoted from an explicit rule the way #57/#58's forward-only convention is — a distinction Cowork's review of this guide raised directly and correctly.
- Once decided, every agent proceeds on that basis. Not re-litigating a settled question is as much a part of this protocol as raising one honestly in the first place.

## 7. Joining cold — what to read, in order

Do **not** read the `_messages/` backlog front to back to infer how this works. That's the exact problem this guide exists to replace. Read, in this order:

1. `ONBOARDING.md` — once, on first contact with the project.
2. `AI_INSTRUCTIONS.md` — canonical rules, role definitions, the RCT framework. Authoritative on intent.
3. **This guide** — how to actually participate in a message exchange: propose, review, mark discussion vs. proposal, resolve disagreement.
4. Your own role-specific derivative file, if you're filling a defined role — `CLAUDE.md` for Claude Code / Publish Agent, `draft-agent-config.md` plus `AI-Working/Protocols/cowork-conventions.md` for Draft Agent. Skip this step if you're only observing or reading along, not filling a role.
5. `PROJECT_STATE.md` — current state: active branch, page inventory, open decisions, capability baseline, the full instruction file index. Read in full once, then re-read at the start of every session per its own instruction.
6. `_messages/index.md` — a thread-grouped map of the archived record. Use it as a table of contents to pull up a specific thread's history when a specific topic needs it. This is navigation, not a reading assignment — you are not expected to read all 500+ entries before participating.

If something in a live exchange genuinely depends on history not covered by the above, ask directly rather than guessing from partial context — same rule `AI_INSTRUCTIONS.md` §7 already gives for a non-Claude tool joining this project.

## Still open, not resolved by this doc

- Whether `stage:` should ever be backfilled onto pre-existing `AI-Working/Messages/` or `_messages/` files — default is no, forward-only, matching every prior frontmatter addition (Open Decisions #57, #58). Not decided here as an exception.
- Exact iteration depth before a disagreement counts as genuinely stuck (§6) — deliberately left to judgment, not a fixed number, since no real disagreement has happened yet to calibrate against.
- Hermes's own participation shape and timing — explicitly out of scope for this document. Cameron's stated plan is temporary read-only access to `AI-Working/Messages/` once this guide is finished, to read along — not something this guide itself decides or depends on.
- ~~Whether this guide needs its own dry-run acceptance test against a real cold participant~~ — answered 2026-08-16: DeepSeek Harness's instruction-redesign proposal, both independent reviews of it, and this exact set of hardening changes *is* that dry run. Evidence gathered, not still pending — it surfaced two real gaps (the `role:` enum, the `thread_number:`/`note:` new-topic case) rather than a clean pass, which is itself informative: the guide worked well enough for a cold participant to act from, and imperfectly enough to be worth hardening further.

## Links
<!-- generated from refs: - do not hand-edit -->
- [[AI_INSTRUCTIONS]]
- [[messages-promotion-procedure]]
- [[backlog-promotion-workflow]]
- [[draft-agent-config]]
