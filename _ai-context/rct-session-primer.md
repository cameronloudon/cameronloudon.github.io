---
type: reference
title: "RCT Session Primer"
role: Publish
wrapper: Claude Code
identity: Sonnet 5
generated: { by: Claude Code/Sonnet 5, at: 2026-07-28T10:03:10+10:00 }  # generated from wrapper:+identity:+commit-date - do not hand-edit
aliases:
  - RCT session primer
  - session log format
  - collaboration note format
refs:
  - ../PROJECT_STATE.md
  - ./attribution-schema.md
---

**Last updated:** 2026-06-21
**Part of:** Radical Collaboration Transparency framework

---

## What RCT Is

**Radical Collaboration Transparency (RCT)** is Cameron's framework for honest attribution of AI collaboration. The principle: if AI contributed to thinking or output, that contribution is documented specifically — not hidden, not overstated.

Every published page on cameronloudon.github.io that carries AI-assisted content must have a Collaboration Note. Every session that changes the repo must produce a Session Log. Both are public and auditable.

RCT exists because "made with AI" is not a useful description of what actually happened. The session log is.

---

## How Cameron Works

- Cameron brings domain knowledge, judgment, and accountability. He owns every decision and every published conclusion.
- The AI brings pattern recognition, structure, and friction without ego.
- Contradictions are named and held, not resolved prematurely.
- What remains unresolved at the end of a session is flagged explicitly — not papered over.

---

## Collaboration Note Format

Every published page carrying AI-assisted content must include a Collaboration Note. Use this HTML structure:

```html
<div class="collab-note">
  <div class="collab-note-header">
    🤝 Collaboration Note
  </div>
  <div class="collab-note-body">
    <p>This [page/piece/section] was developed in a session with [AI name] ([provider]).</p>
    <p>Role: [Publish/Draft/etc.] · Model: [model string] · Session: [session ID] · Platform: [platform] · Date: [YYYY-MM-DD]</p>
    <p>[1–2 sentences on what Cameron contributed vs what the AI contributed. Be specific — "developed collaboratively" is not acceptable.]</p>
    <p>Reviewed and approved by Cameron Loudon. Part of the Radical Collaboration Transparency framework.</p>
  </div>
</div>
```

**Rules:**
- One collab-note per page. Not zero, not two.
- The class must be `collab-note` (not `collaboration-note` or any variant).
- Inner structure must use `collab-note-header` and `collab-note-body`.
- The AI contribution description must be specific. Name what the AI actually did.
- The session ID must match a session log that exists or will exist in `_session-logs/`.

---

## Session Log Format

Every session that changes the repo must produce a session log file in `_session-logs/`.

**Filename:** `session-YYYY-MM-DD-NNN.md`
NNN is a zero-padded three-digit counter. The correct next ID is in `PROJECT_STATE.md` under `NEXT_SESSION_LOG_ID`. Do not guess — read it.

**Frontmatter:**
```yaml
---
layout: default
title: "Session Log — YYYY-MM-DD-NNN"
date: YYYY-MM-DD
session_id: YYYY-MM-DD-NNN
---
```

**Required fields (metadata table):**

| Field | Value |
|---|---|
| Session ID | YYYY-MM-DD-NNN |
| Date | YYYY-MM-DD |
| Participants | Cameron Loudon + [AI name and model] |
| Model | [exact model string if known] |
| Platform | [e.g. Claude Code, Cowork, API] |
| Duration | [estimated] |
| Threads | [count] |
| Contradictions named | [count] |
| Resolved | [count] |
| Unresolved | [count] |
| Files changed | [count] |

**Tags:** `#tag1` `#tag2` — topic-based

**Documents touched:** list of files created, edited, or referenced

---

### Thread Format

For each distinct line of work in the session:

```
## Thread N — [Name]

**What happened:**
[What was done, what emerged, what changed]

**Decisions made:**
[What was decided and why]

**Unresolved:**
[What remains open]
```

---

### Closing Lines

End every session log with:

```
*Session conducted under the Radical Collaboration Transparency framework.*
*Role: [Publish/Draft/etc.] · Model: [model] · Session ID: [ID] · Platform: [platform]*
*Reviewed and approved by Cameron Loudon.*
```

---

## Self-Identification

When writing a collab-note or session log, the AI identifies itself as it actually is: "Claude (Anthropic)," "Codex (OpenAI)," "Llama-3-70B," or whatever is accurate. Do not substitute a generic placeholder. Honest self-identification is a requirement of RCT, not a preference.

---

*Version: 1.1 · Updated: 2026-06-21 · Promoted from AI-Working to _ai-context/*

## Links
<!-- generated from refs: - do not hand-edit -->
- [[PROJECT_STATE]]
- [[attribution-schema]]
