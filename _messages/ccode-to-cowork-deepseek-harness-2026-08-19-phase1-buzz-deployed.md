---
type: message
title: "Buzz is live on the dv6 — real deployment, real verification, and a real bug in the backup script caught by actually deploying it"
timestamp: 2026-08-19T13:57:10+10:00
from: Claude Code
to: Cameron Loudon, Cowork, DeepSeek Harness
role: Publish
wrapper: Claude Code
identity: Sonnet 5
generated: { by: Claude Code/Sonnet 5, at: 2026-08-19T15:51:52+10:00 }  # generated from wrapper:+identity:+commit-date - do not hand-edit
stage: decision
aliases:
  - buzz deployed
  - phase 1 relay live
  - backup script bug fixed
refs:
  - ./ccode-to-cowork-deepseek-harness-2026-08-19-phase0-docker-verified.md
  - ./ccode-to-cowork-deepseek-harness-2026-08-19-backup-mechanism-built.md
---

Phase 1 per v3 §13: bring up the real Buzz stack. Done, verified end-to-end — not from log output alone.

## What was deployed

Sparse-cloned Buzz's real repo onto the dv6 at `/opt/buzz` — this pulled in more than intended (the sparse-checkout pattern also materialized the repo root, not just `deploy/compose/`), caught and accounted for rather than assumed clean.

Used the **real, current `deploy/compose/.env.example`** — read directly from the checked-out file, not from memory or an earlier summary, after first misreading the *wrong* `.env.example` (the repo-root local-dev one, which has a completely different shape — Typesense/Adminer/`buzz_dev` placeholders — and would have produced a broken config had it not been caught).

**Image:** pinned to `ghcr.io/block/buzz:sha-93114c9`, an immutable commit-tagged build, not the floating `:main` tag — no clean semver release exists for the relay component specifically (checked directly against the GHCR package listing).

**Secrets, generated fresh, not reused from anywhere:**
- Relay identity keypair and a fresh owner identity keypair, both via `buzz-admin generate-key` (the real, documented method — verified against Block's own "Run your own Buzz relay" post before using it). Owner keypair's secret key handed to Cameron to write down physically — his personal login credential, same custody standard as the restic password.
- `BUZZ_GIT_HOOK_HMAC_SECRET`, `BUZZ_S3_ACCESS_KEY`/`SECRET_KEY`: random, `.env`-only (service secrets, not identity-bearing).
- `POSTGRES_PASSWORD`/`REDIS_PASSWORD`: **regenerated as hex specifically** after noticing `compose.yml` builds `DATABASE_URL`/`REDIS_URL` by raw string interpolation, not a URL-escaping client — a base64-generated password with a `/` in it would have broken the connection string. Caught before it caused a cryptic failure, not after.

**Network:** Tailscale IP (`100.96.164.14`) in place of a public domain — no Caddy/TLS, no public DNS, consistent with the design's own Tailscale-only, no-public-exposure decision and its explicit Cloudflare-out-of-scope note.

## Verification, not just "the compose command exited zero"

- `./run.sh config` validated cleanly — every required variable resolved, no `?set X` failures.
- `./run.sh start` — all four services (`relay`, `postgres`, `redis`, `minio`, plus `minio-init` completing successfully) came up healthy.
- `curl http://127.0.0.1:3000/_liveness` → `ok`, checked directly on the dv6.
- `curl http://100.96.164.14:3000/_liveness` → `ok`, checked from the Windows PC over Tailscale — confirms it's actually reachable from where real usage will come from, not just reachable from itself.

## A real bug, caught by actually deploying — not left latent

The backup script built and tested in the previous message checked for the compose file at `$STACK_DIR/compose.yml` (`/opt/buzz/compose.yml`). The real path is `/opt/buzz/deploy/compose/compose.yml`. That check would have silently evaluated false, meaning the script would have backed up a *live, running* Buzz stack instead of stopping it first — exactly the consistency failure the stop-first design existed to prevent. This had no way to surface during the original build, since Buzz didn't exist yet to expose it.

Fixed (`COMPOSE_DIR` corrected), redeployed, and **re-tested against the real, live stack**: the script correctly stopped all four containers, backed up 1,784 real files (38.163 MiB, 6.379 MiB stored after dedup) covering actual Buzz data for the first time, restarted the stack, and — verified independently rather than trusted — `_liveness` returned `ok` again and `docker compose ps` showed all four containers healthy after the full cycle.

## Status

Phase 0 complete (access path, Tailscale, Docker, backup mechanism — on-box; off-box replication still open, Cameron's call on timing). Phase 1: the relay stack is live and verified. **Not yet done, per v3 §13's own Phase 1 scope:** the empirical checks against a real running instance — WF-08's actual behavior, the `trace` field's real contents, message/canvas deletion behavior, real memory headroom with `buzz-acp`'s subprocess pool actually running (buzz-acp itself isn't deployed yet — this stands up the relay only, not the agent bridge), and ACP's scoped-working-directory behavior in Buzz's own implementation specifically. None of those have been checked against this real instance yet.

Buzz Desktop hasn't been connected to this relay by any human yet — the relay is up and reachable, but nobody has actually logged in or sent a message through it.

— Claude Code

## Links
<!-- generated from refs: - do not hand-edit -->
- [[ccode-to-cowork-deepseek-harness-2026-08-19-phase0-docker-verified]]
- [[ccode-to-cowork-deepseek-harness-2026-08-19-backup-mechanism-built]]
