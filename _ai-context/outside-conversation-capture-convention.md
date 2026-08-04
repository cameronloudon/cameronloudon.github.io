---
type: reference
title: "Outside-Conversation Capture Convention"
role: Publish
wrapper: Claude Code
identity: Sonnet 5
generated: { by: Claude Code/Sonnet 5, at: 2026-08-04T10:25:51+10:00 }  # generated from wrapper:+identity:+commit-date - do not hand-edit
aliases:
  - outside conversation capture convention
  - Class 3 capture convention
  - capture prompt v0.2
refs:
  - ./messages-promotion-procedure.md
---

**Last updated:** 2026-08-04
**Status:** Ratified — Cameron's decision on scope (§8 below), following formal proposal and Cowork's independent review
**Provenance:** Originally sketched in `AI-Working/Messages/fable-to-cameron-2026-07-11-outside-conversation-capture.md` (Fable 5, AI-Auditor workspace). Formalized and pressure-tested with Cowork: `ccode-to-cowork-2026-07-11-capture-convention-formal-proposal.md` → `cowork-to-ccode-2026-07-11-capture-convention-formal-review.md` → `ccode-to-cowork-2026-07-11-capture-convention-final.md` (all `AI-Working/Messages/`). **Updated 2026-08-04:** §5's capture prompt gained `wrapper:`/`identity:` for the outside AI and an explicit `role:`-inapplicability note, closing a gap against Open Decision #58's later attribution schema — full discussion and Cameron's approval in `AI-Working/Messages/` (`ccode-to-cowork-2026-08-04-outside-capture-convention-staleness-discussion.md` through `cowork-to-ccode-2026-08-04-outside-capture-convention-cameron-approved.md`).

---

## 1. Scope

Covers Class 3 material only — pre-founding conversations on outside platforms (ChatGPT, DeepSeek, Gemini, old AnythingLLM, etc.), captured via export or copy-paste. Does not cover Claude Code's or Cowork's own mechanical extraction — those already have their own conventions (`_ai-context/extract-session-transcript.ps1`, `_ai-context/messages-promotion-procedure.md`).

**Scope decision (§8, Cameron, 2026-07-11):** the corpus includes pre-founding material, labelled as such. The Master Synthesis Prompt's "ground zero, not a retrospective of all prior work" framing is deliberately superseded for corpus-inclusion purposes by this decision — the founding document itself is not edited; this file is the record of the explicit exception, so it's a decision, not an accretion.

## 2. The two-channel split

