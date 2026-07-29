---
type: message
title: "Follow-Up Brief for Fable 5 — Scoped Review of Two Additions Since Brief B"
timestamp: 2026-07-27
from: Claude Code
to: Cameron
aliases:
  - fable 5 followup brief
  - duplicate detection and exit code review
refs:
  - ./cowork-to-ccode-2026-07-27-cold-read-brief-b-summary.md
  - ./cowork-to-ccode-2026-07-27-duplicate-detection-review.md
---

Ready to paste into a fresh Fable 5 session. Unlike Brief A/B, this one is deliberately transparent about context rather than de-narrated — it's not a repeat of the blind first-look cold read (that already happened and doesn't need redoing), it's a focused second opinion on what changed afterward: two new additions Fable 5's original review never saw, one of which Cowork's own review already caught a real bug in (now fixed). Ask is a critical pass on the new logic specifically, not a full re-review of everything already cleared.

---

```
You reviewed an earlier version of this script already (Function B, the
drift-detection tool for cameronloudon.github.io's PROJECT_STATE.md).
Your original review found two real gaps -- an encoding blind spot
(Get-Content needed -Encoding UTF8) and an unanchored start-of-section
heading search -- both already fixed and verified against the live repo.
You also suggested, as optional hardening rather than required fixes,
duplicate-entry detection and a non-zero exit code on findings.

Both of those optional suggestions have now been built. This is a
follow-up review of just that new code, not a repeat of your original
full read. You don't need to re-verify the encoding or heading-anchor
fixes -- focus on what's new since you last saw this script:

1. Duplicate-entry detection, added to both Check 2 (the session-log
   enumerated list) and each of Check 3's six inventory sections. Groups
   the *listed* entries (never the disk side, since a real directory
   can't contain the same filename twice) and flags any value appearing
   more than once.

2. A non-zero exit code: 0 for a clean pass, 1 for a genuine script
   error (PROJECT_STATE.md missing -- this already existed), 2 for "ran
   fine, real findings to report." Cowork's independent review already
   caught a real bug here -- the findings-branch originally reused exit
   code 1, colliding with the pre-existing error-exit meaning, which
   would have made the two cases indistinguishable to an automated
   caller. That's already fixed to exit 2 in the version below.

YOUR TASK: review the two additions above with the same rigor as your
original cold read -- trace the logic, don't assume it's correct because
someone already reviewed it once. In particular: is the duplicate
detection genuinely mechanical (pure counting, no interpretation), does
it correctly stay disk-side-blind for the reason stated, and is there
any PowerShell collection-semantics edge case (single-item array
unwrapping, the kind of bug this project has hit multiple times before)
that the @() wrapping doesn't actually cover? Is the three-way exit code
scheme (0/1/2) internally consistent and correctly triggered by the
actual code paths? Note anything you'd improve or do differently, not
only outright errors. A script with no remaining issues is a legitimate,
honest result -- report that if it's what you find, don't manufacture a
finding to fulfill this task's premise.

The full, current script (all fixes and both additions included):

<#
.SYNOPSIS
    Function B (drift detection) -- first script. Checks PROJECT_STATE.md's
    mechanical, structural claims against actual repo state. Report-only,
    changes nothing. See PROJECT_STATE.md Open Decision #59 for the process
    this script itself is required to go through before anyone trusts it:
    proposed -> independently reviewed (Cowork) -> cold read (first script
    only) -> Cameron ratifies -> committed -> mechanical drift-check from
    then on.

.NOTES
    Deliberately out of scope: anything requiring semantic judgment
    (AI_INSTRUCTIONS.md vs CLAUDE.md agreement, system-architecture.md vs
    charter agreement). That stays cold-context per Open Decision #59 and
    is not something this script -- or any script -- should attempt.

    ASCII-only by deliberate choice, not oversight: Windows PowerShell 5.1
    has previously misread non-ASCII characters (em-dashes) in a
    non-BOM-marked script and refused to parse it at all -- the same bug
    class documented in Open Decision #39 for
    extract-session-transcript.ps1. Avoiding the character class avoids
    the bug entirely rather than depending on file encoding being right.
#>

param(
    [string]$RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
)

$ProjectStatePath = Join-Path $RepoRoot "PROJECT_STATE.md"
if (-not (Test-Path $ProjectStatePath)) {
    Write-Error "PROJECT_STATE.md not found at $ProjectStatePath"
    exit 1
}
# -Encoding UTF8 is required: PROJECT_STATE.md is UTF-8 without a BOM, and
# bare Get-Content decodes a BOM-less UTF-8 file as ANSI on Windows
# PowerShell 5.1 -- verified directly (an em-dash on line 10 comes back as
# mojibake without this flag). Harmless today only because every compared
# token is ASCII; caught in cold review (Fable 5, Brief B) before it could
# produce a silent false MISMATCH against some future non-ASCII entry.
$stateLines = Get-Content $ProjectStatePath -Encoding UTF8
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
    # Line-anchored, same as Check 3's fix -- a plain '-split "---"' is a
    # regex substring match, not a standalone-line match, and would
    # truncate early if the section's own prose ever happened to contain
    # three consecutive hyphens before the real divider. Caught in review
    # (Cowork) as the same bug shape as Check 3's original table-separator
    # bug, just not yet triggered here by circumstance.
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
# of that sentence, not just any period. The original version stopped at
# the first literal period anywhere, which breaks across a line wrap
# ('.' excludes newlines without singleline mode, and this sentence is
# already long enough that wrapping is a real future possibility) --
# caught in review (Cowork). A first attempt at fixing that by matching
# to the next blank line instead was itself wrong, caught in this
# script's own second test run: the very next line in the real file is
# an unrelated "Note:" sentence with no blank line separating it, so
# that version pulled a session ID mentioned in that note (as an
# explicitly-known non-existent log) into the "listed" set as a false
# positive. Terminating on period-then-newline avoids both failure
# modes without assuming a blank-line paragraph break exists.
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
    # returns $null rather than 1. Same bug family as cascade-check.ps1's
    # historical $Matches-clobbering bug and the identity-backfill
    # script's .Count bug (Open Decision #54, #58); flagged in review as
    # present here too, though only affecting the cosmetic "OK" count
    # display, not the comparison logic itself.
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

# Duplicate check -- the membership tests above only compare sets, so a
# session ID listed twice in the enumerated sentence (a real documentation
# error -- the sentence's own count word would then be wrong) would
# otherwise pass silently. Disk-side duplicates are not checked: a
# filesystem directory listing cannot contain the same filename twice.
# This is the inverse of a drift class this project has already hit for
# real (the _messages/ 8-vs-58 miscount, the fifty-seven-vs-fifty-eight
# session-log count correction) -- flagged as a genuine, then-unbuilt gap
# by cold review (Fable 5, Brief B).
$listedDuplicates = @($listedSessionLogs | Group-Object | Where-Object { $_.Count -gt 1 })
foreach ($d in $listedDuplicates) {
    Add-Finding "Session log '$($d.Name)' is listed $($d.Count) times in PROJECT_STATE.md's enumerated list (should appear once)."
}

if (-not $onDiskNotListed -and -not $listedNotOnDisk -and -not $listedDuplicates -and $listSentenceMatch.Success) {
    Write-Host "  OK -- enumerated list matches disk ($($actualSessionLogs.Count) files)." -ForegroundColor Green
} elseif (-not $listSentenceMatch.Success) {
    Add-Finding "Could not find the 'existing session logs are:' sentence in PROJECT_STATE.md -- check the section's wording hasn't changed."
}

# ------------------------------------------------------------------
# CHECK 3 -- Page Inventory table sections vs actual files/folders
# ------------------------------------------------------------------
Write-Host "`n=== Check 3: Page Inventory tables vs disk ===" -ForegroundColor Cyan

