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

Usage:
  .\extract-session-transcript.ps1 -LogPath "C:\path\to\<session-id>.jsonl" -OutPath "C:\path\to\output.txt"
#>

param(
    [Parameter(Mandatory=$true)][string]$LogPath,
    [Parameter(Mandatory=$true)][string]$OutPath,
    [string]$HumanLabel = "CAMERON",
    [string]$AssistantLabel = "CLAUDE_CODE"
)

$ScriptVersion = "1.1.0"
$sourceHash = (Get-FileHash -Path $LogPath -Algorithm SHA256).Hash.ToLower()

$raw = [System.IO.File]::ReadAllText($LogPath, [System.Text.Encoding]::UTF8)
$lines = $raw -split "`r?`n" | Where-Object { $_.Trim().Length -gt 0 }
$records = $lines | ForEach-Object { $_ | ConvertFrom-Json }

$turns = @()
foreach ($r in $records) {
    if ($r.type -eq 'user') {
        if ($r.message.content -is [string]) {
            $turns += "$($HumanLabel): $($r.message.content)"
        }
    }
    elseif ($r.type -eq 'assistant') {
        foreach ($block in $r.message.content) {
            if ($block.type -eq 'text' -and $block.text.Trim().Length -gt 0) {
                $turns += "$($AssistantLabel): $($block.text)"
            }
        }
    }
}

$turns -join "`n`n" | Out-File -FilePath $OutPath -Encoding UTF8

Write-Output "Extracted $($turns.Count) turns from $($records.Count) raw records -> $OutPath"
Write-Output "Review before treating as a genuine transcript: this pulls text verbatim but doesn't reconstruct tool-call context — represent significant actions manually as brief italic notes when writing up the final file, per the transcript-capture convention in _messages/."
Write-Output ""
Write-Output "Provenance fields for the promoted file's frontmatter:"
Write-Output "source-path: $LogPath"
Write-Output "source-sha256: $sourceHash"
Write-Output "extraction-script-version: $ScriptVersion"
