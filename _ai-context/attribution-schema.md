---
type: reference
title: "Attribution Schema — role / wrapper / identity / generated.by"
role: Publish
wrapper: Claude Code
identity: Sonnet 5
generated.by: "Claude Code/Sonnet 5"  # generated from wrapper:+identity: - do not hand-edit
aliases:
  - attribution schema
  - role wrapper identity
  - generated.by
refs:
  - ../AI_INSTRUCTIONS.md
  - ../PROJECT_STATE.md
  - ./messages-promotion-procedure.md
  - ./ai-content-creation-spec.md
---

**Created:** 2026-07-28
**Status:** Live — governs all new content going forward. See Open Decision #58 in `PROJECT_STATE.md` (now archived to `decisions-archive.md`) for the full design conversation this doc consolidates.

This file exists for the same reason `messages-promotion-procedure.md` does: a real convention got worked out across a long, multi-session conversation (Open Decision #58) and needed one canonical place to live, rather than staying spread across Open Decision prose and message threads.

---

## 1. The three axes

`from:`/`to:`/`participants:` (existing `_messages:` fields) and `provenance:` (existing `_audit-findings:` field) name *who*, but conflate three different things into one string. A bare wrapper name like "Claude Code" doesn't say which model was behind it, or in what capacity. Three parallel scalar fields, not a compound value, so each stays independently queryable and survives wrapper churn without a schema change:

- **`role:`** — the function being performed. One of: `Draft`, `Publish`, `Review`, `Audit`, `Human-in-the-loop`. Not a tool, not an entity-type — "Human-in-the-loop" names a *kind of participation*, not an outcome, which is why it isn't "Decision."
- **`wrapper:`** — the vessel carrying the judgment. One of: `Claude Code`, `Cowork`, `AnythingLLM`, `OpenCode`, `Person` (or a newly-adopted tool as the project's toolset changes).
- **`identity:`** — the specific instance whose judgment actually produced the content. A model name (`Sonnet 5`, `Opus 5`, `DeepSeek-V3`) or, when `wrapper: Person`, the person's name (`Cameron`).

The founding analogy: `wrapper : LLM :: Person : Cameron`.

## 2. Where these fields apply

**Forward-only, no retroactive sweep** — Cameron's direction, 2026-07-27. Existing files in any of the surfaces below keep whatever they already have (`from:`/`to:`/`participants:`, `provenance:` prose, nothing at all). The new fields land on files created, or substantively edited, from this point on — the same precedent already used for `aliases:`/`refs:` at promotion time. A file being touched for an unrelated reason isn't itself a trigger to backfill this; a file whose *content* changes as part of the work being done is.

### `_messages/`

Add `role:`/`wrapper:`/`identity:` as new fields alongside the existing `from:`/`to:` — they don't replace `from:`/`to:`, which stay exactly as they are. For a single-author message, this is a straightforward one-to-one addition: `from: Claude Code` gains siblings `role: Publish`, `wrapper: Claude Code`, `identity: Sonnet 5`.

**Not yet resolved:** how the triple applies to `participants:` (multi-author transcripts) — one shared triple per file doesn't work once participants have different roles/wrappers/identities, but a per-participant nested structure was never designed or agreed. Flagged here rather than guessed; decide this when a `participants:` file is next actually promoted, not before.

### `_audit-findings/`

Same addition as `_messages/` — `role:`/`wrapper:`/`identity:` as new fields. The existing `provenance:` prose field stays; it carries genuinely qualitative context (kickoff-round history, staging path, caveats about self-report reliability) that a three-scalar field can't hold and isn't trying to replace. `role:` will almost always be `Audit`.

### `_ai-context/`

Flat scalars representing **current-version attribution only** — who is responsible for the file as it currently reads, not a full authorship history. `_ai-context/` files are not single-authorship-event artifacts the way a `_messages/` entry or an audit finding is; several (the Auditor charter, this project's own instruction files) have been revised by multiple parties across multiple sessions. Revision history stays exactly where it already lives — each file's own body-text metadata block (`**Last updated:**`, `**Version:**`, `**Status:**`, `**Provenance:**` or equivalent), the same division of labor those sections already do. `role:`/`wrapper:`/`identity:` describe only the most recent substantive edit.

### Published Collaboration Note (site content)

The existing template (`ai-content-creation-spec.md` §5) already states Model and Platform on every published page — the oldest attribution precedent in this project, predating `_messages/`, OKF, and the Auditor entirely (session-2026-06-10-001). Add a **Role** line alongside them: `Role: [Publish/Draft/etc.] · Model: [model string] · Session: [session ID] · Platform: [platform] · Date: [YYYY-MM-DD]`. This is prose on a published HTML page, not YAML frontmatter — there is no `generated.by:` equivalent here; see §3.

## 3. `generated.by:` — OKF-native, mechanically derived

OKF's real spec (v0.2, verified directly — not the v0.1 originally assumed) has its own native actor-identity convention: `generated.by:` / `verified[].by:`, shaped as `<producer>/<version>` or `human:<id>`. This project chose the three-scalar `role:`/`wrapper:`/`identity:` split deliberately, as a genuine divergence from OKF's own native shape rather than an oversight — but the divergence doesn't need to be permanent. `generated.by:` is added as a **mechanically derived** field, the same relationship `refs:` already has to the generated `## Links` footer (`generate-links-footer.ps1`): `wrapper:`/`identity:` stay the real, hand-authored source of truth; `generated.by:` is never hand-edited, only regenerated.

**Derivation rule**, run by `_ai-context/generate-provenance.ps1`:

- `wrapper: Person` → `generated.by: "human:<identity, lowercased, spaces to hyphens>"` (e.g. `identity: Cameron` → `human:cameron`)
- Any other `wrapper:` → `generated.by: "<wrapper>/<identity>"` literally (e.g. `wrapper: Claude Code`, `identity: Sonnet 5` → `Claude Code/Sonnet 5`)

A file with only one of `wrapper:`/`identity:` present is a real error, not a value to guess past — the script fails loudly on it rather than emitting a partial or wrong `generated.by:`.

`verified[].by:` is a good future fit — `_audit-findings/` already has a real generate/verify split in practice (Auditor produces, Cameron approves, Cowork/Claude Code often independently re-verify specific claims before trusting a report) — but is explicitly **not** part of this build. Cowork's caution, agreed: keep this the same size as `generate-links-footer.ps1`, one field derived from two others. Adding `verified[].by:` is its own separate design pass.

## 4. Still open, not resolved by this doc

- `participants:` (multi-author `_messages/` transcripts) — see §2.
- Whether `_audit-findings/`'s `provenance:` prose field should eventually be split further once more findings exist to generalize from — not decided, not blocking.
- `verified[].by:` — named as a good future fit, not designed.

## Links
<!-- generated from refs: - do not hand-edit -->
- [[AI_INSTRUCTIONS]]
- [[PROJECT_STATE]]
- [[messages-promotion-procedure]]
- [[ai-content-creation-spec]]
