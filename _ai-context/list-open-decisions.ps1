<#
Lists genuinely open Open Decision rows from PROJECT_STATE.md.

"Genuinely open" is defined by the Gate column (the table's last cell),
not by the presence/absence of a checkmark anywhere in the row - a row
can carry "Ratified" or "Threads 1/2 resolved" language in its Owner
column while its Gate column still holds a real, unresolved item (#43
and #48 were both missed this way: filtering on "no checkmark in the
row" treated a partially-resolved entry as fully closed). A row counts
as resolved only when its Gate column is exactly a single em-dash character; any
other content there means something is still open.

Usage:
  .\_ai-context\list-open-decisions.ps1
#>

$projectState = "PROJECT_STATE.md"
# Explicit UTF-8 read, not plain Get-Content - PowerShell 5.1's default
# encoding detection misreads this file's em-dashes as mojibake without a
# BOM, which silently made every single row compare as "open" (same class
# of bug as #39, on the read side rather than the parse side). Matches the
# pattern generate-links-footer.ps1 already established for this reason.
$lines = [System.IO.File]::ReadAllLines((Resolve-Path $projectState), [System.Text.Encoding]::UTF8)

$openPattern = '^\| (\d+) \| (.*) \| ([\d, ]+) \| (.*) \| (.*) \|\s*$'

# Built from its Unicode code point rather than embedded as a literal glyph -
# a literal em-dash in this file broke Windows PowerShell 5.1's parser
# entirely without a UTF-8 BOM (the exact same failure as Open Decision #39,
# in a different script). Constructing it this way removes the dependency
# on this file's own encoding for the comparison to work correctly.
$emDash = [char]0x2014

$open = @()
foreach ($line in $lines) {
    if ($line -notmatch $openPattern) { continue }
    $num = $Matches[1]
    $gate = $Matches[5].Trim()
    if ($gate -ne $emDash) {
        $open += [PSCustomObject]@{ Number = [int]$num; Gate = $gate }
    }
}

if ($open.Count -eq 0) {
    Write-Output "No genuinely open Open Decisions found."
} else {
    Write-Output "Genuinely open Open Decisions ($($open.Count)):"
    foreach ($item in ($open | Sort-Object Number)) {
        Write-Output "  #$($item.Number) - $($item.Gate)"
    }
}
