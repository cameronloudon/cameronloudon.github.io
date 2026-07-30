---
type: reference
title: "Messages Bundle — Promotion Procedure"
role: Publish
wrapper: Claude Code
identity: Sonnet 5
generated: { by: Claude Code/Sonnet 5, at: 2026-07-28T09:19:06+10:00 }  # generated from wrapper:+identity:+commit-date - do not hand-edit
aliases:
  - messages promotion procedure
  - promotion procedure
refs:
  - ../AI_INSTRUCTIONS.md
  - ./auditor-charter.md
  - ./attribution-schema.md
  - ./backlog-promotion-workflow.md
---

**Last updated:** 2026-07-11
**Applies to:** any file moving from `AI-Working/Messages/` (or a raw session log, via mechanical extraction) into the git-tracked `_messages/` bundle. Also the base convention for `_audit-findings/`, which reuses everything here — see `_ai-context/auditor-charter.md` §6 for the one audit-finding-specific addition (the verbatim-promotion rule).

This file exists because four real conventions were established across a single session (Open Decisions #34, #42, #44, #45) and none of them were ever written down as one canonical procedure — each lived in its own Open Decision entry and message thread. Consolidating them here so a promotion doesn't depend on remembering, or re-deriving, four separate decisions.

---

## 1. When something gets promoted

Cadence is currently at the Publish Agent's discretion, session by session — commit cadence for promotions (session-close only vs. also at session-start) is a genuinely open question, not decided here or anywhere else yet. Don't treat "not documented" as "not a real gap"; it's tracked, just unresolved.

**The session-level question — how a batch actually gets selected, scoped, verified, and closed out — is answered separately, in `_ai-context/backlog-promotion-workflow.md`** (written 2026-07-29, session-64, once the historical backlog was fully promoted). This file stays about per-file mechanics; that one is the workflow. Read both.

## 1a. Before a backlog batch — `prescan-backlog.ps1`

Run `_ai-context/prescan-backlog.ps1 -Path <AI-Working/Messages> -Since <date>` right before working through a batch, not once upfront against the whole remaining backlog — keeps candidates as fresh as the promotion decision itself (built 2026-07-28, the token-cost question adjacent to Open Decision #57). Report-only: mechanically extracts `title:`/`from:`/`to:`/`timestamp:` for any file with the plain `From:`/`To:`/`Date:` header, and offers `refs:` candidates in two confidence tiers pulled from backtick-quoted `.md` mentions (the file's own `Re:` line, and the wider body). Every candidate — resolved or not — still needs a human or agent look before it lands in real frontmatter; this cuts the search-the-corpus cost per file, it doesn't replace judgment on `type:` or `aliases:`, which stay exactly as required below.

## 2. Required frontmatter

- `type:` — `message` / `transcript` / `summary` / `audit-finding` / `index`. Comes from reading the content, never from the filename or the file's own self-description (Open Decision #34).
- `title:`
- `timestamp:` — not `date`; matches the OKF spec's actual optional field name.
- `from:`/`to:` for authored content, or `participants:` for captured/transcript content — authored and captured content need different shapes (Open Decision #34). **`participants:` does not require multiple entries.** A single-entry `participants:` is the correct shape for a standalone capture of one actor's own record (a cold-walk transcript, for instance) — the deciding question is authored vs. captured, not how many parties are named. Precedent: `cowork-to-ccode-2026-07-19-mission-1-full-transcript.md`, Cameron's own call, 2026-07-29 — "it is not about [who sent it]. Its a standalone record." Who relayed a captured file belongs in the body's own framing text, not in `from:`/`to:` frontmatter competing with what the capture actually contains.
- `role:`/`wrapper:`/`identity:` — new fields, forward-only from 2026-07-28 (Open Decision #58). Sit alongside `from:`/`to:`, not instead of them. Full definitions and per-surface rules: `_ai-context/attribution-schema.md`.
- `aliases:` — 2–5 alternate search terms, drafted from the file's actual content. Drafted by whoever authored it, or is closest to its original intent — not guessed by the promoting agent on the other side's behalf (Open Decision #42).
- `refs:` — bundle-relative markdown links (`./file.md`), or a relative path to a git-tracked instruction file outside the bundle (`../AI_INSTRUCTIONS.md`) for the record-to-instruction case. `refs:` is the single source of truth; every other link representation is mechanically generated from it, never hand-authored (Open Decision #42).

## 3. Generated `## Links` footer

Run `_ai-context/generate-links-footer.ps1 -BundlePath <path>` after adding or changing any file's `refs:`. It regenerates the marked footer for every file that has one, validates every ref actually resolves, and fails loudly on a broken ref rather than silently emitting a broken link. `index.md` is always skipped — it stays hand-written curation, never a generated footer (Open Decision #42).

## 3a. Generated `generated:` field

If the file carries `role:`/`wrapper:`/`identity:` (forward-only, see §2 and `_ai-context/attribution-schema.md`), commit it first, then run `_ai-context/generate-provenance.ps1 -BundlePath <path>` — it regenerates the marked, nested `generated: { by, at }` frontmatter field (`by` from `wrapper:`/`identity:`, `at` from the file's own last-commit author date via `git log`), and fails loudly if only one of `wrapper:`/`identity:` is present, or if the file has no commit yet, rather than guessing (Open Decision #58). Stage the file again and `git commit --amend --no-edit` to fold the derived field into the same commit — full workflow and rationale in `_ai-context/attribution-schema.md` §3.

## 4. Provenance stamping — mechanical transcripts only

If the file is a genuinely mechanical extraction from a stored raw log (not live-captured, not manually pasted), run `_ai-context/extract-session-transcript.ps1` and paste its printed `source-path`/`source-sha256`/`extraction-script-version` into the frontmatter. If the source log was still open and growing at extraction time, do not hash the whole file — hash only the slice actually extracted, and disclose the boundary plus the append-only assumption in a `source-sha256-note` field (Open Decision #44).

## 5. Action-digest capture — mechanical transcripts only

Run the same extraction with `-IncludeActions` and save the output to a local, git-untracked evidence store (`AI-Evidence\action-digests\<platform>\`) — as a matter of course, every time, not judged case by case. Never commit or promote the digest itself without a separate, later, deliberate decision — there is no consumer for it yet, since the Auditor hasn't run once (Open Decision #45).

## 6. Index

`_messages/index.md` stays hand-written: a thread-grouped narrative, each entry citing its own file's `refs:` rather than re-deriving relationships. Add a new entry under the relevant thread (or open a new thread heading) at promotion time.

---

## Still open, not resolved by this doc

- Commit cadence (§1).
- Whether the separate outside-conversation capture convention's fields (`capture-method`, `capture-date`, `note-source`) fold into this same procedure once that convention is actually drafted — not yet, since it isn't finalized.

## Links
<!-- generated from refs: - do not hand-edit -->
- [[AI_INSTRUCTIONS]]
- [[auditor-charter]]
- [[attribution-schema]]
- [[backlog-promotion-workflow]]
