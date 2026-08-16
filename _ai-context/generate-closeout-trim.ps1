<#
Size-triggered trim of PROJECT_STATE.md's "Next Session Log ID" close-out
paragraphs into _ai-context/session-closeout-archive.md. Not a schedule -
a threshold check: if more than -Threshold close-out paragraphs are sitting
in PROJECT_STATE.md, the oldest ones move to the archive automatically,
keeping only the -Threshold most recent inline. Removes the "someone has
to remember to trigger this" failure mode the manual 2026-07-29 trim had.

Each close-out paragraph is a single unwrapped line matching:
  **Session-N close-out (DATE):** ... This field advances past it now.
Both files keep these in descending session-number order (most recent
first), so newly-archived paragraphs always insert at the TOP of the
archive's existing paragraph list - they are, by construction, always
more recent than everything already there.

No-op (exit 0) if the count is already at or under threshold - this
script is meant to run every session close, not just when something is
known to be due.

Usage:
  .\generate-closeout-trim.ps1 -ProjectStatePath "..\PROJECT_STATE.md" -ArchivePath ".\session-closeout-archive.md" -Threshold 5
#>

param(
    [Parameter(Mandatory=$true)][string]$ProjectStatePath,
    [Parameter(Mandatory=$true)][string]$ArchivePath,
    [int]$Threshold = 5
)

if (-not (Test-Path $ProjectStatePath)) { Write-Error "PROJECT_STATE.md not found at $ProjectStatePath"; exit 1 }
if (-not (Test-Path $ArchivePath)) { Write-Error "Archive file not found at $ArchivePath"; exit 1 }

$ProjectStatePath = (Resolve-Path $ProjectStatePath).Path
$ArchivePath = (Resolve-Path $ArchivePath).Path

$utf8NoBom = New-Object System.Text.UTF8Encoding($false)
$psContent = [System.IO.File]::ReadAllText($ProjectStatePath, [System.Text.Encoding]::UTF8)

$closeoutPattern = '(?m)^(\*\*Session-(\d+) close-out \(([^)]+)\):\*\*.*)$'
$matches = [regex]::Matches($psContent, $closeoutPattern)

if ($matches.Count -eq 0) {
    Write-Error "No close-out paragraphs found in PROJECT_STATE.md matching the expected pattern - refusing to proceed, this likely means the format changed and the regex needs updating, not that there's nothing to do."
    exit 1
}

# Sort descending by session number (most recent first) - matches the file's own existing order,
# but sort explicitly rather than trust line order, so a future out-of-order edit doesn't silently mis-trim.
$sorted = $matches | Sort-Object { [int]$_.Groups[2].Value } -Descending

if ($sorted.Count -le $Threshold) {
    Write-Output "Close-out paragraphs found: $($sorted.Count) (threshold $Threshold) - nothing to trim."
    exit 0
}

$keep = $sorted | Select-Object -First $Threshold
$trim = $sorted | Select-Object -Skip $Threshold
# Re-sort the trim set descending by session number for insertion order (Select-Object -Skip preserves
# the already-descending order here, but re-asserting it makes the invariant explicit rather than assumed).
$trim = $trim | Sort-Object { [int]$_.Groups[2].Value } -Descending

$trimSessionNumbers = $trim | ForEach-Object { [int]$_.Groups[2].Value }
$keepSessionNumbers = $keep | ForEach-Object { [int]$_.Groups[2].Value }
$highestTrimmed = ($trimSessionNumbers | Measure-Object -Maximum).Maximum
$lowestTrimmed = ($trimSessionNumbers | Measure-Object -Minimum).Minimum
$lowestKept = ($keepSessionNumbers | Measure-Object -Minimum).Minimum

if ($highestTrimmed -ge $lowestKept) {
    Write-Error "Sanity check failed: a trimmed session number ($highestTrimmed) is >= the lowest kept session number ($lowestKept). This should be structurally impossible given the sort above - refusing to proceed rather than risk trimming something that should stay."
    exit 1
}

# --- Build the archive insertion block ---
$today = Get-Date -Format "yyyy-MM-dd"
$archiveNote = "**Trimmed $today** (`generate-closeout-trim.ps1`, threshold $Threshold): session-$lowestTrimmed through session-$highestTrimmed close-out paragraphs moved here from `PROJECT_STATE.md`. Sessions $($keepSessionNumbers -join ', ') stayed inline as the $Threshold most recent at the time of this trim."

