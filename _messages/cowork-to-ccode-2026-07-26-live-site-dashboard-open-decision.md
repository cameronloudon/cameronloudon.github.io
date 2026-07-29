---
type: message
title: "Live Site Dashboard — Snapshot-at-Merge Shape Chosen, Needs an Open Decision Entry"
timestamp: 2026-07-26
from: Cowork
to: Claude Code
aliases:
  - live site dashboard
  - project telemetry on cameronloudon.github.io
  - snapshot vs client-side API shape
refs: []
---

For discussion next session — not built, nothing to action before then. Cameron's asked that this get its own `PROJECT_STATE.md` Open Decision so it's tracked rather than living only in this message.

## Origin

Cameron asked me to build a quick project-telemetry dashboard today (Open Decisions health, Messages custody-promotion coverage), which I did as a Cowork-sidebar artifact (`ai-prod-telemetry`) — real numbers pulled directly from `PROJECT_STATE.md` and `AI-Working/Messages/`, not sample data: 58 tracked decisions (6 genuinely open), 396 files authored in the Messages backlog vs. 60 promoted into the git-tracked `_messages/` bundle.

He then asked whether a GitHub MCP connector could keep that dashboard live and display it on the actual site (`cameronloudon.github.io`). Checked the connector registry directly — no GitHub connector is available to connect at all. Separately, even if one existed, it wouldn't bridge the gap: `create_artifact`'s live refresh only calls connector tools from inside Cowork's own sandboxed sidebar view; it has no path to publish onto the Jekyll site, which is a wholly separate pipeline (commit → merge → Pages build).

## Two shapes discussed, one chosen

**Shape A — client-side live fetch.** A page on the site calls GitHub's public REST API directly from JS at render time. Genuinely live (refreshes per visitor load), but a new architectural pattern for this project — everything on the site today is static, committed content; nothing currently calls out to a live API at render time.

**Shape B — snapshot regenerated at merge time.** Same discipline already used for `PROJECT_STATE.md` and the session logs: the Publish Agent regenerates the dashboard's data and commits it as part of the normal session-close flow. Not moment-to-moment live, only as fresh as the last merge — but zero new architecture, fits the project's existing git-native, no-backend, no-live-API stance exactly.

**Cameron chose Shape B** — fits the project's existing philosophy better than introducing a live client-side API call would.

## What's actually open, for when we talk next

- Where this page/section lives (new root page? folded into an existing one — `now.html`? a new `_now/` entry?) and what it should visually look like on the live site vs. the Cowork-sidebar version I built today.
- What gets tracked long-term — today's two metrics (Open Decisions health, Messages custody coverage) were picked as a fast first pass, not a considered final choice. Worth revisiting whether these are the right two, or whether something else (branch/session cadence, page inventory growth) is more useful to surface publicly.
- Mechanically: does the regeneration script live in `_ai-context/` alongside `generate-links-footer.ps1` and `cascade-check.ps1`, run as its own step in the session-close checklist? Data source would be `PROJECT_STATE.md` itself plus a `Messages/` file count — both already computable from things the Publish Agent reads at session close anyway, so this may be closer to "one more generated artifact in the existing pipeline" than new infrastructure.
- Whether this belongs on the public site at all vs. staying an internal-only Cowork artifact — Cameron leaned toward wanting it public, but that's worth confirming explicitly before scoping it as a build.

No proposal drafted yet, nothing blocking. Please add this as a new numbered Open Decision in `PROJECT_STATE.md` at your next session close, referencing this message.

---

*Cowork (Draft Agent) · 2026-07-26*
