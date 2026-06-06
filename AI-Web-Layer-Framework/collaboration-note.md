# Collaboration Note — AI-Readable Web Layer Framework

**Project:** AI-Readable Web Layer — De-identified Framework  
**Model:** claude-sonnet-4-6  
**Platform:** Claude Cowork (Desktop)  
**Session date:** 7 June 2026  
**Reviewed and approved by:** Cameron Loudon

---

## Context and Prior Work

This session is a direct continuation of work begun earlier the same day (Session 1, claude.ai) in which a two-layer AI-readable web architecture was designed and prototyped for the University of New England (UNE). That session produced:

- A content layer (9 markdown files mirroring the public website structure)
- A skills/intelligence layer (7 files: positioning, personas, competitors, objections, USPs, tone, FAQ)
- A professional proposal document (v2) and prototype zip
- A chat transcript documenting the session

Those files are preserved unchanged in `Projects/AI-Readable-Web-Layer/`.

---

## What This Session Produced

This session stepped back from the UNE-specific implementation to develop a **three-tier framework** that separates the methodology from the reference implementation.

### The Three-Tier Structure

**Tier 1 — Marketing OS**  
University-agnostic internal strategic framework. No changes. Remains the source of truth for positioning, personas, and value proposition. Lives in `Projects/Marketing-OS/`.

**Tier 2 — AI-Readable Web Layer Framework** (this folder)  
De-identified architecture and methodology. Templates with `[YOUR UNIVERSITY NAME]` and `[TO BE DEFINED]` placeholders. Any university can pick this up and implement it. Includes the GitHub architecture and maintenance model.

**Tier 3 — UNE Reference Implementation**  
The existing v2 prototype serves as the worked example. Preserved unchanged in `Projects/AI-Readable-Web-Layer/`.

---

## Key Ideas Developed in This Session

**Why websites block AI crawlers** — commercial protection, analytics inflation, DoS risk, narrative control, legal/privacy exposure, and bandwidth. The framework reframes the AI layer as a governance and security argument, not just a marketing one.

**Subdomain hosting** — rather than a path on the main website, the framework recommends a dedicated static subdomain (e.g. `ai.uni.edu.au`). Benefits: fully decoupled from main site infrastructure, clean analytics separation, minimal attack surface, credentialed official signal to AI systems.

**The two-layer architecture** — content layer (what the institution is) and skills layer (how AI should talk about and position the institution). The main site's `llms.txt` points AI systems to the subdomain.

**Maintenance model** — hybrid approach: content layer maintained by automated script or CMS export; skills layer maintained deliberately by an agent drawing instruction from the Marketing OS. Skills layer changes require human sign-off.

**The Marketing OS connection** — the Marketing OS Foundation Layer is the direct upstream source for the skills files. An agent sitting between them propagates strategic updates downstream. The Marketing OS is the brain; the AI web layer is the voice.

**GitHub architecture** — a public repository hosting the de-identified framework, the reference implementation, and a GitHub Pages site presenting the methodology and case study.

---

## Connective Logic Across All Three Tiers

Marketing OS generates the strategy → Framework shows how to surface it externally → UNE demonstrates it working in practice.

The same intellectual work faces two directions: inward to internal teams (Marketing OS), outward to AI systems (AI web layer). Terminology differs; substance is the same.

---

## Attribution

The three-tier structure, the subdomain hosting architecture, the hybrid maintenance model, and the Marketing OS → skills layer pipeline were developed collaboratively in this session. The original two-layer content/skills architecture and the UNE reference implementation were produced in Session 1 (claude.ai, 7 June 2026).

Cameron identified the connection between the Marketing OS and the AI web layer. The articulation of the Marketing OS as "brain" and AI web layer as "voice" emerged from that observation in dialogue.

---

## Suggested Tags

`#session-claude` `#marketing` `#strategy` `#framework` `#ai-infrastructure` `#in-progress`

---

*This collaboration note was written by claude-sonnet-4-6 at Cameron Loudon's request, citing itself as a genuine collaborator in the spirit of the Radical Collaboration Transparency framework.*
