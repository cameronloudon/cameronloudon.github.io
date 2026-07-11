<#
Extracts a readable Cameron/Claude-Code transcript from a raw Claude Code
session log (.claude/projects/<project-hash>/<session-id>.jsonl).

Keeps: type=='user' records with plain string content, and type=='assistant'
records' 'text' content blocks. Drops: thinking, tool_use, tool_result, and
system/bookkeeping records as noise.

Must read the file as UTF-8 explicitly — PowerShell's Get-Content default
encoding mangles em-dashes and other non-ASCII characters.

Proven working 2026-07-09 against a closed, two-day-old session (28 turns
recovered cleanly from 203 raw log lines) — see
_messages/cameron-claudecode-conversation-transcript-2026-07-08.md for the
output this script produced. Untested against sessions containing sidechain
turns, multiple assistant text blocks per turn beyond simple cases, or very
large files.

Provenance stamping (v1.1, 2026-07-11, Observation 2 Option A): computes and
prints source-path/source-sha256/extraction-script-version for the operator
to paste into the promoted file's frontmatter — this script does not write
frontmatter itself, only the plain turn-by-turn body. If LogPath points at a
session that is still open (still being appended to), the hash describes
only a snapshot at extraction time, not a stable file — check the log isn't
still growing before treating the hash as durable, same caution that applies
on any platform, not just this one.

Action digest (v1.2, 2026-07-11, Observation 2 Option B — opt-in via
-IncludeActions, default output unchanged): interleaves one compact
[TOOL_CALL: name] / [TOOL_RESULT: name] line per tool_use/tool_result pair
alongside the conversation turns. Truncation is per-field, not per-blob
(each top-level input field previewed to ~70 chars, every field kept) -
flat whole-input truncation was rejected during design review because it
would exhaust its budget on a multi-field tool's first field (e.g. Edit's
old_string) and never show the rest (new_string), making that record
useless for checking a claim against what was actually done. Piloted
successfully against a real closed session (Open Decision #45) - both real
Edit calls in that session showed both fields correctly, a rejected tool
use correctly surfaced as status=error.

Adopted policy (2026-07-11, decided by Cameron on Cowork's proposal,
decoupling capture from adoption): run WITH -IncludeActions at every future
mechanical extraction, as a matter of course - not optional, not judged
case by case. Save the digest output to a local, git-untracked evidence
store (current convention: AI-Evidence\action-digests\<platform>\), never
committed to the repo or _messages/ without a separate, deliberate
promotion decision later. Rationale, not just habit: action digests can
only be generated from a session's raw JSONL, which is on the same
retention clock that made the original rescue (Open Decision #39) urgent -
if a mechanical transcript is extracted without also generating its
digest, and the raw log later ages out under cleanupPeriodDays, that
session's action-evidence is gone permanently regardless of whether the
mechanism is later turned on for future sessions. Generating it now is
cheap and forecloses nothing; not generating it is the one choice that
can't be undone later. The digest remaining unreviewed/unpromoted is a
separate, later decision - there is no consumer for it yet (the Auditor
hasn't run once), and building review/promotion machinery ahead of that
would repeat the supply-before-demand mistake this project has
deliberately avoided elsewhere (type taxonomy before the pilot, OpenWork
before the test protocol).

Usage:
  .\extract-session-transcript.ps1 -LogPath "C:\path\to\<session-id>.jsonl" -OutPath "C:\path\to\output.txt"
  .\extract-session-transcript.ps1 -LogPath "..." -OutPath "..." -IncludeActions
#>

param(
    [Parameter(Mandatory=$true)][string]$LogPath,
    [Parameter(Mandatory=$true)][string]$OutPath,
    [string]$HumanLabel = "CAMERON",
    [string]$AssistantLabel = "CLAUDE_CODE",
    [switch]$IncludeActions
)

$ScriptVersion = "1.2.0"
$sourceHash = (Get-FileHash -Path $LogPath -Algorithm SHA256).Hash.ToLower()

$raw = [System.IO.File]::ReadAllText($LogPath, [System.Text.Encoding]::UTF8)
$lines = $raw -split "`r?`n" | Where-Object { $_.Trim().Length -gt 0 }
$records = $lines | ForEach-Object { $_ | ConvertFrom-Json }

function Format-FieldPreview {
    param($Value, [int]$MaxLen = 70)
    if ($null -eq $Value) { return "" }
    if ($Value -is [string]) { $s = $Value } else { $s = ($Value | ConvertTo-Json -Compress -Depth 5) }
    $s = $s -replace "`r?`n", ' '
    if ($s.Length -gt $MaxLen) { return $s.Substring(0, $MaxLen) + "..." }
    return $s
}

$toolNames = @{}
$turns = @()
foreach ($r in $records) {
    if ($r.type -eq 'user') {
        if ($r.message.content -is [string]) {
            $turns += "$($HumanLabel): $($r.message.content)"
        }
        elseif ($IncludeActions -and $r.message.content) {
            foreach ($block in $r.message.content) {
                if ($block.type -eq 'tool_result') {
                    $name = $toolNames[$block.tool_use_id]
                    if (-not $name) { $name = "unknown" }
                    $status = if ($block.is_error) { "error" } else { "ok" }
                    $preview = Format-FieldPreview -Value $block.content -MaxLen 120
                    $turns += "[TOOL_RESULT: $name] status=$status $preview"
                }
            }
        }
    }
    elseif ($r.type -eq 'assistant') {
        foreach ($block in $r.message.content) {
            if ($block.type -eq 'text' -and $block.text.Trim().Length -gt 0) {
                $turns += "$($AssistantLabel): $($block.text)"
            }
            elseif ($IncludeActions -and $block.type -eq 'tool_use') {
                $toolNames[$block.id] = $block.name
                $fieldParts = @()
                if ($block.input) {
                    foreach ($prop in $block.input.PSObject.Properties) {
                        $preview = Format-FieldPreview -Value $prop.Value -MaxLen 70
                        $fieldParts += "$($prop.Name)=`"$preview`""
                    }
                }
                $turns += "[TOOL_CALL: $($block.name)] " + ($fieldParts -join ' ')
            }
        }
    }
}

$turns -join "`n`n" | Out-File -FilePath $OutPath -Encoding UTF8

Write-Output "Extracted $($turns.Count) turns from $($records.Count) raw records -> $OutPath"
if ($IncludeActions) {
    Write-Output "Action digest included (pilot, v1.2): TOOL_CALL/TOOL_RESULT lines interleaved, per-field truncation. Not for the public repo without a separate promotion decision."
} else {
    Write-Output "Review before treating as a genuine transcript: this pulls text verbatim but doesn't reconstruct tool-call context — represent significant actions manually as brief italic notes when writing up the final file, per the transcript-capture convention in _messages/."
}
Write-Output ""
Write-Output "Provenance fields for the promoted file's frontmatter:"
Write-Output "source-path: $LogPath"
Write-Output "source-sha256: $sourceHash"
Write-Output "extraction-script-version: $ScriptVersion"
