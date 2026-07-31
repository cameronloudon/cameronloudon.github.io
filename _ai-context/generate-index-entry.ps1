<#
Open Decision #57. Reads a single promoted _messages/ (or _audit-findings/)
file's frontmatter and prints the entry line index.md's established format
uses, to console only -- it never writes to index.md. Placement (which
Thread heading, which sub-group if the thread uses one) stays a human
call; thread_number:/subgroup: frontmatter is printed as a hint, not
acted on, since index.md's own thread structure -- titles, narrative
paragraphs, the Gaps section -- stays entirely hand-composed and this
script has no model of it.

Mechanical, not editorial: type:/title:/from:/to:/participants:/refs:/
note: are all copied from frontmatter that already exists (the same
promotion-time authorship rule as aliases: -- drafted by whoever is
closest to the file's own intent, not guessed by this script or the
agent running it). This script assembles them into the established line
shape; it does not decide what any of them say.

Known, deliberate limitation on the refs: portion: real index.md entries
often use connective prose ("refs the review and the CTA update above")
that names targets by role, not just title. This script renders refs: as
a plain resolved list -- each target's own title:, or its bare filename
if it has none (an instruction file outside the bundle, for instance) --
not an attempt to reproduce that prose style. Treat the printed line as a
solid mechanical draft to hand-place and lightly edit into house style,
same as every other generator in this family produces a draft, not a
final artifact, where real editorial judgment is still involved.

Fails loudly (non-zero exit) if type:/title:/refs: are missing, or if
neither from:/to: nor participants: is present -- these are the fields
messages-promotion-procedure.md SS2 requires unconditionally, so a file
missing one of them isn't ready to be indexed yet, not a case to guess
past. thread_number:/subgroup:/note: are warned about if missing, not
failed on -- newer, optional fields (SS2), and a file can still be
usefully indexed without them.

Usage:
  .\generate-index-entry.ps1 -File "C:\path\to\_messages\some-file.md"
#>

param(
    [Parameter(Mandatory=$true)][string]$File
)

if (-not (Test-Path $File)) {
    Write-Error "File not found: $File"
    exit 1
}

$fullPath = (Resolve-Path $File).Path
$dir = Split-Path $fullPath -Parent
$content = [System.IO.File]::ReadAllText($fullPath, [System.Text.Encoding]::UTF8)

if ($content -notmatch '(?s)^---\r?\n(.*?)\r?\n---\r?\n') {
    Write-Error "$($File): no OKF frontmatter block found -- nothing to generate from."
    exit 1
}
$frontmatter = $Matches[1]
$lines = $frontmatter -split "`r?`n"

function Get-ScalarField {
    param([string[]]$Lines, [string]$Name)
    foreach ($l in $Lines) {
        if ($l -match "^${Name}:\s*(.+?)\s*$") { return $Matches[1].Trim('"') }
    }
    return $null
}

function Get-ListField {
    param([string[]]$Lines, [string]$Name)
    $result = @()
    $inField = $false
    foreach ($l in $Lines) {
        if ($l -match "^${Name}:\s*(\[\s*\])?\s*$") { $inField = $true; continue }
        if ($inField) {
            if ($l -match '^\s*-\s*(.+?)\s*$') {
                $result += $Matches[1].Trim()
            } elseif ($l -match '^\S') {
                $inField = $false
            }
        }
    }
    return $result
}

$type = Get-ScalarField $lines "type"
$title = Get-ScalarField $lines "title"
$from = Get-ScalarField $lines "from"
$to = Get-ScalarField $lines "to"
$participants = Get-ListField $lines "participants"
$refs = Get-ListField $lines "refs"
$threadNumber = Get-ScalarField $lines "thread_number"
$subgroup = Get-ScalarField $lines "subgroup"
$note = Get-ScalarField $lines "note"

$missing = @()
if (-not $type) { $missing += "type:" }
if (-not $title) { $missing += "title:" }
if (-not $from -and $participants.Count -eq 0) { $missing += "from:/to: or participants:" }
if ($missing.Count -gt 0) {
    Write-Error "$($File): missing required field(s): $($missing -join ', ') -- not ready to index."
    exit 1
}

$warnings = @()
if (-not $threadNumber) { $warnings += "thread_number: not set -- placement is entirely your call" }
if (-not $note) { $warnings += "note: not set -- the qualitative caption after the semicolon will be blank, fill it in by hand" }

# index.md's real format uses literal em-dash/right-arrow characters, not
# ASCII "--"/"->". Built from character codes rather than written as
# literal non-ASCII source text -- this script file itself has no BOM
# (deliberate, matching function-b-state-check.ps1's precedent), and
# Windows PowerShell 5.1 misreads non-ASCII source characters as ANSI on
# a BOM-less file. Keeping the .ps1 source pure ASCII avoids that bug
# entirely while still producing correctly-encoded Unicode output.
$emdash = [char]0x2014
$arrow = [char]0x2192

# Actor portion: from/to (authored) or participants (captured) -- mutually
# exclusive per messages-promotion-procedure.md SS2, never both.
if ($from) {
    $actorText = "($from $arrow $to)"
} else {
    $actorText = "(participants: $($participants -join ', '))"
}

# Resolve each refs: target to its own title:, falling back to the bare
# filename if the target has no frontmatter title (a plain instruction
# file, or a bundle file that predates OKF adoption).
function Resolve-RefTitle {
    param([string]$RefPath, [string]$FromDir)
    $resolved = [System.IO.Path]::GetFullPath((Join-Path $FromDir $RefPath))
    if (-not (Test-Path $resolved)) {
        return "$RefPath [UNRESOLVED]"
    }
    $refContent = [System.IO.File]::ReadAllText($resolved, [System.Text.Encoding]::UTF8)
    if ($refContent -match '(?s)^---\r?\n(.*?)\r?\n---\r?\n') {
        $refFm = $Matches[1] -split "`r?`n"
        $refTitle = Get-ScalarField $refFm "title"
        if ($refTitle) { return $refTitle }
    }
    return [System.IO.Path]::GetFileNameWithoutExtension($resolved)
}

if ($refs.Count -eq 0) {
    $refsText = "no in-bundle refs"
} else {
    $resolvedTitles = $refs | ForEach-Object { Resolve-RefTitle -RefPath $_ -FromDir $dir }
    $refsText = "refs " + ($resolvedTitles -join ", ")
}

$fileName = Split-Path $fullPath -Leaf
$noteText = if ($note) { "; $note" } else { "" }

$line = "- [$title](./$fileName) $emdash ``$type`` $actorText $arrow $refsText$noteText"

Write-Output "=== Generated entry line ==="
Write-Output $line
Write-Output ""
Write-Output "=== Placement hint ==="
if ($threadNumber) {
    $placement = "Thread $threadNumber"
    if ($subgroup) { $placement += ", sub-group '$subgroup'" }
    Write-Output $placement
} else {
    Write-Output "(none given -- thread_number: not set on this file)"
}
if ($warnings.Count -gt 0) {
    Write-Output ""
    Write-Output "=== Warnings ==="
    $warnings | ForEach-Object { Write-Output "- $_" }
}
