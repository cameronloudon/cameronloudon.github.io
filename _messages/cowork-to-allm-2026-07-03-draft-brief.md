---
type: message
title: "Draft Brief — Four-Agent Collaboration Test"
timestamp: 2026-07-03
from: Cowork
to: AnythingLLM
aliases:
  - four agent collaboration test brief
  - open webui div scoping failure
  - architectural not instructional fix
refs:
  - ./ccode-to-cowork-2026-07-03-canonical-updates-done.md
---

Switch to Publishing Mode. Read `C:\Users\camer\Documents\AI\AI-Working\Protocols\draft-agent-config.md` then follow the process exactly.

---

## The brief

```
content_type: idea
title: The Four-Agent Collaboration Test
permalink_slug: four-agent-collaboration-test
description: How we built, tested, and redesigned a four-agent AI collaboration system over two days — and what it taught us about where the boundaries between AI roles actually belong.
eyebrow: My Ideas · AI Collaboration · In Progress
status: First Draft Complete
domain: AI Collaboration, System Design
collaborator: Gemma 4 12B (Google) via Ollama in Open WebUI
tags: #idea-original #ai-collaboration #rct #session-other-ai
```

Draft an ideas post for cameronloudon.github.io covering two days of work: the initial four-agent verification test on 2026-07-02, and the architectural reframe that came out of it on 2026-07-03.

Write in Cameron's voice — first person, direct, specific. No fluff. This is a real post about real work and real failures.

---

## Sections required

Write one `## Section Heading` for each of the following. Do not skip any. Do not add sections not on this list.

1. The Experiment
2. The Four Collaborators
3. What Passed
4. What Failed
5. The Diagnosis
6. The Fix
7. Why This Matters

---

## Facts you can draw on — do not fabricate beyond these

### What we were building

A four-agent AI collaboration system for Cameron's personal website (cameronloudon.github.io). Two roles:
- **Draft Agent** — drafts content, cannot touch the repo or GitHub
- **Publish Agent** — converts content to HTML, commits, pushes, opens PRs

The key structural innovation: a shared `Messages/` folder as the inter-agent communication channel. Every message between agents is a named `.md` file (`[from]-to-[to]-[date]-[topic].md`). No copy-pasting. No lost context. Every exchange is a persistent, auditable record — part of the Radical Collaboration Transparency (RCT) framework.

### The four collaborators

- **Cowork** — Claude (Anthropic) via Cowork desktop app. Draft Agent.
- **Claude Code** — Claude (Anthropic) via CLI. Publish Agent and technical reviewer.
- **AnythingLLM** — Gemma 4 12B (Google) via Ollama running locally. Draft Agent (alternative).
- **OpenCode** — big-pickle model running locally. Publish Agent (alternative). Also used as independent reviewer in a check-and-balance process.

### What the verification tested (2026-07-02)

- Could each agent read from and write to `Messages/` using the correct naming convention?
- Did each agent understand its role boundaries?
- Did each agent understand the full workflow including Phase 2 (AI-Prod sync after merge)?
- Could agents pass a handoff to each other without Cameron manually bridging the gap?

### What passed

All four agents demonstrated they could read from `Messages/` and write correctly formatted responses back. The naming convention held. The check-and-balance process between Cowork and Claude Code caught issues the other missed — both on system prompt design and architectural decisions. The Messages/ folder as an inter-agent bus worked exactly as designed.

### What failed

AnythingLLM was producing outputs that looked like it had read the instructions — but it hadn't. It was generating from training data. Root cause: the `@agents` file system tool was not connected in the AnythingLLM workspace. The model had no actual file access.

Open WebUI fixed the agent connectivity problem (tool calls were visible in the output: `glob_search`, `list_files`, `read_file`, `write_file`). But a new failure emerged: HTML generation. Across six or more attempts with multiple instruction variations, Gemma 4 consistently closed its grid wrapper div after the first child element, leaving three of the four collaborator cards outside the wrapper. Explicit counting instructions, step-by-step section lists, and re-read-the-template checks all failed to fix it.

### The diagnosis

Two separate root causes:

1. **AnythingLLM**: Not a model problem. The @agents tool simply wasn't connected. Once the workspace was correctly configured (or replaced with Open WebUI), the file access problem disappeared.

2. **Open WebUI / Gemma 4**: A model-level ceiling on HTML generation, specifically around maintaining div scope across multiple child elements. Instruction fixes cannot solve a model capability limit. Six attempts confirmed the pattern was consistent, not intermittent.

### The fix (2026-07-03)

Architectural, not instructional. The Draft Agent role was redefined: it produces structured Markdown only — a content file with a key:value header (`content_type`, `title`, `permalink_slug`, sections) and `##` section headings. No HTML. No frontmatter. No CSS.

The Publish Agent (Claude Code) converts that Markdown to correct HTML using `ai-content-creation-spec.md` §6 as the template library.

This is not a Gemma workaround. The content/HTML boundary is now the canonical split for every tool in every role. It reflects where the boundary actually belongs: content is the Draft Agent's job, structure and markup are the Publish Agent's job. These were always different concerns — the original design accidentally gave both to the Draft Agent.

The change was adopted across all canonical documentation: `AI_INSTRUCTIONS.md`, `CLAUDE.md`, `draft-agent-config.md`, `publish-handoff-template.md`, `ai-content-creation-spec.md`, and `single-ai-workflow.md`.

### Why this matters

The goal from the start was AI-agnostic collaboration — a system any capable AI could step into. The Messages/ folder makes every inter-agent exchange auditable. The role definitions make responsibilities unambiguous. And the content/HTML split means the Draft Agent role is genuinely portable: any model that can write in Cameron's voice and follow a field schema can do the job, regardless of how it handles HTML.

The failures on 2026-07-02 were not wasted time. They surfaced the instruction specificity problem (hardcoded template paths, section-specific checklists) and the HTML generation ceiling — both of which led directly to a cleaner architecture. The system is better for having broken.

---

## Collab note instructions

The collab note for this post should read:
- Drafted by: Gemma 4 12B (Google) via Ollama in Open WebUI
- Session: 2026-07-03 (use today's date)
- Cameron contributed: the system design, all four days of testing, the diagnosis, and the decision to reframe. The AI contributed: the structured prose draft from the brief above.

---

*Cowork · 2026-07-03*

## Links
<!-- generated from refs: - do not hand-edit -->
- [[ccode-to-cowork-2026-07-03-canonical-updates-done]]
