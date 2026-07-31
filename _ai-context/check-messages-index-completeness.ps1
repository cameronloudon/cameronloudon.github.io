<#
.SYNOPSIS
    Open Decision #61. Report-only: confirms every real _messages/ file
    on disk has at least one corresponding entry link in index.md, and
    separately flags any index.md entry link pointing at a file that
    doesn't exist. Filename-level comparison only -- never reads the
    content of any individual message file, same cheap cost profile as
    function-b-state-check.ps1's other checks (confirmed directly before
    building this: a manual pre-build run of the same logic touched only
    index.md's own content plus a directory listing, nothing else).

.NOTES
    Entry links are matched only on real list-item lines (lines starting
    "- ["), not any [Title](./file.md)-shaped text anywhere in the
    document. index.md's own format-description prose near the top uses
    that exact literal shape as an illustrative example ("Each entry
    below is `[Title](./file.md)`") -- a naive whole-document regex
    would misreport that as a dangling reference to a file literally
    named "file.md" on every single run. Caught during the manual
    pre-build check (2026-07-31), before this script was ever written,
    not discovered the hard way after shipping it.

    Deliberately does not verify entry CORRECTNESS (right type, right
    refs, right thread placement) -- that's generate-index-entry.ps1's
    job (Open Decision #57). This script only answers "does an entry
    exist for this file at all," the category distinction this project
    already draws between record-verification.ps1 (checks what's there)
    and prescan-backlog.ps1 (surfaces what isn't yet).

    ASCII-only by the same deliberate choice as function-b-state-check.ps1
    and generate-index-entry.ps1 -- no BOM on this file, and Windows
    PowerShell 5.1 misreads non-ASCII source characters on a BOM-less
    file (Open Decision #39's bug class).

.USAGE
    .\check-messages-index-completeness.ps1 -RepoRoot "C:\path\to\repo"
#>

param(
    [string]$RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
)

$messagesDir = Join-Path $RepoRoot "_messages"
$indexPath = Join-Path $messagesDir "index.md"

if (-not (Test-Path $indexPath)) {
    Write-Error "index.md not found at $indexPath"
    exit 1
}

# Real files on disk, excluding index.md itself.
$diskFiles = @(Get-ChildItem $messagesDir -Filter "*.md" |
    Where-Object { $_.Name -ne "index.md" } |
    ForEach-Object { $_.Name }) | Sort-Object -Unique

# Entry links: only real list-item lines ("- [Title](./file.md) ..."),
# not any matching shape anywhere in the document -- see .NOTES above.
$indexLines = Get-Content $indexPath -Encoding UTF8
$linkedFiles = New-Object System.Collections.Generic.HashSet[string]
foreach ($line in $indexLines) {
    if ($line -match '^\s*-\s*\[') {
        $m = [regex]::Match($line, '\]\(\./([a-zA-Z0-9_.-]+\.md)\)')
        if ($m.Success) { [void]$linkedFiles.Add($m.Groups[1].Value) }
    }
}

$missing = @($diskFiles | Where-Object { -not $linkedFiles.Contains($_) })
$dangling = @($linkedFiles | Where-Object { $diskFiles -notcontains $_ } | Sort-Object)

Write-Output "=== Messages Index Completeness Check ==="
Write-Output "Files on disk (excl. index.md): $($diskFiles.Count)"
Write-Output "Distinct files linked from real entries in index.md: $($linkedFiles.Count)"
Write-Output ""

if ($missing.Count -eq 0) {
    Write-Output "OK -- every real file has a corresponding index.md entry."
} else {
    Write-Output "MISSING -- $($missing.Count) file(s) on disk with no index.md entry:"
    $missing | ForEach-Object { Write-Output "  - $_" }
}

Write-Output ""
if ($dangling.Count -eq 0) {
    Write-Output "OK -- no index.md entry points at a nonexistent file."
} else {
    Write-Output "DANGLING -- $($dangling.Count) index.md entry link(s) pointing at a nonexistent file:"
    $dangling | ForEach-Object { Write-Output "  - $_" }
}

Write-Output ""
Write-Output "Report-only -- nothing was written to any file."

if ($missing.Count -gt 0 -or $dangling.Count -gt 0) {
    exit 2
}
exit 0