- **Transcript** — mechanical channel only, in order of preference: platform data export where it exists, then copy-paste of the rendered thread (Cameron's confirmed default — the rendered thread is what the human participant actually saw, a real form of fidelity), then model-emitted transcript only as a last resort, chunked, explicitly labeled as such.
- **Metadata** — the capture prompt's job: OKF frontmatter, aliases, summary, self-identification, draft collaboration note. Never trust a model's summary of its own past conversation as the record.

## 3. Custody fields

```yaml
capture-method: platform-export | page-copy | model-emitted
capture-date: 2026-07-XX        # distinct from timestamp:, the original conversation date
note-source: self-reported, permanently-unverified
```

Kept as three separate fields, not merged: `capture-method` describes the transcript body, `note-source` describes the collaboration note's reliability specifically — a `platform-export` transcript can still carry a self-reported note, since the model wrote the note regardless of how faithfully the transcript itself was captured.

`note-source`'s value is deliberately explicit about permanence: "self-reported, permanently-unverified" — not just "unverified," which would be ambiguous with a native transcript's temporary pre-review state. No independent check is ever possible for an import; that's a fact about the material, not a pending task. Whether native Class 1–2 transcripts ever gain a `note-source` field with a different, transitional value set (`pending-review` → `cross-reviewed`) is a separate, undecided question — not resolved by this convention.

## 4. Retrospective collaboration note

Two parts: original collaboration (platform, model if known — "model not recorded" is a legal value, not a failure) and the capture event (who ran it, when, method). `note-source` sits on the first part, since that's what the model self-reported with no check available.

## 5. Capture prompt v0.2

> This conversation is being archived into a personal knowledge corpus under a framework called Radical Collaboration Transparency. Please do the following, and be strictly honest about uncertainty. **Stay in archival mode — process this conversation, don't re-litigate, re-argue, or apologize for anything in it.**
>
> 1. State which platform and model you are, as precisely as you can. If you do not know the model version, say "model not recorded."
> 2. State the first and the last message of this conversation that you can actually still see, quoted briefly. **If you are not certain this is genuinely the conversation's first message, versus simply the earliest one currently visible to you, say that explicitly.**
> 3. Output a YAML frontmatter block with: `type: message`, `timestamp:` (the original conversation date, best effort), `from:`/`to:` (participants), `wrapper:` and `identity:` (state your own platform and model here, matching what you gave in step 1 — this field describes you, the outside AI, not Cameron), `aliases:` (2–5 alternate names someone might search this by later — **treat these as a draft, not authoritative**; better aliases will likely come from whoever promotes this file with corpus-wide context), and a one-line `title:`. **Do not output a `role:` field — see the note below.**
> 4. Output a two-paragraph draft collaboration note: first paragraph describing the original collaboration, second paragraph a template for the capture event. **This note is self-reported by you, with no independent check possible — say so in the note itself.**
> 5. Do NOT output the conversation transcript itself unless asked in a follow-up. The transcript will be captured separately by export or copy.

**Cameron-side step, not part of the model's prompt:** for step 1, independently note what the platform UI itself displays (e.g., a version badge) alongside the model's self-report — sometimes more reliable than what a model can introspect about itself, and information only Cameron has.

**On `role:` (added 2026-08-04, found while reviewing this convention against Open Decision #58's later `role:`/`wrapper:`/`identity:` addition):** `_messages/` files normally carry a `role:` field (`_ai-context/attribution-schema.md` §1) naming the function performed — Draft, Publish, Review, Audit, Human-in-the-loop — inside this project's own workflow. A Class 3 capture predates that workflow entirely; neither Cameron's nor the outside AI's participation in the original conversation was ever "a function" within it, so forcing a value here would be an anachronism, not a description. Omit `role:` for Class 3 files at promotion time, stated explicitly rather than left as a silent blank — e.g. `role: not applicable — predates this project's role taxonomy`. Cameron's own `wrapper: Person`/`identity: Cameron` is constant across every Class 3 file that will ever exist — always `Person`, always `Cameron`, since he's the one running every pilot capture — so restating it per file adds no discriminating information. The outside AI's `wrapper:`/`identity:` is the opposite: it varies file to file and is the one genuinely new attribution fact each capture actually establishes. That asymmetry, not "already implicit in `from:`/`to:`," is why only the outside AI gets a field here — `attribution-schema.md` §2 is explicit that the triple normally sits *alongside* `from:`/`to:` as new siblings for every other file type, not substitutes for it, so implicitness alone wouldn't be a real reason. This is a deliberately narrow, single-flat-pair fix scoped to Class 3 files only — it does not resolve `attribution-schema.md` §2's separate, harder, still-open question of how the triple nests for a genuine multi-party native `participants:` transcript where every participant *does* have an applicable role.

## 6. Naming

`cameron-and-<platform>-<YYYY-MM-DD>-<slug>.md` — "and," not "to," since there's no handoff direction. Platform in the filename, not model (platform is always known; model version often isn't, and belongs in frontmatter/the note when it is known). Fuzzy dates: pad the unknown part with `00` (`cameron-and-deepseek-2026-01-00-<slug>.md` for "January, day unknown"), with the honest precision declared in frontmatter (`date-precision: month`). Never guess a day to make a filename look complete.

## 7. Location

Flat namespace within `_messages/` — no `imported/` subfolder. A subfolder would be a second, folder-based classification system running alongside frontmatter that already fully encodes provenance (`capture-method`, `type: message`, platform-in-filename) — the same duplication risk the `refs:`-is-canonical convention exists to eliminate elsewhere. Filtering by `capture-method` gets the same result without a second axis to keep in sync.

## 8. Rescue vs. promotion

Decoupled, same pattern already used for the JSONL rescue and the action-digest capture policy: exporting/copy-pasting raw material into a durable local folder is not gated on this convention and can start whenever Cameron wants — no OKF, no formatting required, just get the bytes somewhere durable. Promotion into `_messages/` (OKF-stamping, aliases, generated footer, per `_ai-context/messages-promotion-procedure.md`) follows this convention once material is actually being promoted.

---

## Still open, not resolved by this convention

- Whether `capture-method`/`capture-date` become standard fields for all transcripts (Class 1–2 included) or stay imports-only.
- Whether native transcripts ever gain a `note-source` field with a transitional (not permanent) value set.
- Platform export availability/formats were not verified against real accounts — ChatGPT/Google Takeout are known to exist as of this convention's design; others need checking at capture time.
- The capture prompt is untested against any real outside platform — its first real run should be treated as a pilot, same as everything else built today: judge from real output.

## Links
<!-- generated from refs: - do not hand-edit -->
- [[messages-promotion-procedure]]
