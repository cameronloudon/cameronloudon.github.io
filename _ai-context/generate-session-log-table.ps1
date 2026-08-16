<#
Regenerates PROJECT_STATE.md's "_session-logs/ collection" table from the
real files on disk in _session-logs/, replacing the content between two
marker comments in place. The table has no other source of truth - every
row is just "does this file exist," which is exactly the kind of fact a
script should read off disk rather than have hand-typed, after two real
incidents (2026-07-24, recurred 2026-08-02) of rows silently going missing
because it was maintained by hand.

Fails loudly (non-zero exit) if the markers aren't found in PROJECT_STATE.md,
rather than silently doing nothing or appending a duplicate table.

Usage:
  .\generate-session-log-table.ps1 -ProjectStatePath "C:\path\to\PROJECT_STATE.md" -SessionLogsPath "C:\path\to\_session-logs"
#>

param(
    [Parameter(Mandatory=$true)][string]$ProjectStatePath,
    [Parameter(Mandatory=$true)][string]$SessionLogsPath
)

$beginMarker = "<!-- BEGIN GENERATED: session-logs-table (generate-session-log-table.ps1) - do not hand-edit -->"
$endMarker = "<!-- END GENERATED: session-logs-table -->"

if (-not (Test-Path $ProjectStatePath)) {
    Write-Error "PROJECT_STATE.md not found at $ProjectStatePath"
    exit 1
}
if (-not (Test-Path $SessionLogsPath)) {
    Write-Error "_session-logs/ not found at $SessionLogsPath"
    exit 1
}

# Resolve to absolute paths before any [System.IO.File] call - PowerShell's own
# working directory (what Test-Path/Resolve-Path use) and .NET's
# Environment.CurrentDirectory are not guaranteed to be the same directory, so
# a relative path handed straight to a .NET method can silently resolve
# somewhere else entirely. Found live: a first run against ".\PROJECT_STATE.md"
# read nothing (wrong resolved path), then $null-concatenated its way past
# PowerShell's own null-propagation into a stray file written to
# "_ai-context\PROJECT_STATE.md" instead of erroring - fixed by removing the
# stray file and resolving both paths up front instead of trusting the caller's
# relative path all the way through.
$ProjectStatePath = (Resolve-Path $ProjectStatePath).Path
$SessionLogsPath = (Resolve-Path $SessionLogsPath).Path

$files = Get-ChildItem -Path $SessionLogsPath -Filter "*.md" | Sort-Object Name

if ($files.Count -eq 0) {
    Write-Error "No session-log files found in $SessionLogsPath - refusing to write an empty table (likely a wrong path, not an empty collection)"
    exit 1
}

$tableLines = @("| File | Status |", "|---|---|")
foreach ($f in $files) {
    $tableLines += "| ``$($f.Name)`` | Published |"
}
$tableBlock = ($tableLines -join "`n")

$content = [System.IO.File]::ReadAllText($ProjectStatePath, [System.Text.Encoding]::UTF8)

$beginIdx = $content.IndexOf($beginMarker)
$endIdx = $content.IndexOf($endMarker)

if ($beginIdx -eq -1 -or $endIdx -eq -1) {
    Write-Error "Markers not found in PROJECT_STATE.md - expected both:`n$beginMarker`n$endMarker`nRefusing to guess where the table belongs."
    exit 1
}
if ($endIdx -lt $beginIdx) {
    Write-Error "END marker appears before BEGIN marker - PROJECT_STATE.md is malformed, refusing to write."
    exit 1
}

$before = $content.Substring(0, $beginIdx + $beginMarker.Length)
$after = $content.Substring($endIdx)

$newContent = $before + "`n" + $tableBlock + "`n" + $after

$utf8NoBom = New-Object System.Text.UTF8Encoding($false)
[System.IO.File]::WriteAllText($ProjectStatePath, $newContent, $utf8NoBom)

Write-Output "Session-log files found on disk: $($files.Count)"
Write-Output "Table rows written: $($files.Count)"
Write-Output "PROJECT_STATE.md updated: $ProjectStatePath"
exit 0
