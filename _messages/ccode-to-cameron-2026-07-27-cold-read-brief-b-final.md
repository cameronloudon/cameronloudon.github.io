---
type: message
title: "Cold-Read Brief B, Final — For a Fresh Separate Session (Opus 5 or similar)"
timestamp: 2026-07-27
from: Claude Code
to: Cameron
aliases:
  - brief b final text
  - function b cold read brief b
refs:
  - ./ccode-to-cowork-2026-07-27-cold-read-briefs-update-applied.md
---

Ready to paste as-is into a genuinely fresh, separate session — no prior context on this project, no memory of this conversation. Nothing left to edit — this is the fully finalized text: clean-pass permission line included, thread-freshness line dropped (withdrawn per Cowork's 2026-07-27 reconsideration), improvement-invite added. The script embedded below is the de-narrated `COLDREAD-COPY` version — same logic as the real file, with every "caught in review" / who-found-what comment stripped, so this reviewer doesn't start already knowing which bugs were already caught.

Whatever model runs this needs the temporary AI-Prod read access set up (same model the Auditor already uses) before it can actually check `PROJECT_STATE.md` directly, per the brief's own instruction.

---

```
You have no prior context on this project. Treat that as deliberate, not
a gap to fill in from assumption -- do not guess at project history,
conventions, or intent beyond what's stated here.

This is cameronloudon.github.io, a personal site built under a framework
called Radical Collaboration Transparency, which requires every AI
contribution to be attributed and auditable. Part of that framework is
an "Auditor" role that periodically checks project state for drift using
cold, context-free reviews specifically because incumbents who know a
project well reliably miss things that a fresh read catches immediately
-- that's been demonstrated concretely on this project more than once.
You are being asked to perform a one-time review in that same spirit,
for a script this project's incumbent agents wrote themselves and cannot
be the sole judges of.

You have been granted temporary read access to a mirror of this
project's live files (AI-Prod) -- the same access model this project's
own Auditor role uses. Use it: read the real, current PROJECT_STATE.md
file directly, and trace the script's logic against its actual content
and structure, rather than reasoning about the code in isolation.

The script itself is pasted in full below (it has not been committed to
the repo yet, so it is not in the file mirror you have access to).

OBJECTIVE OF THE SCRIPT: mechanical, structural drift detection only --
does PROJECT_STATE.md's Active Branch claim, its session-log enumerated
list, and its Page Inventory tables (for six named collections/bundles)
match actual repo state on disk. Report-only, changes nothing.
Deliberately out of scope: anything requiring semantic judgment or
interpretation -- the script should only ever do raw string/file
comparison, never assess whether something "makes sense" or "is still
accurate" in a meaning-based way.

YOUR TASK: review this script fresh, as if you are the first person to
look at it. Do not assume it is already correct. Trace each of its three
checks against the real PROJECT_STATE.md file you have access to.
Identify any bugs, logic errors, or edge cases where a check would
produce a wrong result -- either a false positive (flagging something
that's actually fine) or a false negative (missing something that's
actually wrong). Confirm whether the script genuinely stays inside the
mechanical/structural boundary described above, or smuggles in anything
requiring judgment, and note anything you'd improve or do differently,
not only outright errors. Cite evidence for every finding -- which line,
what you checked it against, why it's wrong.

A script with no remaining issues is a legitimate, honest result. If
that's what you find, report it as such -- do not manufacture a finding
to fulfill this task's premise.

<#
.SYNOPSIS
    Function B (drift detection) -- a candidate script. Checks PROJECT_STATE.md's
    mechanical, structural claims against actual repo state. Report-only,
    changes nothing.

.NOTES
    Deliberately out of scope: anything requiring semantic judgment
    (AI_INSTRUCTIONS.md vs CLAUDE.md agreement, system-architecture.md vs
    charter agreement). That is not something this script -- or any
    script -- should attempt.

    ASCII-only by deliberate choice: Windows PowerShell 5.1 can misread
    non-ASCII characters (e.g. em-dashes) in a non-BOM-marked script and
    refuse to parse it at all. Avoiding the character class avoids the
    bug entirely rather than depending on file encoding being right.
#>

param(
    [string]$RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
)

$ProjectStatePath = Join-Path $RepoRoot "PROJECT_STATE.md"
if (-not (Test-Path $ProjectStatePath)) {
    Write-Error "PROJECT_STATE.md not found at $ProjectStatePath"
    exit 1
}
$stateLines = Get-Content $ProjectStatePath
$stateText = $stateLines -join "`n"

$findings = New-Object System.Collections.Generic.List[string]

function Add-Finding {
    param([string]$Text)
    $findings.Add($Text)
}

# ------------------------------------------------------------------
# CHECK 1 -- Active Branch claim vs actual git state
# ------------------------------------------------------------------
Write-Host "=== Check 1: Active Branch ===" -ForegroundColor Cyan

$activeBranchSection = ($stateText -split "## Active Branch")[1]
if ($activeBranchSection) {
    # Line-anchored so a stray triple-hyphen elsewhere in the section's
    # prose isn't mistaken for the end-of-section divider.
    $endMatch = [regex]::Match($activeBranchSection, '(?m)^(?:##\s|---\s*$)')
    if ($endMatch.Success) {
        $activeBranchSection = $activeBranchSection.Substring(0, $endMatch.Index)
    }
}
$claimedBranchMatch = [regex]::Match($activeBranchSection, '`(session-\d+)`')
$claimedBranch = if ($claimedBranchMatch.Success) { $claimedBranchMatch.Groups[1].Value } else { $null }

$actualBranch = $null
Push-Location $RepoRoot
try {
    $gitOutput = git branch --show-current 2>&1
    if ($LASTEXITCODE -eq 0) {
        $actualBranch = ($gitOutput | Out-String).Trim()
    }
} catch {
    # $actualBranch stays $null; handled below.
} finally {
    Pop-Location
}

if (-not $actualBranch) {
    Add-Finding "Active Branch: could not determine the actual current git branch -- 'git branch --show-current' failed or '$RepoRoot' is not a git repository."
} elseif (-not $claimedBranch) {
    Add-Finding "Active Branch: could not extract a claimed branch name from PROJECT_STATE.md's Active Branch section -- check the section's format hasn't changed."
} elseif ($claimedBranch -ne $actualBranch) {
    Add-Finding "Active Branch MISMATCH: PROJECT_STATE.md claims '$claimedBranch', actual current branch is '$actualBranch'."
} else {
    Write-Host "  OK -- PROJECT_STATE.md claims '$claimedBranch', matches actual branch." -ForegroundColor Green
}

# ------------------------------------------------------------------
# CHECK 2 -- Session-log enumerated list vs actual files in _session-logs/
# ------------------------------------------------------------------
Write-Host "`n=== Check 2: Session-log enumerated list vs disk ===" -ForegroundColor Cyan

# Captures everything between "existing session logs are:" and the first
# period that is itself followed by a line break -- i.e. the actual end
# of that sentence, so the match works whether or not the sentence spans
# multiple lines, and doesn't stop early at a period that isn't actually
# the end of the sentence.
$listSentenceMatch = [regex]::Match($stateText, '(?s)existing session logs are:(.*?)\.\s*\r?\n')
$listedSessionLogs = @()
if ($listSentenceMatch.Success) {
    $listedSessionLogs = @([regex]::Matches($listSentenceMatch.Groups[1].Value, '`(session-\d{4}-\d{2}-\d{2}-\d{3})`') |
        ForEach-Object { $_.Groups[1].Value })
}

$sessionLogsDir = Join-Path $RepoRoot "_session-logs"
$actualSessionLogs = @()
if (Test-Path $sessionLogsDir) {
    # Wrapped in @() to force array context -- without it, PowerShell 5.1
    # unwraps a single-item result to a bare object, and .Count on that
    # returns $null rather than 1.
    $actualSessionLogs = @(Get-ChildItem $sessionLogsDir -Filter "session-*.md" |
        ForEach-Object { $_.BaseName })
}

$onDiskNotListed = $actualSessionLogs | Where-Object { $listedSessionLogs -notcontains $_ }
$listedNotOnDisk = $listedSessionLogs | Where-Object { $actualSessionLogs -notcontains $_ }

if ($onDiskNotListed) {
    foreach ($f in $onDiskNotListed) {
        Add-Finding "Session log '$f' exists in _session-logs/ but is NOT in PROJECT_STATE.md's enumerated list."
    }
}
if ($listedNotOnDisk) {
    foreach ($f in $listedNotOnDisk) {
        Add-Finding "PROJECT_STATE.md's enumerated list claims '$f' exists but no matching file was found in _session-logs/."
    }
}
if (-not $onDiskNotListed -and -not $listedNotOnDisk -and $listSentenceMatch.Success) {
    Write-Host "  OK -- enumerated list matches disk ($($actualSessionLogs.Count) files)." -ForegroundColor Green
} elseif (-not $listSentenceMatch.Success) {
    Add-Finding "Could not find the 'existing session logs are:' sentence in PROJECT_STATE.md -- check the section's wording hasn't changed."
}

# ------------------------------------------------------------------
# CHECK 3 -- Page Inventory table sections vs actual files/folders
# ------------------------------------------------------------------
Write-Host "`n=== Check 3: Page Inventory tables vs disk ===" -ForegroundColor Cyan

# Each entry: heading text to search for, relative folder to check.
$inventorySections = @(
    @{ Heading = "### _ideas/ collection"; Folder = "_ideas" },
    @{ Heading = "### _signals/ collection"; Folder = "_signals" },
    @{ Heading = "### _now/ collection"; Folder = "_now" },
    @{ Heading = "### _session-logs/ collection"; Folder = "_session-logs" },
    @{ Heading = "### _audit-findings/ bundle"; Folder = "_audit-findings" },
    @{ Heading = "### _messages/ bundle"; Folder = "_messages" }
)

foreach ($section in $inventorySections) {
    $heading = $section.Heading
    $folder = Join-Path $RepoRoot $section.Folder

    $afterHeading = ($stateText -split [regex]::Escape($heading))[1]
    if (-not $afterHeading) {
        Add-Finding "Could not find section heading '$heading' in PROJECT_STATE.md -- check it hasn't been renamed."
        continue
    }
    # Section runs until the next '### ' heading or a standalone '---'
    # divider line, whichever comes first. Line-anchored so a markdown
    # table's own header-separator row (e.g. '|---|---|---|---|') isn't
    # mistaken for a section divider.
    $endMatch = [regex]::Match($afterHeading, '(?m)^(?:###\s|---\s*$)')
    $sectionBody = if ($endMatch.Success) { $afterHeading.Substring(0, $endMatch.Index) } else { $afterHeading }

    # Extract first-column backtick-quoted paths from table rows only
    # (lines starting with a pipe then a backtick).
    $tableRows = $sectionBody -split "`n" | Where-Object { $_ -match '^\|\s*`' }
    $listedEntriesRaw = @()
    foreach ($row in $tableRows) {
        $m = [regex]::Match($row, '^\|\s*`([^`]+)`')
        if ($m.Success) { $listedEntriesRaw += $m.Groups[1].Value }
    }

    if (-not (Test-Path $folder)) {
        Add-Finding "Folder '$($section.Folder)' referenced by '$heading' does not exist on disk."
        continue
    }

    # Actual entries: top-level files and folders (folders get a trailing
    # slash to match the table's own convention, e.g. _ideas/my-idea/).
    $actualEntriesRaw = @(Get-ChildItem $folder | ForEach-Object {
        $rel = "$($section.Folder)/$($_.Name)"
        if ($_.PSIsContainer) { "$rel/" } else { $rel }
    })

    # Different sections cite entries differently -- _session-logs/ rows
    # are bare filenames, others include the folder prefix. Normalize
    # both sides to the same shape before comparing.
    $prefixPattern = "^" + [regex]::Escape("$($section.Folder)/")
    $normalize = { param($v) [regex]::Replace($v, $prefixPattern, "") }
    $listedEntries = $listedEntriesRaw | ForEach-Object { & $normalize $_ }
    $actualEntries = $actualEntriesRaw | ForEach-Object { & $normalize $_ }

    $onDiskNotListed = $actualEntries | Where-Object { $listedEntries -notcontains $_ }
    $listedNotOnDisk = $listedEntries | Where-Object { $actualEntries -notcontains $_ }

    foreach ($f in $onDiskNotListed) {
        Add-Finding "'$($section.Folder)/$f' exists on disk but is not listed under '$heading' in PROJECT_STATE.md's page inventory."
    }
    foreach ($f in $listedNotOnDisk) {
        Add-Finding "'$heading' lists '$f' but no matching file/folder was found on disk under '$($section.Folder)/'."
    }
    if (-not $onDiskNotListed -and -not $listedNotOnDisk) {
        Write-Host "  OK -- $heading matches disk ($($actualEntries.Count) entries)." -ForegroundColor Green
    }
}

# ------------------------------------------------------------------
# REPORT
# ------------------------------------------------------------------
Write-Host "`n=== Summary ===" -ForegroundColor Cyan
if ($findings.Count -eq 0) {
    Write-Host "No drift found. All checked claims in PROJECT_STATE.md match actual repo state." -ForegroundColor Green
} else {
    Write-Host "$($findings.Count) finding(s):" -ForegroundColor Yellow
    $i = 1
    foreach ($f in $findings) {
        Write-Host "  $i. $f"
        $i++
    }
}
```

---

*Claude Code (Publish Agent) · 2026-07-27*

## Links
<!-- generated from refs: - do not hand-edit -->
- [[ccode-to-cowork-2026-07-27-cold-read-briefs-update-applied]]