$trimParagraphs = ($trim | ForEach-Object { $_.Groups[1].Value }) -join "`n`n"

$archiveContent = [System.IO.File]::ReadAllText($ArchivePath, [System.Text.Encoding]::UTF8)

# Find the end of the YAML frontmatter (second '---' from the start), then the next '---' after
# that - the content-level divider between intro notes and the paragraph list.
$fmEnd = $archiveContent.IndexOf("`n---`n", 4)  # skip the opening '---' itself
if ($fmEnd -eq -1) {
    Write-Error "Could not find end of YAML frontmatter in $ArchivePath - refusing to guess insertion point."
    exit 1
}
$searchFrom = $fmEnd + 5
$dividerIdx = $archiveContent.IndexOf("`n---`n", $searchFrom)
if ($dividerIdx -eq -1) {
    Write-Error "Could not find the content divider ('---' after the intro notes) in $ArchivePath - refusing to guess insertion point."
    exit 1
}

$beforeDivider = $archiveContent.Substring(0, $dividerIdx)
$fromDivider = $archiveContent.Substring($dividerIdx)  # starts at "\n---\n..."

# $beforeDivider already ends with a single trailing newline (the close-out paragraph's own
# line terminator) - the leading '\n' of the matched "\n---\n" divider pattern belongs to the
# blank line, not the paragraph, so only ONE more '\n' is needed here, not two. Found live: a
# first run added "\n\n" on top of that existing trailing newline and produced a doubled blank
# line before the inserted note.
$newArchiveContent = $beforeDivider + "`n" + $archiveNote + "`n" + $fromDivider.Substring(0, 5) + "`n" + $trimParagraphs + $fromDivider.Substring(5)

$newArchiveContent = [regex]::Replace($newArchiveContent, '(?m)^\*\*Last updated:\*\* \d{4}-\d{2}-\d{2}$', "**Last updated:** $today")

[System.IO.File]::WriteAllText($ArchivePath, $newArchiveContent, $utf8NoBom)

# --- Remove trimmed paragraphs from PROJECT_STATE.md, add a short marker note ---
$newPsContent = $psContent
foreach ($m in $trim) {
    # Remove the paragraph line plus one trailing blank line (the blank line that separates
    # paragraphs) - removing exactly this much keeps single-blank-line spacing intact rather
    # than leaving a double blank or eating the separator before the next paragraph.
    $lineWithBlank = $m.Groups[1].Value + "`n`n"
    $idx = $newPsContent.IndexOf($lineWithBlank)
    if ($idx -eq -1) {
        Write-Error "Could not locate session-$($m.Groups[2].Value)'s close-out line for removal in PROJECT_STATE.md after archive write already happened - PROJECT_STATE.md and the archive are now out of sync and need manual reconciliation. Line: $($m.Groups[1].Value.Substring(0, [Math]::Min(80, $m.Groups[1].Value.Length)))..."
        exit 1
    }
    $newPsContent = $newPsContent.Remove($idx, $lineWithBlank.Length)
}

$psMarkerNote = "**Trimmed $today** (`generate-closeout-trim.ps1`, threshold $Threshold): session-$lowestTrimmed through session-$highestTrimmed close-out paragraphs moved to `_ai-context/session-closeout-archive.md`. This field advances past them now.`n`n"
$lastKeptLine = ($keep | Sort-Object { [int]$_.Groups[2].Value } -Descending | Select-Object -First 1).Groups[1].Value
$insertAfter = $lastKeptLine + "`n`n"
$insertIdx = $newPsContent.IndexOf($insertAfter)
if ($insertIdx -eq -1) {
    Write-Error "Could not locate the lowest-kept session's close-out line to insert the trim marker after - PROJECT_STATE.md was already modified (paragraphs removed) but the marker note was not inserted. Manual check needed."
    exit 1
}
$newPsContent = $newPsContent.Insert($insertIdx + $insertAfter.Length, $psMarkerNote)

[System.IO.File]::WriteAllText($ProjectStatePath, $newPsContent, $utf8NoBom)

Write-Output "Close-out paragraphs found: $($sorted.Count) (threshold $Threshold)"
Write-Output "Trimmed: session-$lowestTrimmed through session-$highestTrimmed ($($trim.Count) paragraphs)"
Write-Output "Kept inline: $($keepSessionNumbers -join ', ')"
Write-Output "Archive updated: $ArchivePath"
Write-Output "PROJECT_STATE.md updated: $ProjectStatePath"
exit 0
