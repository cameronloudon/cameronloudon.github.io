<#
Reads each file's wrapper:/identity: frontmatter fields and emits/refreshes
a mechanically-derived generated.by: frontmatter field, OKF's own native
actor-identity convention. wrapper:/identity: stay the single source of
truth; generated.by: is always derived, never hand-edited - re-running
this script refreshes it in place rather than duplicating it. Same
relationship refs: already has to the generated ## Links footer
(generate-links-footer.ps1), applied to a frontmatter field instead of a
body-text footer. Full schema: _ai-context/attribution-schema.md.

Derivation rule:
  wrapper: Person       -> generated.by: "human:<identity, lowercased, spaces to hyphens>"
  any other wrapper:    -> generated.by: "<wrapper>/<identity>" literally

index.md is skipped entirely - hand-written curation, not attribution
data. Files with neither wrapper: nor identity: are skipped (nothing to
derive - most files, since this field is forward-only per Open Decision
#58). Files with no OKF frontmatter block at all are also skipped, not
treated as an error, same reasoning as generate-links-footer.ps1. A file
with only one of the pair present is a hard failure (fail loudly rather
than guess the missing half) - same fail-loudly design as the refs:
validator.

Usage:
  .\generate-provenance.ps1 -BundlePath "C:\path\to\_ai-context"
#>

param(
    [Parameter(Mandatory=$true)][string]$BundlePath
)

$marker = "# generated from wrapper:+identity: - do not hand-edit"
$files = Get-ChildItem -Path $BundlePath -Filter *.md | Where-Object { $_.Name -ne "index.md" }

$results = @()
$errors = @()

foreach ($f in $files) {
    $content = [System.IO.File]::ReadAllText($f.FullName, [System.Text.Encoding]::UTF8)

    if ($content -notmatch '(?s)^---\r?\n(.*?)\r?\n---\r?\n') {
        $results += [PSCustomObject]@{ File = $f.Name; Status = "skipped (no OKF frontmatter)"; GeneratedBy = "" }
        continue
    }
    $frontmatter = $Matches[1]
    $fmLines = $frontmatter -split "`r?`n"

    $wrapper = $null
    $identity = $null
    $wrapperLineIdx = -1
    $identityLineIdx = -1
    $generatedByLineIdx = -1

    for ($i = 0; $i -lt $fmLines.Count; $i++) {
        if ($fmLines[$i] -match '^wrapper:\s*(.+?)\s*$') {
            $wrapper = $Matches[1].Trim('"').Trim("'")
            $wrapperLineIdx = $i
        } elseif ($fmLines[$i] -match '^identity:\s*(.+?)\s*$') {
            $identity = $Matches[1].Trim('"').Trim("'")
            $identityLineIdx = $i
        } elseif ($fmLines[$i] -match '^generated\.by:') {
            $generatedByLineIdx = $i
        }
    }

    if (-not $wrapper -and -not $identity) {
        $results += [PSCustomObject]@{ File = $f.Name; Status = "skipped (no wrapper:/identity:)"; GeneratedBy = "" }
        continue
    }

    if (-not $wrapper -or -not $identity) {
        $missing = if (-not $wrapper) { "wrapper:" } else { "identity:" }
        $errors += "$($f.Name): has one of wrapper:/identity: but not both - missing $missing"
        $results += [PSCustomObject]@{ File = $f.Name; Status = "FAILED - incomplete pair"; GeneratedBy = "" }
        continue
    }

    if ($wrapper -eq "Person") {
        $slug = $identity.ToLower() -replace '\s+', '-'
        $generatedBy = "human:$slug"
    } else {
        $generatedBy = "$wrapper/$identity"
    }

    $newLine = "generated.by: `"$generatedBy`"  $marker"

    if ($generatedByLineIdx -ge 0) {
        $fmLines[$generatedByLineIdx] = $newLine
    } else {
        # Insert immediately after identity: so the derived field sits next to its source.
        $before = $fmLines[0..$identityLineIdx]
        $after = if ($identityLineIdx + 1 -lt $fmLines.Count) { $fmLines[($identityLineIdx + 1)..($fmLines.Count - 1)] } else { @() }
        $fmLines = $before + $newLine + $after
    }

    $newFrontmatter = ($fmLines -join "`n")
    $oldBlockPattern = '(?s)^---\r?\n' + [regex]::Escape($frontmatter) + '\r?\n---\r?\n'
    $content = [regex]::Replace($content, $oldBlockPattern, "---`n$newFrontmatter`n---`n", 1)

    $utf8NoBom = New-Object System.Text.UTF8Encoding($false)
    [System.IO.File]::WriteAllText($f.FullName, $content, $utf8NoBom)

    $results += [PSCustomObject]@{ File = $f.Name; Status = "OK"; GeneratedBy = $generatedBy }
}

$results | Format-Table -AutoSize
Write-Output "---"
Write-Output "Processed: $($files.Count) files (excluding index.md)"
# @(...) forces array context - a bare (...).Count on a Where-Object result
# that matches exactly one item returns $null instead of 1 in PowerShell 5.1
# (the same collection-semantics bug documented against cascade-check.ps1 and
# the identity-backfill script, Open Decisions #54/#58).
Write-Output "OK: $(@($results | Where-Object Status -eq 'OK').Count)"
Write-Output "Skipped (no wrapper:/identity:): $(@($results | Where-Object {$_.Status -eq 'skipped (no wrapper:/identity:)'}).Count)"
Write-Output "Skipped (no OKF frontmatter): $(@($results | Where-Object {$_.Status -eq 'skipped (no OKF frontmatter)'}).Count)"
Write-Output "FAILED: $(@($results | Where-Object {$_.Status -like 'FAILED*'}).Count)"
if ($errors.Count -gt 0) {
    Write-Output "---ERRORS---"
    $errors | ForEach-Object { Write-Output $_ }
    exit 1
}
