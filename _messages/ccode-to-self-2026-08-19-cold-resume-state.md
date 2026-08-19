---
type: message
title: "Cold-resume state — everything a future Claude Code session needs to pick this back up, written before the server goes offline for a second move"
timestamp: 2026-08-19T15:32:23+10:00
from: Claude Code
to: Claude Code
role: Publish
wrapper: Claude Code
identity: Sonnet 5
generated: { by: Claude Code/Sonnet 5, at: 2026-08-19T15:51:52+10:00 }  # generated from wrapper:+identity:+commit-date - do not hand-edit
stage: decision
aliases:
  - cold resume state
  - buzz pilot operational reference
  - session self-briefing
---

Written for myself, cold. If a future session picks this up with no memory of today, read this first — it's the operational state, not the design reasoning (that's in the execution-findings doc, linked above). No secrets are reproduced here (key/password values); this says where they live and how to reach them, not what they are.

**As of this writing: the dv6 is being shut down for a second physical move.** Last verified fully healthy immediately before shutdown. Don't assume it's reachable until re-verified.

---

## 1. Topology

- **Windows PC** (where Claude Code runs): Tailscale hostname `bonoxide`, IP `100.83.106.45`.
- **The dv6** (HP Pavilion, repurposed): Tailscale hostname `hpserver`, IP `100.96.164.14`, Ubuntu 24.04, user `cameron`.
- Both on the same tailnet. No public exposure anywhere — Tailscale-only by design.

## 2. Access

- SSH key: `~/.ssh/hpserver_dv6` (ed25519, no passphrase — deliberate tradeoff for non-interactive use, disclosed to Cameron). Connect as: `ssh -i ~/.ssh/hpserver_dv6 cameron@100.96.164.14`.
- Sudo is passwordless (`/etc/sudoers.d/cameron-nopasswd`, `NOPASSWD:ALL`) — Cameron's own choice, set up mid-session after the original password-gated approach caused too much manual back-and-forth.
- **Raw `psql SELECT` queries against the live database get blocked by the permission classifier and need Cameron's approval each time** (his choice — he declined a standing grant). Budget for this when planning DB-inspection work.

## 3. What's deployed

- Buzz repo sparse-cloned to `/opt/buzz` — **note:** the sparse-checkout pattern used didn't actually restrict cleanly; the repo root files are there too, not just `deploy/compose/`. The real compose directory is `/opt/buzz/deploy/compose/`, not `/opt/buzz/` itself — a bug I hit once already (the backup script's stack-detection path), don't repeat it.
- Image pinned: `ghcr.io/block/buzz:sha-93114c9` (immutable commit tag, not `:main`).
- `.env` lives at `/opt/buzz/deploy/compose/.env`, `600` permissions. Contains: relay identity private key, owner pubkey, Postgres/Redis/MinIO credentials, Tailscale-IP-based URLs (no Caddy/TLS, no public domain).
- **`buzz-admin` must be run via `docker compose exec relay buzz-admin ...`** (from `/opt/buzz/deploy/compose/`), inheriting the live container's real environment — NOT as a fresh `docker run` with manually-reconstructed env vars. The latter produces a misleading "not mapped to a community" error that has nothing to do with a missing community.
- Backup: external USB SSD mounted at `/mnt/backup-ssd` (persistent `fstab` entry, survives reboot — confirmed). Restic repository at `/mnt/backup-ssd/restic-repo`. Password stored at `/root/.restic-password` (`600`, root-only) AND written down physically by Cameron — the only two copies, deliberately not both on the dv6. Backup script: `/usr/local/sbin/backup-hpserver.sh` (`700`, root-only) — stops the stack, backs up `/var/lib/docker/volumes` + `/opt/buzz`, restarts, applies retention (7 daily/4 weekly/6 monthly). Cron: nightly 3am, logs to `/var/log/backup-hpserver.log`. **Off-box replication (a copy on the Windows PC, not just the attached SSD) is explicitly deferred, Cameron's choice — the current backup protects against the internal drive failing, not against losing the whole machine.**

## 4. Identities in play

