---
type: reference
title: "System Architecture — cameronloudon.github.io and the AI Collaboration System"
aliases:
  - system architecture document
  - architecture reference
  - Auditor baseline document
refs:
  - ../PROJECT_STATE.md
  - ../AI_INSTRUCTIONS.md
  - ../CLAUDE.md
  - ./auditor-charter.md
  - ./messages-promotion-procedure.md
  - ./outside-conversation-capture-convention.md
---

**Last updated:** 2026-07-11 (session-32)
**Status:** Full rewrite, superseding `AI-Working/Messages/audit-reference-standalone-2026-07-05.md` (the 2026-07-05 version, DeepSeek-audited — see Open Decision #28). That document was used as a structural template, not a binding one; sections, emphasis, and content have all changed where the system itself changed. This document is the prerequisite deliverable named in `auditor-charter.md` §7 — the Auditor's Function B (drift detection) verifies it against reality every run. Piloted as the first `_ai-context/` file to carry OKF frontmatter, per consensus with Cowork (`AI-Working/Messages/ccode-to-cowork-2026-07-11-okf-pilot-agreed.md`).
**Single-sourcing rule this document follows:** anything that changes often — the active branch, the current Open Decisions list, exact page/file inventories, the Capability Baseline tables — is not duplicated here. It lives in `PROJECT_STATE.md`, cited by `refs:`, not restated. This document describes *structure*: what doesn't change every session, even when the specific facts inside that structure do.

---

## 1. Purpose

A complete, current, self-contained picture of how this repository and its surrounding AI-collaboration system work, for two audiences: a cold-reading Auditor checking whether the system's actual state agrees with what's documented, and any AI or human onboarding cold. Everything here is either a durable structural fact (verified against the live repo, not assumed) or an explicit pointer to where the current, changing version of a fact lives.

## 2. System overview

The system has four roles, only one of which is currently instantiated in more than name. All four exist to serve one stated goal: **AI independence** — the ability to swap which Tool, Model, and Runtime fills any role, without the record of what happened depending on any one of them (`PROJECT_STATE.md` Capability Baseline; full role definitions: `AI_INSTRUCTIONS.md` §3).

```mermaid
flowchart LR
    C[Cameron<br/>decides & merges] --> DA[Draft Agent<br/>currently Cowork]
    DA -->|Ready/| PA[Publish Agent<br/>currently Claude Code]
    PA -->|branch + PR| C
    C -->|merge confirmation| PA
    PA -->|Phase 2 sync| M[(AI-Prod mirror)]
    DA <-->|Messages/| PA
    R[Review Agent<br/>rotating, cold] -.->|reviews docs| C
    A[Auditor<br/>cold, read-only<br/>ratified, not instantiated] -.->|audit-findings| C
    A -.->|reads| M
    A -.->|reads, once granted| W[(AI-Working)]
```

- **Draft Agent** — drafts structured content only (no HTML, no frontmatter). Read/write on `AI-Working\`; read-only on the `AI-Prod` mirror; no direct repo/git access.
- **Publish Agent** — authors all HTML/frontmatter from Draft Agent content, commits, pushes, runs Phase 2. Read/write on the repo; read-only on `AI-Working\Ready\`; read/write on `AI-Working\Messages\`; read on `AI-Working\Audit\`.
- **Review Agent** — external, rotating (most recently DeepSeek), reviews documents Cameron provides. No standing access.
- **Auditor** — cold, independent, read-only across the repo and `AI-Prod`; writes only its own `type: audit-finding` reports to `AI-Working\Audit\`. Charter ratified 2026-07-11 (`auditor-charter.md`); role not yet instantiated for a real run — see `PROJECT_STATE.md` Open Decision #47 for exactly where that stands.

Current tool/model filling each role, and every tested alternative: `PROJECT_STATE.md`, Tool/Model/Runtime Matrix — not duplicated here, since it changes every time something gets retested.

## 3. How Jekyll builds this site

Two mechanics are load-bearing for everything in §5:

- **A page's published URL is set by its `permalink:` frontmatter field, not by where its source file lives.** A file can move anywhere in the source tree without changing its public URL, provided `permalink:` is set and unchanged.
- **Any plain directory is processed automatically; any underscore-prefixed directory is either a Jekyll reserved name or a custom collection, which must be declared in `_config.yml`.** Underscore alone does not hide a folder from the build — only the `exclude:` list, or non-declaration as a collection, does that.

Both verified directly against this repo's `_config.yml`, not assumed.

## 4. The publishing pipeline

```mermaid
flowchart TD
    D[Draft Agent writes<br/>structured content] --> R[AI-Working/Ready/]
    R --> P[Publish Agent<br/>authors HTML + frontmatter]
    P --> V{Validation checklist<br/>rct-validation-checklist.md}
    V -->|pass| B[Commit + push<br/>session branch]
    V -->|fail| P
    B --> PR[Cameron reviews<br/>on GitHub]
    PR --> MG[Merge to main]
    MG --> PH[Phase 2:<br/>1. correct PROJECT_STATE.md<br/>2. open next session branch<br/>3. robocopy sync to AI-Prod]
    PH --> AP[(AI-Prod mirror)]
```

This separation exists specifically so neither agent can accidentally modify the other's files — enforced by filesystem permission grants for the Publish Agent (`.claude/settings.json`), by convention for the Draft Agent (a real enforcement-parity gap, not yet closed — see §8).

**Phase 2, precisely:** triggered by Cameron pasting the GitHub merge-confirmation message, not by any automated hook. Step 1 (state correction) happens before step 2 (sync) — this ordering exists because the branch-staleness bug (`PROJECT_STATE.md` Open Decisions #19/#21) recurred three times when correction depended on the next session happening to start, rather than firing at the merge event itself.

## 5. The evidence and knowledgebase layer

Did not exist in the 2026-07-05 predecessor document. Built across sessions 26–32 (`PROJECT_STATE.md` Open Decisions #34–#48).

```mermaid
flowchart LR
    AWM[AI-Working/Messages/<br/>plain From/To/Date/Re] -->|OKF-stamp + promote| MB[(_messages/<br/>git-tracked, chain-of-custody)]
    AWA[AI-Working/Audit/<br/>Auditor writes findings] -->|verbatim promote| AF[(_audit-findings/<br/>git-tracked, sibling to _messages)]
    MB --> GEN[generate-links-footer.ps1<br/>refs: is canonical]
    AF --> GEN
    GEN --> WL[Generated ## Links footer<br/>Obsidian-visible wikilinks]
    JSONL[Raw session JSONL<br/>.claude/projects/.../*.jsonl] -->|extract-session-transcript.ps1| MT[Mechanical transcript<br/>+ provenance stamp]
    JSONL -->|-IncludeActions, adopted policy| AD[(AI-Evidence/action-digests/<br/>local, unpromoted)]
    MT --> MB
```

- **`_messages/`** — git-tracked chain-of-custody bundle. `type:` (`message`/`transcript`/`summary`/`index`) comes from reading content, never from filename or self-description (Open Decision #34). Every content file carries `aliases:` and `refs:`; `refs:` is the single source of truth, every other link representation (the generated footer) is mechanically derived and marked as such, never hand-edited (Open Decision #42). Full promotion procedure: `messages-promotion-procedure.md`.
- **`_audit-findings/`** — same treatment, sibling collection for the Auditor's own reports. Verbatim-promotion rule layered on top: the promoting agent is an audited party and never edits a finding's content; the generated footer is the one exception, since it's derived, not authored (`auditor-charter.md` §6).
- **Provenance stamping** — mechanical transcripts carry `source-path`/`source-sha256`/`extraction-script-version`, converting "trust this transcript" into a checkable claim (Open Decision #44). If the source log was still open/growing at extraction time, the hash covers only the extracted slice, disclosed via `source-sha256-note`, not the whole file.
- **Action-digest capture** — `extract-session-transcript.ps1 -IncludeActions` (Claude Code) and Cowork's own Python equivalent, mirroring the same per-field-truncation logic independently on her own platform, both run at every future mechanical extraction as a matter of course, output held locally and unpromoted (`AI-Evidence\action-digests\<platform>\`) until an actual Auditor consumer exists. Two independent implementations of the same policy, not one shared script — decoupling capture from adoption exists because the raw JSONL evidence is itself on a retention clock — waiting to decide risks losing it permanently (Open Decision #45).
- **Outside-conversation capture** — a separate, narrower convention for pre-founding material from outside platforms (ChatGPT, DeepSeek, etc.), not the mechanisms above. Full convention: `outside-conversation-capture-convention.md`.

## 6. Instruction file map

| File | Audience | Precedence |
|---|---|---|
| `ONBOARDING.md` | Any new AI, first session only | Directs to `AI_INSTRUCTIONS.md` and `PROJECT_STATE.md` next |
| `AI_INSTRUCTIONS.md` | Any AI, every session | States its own precedence: authoritative on intent/conventions, governs over `CLAUDE.md` on conflict |
| `CLAUDE.md` | Claude Code specifically; auto-loads every session | Subordinate to `AI_INSTRUCTIONS.md` by that file's own rule |
| `PROJECT_STATE.md` | Any AI, required reading every session | Outranks `AI_INSTRUCTIONS.md` on current state specifically — the one file that changes every session |
| `_ai-context/*` | Whichever role a given file addresses, read on demand | Stable reference material — not auto-loaded, read when a task calls for it (token-cost distinction from `CLAUDE.md`: see `AI-Working/Messages/ccode-to-cowork-2026-07-11-instruction-file-okf-pilot-proposal.md`) |

Full current inventory with per-file detail: `PROJECT_STATE.md`, Instruction File Index — not duplicated here, since it changes whenever a file is added, retired, or re-scoped.

**Known enforcement-parity gap, still open:** the Publish Agent's access is enforced by real, checked grants (`.claude/settings.json`). The Draft Agent's restrictions are convention-only — nothing technical stops Cowork from writing outside her documented scope except being told not to (demonstrated live, Open Decision #38: an unauthorized rescue, disclosed by Cowork herself the same day). Whichever tool eventually fills the Auditor role needs its own enforcement question answered empirically, not assumed — Fable 5's own AI-Auditor workspace, for instance, currently has *zero* access to `AI-Working` at all, confirmed by Fable itself hitting that boundary directly (Open Decision #47).

## 7. Structural conventions

- **Directory-per-entry when an entry has, or is likely to need, sub-pages; flat file remains valid for a single-page entry with none in view.** Narrower than "directory-per-entry universally," which was considered and rejected — a universal rule would have forced migrating entries with no functional gain.
- **No file named `index.html` inside a directory-pattern entry** — the file is named after the directory/topic instead, safe because every entry declares an explicit `permalink:`. The one exception is the true site-root `index.html`, a universal Jekyll convention, not a project-specific exception.
- **`_ideas/`, `_signals/`, `_now/`, `_skills/` remain declared Jekyll collections**, not plain undeclared directories, even though every index page in the site is currently hand-authored rather than collection-generated — preserves the option to generate them automatically later, which would close a confirmed defect class (a published entry not appearing on its own hand-written index because nobody remembered to add it — `rct-validation-checklist.md` §2 now makes this an explicit checklist item).
- **Every deviation from an otherwise-consistent pattern requires an explicit, discoverable written explanation** — an undocumented deviation is treated as a defect regardless of cause. (`_ideas/marketing-os-foundation.html` carries a documented legacy-file note and is compliant under this rule as-is; it is not a pattern to replicate.)
- **Root-level separation (former Rule 5.4) and the `about/` restructuring (former Rule 5.5)** — both open questions in the 2026-07-05 predecessor document — are done. Root now holds only instruction/config files plus `index.html`, the one universal exception. Full history: `PROJECT_STATE.md` Open Decision #30.
- **`_messages/`/`_audit-findings/` follow their own, separate convention** — §5 above and `messages-promotion-procedure.md` — not the HTML/frontmatter rules in this section, which govern published site content only.

## 8. Known permanent limits

**No file-based inventory can discover an instruction injected outside any file.** The Draft Agent's environment may carry at least one instruction configured through that application's own interface, reaching the agent only because the application injects it directly into context at session start. Nothing that reads a folder — including this document, including a future Auditor run — can discover that such a setting exists or what it contains. This is a permanent boundary on documentation efforts of this kind, not a gap this document has failed to close.

**Enforcement is inconsistent across roles and tools**, as named in §6 — a structural fact likely to remain true for any future Draft Agent, Review Agent, or Auditor candidate until each is specifically tested, not assumed compliant by role definition alone.

## 9. Where current state actually lives

This document does not track: the active branch, open decisions, page/file inventories, the Capability Baseline, or anything else that changes session to session. That's `PROJECT_STATE.md`, by design — re-deriving or duplicating it here would recreate exactly the staleness risk this document exists to prevent (`auditor-charter.md` §7's own design requirement: single-sourced where possible). The Auditor's Function B checks this document against `PROJECT_STATE.md` and the live repo on every run — a structural fact stated wrong here is itself a finding.

## 10. Explicit scope exclusions

- No migration sequence, timeline, or task breakdown for anything mentioned as structural-but-unfinished.
- Does not certify every file in the repo or `AI-Working` has been read in full — certifies that everything identified during the review producing this document has been accounted for, stated plainly.
- Whether `karpathy-llm-wiki`'s self-compiling capability, Graphify, or any other discovery-layer tool gets adopted is out of scope — referenced in `PROJECT_STATE.md` Open Decision #37 only.

---

*Prepared by the Publish Agent (Claude Code), full rewrite superseding the 2026-07-05 predecessor, decisions and scope confirmed by Cameron Loudon. 2026-07-11.*

## Links
<!-- generated from refs: - do not hand-edit -->
- [[PROJECT_STATE]]
- [[AI_INSTRUCTIONS]]
- [[CLAUDE]]
- [[auditor-charter]]
- [[messages-promotion-procedure]]
- [[outside-conversation-capture-convention]]
