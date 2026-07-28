<#
Appends one verification event to a file's `verified:` frontmatter list -
OKF v0.2's real trust-tier mechanism (attribution-schema.md §3). Unlike
every other script in this family, this one is append-only: it preserves
every prior entry rather than deriving and replacing a whole field. Run
once per verification event, one file at a time - not a -BundlePath
sweep, since a verification event is about one specific file at one
specific moment, not a mechanical property of a whole bundle.

Actor form - two mutually exclusive parameter sets, matching OKF's real
actor convention (attribution-schema.md §1, §3):
  -Wrapper/-Identity  -> by: human:<identity, lowercased, hyphenated>
                         (when -Wrapper Person) or <wrapper>/<identity>
                         otherwise - same derivation as generate-provenance.ps1.
  -Process <id>       -> by: process:<id> literally - for a mechanical,
                         non-agent, non-human verifier (e.g. a future
                         function-b-state-check.ps1 / cascade-check.ps1
                         run that confirms a claim on its own). Not used
                         by anything in this project yet as of
                         2026-07-28 - added to complete the actor
                         convention OKF's own verified: examples assume,
                         not because a concrete caller exists.

-At: ISO 8601, defaults to the system clock at invocation. Deliberately
NOT git-log-sourced like Part A's generated.at - a verification event has
no necessary relationship to any commit (Cowork could verify a file
Claude Code committed three days ago), so it answers a different
question ("when did this verification act happen," not "when did this
file's content last change"). Reading the system clock is not the
self-report this project's anti-date-guessing rule targets - that rule
is about a model inferring a date from reasoning, not a script reading
the actual clock, same distinction Part A already relies on for
git log. Pass -At explicitly to record an event after the fact.

Append semantics:
  - No verified: key -> create fresh, one-item list.
  - verified: as a bare single mapping (the spec's own tolerated
    shorthand) -> converted to a proper list, existing entry preserved,
    new one appended.
  - verified: already a list -> appended.
  - Exact { by, at } duplicate -> skipped, reported, not re-appended
    (protects against an accidental double-run). A matching by with a
    different at is a genuine new event - always appended (OKF §5.2:
    "facts can be re-confirmed without regeneration").

Fail-loudly, not guessed: if verified: already exists but isn't one of
the two expected shapes (bare mapping, or a list of one-line { by, at }
flow mappings), this script refuses to touch the file - parsing and
mutating an already-populated list is a riskier operation than anything
else built in this family so far, and a wrong guess here would corrupt
real verification history, not just misformat a re-derivable field.

No precondition on role:/wrapper:/identity:/generated: already being
present - a legitimate re-check of an old, not-yet-migrated file is a
real case (someone verifying a claim without otherwise editing the
file), so this is deliberately not blocked. verified: appearing with no
generated: alongside it is an expected, valid combination, not a sign of
a broken file.

Usage:
  .\record-verification.ps1 -File "C:\path\to\file.md" -Wrapper Cowork -Identity "Claude, Anthropic"
  .\record-verification.ps1 -File "C:\path\to\file.md" -Wrapper Person -Identity Cameron -At "2026-07-20T10:00:00+10:00"
  .\record-verification.ps1 -File "C:\path\to\file.md" -Process function-b-state-check
#>

param(
    [Parameter(Mandatory=$true)][string]$File,
    [Parameter(Mandatory=$true, ParameterSetName="Actor")][string]$Wrapper,
    [Parameter(Mandatory=$true, ParameterSetName="Actor")][string]$Identity,
    [Parameter(Mandatory=$true, ParameterSetName="Process")][string]$Process,
    [string]$At
)

$marker = "# entries appended by record-verification.ps1 - do not hand-edit"

if (-not (Test-Path $File)) {
    Write-Output "FAILED: file not found: $File"
    exit 1
}
$fileItem = Get-Item $File

$content = [System.IO.File]::ReadAllText($fileItem.FullName, [System.Text.Encoding]::UTF8)

if ($content -notmatch '(?s)^---\r?\n(.*?)\r?\n---\r?\n') {
    Write-Output "FAILED: $($fileItem.Name) has no OKF frontmatter block"
    exit 1
}
$frontmatter = $Matches[1]
$fmLines = [System.Collections.Generic.List[string]]::new()
foreach ($l in ($frontmatter -split "`r?`n")) { $fmLines.Add($l) }

if ($PSCmdlet.ParameterSetName -eq "Process") {
    $by = "process:$Process"
} elseif ($Wrapper -eq "Person") {
    $slug = $Identity.ToLower() -replace '\s+', '-'
    $by = "human:$slug"
} else {
    $by = "$Wrapper/$Identity"
}

$at = if ([string]::IsNullOrWhiteSpace($At)) { (Get-Date).ToString("o") } else { $At }
$newEntryText = "{ by: $by, at: $at }"

# Locate any existing verified: field and classify its shape.
$verifiedLineIdx = -1
$verifiedShape = "none"      # none | bare | list | unrecognized
$listEntryIndices = New-Object System.Collections.Generic.List[int]
$listEndIdx = -1

for ($i = 0; $i -lt $fmLines.Count; $i++) {
    if ($fmLines[$i] -match '^verified:\s*\{.*\}\s*$') {
        $verifiedLineIdx = $i
        $verifiedShape = "bare"
        break
    }
    if ($fmLines[$i] -match '^verified:\s*(#.*)?$') {
        $verifiedLineIdx = $i
        $j = $i + 1
        $ok = $true
        while ($j -lt $fmLines.Count -and $fmLines[$j] -match '^\s') {
            if ($fmLines[$j] -match '^\s*-\s*\{.*\}\s*$') {
                $listEntryIndices.Add($j)
                $j++
            } else {
                $ok = $false
                break
            }
        }
        $listEndIdx = $j - 1
        $verifiedShape = if ($ok -and $listEntryIndices.Count -gt 0) { "list" } else { "unrecognized" }
        break
    }
    if ($fmLines[$i] -match '^verified:') {
        $verifiedLineIdx = $i
        $verifiedShape = "unrecognized"
        break
    }
}

if ($verifiedShape -eq "unrecognized") {
    Write-Output "FAILED: $($fileItem.Name) has a verified: field in a shape this script doesn't recognize (not a bare { by, at } mapping or a plain list of one-line { by, at } entries). Refusing to touch it - fix the shape by hand first, or this needs the script's parser extended, not a guess."
    exit 1
}

# Duplicate check against any existing entries (bare or list).
$existingEntries = New-Object System.Collections.Generic.List[string]
if ($verifiedShape -eq "bare") {
    $existingEntries.Add(($fmLines[$verifiedLineIdx] -replace '^verified:\s*', '' -replace '\s*' + [regex]::Escape($marker) + '\s*$', '').Trim())
} elseif ($verifiedShape -eq "list") {
    foreach ($idx in $listEntryIndices) {
        $existingEntries.Add(($fmLines[$idx] -replace '^\s*-\s*', '').Trim())
    }
}
if ($existingEntries -contains $newEntryText) {
    Write-Output "SKIPPED: $($fileItem.Name) already has an identical verified: entry ($newEntryText) - not duplicating. Pass a different -At if this is genuinely a new re-confirmation, not a re-run of the same one."
    exit 0
}

switch ($verifiedShape) {
    "none" {
        # Insert after generated: if present, else after identity:, else at
        # the end of frontmatter - same "sit next to related fields" instinct
        # as generate-provenance.ps1's insertion rule.
        $anchorIdx = -1
        for ($i = 0; $i -lt $fmLines.Count; $i++) {
            if ($fmLines[$i] -match '^generated:') { $anchorIdx = $i }
        }
        if ($anchorIdx -lt 0) {
            for ($i = 0; $i -lt $fmLines.Count; $i++) {
                if ($fmLines[$i] -match '^identity:') { $anchorIdx = $i }
            }
        }
        if ($anchorIdx -lt 0) { $anchorIdx = $fmLines.Count - 1 }
        $fmLines.InsertRange($anchorIdx + 1, [string[]]@("verified:  $marker", "  - $newEntryText"))
    }
    "bare" {
        $existingText = $existingEntries[0]
        $fmLines[$verifiedLineIdx] = "verified:  $marker"
        $fmLines.InsertRange($verifiedLineIdx + 1, [string[]]@("  - { $($existingText.Trim('{','}').Trim()) }", "  - $newEntryText"))
    }
    "list" {
        # Backfill the marker if this list predates this tool (hand-authored
        # or from an older run before the marker convention existed) - once
        # this script has touched a verified: block, the whole field should
        # consistently read as tool-managed, not just the newest line.
        if ($fmLines[$verifiedLineIdx] -notmatch [regex]::Escape($marker)) {
            $fmLines[$verifiedLineIdx] = "verified:  $marker"
        }
        $fmLines.Insert($listEndIdx + 1, "  - $newEntryText")
    }
}

$newFrontmatter = ($fmLines -join "`n")
$oldBlockPattern = '(?s)^---\r?\n' + [regex]::Escape($frontmatter) + '\r?\n---\r?\n'
$content = [regex]::Replace($content, $oldBlockPattern, "---`n$newFrontmatter`n---`n", 1)

$utf8NoBom = New-Object System.Text.UTF8Encoding($false)
[System.IO.File]::WriteAllText($fileItem.FullName, $content, $utf8NoBom)

Write-Output "OK: $($fileItem.Name) - appended $newEntryText (shape was: $verifiedShape)"
