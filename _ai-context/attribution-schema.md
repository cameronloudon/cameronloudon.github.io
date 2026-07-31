---
type: reference
title: "Attribution Schema — role / wrapper / identity / generated.by"
role: Publish
wrapper: Claude Code
identity: Sonnet 5
generated: { by: Claude Code/Sonnet 5, at: 2026-07-31T11:48:34+10:00 }  # generated from wrapper:+identity:+commit-date - do not hand-edit
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

## 3. `generated:` — OKF-native, mechanically derived

OKF's real spec (v0.2, verified directly — not the v0.1 originally assumed) has its own native actor-identity convention: a nested `generated: { by, at }` mapping and a `verified: [{ by, at }]` list, with `by` shaped as `<producer>/<version>`, `human:<id>`, or `process:<id>`. This project chose the three-scalar `role:`/`wrapper:`/`identity:` split deliberately, as a genuine divergence from OKF's own native shape rather than an oversight — but the divergence doesn't need to be permanent. `generated:` is added as a **mechanically derived** field, the same relationship `refs:` already has to the generated `## Links` footer (`generate-links-footer.ps1`): `wrapper:`/`identity:` stay the real, hand-authored source of truth; `generated:` is never hand-edited, only regenerated.

**Corrected 2026-07-28:** the first build of this field (`generated.by:`, a flat dotted string) shipped before the real spec's shape was verified directly. It was wrong — checked and confirmed via raw `curl` against both the spec file and its GPG-signature-verified commit history, independently re-confirmed by Cowork after her own first check hit a stale cache. `_ai-context/generate-provenance.ps1` was rebuilt to emit the real nested shape; any file still carrying the old flat key gets it migrated automatically the next time the script runs (strips the old line, replaces it with the new one — a one-time cleanup, not an ongoing dual-format).

**Derivation rule**, run by `_ai-context/generate-provenance.ps1`:

- `by`: `wrapper: Person` → `human:<identity, lowercased, spaces to hyphens>` (e.g. `identity: Cameron` → `human:cameron`); any other `wrapper:` → `<wrapper>/<identity>` literally (e.g. `wrapper: Claude Code`, `identity: Sonnet 5` → `Claude Code/Sonnet 5`).
- `at`: the file's own last-commit author date, via `git log -1 --format=%aI -- <file>` — never a model-asserted date, matching this project's standing rule against self-reported timestamps (the isolation safeguard; Open Decision #47's wrong-self-inferred-date finding). This means the file needs at least one commit before the script can compute `at:` for it — a hard failure, not a guessed value, if it doesn't have one yet.

**Workflow** (verified empirically against a real git repo before adopting it): commit the file normally first — `generated:` will be stale, incomplete, or absent at that point, and that's fine. Run the script; `git log` now resolves against the commit just made, so `at:` matches it exactly. Stage the file again and `git commit --amend --no-edit` to fold the derived field into that same commit — `--amend --no-edit` never touches the author date, only the committer date, so the `at:` value the script wrote still matches the amended commit exactly, and the history shows one commit for the change, not two. Files that already had a prior, unrelated commit (the migration itself, for example) don't need the amend step — a plain new commit is correct there, since the goal is preserving the *original* authorship date, not a just-made one.

A file with only one of `wrapper:`/`identity:` present is a real error, not a value to guess past — the script fails loudly on it rather than emitting a partial or wrong `generated:`.

## 3a. `verified:` — append-only, via `_ai-context/record-verification.ps1`

Built 2026-07-28, per Cameron's direction to stay as OKF-conformant as possible — the real list (`verified: [{ by, at }, ...]`), not a flat single-pair field, since `_audit-findings/` already has a genuine generate/verify split in practice (Auditor produces, Cameron approves, Cowork/Claude Code often independently re-verify specific claims before trusting a report) that a flat field would have lost the moment more than one party checks the same file.

Unlike `generated:`, this field is never regenerated wholesale — every other script in this family derives and replaces a whole field from source-of-truth inputs; `verified:` is an accumulating log, so the script only ever appends one entry per invocation, never touching prior ones.

**Interface:** `record-verification.ps1 -File <path> -Wrapper <wrapper> -Identity <identity> [-At <ISO8601>]`, or `-Process <id>` as a mutually exclusive alternative producing `by: process:<id>` directly — the third actor form OKF's own convention defines (alongside `<producer>/<version>` and `human:<id>`) for a mechanical, non-agent, non-human verifier. Not used by anything in this project yet as of 2026-07-28 (`function-b-state-check.ps1`/`cascade-check.ps1` are the two plausible future callers), added to complete the convention rather than because a concrete caller exists.

**`-At`** defaults to the system clock at invocation, not `git log` — deliberately different from `generated.at`'s sourcing, since a verification event has no necessary relationship to any file commit (Cowork could verify a file Claude Code committed days earlier). Reading the system clock isn't the model-inferred-date risk this project's anti-guessing rule targets; an explicit override is available for recording an event after the fact.

**Duplicate handling:** an identical `{ by, at }` pair is skipped, not re-appended (protects against an accidental double-run); a matching `by` with a different `at` is always appended as a genuine new event, per OKF §5.2 ("facts can be re-confirmed without regeneration"). If the file's existing `verified:` content doesn't match one of the two shapes the spec actually tolerates (a bare single mapping, or a plain list of one-line `{ by, at }` entries), the script fails loudly and leaves the file untouched rather than risk corrupting real verification history — a harder, riskier parse-and-mutate operation than anything else in this script family, named as such rather than hand-waved past.

No precondition on `role:`/`wrapper:`/`identity:`/`generated:` already being present — a legitimate re-check of an old, not-yet-migrated file is a real case, so `verified:` appearing without `generated:` alongside it is an expected, valid combination, not a sign of a broken file.

## 4. Still open, not resolved by this doc

- `participants:` (multi-author `_messages/` transcripts) — see §2.
- Whether `_audit-findings/`'s `provenance:` prose field should eventually be split further once more findings exist to generalize from — not decided, not blocking.

## Links
<!-- generated from refs: - do not hand-edit -->
- [[AI_INSTRUCTIONS]]
- [[PROJECT_STATE]]
- [[messages-promotion-procedure]]
- [[ai-content-creation-spec]]
