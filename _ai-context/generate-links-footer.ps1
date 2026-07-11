<#
Reads each _messages/ file's refs: frontmatter and emits/refreshes a
generated ## Links footer of Obsidian [[wikilinks]], one per ref. refs:
stays the single source of truth; the footer is always derived, never
hand-edited - re-running this script refreshes it in place rather than
duplicating it.

Validates every ref resolves to a real file on disk, failing loudly
(non-zero exit, errors listed) rather than emitting a broken link.

index.md is skipped entirely - it is hand-written curation, not link
data. Files with no refs: field are skipped (nothing to link).

Usage:
  .\generate-links-footer.ps1 -BundlePath "C:\path\to\_messages"
#>

param(
    [Parameter(Mandatory=$true)][string]$BundlePath
)

$marker = "<!-- generated from refs: - do not hand-edit -->"
$files = Get-ChildItem -Path $BundlePath -Filter *.md | Where-Object { $_.Name -ne "index.md" }

$results = @()
$errors = @()

foreach ($f in $files) {
    $content = [System.IO.File]::ReadAllText($f.FullName, [System.Text.Encoding]::UTF8)

    if ($content -notmatch '(?s)^---\r?\n(.*?)\r?\n---\r?\n') {
        $errors += "$($f.Name): no frontmatter found"
        continue
    }
    $frontmatter = $Matches[1]

    $refLines = @()
    $inRefs = $false
    foreach ($line in ($frontmatter -split "`r?`n")) {
        if ($line -match '^refs:\s*$') { $inRefs = $true; continue }
        if ($inRefs) {
            if ($line -match '^\s*-\s*(.+?)\s*$') {
                $refLines += $Matches[1].Trim()
            } elseif ($line -match '^\S') {
                $inRefs = $false
            }
        }
    }

    if ($refLines.Count -eq 0) {
        $results += [PSCustomObject]@{ File = $f.Name; Status = "skipped (no refs)"; Links = 0 }
        continue
    }

    $wikilinks = @()
    $fileHadError = $false
    foreach ($ref in $refLines) {
        $resolved = [System.IO.Path]::GetFullPath((Join-Path $f.DirectoryName $ref))
        if (-not (Test-Path $resolved)) {
            $errors += "$($f.Name): refs: entry '$ref' does not resolve to $resolved"
            $fileHadError = $true
            continue
        }
        $wikilinks += [System.IO.Path]::GetFileNameWithoutExtension($resolved)
    }

    if ($fileHadError) {
        $results += [PSCustomObject]@{ File = $f.Name; Status = "FAILED - broken refs"; Links = $wikilinks.Count }
        continue
    }

    $footerLines = @("## Links", $marker)
    foreach ($w in $wikilinks) { $footerLines += "- [[$w]]" }
    $footer = ($footerLines -join "`n")

    $footerHeadingMarker = "`n## Links`n$marker"
    $existingIndex = $content.IndexOf($footerHeadingMarker)
    if ($existingIndex -ge 0) {
        $content = $content.Substring(0, $existingIndex)
    }

    $content = $content.TrimEnd() + "`n`n" + $footer + "`n"
    $utf8NoBom = New-Object System.Text.UTF8Encoding($false)
    [System.IO.File]::WriteAllText($f.FullName, $content, $utf8NoBom)

    $results += [PSCustomObject]@{ File = $f.Name; Status = "OK"; Links = $wikilinks.Count }
}

$results | Format-Table -AutoSize
Write-Output "---"
Write-Output "Processed: $($files.Count) files (excluding index.md)"
Write-Output "OK: $(($results | Where-Object Status -eq 'OK').Count)"
Write-Output "Skipped (no refs): $(($results | Where-Object {$_.Status -like 'skipped*'}).Count)"
Write-Output "FAILED: $(($results | Where-Object {$_.Status -like 'FAILED*'}).Count)"
if ($errors.Count -gt 0) {
    Write-Output "---ERRORS---"
    $errors | ForEach-Object { Write-Output $_ }
    exit 1
}