# Each entry: heading text to search for, relative folder to check.
# _messages/ bundle added after independent review (Cowork) found it was
# missing from this list -- and found real, current drift sitting there
# as a direct result: PROJECT_STATE.md's table lists 8 files, the actual
# folder has 58. Verified independently before accepting: confirmed via
# `ls _messages/*.md` (58 files) against the table's 8 rows. The scope
# gap wasn't cosmetic -- the very drift Function B exists to catch was
# sitting uncaught in the one section this script didn't check.
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

    # Line-anchored on the start side too, not just the end (Check 3's end
    # boundary was already fixed this way). A plain substring split is only
    # safe as long as the heading text never appears anywhere else in the
    # file -- true today, but this project's own close-out notes quote
    # section headings in prose routinely, and a future one doing so would
    # silently start extraction at the wrong occurrence. Caught in cold
    # review (Fable 5, Brief B) as the one gap neither Cowork's review nor
    # this script's own end-boundary fix had covered.
    $headingPattern = "(?m)^" + [regex]::Escape($heading)
    $afterHeading = ($stateText -split $headingPattern)[1]
    if (-not $afterHeading) {
        Add-Finding "Could not find section heading '$heading' in PROJECT_STATE.md -- check it hasn't been renamed."
        continue
    }
    # Section runs until the next '### ' heading or a standalone '---' divider
    # line, whichever comes first. Deliberately line-anchored (not a plain
    # substring search) so a markdown table's own header-separator row
    # (e.g. '|---|---|---|---|') is never mistaken for a section divider --
    # a real bug caught during this script's own first test run, before
    # it was ever sent for review.
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
    # Wrapped in @() for the same reason as Check 2's array fix above.
    $actualEntriesRaw = @(Get-ChildItem $folder | ForEach-Object {
        $rel = "$($section.Folder)/$($_.Name)"
        if ($_.PSIsContainer) { "$rel/" } else { $rel }
    })

    # Different sections cite entries differently -- _session-logs/ rows are
    # bare filenames, others include the folder prefix. Normalize both sides
    # to the same shape (folder prefix stripped) rather than assuming one
    # convention; a second real formatting inconsistency caught during this
    # script's own first test run.
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

    # Duplicate check -- same reasoning as Check 2's: a table row repeated
    # twice under one heading would otherwise pass the membership tests
    # above silently. Disk side not checked, same reason as Check 2 (a
    # directory listing can't repeat a filename). Flagged by cold review
    # (Fable 5, Brief B).
    $listedDuplicatesInSection = @($listedEntries | Group-Object | Where-Object { $_.Count -gt 1 })
    foreach ($d in $listedDuplicatesInSection) {
        Add-Finding "'$heading' lists '$($d.Name)' $($d.Count) times in PROJECT_STATE.md's page inventory (should appear once)."
    }

    if (-not $onDiskNotListed -and -not $listedNotOnDisk -and -not $listedDuplicatesInSection) {
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

# Non-zero exit on any finding -- makes the script composable into
# automation (a future CI step, pre-commit hook, or session-start check)
# without needing to parse Write-Host output to know whether it passed.
# Flagged by cold review (Fable 5, Brief B) as cheap and worth having
# given Open Decision #59's consensus-gating context. Exit code 2, not 1
# -- 1 is already used above for a genuine script error (PROJECT_STATE.md
# missing) and needs to stay distinguishable from "the script ran fine
# and found real drift to report," or an automated caller can't tell the
# two apart. Caught in review (Cowork).
if ($findings.Count -gt 0) {
    exit 2
}
exit 0
```

---

*Claude Code (Publish Agent) · 2026-07-27*

## Links
<!-- generated from refs: - do not hand-edit -->
- [[cowork-to-ccode-2026-07-27-cold-read-brief-b-summary]]
- [[cowork-to-ccode-2026-07-27-duplicate-detection-review]]