- **Owner** (Cameron's personal login): pubkey `9b992fd202680ce0059196e5a2fe51d9068047fa9d131f3d8020bafcd21a06b4`. He holds the secret key, written down physically.
- **Relay identity**: separate keypair, private key lives in `.env` as `BUZZ_RELAY_PRIVATE_KEY`.
- **Claude Code's agent identity** (registered as a relay member, for eventual ACP use — currently blocked, see below): pubkey `e255363cf2853c9a5d188d23015278be805c86c86725e4084e0fbe93d667e532`. Private key lives in this session's own history, not written down anywhere durable yet — if this matters later, regenerate rather than assume it's recoverable.
- Bech32 (`nsec1`/`npub1`) conversion: no library was available; a hand-written, round-trip-verified bech32 encoder was used (`hex-to-bech32.js`, in the scratchpad — not committed anywhere durable, would need rewriting if needed again, though it's a ~40-line self-contained script, cheap to redo).

## 5. Real bugs found today, with their working workarounds

- **Buzz Desktop's "Create a community" / "I own the community" both route through Builderlab** (a genuine third-party hosted-account signup, confirmed intentional via `CHANGELOG.md`) — don't complete it, it very likely provisions infrastructure on Block's servers, not ours. **Working path: "I'm a member or admin," enter the relay URL directly** (`ws://100.96.164.14:3000`).
- **`claude-code-acp` (npm) speaks ACP protocol v2; this Buzz build's `buzz-acp` harness only speaks v1.** Confirmed on both published npm versions (0.1.0, 0.1.1). Blocks Claude Code specifically via ACP — not a config issue, a real upstream version-skew. `goose` (Buzz's own reference target) untested as an alternative.
- **Buzz Desktop's "Invite to community" link generation fails silently, client-side** — "Couldn't create invite link," and the relay's own logs show no corresponding request ever arrived. **Working path for adding colleagues: they generate their own identity locally (Desktop's offline onboarding step), send you their pubkey out of band, you run `buzz-admin add-member --pubkey <key>` via `docker compose exec relay`, then they connect via the member/admin path above.**
- **Mobile app pairing (QR/pairing code) fails with a 404** — depends on `buzz-pair-relay`, a separate sidecar not included in the production compose bundle at all, for a mobile client Buzz's own `VISION.md` marks "🚧 in active development." **Shelved by Cameron's choice, not pursued further.**

## 6. Empirically verified against the live instance (not just documentation)

- **Message edit**: new `kind:40003` event, original `kind:9` untouched. Confirmed.
- **Message deletion**: tombstone (`kind:5` deletion-request event), original row stays in the database unmodified. Confirmed — good news for the forensic-reconstruction standard.
- **WF-08**: confirmed exactly as documented — `status: failed`, `error_code: approval_not_supported`. **Sharper finding: `execution_trace` is a literal empty array `[]`** even in this failure case — nothing recorded about the step that was reached. Empirically proves the "post gate reasoning as a real message" recommendation already in the design, doesn't just motivate it.
- **Not yet tested**: canvas deletion/versioning (no canvas activity created). Memory headroom under `buzz-acp` load and ACP's scoped-working-directory behavior — both blocked on the protocol mismatch above.

## 7. Where the full record lives

- Design decisions: `AI-Working/Projects/Marketing-OS/marketing-os-icm-buzz-system-design-and-rollout-plan-v3.md`.
- Consolidated execution findings (written before this doc): `AI-Working/Projects/Marketing-OS/marketing-os-icm-buzz-phase0-phase1-execution-findings.md`.
- Full blow-by-blow, every step: `AI-Working/Messages/`, all files dated `2026-08-19` with `phase0`/`phase1`/`buzz`/`backup` in the name — roughly chronological by filename.

## 8. First thing to do on resume

Don't trust that anything is still in the state described above — re-verify, same discipline as every step today:
```bash
ssh -i ~/.ssh/hpserver_dv6 cameron@100.96.164.14 "uptime && systemctl is-active docker && cd /opt/buzz/deploy/compose && docker compose ps"
curl -fsS http://100.96.164.14:3000/_liveness
```
If both come back clean, everything in this document should still hold. If not, start diagnosing from there rather than assuming.

— Claude Code
