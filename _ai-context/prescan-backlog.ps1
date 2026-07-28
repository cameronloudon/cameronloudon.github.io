<#
Report-only mechanical prescan of AI-Working/Messages/ files ahead of
promotion into _messages/ (messages-promotion-procedure.md). Reads,
never writes, changes nothing - same discipline as
function-b-state-check.ps1. Exists to cut token cost on the remaining
backlog (Open Decision #57's adjacent token-cost question, 2026-07-28):
most files carry a plain, consistent header this script can parse for
free, and the single most expensive part of manual promotion - figuring
out what a message replies to - is very often already named in plain
text in that header's Re: line.

Deliberately does NOT touch type: or aliases:. Both still require
reading the actual content - type: by standing rule (Open Decision #34:
a real file in this project's own history was initially misclassified
transcript when it was actually summary, caught only on inspection;
"type has to come from reading content, not trusting a
filename/self-description"), aliases: because drafting real search
terms is generation work, not extraction. Nothing this script produces
should be pasted into real frontmatter without a human or agent reading
the file and confirming it - this is a report, not a promotion.

Per file, one of:
  MECHANICAL  - From:/To:/Date: header parsed cleanly. title:/from:/
                to:/timestamp: given as ready-to-use values.
  NO_HEADER   - doesn't match the convention (transcripts, summaries,
                older-format files). Needs the same full manual
                handling it needs today - not guessed at.

refs: candidates, two confidence tiers, both checked for existence
against -Path before being offered (an unresolved name is flagged, not
silently dropped - a real, non-hypothetical case: a 20-file spot check
during this design found 3 of 20 Re:-line targets no longer resolved,
renamed/superseded/typo'd since being written):
  REFS_CANDIDATE_FROM_RE   - the Re: line's own named file(s). Higher
                             confidence but not ground truth - check
                             this first, don't trust it outright.
  REFS_CANDIDATE_FROM_BODY - any other backtick-quoted .md mention
                             anywhere else in the file. Lower
                             confidence, rendered terser (filename
                             only, no surrounding context) to keep
                             the report's size down without hiding
                             real candidates.

Known limitation, not silently papered over: existence is only checked
within the scanned -Path. A Re: line pointing at a file already
promoted into _messages/ will show as unresolved even though it's
genuinely valid - a real false-positive class, not a bug, since this
script has no opinion on _messages/'s own contents.

Does not filter out operational prompt-paste templates (the standing
exclusion from _messages/ entirely) - that requires the same kind of
content judgment as type:, deliberately out of scope here. Still needs
doing by hand, same as today.

Recommended usage: run with -Since right before promoting each batch,
not once upfront against the whole backlog - matches the promotion
cadence already decided 2026-07-24 ("flag me when a batch is ready...
not waiting until everything's done"), and keeps candidates as fresh as
the promotion decision itself rather than stale by the time they're
used (the same staleness class the 3/20 spot-check already caught).

-Since filters on the header Date:, falling back to a filename-embedded
date if the header has none - purely for filtering, not attribute
derivation. A small set of files (21 of 479 as of 2026-07-28, mostly the
earliest pre-`_messages/`-convention material) have no date anywhere at
all; these are shown regardless of -Since rather than silently hidden,
since a genuinely undated file could still be recent and relevant -
flagged explicitly in both the per-file output and the summary count so
this isn't mistaken for the filter having worked on them.

Usage:
  .\prescan-backlog.ps1 -Path "C:\path\to\AI-Working\Messages" -Since "2026-06-29"
  .\prescan-backlog.ps1 -Path "C:\path\to\AI-Working\Messages"   # whole-folder scan, reconnaissance only
#>

param(
    [Parameter(Mandatory=$true)][string]$Path,
    [string]$Since
)

$sinceDate = $null
if (-not [string]::IsNullOrWhiteSpace($Since)) {
    $sinceDate = [datetime]::Parse($Since)
}

$files = Get-ChildItem -Path $Path -Filter *.md
$existingNames = @{}
foreach ($f in $files) { $existingNames[$f.Name] = $true }

$mechanicalCount = 0
$noHeaderCount = 0
$refsFromReFound = 0
$refsFromReUnresolved = 0
$refsFromBodyCount = 0
$skippedBySince = 0
$undatedShown = 0

foreach ($f in $files) {
    $content = [System.IO.File]::ReadAllText($f.FullName, [System.Text.Encoding]::UTF8)
    $lines = $content -split "`r?`n"

    $title = $null
    $from = $null
    $to = $null
    $date = $null
    $reLine = $null

    foreach ($l in ($lines | Select-Object -First 12)) {
        if (-not $title -and $l -match '^#\s+(.+)$') { $title = $Matches[1].Trim() }
        if ($l -match '^From:\s*(.+)$') { $from = $Matches[1].Trim() }
        if ($l -match '^To:\s*(.+)$') { $to = $Matches[1].Trim() }
        if ($l -match '^Date:\s*(\d{4}-\d{2}-\d{2})') { $date = $Matches[1] }
        if ($l -match '^Re:\s*(.*)$') { $reLine = $Matches[1].Trim() }
    }

    # Date filter: prefer the parsed header Date:, fall back to a
    # filename-embedded date purely for filtering purposes - this is
    # not attribute derivation, just deciding whether to report on the
    # file at all, so it doesn't touch the type:/self-description rule.
    $filterDate = $date
    if (-not $filterDate -and $f.Name -match '(\d{4}-\d{2}-\d{2})') { $filterDate = $Matches[1] }
    $undated = $false
    if ($sinceDate) {
        if ($filterDate) {
            if ([datetime]::Parse($filterDate) -lt $sinceDate) { $skippedBySince++; continue }
        } else {
            # No date anywhere - header or filename. Shown regardless
            # rather than silently hidden (a file with no discoverable
            # date could be recent and relevant), but flagged so this
            # isn't mistaken for the -Since filter having worked.
            $undated = $true
            $undatedShown++
        }
    }

    $isMechanical = $from -and $to -and $date

    Write-Output "=== $($f.Name) ==="
    if (-not $isMechanical) {
        Write-Output "Status: NO_HEADER (needs full manual handling)"
        if ($undated) { Write-Output "(no date found in header or filename - shown regardless of -Since)" }
        $noHeaderCount++
        Write-Output ""
        continue
    }

    $mechanicalCount++
    Write-Output "Status: MECHANICAL"
    Write-Output "Title: $title"
    Write-Output "From: $from"
    Write-Output "To: $to"
    Write-Output "Date: $date"
    if ($reLine) { Write-Output "Re: $reLine" }

    if ($reLine) {
        $reMatches = [regex]::Matches($reLine, '`([a-zA-Z0-9_.-]+\.md)`')
        foreach ($m in $reMatches) {
            $candidate = $m.Groups[1].Value
            if ($existingNames.ContainsKey($candidate)) {
                Write-Output "REFS_CANDIDATE_FROM_RE: $candidate [FOUND]"
                $refsFromReFound++
            } else {
                Write-Output "REFS_CANDIDATE_FROM_RE: $candidate [UNRESOLVED - not found in scanned path]"
                $refsFromReUnresolved++
            }
        }
    }

    $bodyText = ($lines | Select-Object -Skip 6) -join "`n"
    $bodyMatches = [regex]::Matches($bodyText, '`([a-zA-Z0-9_.-]+\.md)`') | ForEach-Object { $_.Groups[1].Value } | Select-Object -Unique
    if ($bodyMatches) {
        $terse = ($bodyMatches -join ", ")
        Write-Output "REFS_CANDIDATE_FROM_BODY: $terse"
        $refsFromBodyCount += $bodyMatches.Count
    }

    Write-Output ""
}

Write-Output "---"
Write-Output "Scanned path: $Path"
if ($sinceDate) { Write-Output "Since: $Since (skipped $skippedBySince files older than this; $undatedShown had no determinable date and were shown regardless)" }
Write-Output "MECHANICAL: $mechanicalCount"
Write-Output "NO_HEADER: $noHeaderCount"
Write-Output "REFS_CANDIDATE_FROM_RE found: $refsFromReFound"
Write-Output "REFS_CANDIDATE_FROM_RE unresolved: $refsFromReUnresolved"
Write-Output "REFS_CANDIDATE_FROM_BODY total mentions: $refsFromBodyCount"
Write-Output "Report-only - nothing was written to any file."
