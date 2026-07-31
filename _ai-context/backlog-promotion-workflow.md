---
type: reference
title: "Backlog-Promotion Workflow — Session-Level Procedure"
role: Publish
wrapper: Claude Code
identity: Sonnet 5
generated: { by: Claude Code/Sonnet 5, at: 2026-07-31T11:48:34+10:00 }  # generated from wrapper:+identity:+commit-date - do not hand-edit
aliases:
  - backlog promotion workflow
  - how to run a promotion batch
  - batch selection procedure
refs:
  - ./messages-promotion-procedure.md
  - ../PROJECT_STATE.md
---

**Written:** 2026-07-29 (session-64), at Cameron's direct request, once the historical `AI-Working/Messages/` backlog (2026-06-26 through 2026-07-28) was fully promoted. Captures a workflow that had only existed as unwritten session practice — refined mostly through session-64's own back-and-forth with Cameron, not designed upfront.

**Distinct from `messages-promotion-procedure.md`:** that file covers per-file mechanics — required frontmatter, the generated Links footer, provenance stamping. This file covers the session-level question that file's own §1 names as genuinely open: how a batch actually gets selected, scoped, verified, and closed out. Read both; they answer different questions.

---

## 1. Find what's actually left

```
comm -23 <(ls "AI-Working/Messages/" | sort) <(ls "_messages/" | sort)
```

This is the ground truth, not whatever count `PROJECT_STATE.md` or `_messages/index.md`'s Gaps section last stated — both are narrative summaries that can drift a session or two behind the real folder (new backlog content keeps landing in `AI-Working/Messages/` between sessions). Recount directly every time a batch starts, cite the recount, don't carry forward a stale figure.

