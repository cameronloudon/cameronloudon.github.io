---
type: message
title: "Resume Handoff — session-28, Success Test Passed, Two Design Questions Open"
timestamp: 2026-07-10
from: Claude Code
to: Cowork and Claude Code
aliases:
  - resume handoff session-28
  - open decision 37 corpus discoverability
refs:
  - ./ccode-to-cowork-2026-07-10-refs-to-instruction-demo.md
  - ./cowork-to-ccode-2026-07-10-independent-graph-verification-result.md
  - ./cowork-to-ccode-2026-07-10-cold-question-test-answer.md
  - ./cowork-to-ccode-2026-07-10-index-finding-retracted.md
---

# Resume Handoff — session-28, Success Test Passed, Two Design Questions Open
From: Claude Code
To: Cowork and Claude Code (whichever session resumes this)
Date: 2026-07-10, end of day
Re: Cameron is pausing for the night — read this first, don't re-derive the state from scratch

---

## Where things actually stand

`session-28` is open, unmerged, working tree clean. Branched from `main` at `7d7c367` (the `session-27` merge, PR #51). Six commits so far, all pushed to `origin/session-28`:

- `33703af` — Phase 2 state correction, opened the branch
- `0a31f21` — fixed a stale provenance note flagged by Cowork's review
- `0ddf723` — built the record-to-instruction traceability demo (Open Decision #35, capability 4)
- `bc13486` — logged Cowork's independent graph verification
- `35a9cfd` — logged the cold-question success test result
- `c028fa2` — logged Open Decision #37 (corpus discoverability gap)

Not merged. Resume on this branch, don't create a new one.

## What actually got proven tonight, in order

1. **The curated 28-file slice is fully promoted** into `_messages/` (36 files total), `index.md` rebuilt into a real cross-linked index, Cowork's review findings from the promotion (duplicate transcript, four-agent-test diagnosis) both fixed.
2. **Record-to-instruction traceability demoed for real** — `_messages/ccode-to-cowork-2026-07-10-refs-to-instruction-demo.md`, the first `refs:` link in the bundle pointing outside it to `AI_INSTRUCTIONS.md` directly, using the real Open Decision #36 finding rather than a synthetic test case.
3. **Obsidian pointed at `_messages/` (via AI-Prod), checked live** — confirmed empirically, not just from docs: every file a disconnected dot except `index.md`, which has real edges because it's the one file with actual markdown body links, not just frontmatter `refs:`. Traced one stray node (`PROJECT_STATE.md` showing up despite folder filtering) to Obsidian's filter doing text-match, not path-scoping — resolved with `path:_messages`.
4. **Cowork independently re-verified the link structure** from raw frontmatter, not from Cameron's screen: re-ran mechanical resolution herself (36 files, 44 links, zero broken), spot-checked two relationships against real content, tested `index.md`'s own accuracy rule. All held.
5. **The actual success test ran and passed** — Cameron asked cold: "why did we decide not to follow through on OpenBrain?" A fresh Claude Code subagent (zero conversation memory) and Cowork answered independently, no coordination. Both found the same source, quoted the same passage verbatim, and both corrected the question's own false premise — there was never a formal decision, just an unresolved pivot to a different idea (which became `_messages/` itself).
6. **A real limitation surfaced from that result, not left implicit** — both agents found the answer via the identical mechanism (grep for the exact term "OpenBrain"). That only worked because both happened to have grep-equivalent tool access today, and because the question used the corpus's own original terminology verbatim. Neither condition is guaranteed for a future agent/role or a paraphrased question. Logged as Open Decision #37, directly tied back to the concern Cameron first raised in the 2026-07-09 design conversation about Draft/Publish/Research Agents that might not have filesystem search wired in at all.

## What's already done, don't redo it

- The 28-file promotion, the index rebuild, the record-to-instruction demo, both rounds of Cowork's independent verification, the OpenBrain success test — all complete, all logged in `PROJECT_STATE.md` (Open Decisions #35, #36, #37).
- The `superseded_by:` fix and stale-note fix from Cowork's original review — done.

## What's open, not decided, genuinely next

Three real design questions, none built yet, none blocking anything:

1. **The body-link generator** (Open Decision #35's remaining scope) — mechanically generate body-text links from `refs:` frontmatter so Obsidian's graph shows real connections across all 36 files, not just `index.md`'s hub. Confirmed viable, confirmed as the actual OKF-native pattern (even Google's own reference visualizer reads body links, not frontmatter). **New refinement from tonight's last exchange:** if the generator emits `[[wikilinks]]` instead of plain markdown links, it would *also* satisfy `karpathy-llm-wiki`'s PageRank retrieval requirement in one pass — Obsidian's core graph treats both syntaxes identically, so this is close to free. **Unverified:** whether Google's official OKF visualizer also reads wikilink syntax, or only markdown-style links specifically — if markdown-only, the generator may need to emit both forms, not just switch to wikilinks. Check this before committing to one syntax.
2. **Dataview** as a query-based alternative to fixing graph view directly — confirmed technically viable, reads frontmatter list fields without needing real links at all. Blocked on one practical fix first: AI-Prod's `/MIR` robocopy sync would wipe Obsidian's `.obsidian/` plugin config (including Dataview itself) on every Phase 2 sync unless `.obsidian` gets added to the exclude list. Fix identified, not made — Cameron explicitly held this for now.
3. **Open Decision #37** (corpus discoverability independent of the querying agent's own tools) — two candidate mechanisms named, neither built: `karpathy-llm-wiki`'s Query operation (search lives in the knowledgebase itself), or Obsidian search exposed via API/MCP to any agent, not just Cameron's own GUI session.

## Explicitly still deferred, not decided against

- `karpathy-llm-wiki`'s actual self-compiling capability (Ingest/Query/Lint, active LLM-maintained rewriting) — confirmed from Karpathy's own source document to require `[[wikilinks]]` natively, tool-agnostic in principle but not in link syntax. This is a fundamentally bigger commitment than anything built so far: it also has a real, unresolved tension with RCT's attribution model (continuously-rewritten pages don't fit the current one-static-collab-note-per-page convention) — flagged in discussion, not yet a proposal.
- The wider historical backfill (DeepSeek, ChatGPT, old Gemma/AnythingLLM sessions, pre-`_messages/` history).
- `obsidian-local-rest-api` / MCP access for Claude Code or Cowork to Obsidian's live state — researched, looks genuinely viable and well-secured, not set up.

---

*Claude Code (Publish Agent) · 2026-07-10, end of day*

## Links
<!-- generated from refs: - do not hand-edit -->
- [[ccode-to-cowork-2026-07-10-refs-to-instruction-demo]]
- [[cowork-to-ccode-2026-07-10-independent-graph-verification-result]]
- [[cowork-to-ccode-2026-07-10-cold-question-test-answer]]
- [[cowork-to-ccode-2026-07-10-index-finding-retracted]]
