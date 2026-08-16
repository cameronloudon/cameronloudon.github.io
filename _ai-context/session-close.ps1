<#
.SYNOPSIS
    Session-close runner - composes the existing check/generate scripts into
    the enforced order the checklist already requires, so that order can't
    be gotten wrong by hand (the #62 ordering bug's whole failure class).

.DESCRIPTION
    Two phases, not one script, because a real session close has a
    hand-written step in the middle of the sequence (the session log
    itself) that no script can do. Running the wrong phase, or running
    Post before the session log actually exists, is refused rather than
    silently producing a wrong count - the exact #62 failure, made
    structurally impossible here instead of relying on a human remembering
    the right order.

    -Phase Pre    : run before writing the session log. Verifies branch/
                    structural state (report-only) and messages-index
                    completeness (mandatory - stops on findings). Prints
                    reminders for the PROJECT_STATE.md/cascade-check steps
                    that still require human judgment.

    -Phase Post   : run after the session log has been written and saved.
                    Requires -SessionLogFile naming the exact file just
                    written; refuses to proceed if that file does not
                    exist on disk, which is the mechanical guard against
                    running stats regeneration before the log exists.
                    Regenerates the session-log table and runs the
                    close-out trim, then generate-stats-data.ps1, then
                    prints reminders for the remaining human steps
                    (validation checklist, sync check, self-check pass,
                    commit+push, the "finalised" message).

    This script does not touch Git and does not send Cameron any message
    itself - the two-message handshake (draft-ready / finalised) stays a
    human action, per its own design (it is the forcing function; nothing
    here replaces it).

.NOTES
    Findings from function-b-state-check.ps1 are printed but do not stop
    this runner - that script has always been report-only/advisory, and
    changing that here would be a scope expansion beyond what this runner
    was built to do. Findings from check-messages-index-completeness.ps1
    DO stop the runner, matching its own existing "resolve before
    proceeding" mandatory status.

Usage:
  .\session-close.ps1 -Phase Pre
  .\session-close.ps1 -Phase Post -SessionLogFile "session-2026-07-15-039.md"
  .\session-close.ps1 -Phase Post -SessionLogFile "session-2026-07-15-039.md" -CloseoutThreshold 5
#>

param(
    [Parameter(Mandatory=$true)][ValidateSet("Pre","Post")][string]$Phase,
    [string]$SessionLogFile,
    [int]$CloseoutThreshold = 5,
    [string]$RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
)

$ScriptDir = $PSScriptRoot
$ProjectStatePath = Join-Path $RepoRoot "PROJECT_STATE.md"
$ArchivePath = Join-Path $ScriptDir "session-closeout-archive.md"
$SessionLogsPath = Join-Path $RepoRoot "_session-logs"

function Run-Step {
    param([string]$Name, [scriptblock]$Block, [bool]$Mandatory)
    Write-Output "--- $Name ---"
    & $Block
    $code = $LASTEXITCODE
    if ($code -ne 0) {
        if ($Mandatory) {
            Write-Output "FAILED (exit $code) - mandatory, stopping."
            exit 1
        } else {
            Write-Output "Findings present (exit $code) - advisory, not blocking. Review before proceeding."
        }
    } else {
        Write-Output "OK"
    }
    Write-Output ""
}

if ($Phase -eq "Pre") {
    Write-Output "=== Session-close Phase: Pre (before session log is written) ==="
    Write-Output ""

    Run-Step -Name "function-b-state-check.ps1 (branch/structural drift, report-only)" -Mandatory $false -Block {
        & (Join-Path $ScriptDir "function-b-state-check.ps1") -RepoRoot $RepoRoot
    }

    Run-Step -Name "check-messages-index-completeness.ps1 (mandatory)" -Mandatory $true -Block {
        & (Join-Path $ScriptDir "check-messages-index-completeness.ps1") -RepoRoot $RepoRoot
    }

    Write-Output "=== Remaining before Phase Post ==="
    Write-Output "1. Update PROJECT_STATE.md: Last updated, Updated by, increment NEXT_SESSION_LOG_ID."
    Write-Output "2. Update Open Decisions/page inventory as needed. For each Open Decision touched, run:"
    Write-Output "     .\cascade-check.ps1 -DecisionNumber N"
    Write-Output "3. Write the session log to _session-logs\, using the ID read BEFORE incrementing."
    Write-Output "4. Then run: .\session-close.ps1 -Phase Post -SessionLogFile <the log you just wrote>"
    exit 0
}

if ($Phase -eq "Post") {
    if (-not $SessionLogFile) {
        Write-Error "-SessionLogFile is required for -Phase Post - name the exact session-log file you just wrote, so this script can verify it exists before running anything that counts it."
        exit 1
    }

    Write-Output "=== Session-close Phase: Post (after session log is written) ==="
    Write-Output ""

    $logPath = Join-Path $SessionLogsPath $SessionLogFile
    if (-not (Test-Path $logPath)) {
        Write-Error "Session log not found: $logPath`nRefusing to proceed. This check exists specifically to prevent the #62 ordering bug (generate-stats-data.ps1 undercounting sessions_logged when run before the log exists on disk). Write and save the session log first, then re-run this phase."
        exit 1
    }
    Write-Output "Confirmed session log exists: $SessionLogFile"
    Write-Output ""

    Run-Step -Name "generate-session-log-table.ps1" -Mandatory $true -Block {
        & (Join-Path $ScriptDir "generate-session-log-table.ps1") -ProjectStatePath $ProjectStatePath -SessionLogsPath $SessionLogsPath
    }

    Run-Step -Name "generate-closeout-trim.ps1 (threshold $CloseoutThreshold)" -Mandatory $true -Block {
        & (Join-Path $ScriptDir "generate-closeout-trim.ps1") -ProjectStatePath $ProjectStatePath -ArchivePath $ArchivePath -Threshold $CloseoutThreshold
    }

    Run-Step -Name "generate-stats-data.ps1" -Mandatory $true -Block {
        & (Join-Path $ScriptDir "generate-stats-data.ps1") -RepoRoot $RepoRoot
    }

    Write-Output "=== Remaining before the session can be called finalised ==="
    Write-Output "1. If content was published this session, confirm rct-validation-checklist.md was run."
    Write-Output "2. Sync check: if CLAUDE.md/AI_INSTRUCTIONS.md conventions changed, flag it to Cameron."
    Write-Output "3. Self-check pass on this session's own claims (Open Decision #63) - not scriptable, this is a judgment step."
    Write-Output "4. Commit PROJECT_STATE.md, the session log, session-closeout-archive.md (if touched), and _data/stats.json/_ai-context/stats-history.json. Push."
    Write-Output "5. Say: 'Session-X finalised - ready for the PR.' Only this message clears Cameron to create the PR."
    Write-Output ""
    Write-Output "Mechanical steps above are done. Everything in this section is still a human/judgment step - this runner does not do them."
    exit 0
}
