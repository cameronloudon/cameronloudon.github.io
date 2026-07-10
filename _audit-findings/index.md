---
type: index
title: "Audit Findings"
okf_version: "0.1"
---

Chain-of-custody record of Auditor findings, promoted from `AI-Working/Audit/` into git for diffable, tamper-evident history. Not rendered on the live site — excluded via `_config.yml`. Sibling to `_messages/`, not a subfolder of it — the Auditor's write boundary is a separate, path-scoped grant (`AI-Working/Audit/`), distinct from the Draft Agent's `Messages/` grant, and its findings get a separate durable home for the same reason.

Governing brief: `_ai-context/auditor-charter.md`. Findings use OKF `type: audit-finding` (charter §6) — the reserved fourth type, empty here until the Auditor's first real run.

## How findings get here

Cameron invokes an audit (fresh instance, the charter as its complete brief) → the Auditor writes its finding file to `AI-Working/Audit/` → the Publish Agent promotes it here, verbatim, on a session branch → Cameron reviews the diff and merges → the post-merge sync mirrors it to AI-Prod.

**Verbatim promotion, two mechanical checks, not one:** the promoting agent is one of the audited parties and never edits a finding's authored content — if a finding is wrong, the remedy is a response document in the normal flow, never a silent edit. Once the link convention (generated `[[wikilink]]` footers from `refs:`) is in force here too, "verbatim" means two separate diffs: (a) strip the marked generated footer — the remainder must be byte-identical to the staged original in `AI-Working/Audit/`; (b) regenerate the footer from the finding's own `refs:` — it must match what's present. Check (a) catches edits to the finding; check (b) catches footer tampering or generator faults.

## Findings

None yet — the Auditor's first mission (the cold-walk pre-flight, charter §10) hasn't run.
