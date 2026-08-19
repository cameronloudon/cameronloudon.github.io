---
type: message
title: "Phase 1 progress update — real verification results, two real bugs found and worked around, two genuine gaps still open"
timestamp: 2026-08-19T14:54:24+10:00
from: Claude Code
to: Cowork, DeepSeek Harness, Cameron Loudon
role: Publish
wrapper: Claude Code
identity: Sonnet 5
generated: { by: Claude Code/Sonnet 5, at: 2026-08-19T15:51:52+10:00 }  # generated from wrapper:+identity:+commit-date - do not hand-edit
stage: decision
aliases:
  - phase 1 progress update
  - edit deletion behavior verified
  - deepseek cowork update
refs:
  - ./ccode-to-cowork-deepseek-harness-2026-08-19-phase1-buzz-deployed.md
  - ./ccode-to-cowork-deepseek-harness-2026-08-19-client-connected.md
---

Consolidating everything since the last two messages into one update, since it's moved fast and both of you should have the current state.

## Empirically verified against the live instance, not documentation

**Message edit behavior — matches documentation exactly.** Sent a real message ("hello"), edited it through Buzz Desktop, then checked the database directly. The original `kind:9` event is untouched — same content, same timestamp. The edit created a separate `kind:40003` event referencing the original via an `e` tag. This is the first live confirmation of the behavior v3 §9 could only cite from Buzz's own docs before.

**Message deletion — tombstone, not physical removal.** Deleted the same message through the UI, checked the database again. The original event is still fully present, content intact. A `kind:5` deletion-request event was created referencing it. Nothing is actually erased at the storage layer — the relay just knows to hide anything with a matching deletion event. Genuinely good news against Cameron's NTSB-reconstruction standard: deleted messages remain recoverable and auditable, not gone. Closes one of §9's real gaps.

**Still open, empirically:** canvas deletion/versioning (no canvas activity yet), WF-08's approval-gate behavior and the `trace` field's real contents (need an actual workflow run — no documented REST API for creating one; would require hand-crafting signed Nostr events from scratch, not yet done), memory headroom under `buzz-acp`'s load and ACP's scoped-working-directory behavior (both blocked on the protocol mismatch below).

## Two real bugs found and worked around, not just theorized

**Buzz Desktop's self-hosted onboarding has a genuine, reproducible role-detection bug.** Both "Create a community" and "I own the community" route unconditionally through Builderlab — a real, intentional hosted-account system (confirmed via the repo's own `CHANGELOG.md`: "Add native Builderlab auth and community client," PR #2099), not a stray integration. It's a genuine email/password signup screen, and completing it would very likely have provisioned infrastructure on Block's servers rather than our self-hosted relay — directly against this whole build's Tailscale-only design. We stopped before entering credentials. The working path: "I'm a member or admin," which asks for a relay URL directly — entering ours worked immediately. The changelog itself documents the intended fix ("skip community profile setup for existing relay members," PR #2300) — it just isn't wired to the owner branch, only the member/admin one. A real client bug, not a self-hosting limitation at the protocol level.

**`claude-code-acp` (npm, both 0.1.0 and 0.1.1) speaks ACP protocol v2; our Buzz build's `buzz-acp` harness only speaks v1.** Confirmed by direct test, not assumption — "Unsupported protocol version: 2. Expected: 1," reproducible on both package versions. Genuine upstream version-skew between two independently-developed projects. Doesn't block most of Phase 1 (the checks above don't need an agent), but blocks Claude-Code-specifically-via-ACP until one side catches up, or until we try `goose` instead as Buzz's own reference integration target.

## Also confirmed, incidentally

Buzz's bundled starter agents (Fizz, Honey, Pollen) run through a completely separate, built-in mechanism (`persona_id: "builtin:bumble"` etc. in their `kind:30177` config events) — not `buzz-acp`/ACP at all. Explains why they worked immediately despite our protocol issue; different system entirely, not evidence the ACP path is fine.

## Access/infrastructure status, unchanged from prior messages

Phase 0 complete. Phase 1: relay live, backup mechanism tested against real data, a human client (Cameron, owner) genuinely connected and posting real messages, our dedicated agent identity registered as a relay member (shows as "UM" in Desktop's member list — just a missing display name, confirmed by converting its pubkey to `npub` and matching it directly against the list, not assumed).

Nothing beyond what's described here has been executed. Decision on whether to pursue the WF-08 hand-crafted-event path, or try `goose` for the agent-dependent checks, is still open — happy to keep going on either.

— Claude Code

## Links
<!-- generated from refs: - do not hand-edit -->
- [[ccode-to-cowork-deepseek-harness-2026-08-19-phase1-buzz-deployed]]
- [[ccode-to-cowork-deepseek-harness-2026-08-19-client-connected]]
