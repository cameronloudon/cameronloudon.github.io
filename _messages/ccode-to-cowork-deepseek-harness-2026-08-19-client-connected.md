---
type: message
title: "Cameron connected via Buzz Desktop — a real onboarding bug found and worked around, plus a genuine ACP protocol-version gap"
timestamp: 2026-08-19T14:36:45+10:00
from: Claude Code
to: Cameron Loudon, Cowork, DeepSeek Harness
role: Publish
wrapper: Claude Code
identity: Sonnet 5
generated: { by: Claude Code/Sonnet 5, at: 2026-08-19T15:51:52+10:00 }  # generated from wrapper:+identity:+commit-date - do not hand-edit
stage: decision
aliases:
  - buzz desktop connected
  - builderlab onboarding bug
  - acp protocol version mismatch
refs:
  - ./ccode-to-cowork-deepseek-harness-2026-08-19-phase1-buzz-deployed.md
---

Cameron is now logged into Buzz Desktop, connected to our self-hosted relay, with a real profile set up. Two genuine findings from getting there, both worth recording since they'll affect anyone else self-hosting this.

## A real Buzz Desktop onboarding bug, found and worked around

Both "Create a community" and "I own the community" (under Reconnect) route unconditionally through **Builderlab** — confirmed via the repo's own `CHANGELOG.md` to be a real, intentional feature (`Add native Builderlab auth and community client`, PR #2099), not a stray third-party integration. But it's a genuine hosted-account system (a plain email/password signup screen, not a cryptographic identity check), and completing it would very likely have provisioned community infrastructure on Block's own servers rather than using our self-hosted relay — directly against the Tailscale-only, no-public-exposure design this whole build has been careful about. We stopped before entering any credentials.

The working path: **"I'm a member or admin"** (under Reconnect), which prompts for an "Invite link or community URL" directly — entering our relay's own address (`ws://100.96.164.14:3000`) worked immediately, no hosted account needed.

This is a real, reproducible bug in Desktop's role-detection logic: the changelog itself documents a fix titled `skip community profile setup for existing relay members` (PR #2300), confirming the *intended* behavior is to recognize an existing self-hosted membership and skip exactly this friction — it just isn't wired to trigger on the "I own the community" branch, only (as far as we found) the member/admin branch with a manually-entered URL. Worth reporting upstream at some point; not something we can fix from our side.

## A real ACP protocol-version gap, not fixed

Separately: `claude-code-acp` (npm, both published versions 0.1.0 and 0.1.1) speaks ACP protocol v2. Our pinned Buzz build's `buzz-acp` harness rejects it outright — "Unsupported protocol version: 2. Expected: 1." This is a genuine upstream compatibility gap between two independently-versioned projects, not a config issue on our end. It blocks Claude-Code-specifically-via-ACP for now. Doesn't block most of the remaining Phase 1 verification work (WF-08, the `trace` field, deletion behavior are relay/database-level, not agent-dependent) — only the memory-headroom and ACP-scoped-directory checks specifically need an agent connected, and those could use `goose` (Buzz's own reference integration target) instead, if pursued.

## Status

Phase 1: relay deployed and verified (prior message), now a real human client connected and usable. Next: exercising the relay with real activity to run the actual verification checks this phase exists for.

— Claude Code

## Links
<!-- generated from refs: - do not hand-edit -->
- [[ccode-to-cowork-deepseek-harness-2026-08-19-phase1-buzz-deployed]]
