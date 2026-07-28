---
type: message
title: "Corpus Discoverability and Link Representation — One Convention, Not Two Problems"
timestamp: 2026-07-10
from: Claude Code (Fable 5, AI-Auditor workspace — not the Publish Agent)
to: Cameron
aliases:
  - link convention
  - aliases and wikilinks
  - graphify assessment
refs:
  - ./fable-to-cameron-2026-07-10-ai-prod-examination-and-proposals.md
  - ./index.md
  - ../PROJECT_STATE.md
---

**A note on `refs:` above:** the first entry is folder-relative (this file's companion in `AI-Auditor\`); the others are repo-relative to `cameronloudon.github.io`, per the Open Decision #34 rule that citations point at git-tracked paths. Same custody caveat as the companion file: `AI-Auditor\` is not git-tracked; this is stated rather than left implicit.

---

## 1. What this covers

Continuation of the 2026-07-10 examination session (see companion file above, which covers Observations 1–2). This file covers Open Decision #37 (corpus discoverability) and the link-representation question — the three competing link syntaxes — which Cameron merged mid-discussion, correctly: they resolve into a single convention. Two corrections from Cameron shaped this: the 36-file `_messages/` bundle is a pilot slice, with **hundreds** of files (including OKF material) still to be added; and his goal explicitly includes a linked Obsidian graph view plus keeping karpathy-llm-wiki viable via `[[wikilinks]]`.

## 2. How the scale correction changes the earlier advice

At 36 files, "hold discoverability as a known limitation" was defensible. At hundreds, it isn't — but the fix is still not search infrastructure (grep across hundreds of markdown files is instant on every platform in use). The real consequence is sequencing: **conventions must be settled before the backfill, because generating them at promotion time is nearly free and retrofitting them onto hundreds of promoted files is the expensive path.** These decisions stop being "someday" and become prerequisites for the backfill Cameron already intends.

## 3. The two halves, untangled

Cameron's instinct — solve it in the content, not the tooling — is right for both halves, but they are distinct fixes:

**Aliases fix search (the vocabulary problem).** "That memory database tool" failing to find "OpenBrain" is a term-matching failure. Fix: a frontmatter list of alternate names per file. Use Obsidian's native `aliases:` property, not an invented field — Obsidian's quick switcher, search, and unlinked-mentions understand it automatically, while it remains plain grep-able YAML for every other agent, forever, with no plugin and no `.obsidian` config to protect from the robocopy sync.

**Body links fix the graph (the edge problem).** Confirmed in session-28: Obsidian's core graph draws edges only from links in body text, and karpathy-llm-wiki's retrieval-time PageRank walks only native `[[wikilinks]]`. Frontmatter `refs:` — the audit-grade record — is invisible to both. No amount of aliasing changes that.

## 4. The convention: `refs:` is canonical, everything else is generated

The trap at corpus scale is hand-maintaining three link representations (frontmatter `refs:`, markdown links, `[[wikilinks]]`) across hundreds of files — they will drift, and drift in an audit corpus is poison. The escape is one rule:

> **`refs:` frontmatter stays the single source of truth. All other link representations are mechanically generated from it, and marked as generated.**

Concretely: a small generator script (session-28 already judged a body-link generator viable, didn't build it) runs at promotion time and appends a marked footer to each file:

```markdown
---
type: message
title: "Re: Pilot Run, Results"
timestamp: 2026-07-09
from: Cowork
to: Claude Code
aliases:
  - pilot response
  - OKF pilot results reply
refs:
  - ./ccode-to-cowork-2026-07-09-pilot-results.md
---

...the file's actual content, untouched...

## Links
<!-- generated from refs: — do not hand-edit -->
- [[ccode-to-cowork-2026-07-09-pilot-results]]
```

What this buys, all at once:

- **Obsidian graph view lights up** across all files, not just `index.md`'s hub — with zero plugins (no Dataview dependency, which also lowers the urgency, though not the necessity, of the `.obsidian` robocopy exclusion).
- **karpathy-llm-wiki stays a genuine option** — its `[[wikilink]]` requirement is met the day it's installed, with no migration.
- **The audit layer stays pure and drift becomes detectable** — because the footer is derived, any verifier (Cowork's independent checks today, the Auditor later) can regenerate it from `refs:` and diff. A mismatch is evidence of hand-tampering or staleness, mechanically catchable. This converts the three-syntax liability into an integrity check.
- **It scales to the backfill** — the same script that stamps one file stamps four hundred, and the aliases habit rides the same pipeline.

Honest cost: the generated footer is content inside custody-tracked files, so the convention ("files carry a generated Links section; `refs:` verification treats it as derived, not authored") is a structural change to the OKF bundle format and belongs in the propose→review→consensus loop with Cowork before backfill bakes it in. She is already primed — the generator idea surfaced in her own session-28 exchanges.

Design details deliberately left open for that consensus loop, not decided here: exact footer heading and marker comment; whether aliases are required or best-effort at promotion; whether the generator also validates `refs:` resolution as it runs (recommended — it is the natural place); and whether `index.md`'s hand-written thread narrative remains hand-written (recommended — it is prose, not link data).

## 5. Proposed actions

In order. Nothing here was executed this session; all of it precedes and unblocks the historical backfill.

1. **Propose the convention to Cowork** — `aliases:` frontmatter + generated `[[wikilink]]` footer derived from `refs:` — through the normal propose→review→consensus process. Owner: Publish Agent drafts, Cowork reviews independently, Cameron decides.
2. **Build the generator** once agreed: read `refs:`, emit/refresh the marked footer, validate every ref resolves while doing so. Run it across the existing 36 files as the first real test; check the Obsidian graph before/after — that is the visible acceptance test. Owner: Publish Agent.
3. **Add both conventions to the promotion workflow** (`_ai-context/` spec and the Draft/Publish handoff), so every future promotion — including all backfill batches — carries aliases and generated links from day one. Owner: Publish Agent, per the instruction-file sync discipline.
4. **Only then start the backfill** of the remaining backlog and pre-Messages history, batch by batch, with the pipeline doing the stamping. Owner: per the existing Open Decision #35 sequencing; Cameron gates each batch.

Dependency note: action 2's Obsidian acceptance test will recreate `.obsidian/` in AI-Prod; the robocopy `/XD ".obsidian"` fix (companion file, proposed action 2) should land first or the test's vault state will be wiped at the next merge — observed happening 2026-07-10, not hypothetical.

## 6. Limits

- Obsidian's graph following body `[[wikilinks]]` is confirmed by session-28's own live test (`index.md` showed edges; frontmatter-only files did not). The karpathy-llm-wiki wikilink requirement is per session-28's check against Karpathy's source document — not re-verified in this session.
- Alias quality is a human/agent judgment at promotion time; no generator can know that Cameron will one day call OpenBrain "that memory database tool." The convention lowers the miss rate; it cannot make it zero.
- Fable 5 access is time-limited; as with the companion file, everything here is written to be executable by any capable AI without this session's context.

---

## Addendum (2026-07-11): Graphify as a third Open Decision #37 candidate

Added the day after the original record, at Cameron's request, so Cowork and the Publish Agent see this alongside the convention it relates to.

**What it is.** [Graphify](https://graphify.net/) ([source](https://github.com/safishamsi/graphify)) is an open-source knowledge-graph skill for AI coding assistants (Claude Code among its supported hosts). It ingests markdown, code, PDFs, and images via Tree-sitter static analysis plus LLM semantic extraction, and emits three derived artifacts: an interactive HTML visualization, a markdown report, and a queryable JSON graph. It tags every relationship EXTRACTED / INFERRED / AMBIGUOUS — an unusually audit-friendly design choice worth noting for this project.

**How it relates to the convention above.** It doesn't compete with it — it consumes it. Because §4's rule keeps `refs:` canonical and everything else generated plain text, Graphify is simply a third candidate *consumer* for Open Decision #37 (corpus discoverability), alongside karpathy-llm-wiki Query and Obsidian search/MCP. Nothing in the convention needs to change to keep it viable.

**Three bounds, agreed with Cameron 2026-07-11:**

1. **Its marketing claims are not evidence.** Circulating summaries cite "70x+ token savings" and "eliminating hallucinations"; retrieval reduces hallucination, never eliminates it, and the token math comes from large-codebase scenarios. This corpus is hundreds of small markdown files where grep is nearly free (§2). Graphify's genuine wins here would be vocabulary-mismatch queries (which `aliases:` also attacks, more cheaply) and multi-hop questions a grep cannot answer.
2. **No "always query Graphify first" instruction in `CLAUDE.md` or any instruction file.** That would create a hard tool dependency, against the platform-generality bar this project applies everywhere else. The content stays self-describing; Graphify is an optional accelerator on top, never load-bearing.
3. **Its outputs are derived artifacts — same treatment as `.obsidian/`.** They need a decided home safe from the robocopy `/MIR` sync, and a standing rule that the graph is regenerable from the markdown and diffable against it — never a second source of truth. That makes it Auditor-compatible via the same regenerate-and-diff integrity check as the generated footers (§4).

**Sequencing.** Unchanged by this addendum: settle the convention, run the backfill, *then* evaluate Graphify against the real corpus alongside the other Open Decision #37 candidates. Adopting it earlier means building the graph twice.

---

<div class="collab-note">
<div class="collab-note-header">AI Collaboration Note</div>
<div class="collab-note-body">
This document was written by Claude (Anthropic), model claude-fable-5, running in Claude Code in the AI-Auditor workspace — a separate session from the project's Publish Agent. It records a design discussion held 2026-07-10: the analysis, the single-source-of-truth convention, and the proposed action sequence are the AI's; Cameron supplied the two corrections that shaped it (true corpus scale in the hundreds of files, and the explicit goal of Obsidian graph view plus karpathy-llm-wiki compatibility) and identified that the vocabulary and graph questions should be solved together in content rather than infrastructure. No files in AI-Prod or the repo were created, modified, or deleted. Nothing here has been actioned — every proposal awaits the project's normal propose→review→consensus process.
<br/><br/>
The 2026-07-11 Graphify addendum (and the `aliases:` frontmatter added at the same time) was written by Claude (Anthropic), model claude-fable-5, running in Claude Code in the AI-Auditor workspace, in the session following the original. Cameron raised Graphify from his own research and asked for the assessment to be recorded here so Cowork and the Publish Agent see it with the convention; the tool description was verified against Graphify's public site and repository that day; the three bounds were proposed by the AI and explicitly agreed by Cameron. The original 2026-07-10 body above is unchanged.
</div>
</div>

*Written under the Radical Collaboration Transparency framework.*
*Model: claude-fable-5 · Platform: Claude Code · Workspace: AI-Auditor · Date: 2026-07-10 (addendum 2026-07-11)*

## Links
<!-- generated from refs: - do not hand-edit -->
- [[fable-to-cameron-2026-07-10-ai-prod-examination-and-proposals]]
- [[index]]
- [[PROJECT_STATE]]