Exclude the standing-rule operational prompt-paste templates (per the 2026-07-24 decision recorded in `_messages/index.md`'s Gaps section) before treating the remainder as real backlog — these are never promoted, and including them in a "files remaining" count overstates the real work left.

## 2. Pick a batch boundary

Group the remainder by date first. Within a date, don't default to "the whole day" or "a fixed file count" — look at the actual shape of the content:

- **A real gap in filesystem mtime** (a multi-hour or multi-day jump in when the source files were written) is usually a genuine narrative boundary, not an arbitrary cut. Cross-check it against the `refs:` chain — a clean boundary has no file in the proposed batch referencing something outside it (forward or backward) that isn't already promoted.
- **A coherent story arc** (a single incident, a single design question worked to resolution) is a better unit than a fixed size. Session-64's batches ranged from 5 to 40 files; what mattered was that each one closed something, not that they matched in size.
- A whole day in one batch is fine when the day's content is genuinely one continuous thread (batch-21, batch-23 through -25 each did this). Split a day into multiple batches when it visibly isn't (batch-19/-20 split 2026-07-19's ~84 files because the day covered several distinct sub-arcs).

## 3. Propose scope before executing

State the candidate batch — file count, date, one-line description of what it covers, and confirmation that its `refs:` resolve within the batch plus what's already promoted — and wait for a go-ahead before copying anything.

This isn't the default for every batch mechanically; it's what to do when there's real uncertainty about scope or when the previous batch ran without it and drew a question. Session-64's own history: batch-19 ran without proposing scope first: batch-20 proposed scope first, after Cameron raised the question of whether that step was being skipped. If a session has an established, unremarked-on rhythm going (per Cameron's own confirmation, checked against the actual session-63 transcript — the real historical pattern was per-batch spot-check gating, not per-file proposal), matching that rhythm is enough; don't manufacture a proposal step nobody asked for.

## 4. Verification depth

Every file promoted in this project's post-2026-07-13 era already arrives with complete, correct OKF frontmatter and a pre-generated Links footer at the source — confirmed repeatedly, not assumed. That makes promotion mechanically a copy, not frontmatter construction. It does **not** by itself justify skipping a read of the actual content:

- **Default:** read every file in full before promoting, not just its frontmatter. This became the standing practice in session-64 after Cameron asked directly whether lighter, source-trusted batches held the same integrity as fuller ones — the honest answer required actually reading the files, not asserting it.
- Trusting source frontmatter without an independent content read is a real, defensible choice for routine, undisputed correspondence — but disclose that choice plainly (in the batch's spot-check request, in `PROJECT_STATE.md`'s row-level notes) rather than letting a lighter pass look identical to a fuller one in the record.
- Give unusually high-stakes files — the literal record a whole safeguard process was built toward, a script's own build history, anything a later design decision cites by name — a full read regardless of general batch policy, and say so.

## 5. Copy, validate, fix

```
cp <source files> _messages/
generate-links-footer.ps1 -BundlePath _messages
```

Fix every `FAILED` before moving on. The recurring bug class across session-64's batches (17, 21, 23, 24, 25 all hit it): a file's `refs:` was written relative to wherever `AI-Working/Messages/` sat on the authoring machine at the time (`../../GitHub/cameronloudon.github.io/...`, `../../AI-Prod/...`), which doesn't resolve once the file lives inside `_messages/` itself. Fix is mechanical: strip the working-location prefix, replace with `../` (one level up from `_messages/` to repo root) plus the real path. When several files in one batch share the exact same bad prefix, fix them with one `sed` substitution across all of them rather than editing file-by-file.

A second, rarer case: a `refs:` entry pointing at a file that was never git-tracked at all — a Draft-workspace `Ready/`-folder copy, a raw report staged only in `AI-Working/Audit/` and never promoted, a working-document copy that no longer exists under that name. These aren't path bugs; there is no correct bundle-relative path to write. Drop the entry from `refs:` entirely rather than force-fitting it, and say so in the promotion's own record (see §6).

## 6. Update the record

- **`_messages/index.md`** — a new `## Thread N` (or a new sub-group inside an existing thread, if the batch extends a day already partly promoted), one bullet per file: `[Title](./file.md) — \`type\` (from → to) → refs ...; one-line note`. Update the Gaps section's running paragraph with the batch number, file count, and the recount from §1.
- **`PROJECT_STATE.md`** — one row per promoted file in the `_messages/` bundle table (`| file | type | Batch-N backlog promotion, DATE (session-NN), Thread N — [rigor tier / full content read] |`), and a matching sentence in the running "X more added" paragraph a few lines above the table.
- **Any correction** (a dropped ref, a fixed path, a constructed-not-copied frontmatter for a still-plain-header file) gets cited at the point it's recorded — what was wrong, what changed, why — not folded silently into a generic "promoted" note. This project's own citation-on-correction standard (`AI_INSTRUCTIONS.md` §8) applies here same as everywhere else.

## 7. Verify, don't assume

```
function-b-state-check.ps1 -RepoRoot .
```

Run this after every batch's record updates, not just at session close. It catches exactly the class of self-inflicted drift a large batch of hand-edited table rows is prone to — a miscounted total, a table row that doesn't match a real file. A clean run is the actual close-out signal for a batch, not a feeling that the edits are probably right.

## 8. Looping Cowork in

Not a fixed per-batch requirement — the real historical pattern (checked against session-63's own raw transcript, not assumed) is Cameron relaying her spot-check verdict before the *next* batch starts, not a gate on every single one. When a spot-check does happen, disclose the batch's actual verification depth and any judgment calls honestly in the request — a spot-check against a request that undersells what was skipped isn't a real check.

## Still open, not resolved by this doc

- Exact cadence for requesting a spot-check (every batch vs. periodic) — matched historical practice loosely this session, never re-decided as an explicit rule.
- Whether `_ai-context/prescan-backlog.ps1` gets folded into step 1 as standard practice now that the historical backlog is closed and remaining work is smaller, steadier new-content batches rather than a large multi-year backlog.

## Links
<!-- generated from refs: - do not hand-edit -->
- [[messages-promotion-procedure]]
- [[PROJECT_STATE]]
