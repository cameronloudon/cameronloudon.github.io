<#
Surfaces other Open Decision rows (and archived decisions) that share a
backtick-quoted term - tool name, file path, or "#N" cross-reference - with
the decision being patched or closed, so a cascade effect isn't missed from
memory alone. Surfacing is mechanical; whether a flagged candidate actually
needs updating is still a judgment call for whoever runs this.

Filtering is frequency-based, not a hand-maintained stopword list: a term
is only surfaced if it appears in -MaxOccurrences or fewer entries total
(open + archived). Ubiquitous structural vocabulary (AI_INSTRUCTIONS.md,
refs:, boilerplate like "See decisions-archive.md") naturally appears in
many entries and gets filtered out on its own - nobody has to remember to
maintain an exclusion list as new common terms show up.

Mandatory sub-step of the Session-Close Protocol's step 2 ("Update Open
Decisions if any were resolved or newly raised") - see CLAUDE.md - not a
standalone tool someone has to remember to invoke separately (Open Decision
#54, following the #52 lesson: "remember to run it" is the exact failure
shape this exists to prevent).

Usage:
  .\_ai-context\cascade-check.ps1 -DecisionNumber 38
  .\_ai-context\cascade-check.ps1 -DecisionNumber 38 -MaxOccurrences 6
#>

param(
    [Parameter(Mandatory=$true)][int]$DecisionNumber,
    [int]$MaxOccurrences = 4
)

$projectState = "PROJECT_STATE.md"
$archive = "_ai-context/decisions-archive.md"

$stateLines = Get-Content $projectState
$rowLine = $stateLines | Where-Object { $_ -match "^\| $DecisionNumber \| " } | Select-Object -First 1

if (-not $rowLine) {
    Write-Error "Decision #$DecisionNumber not found as an open row in $projectState (already archived, or doesn't exist)."
    exit 1
}

$openRows = [ordered]@{}
foreach ($line in $stateLines) {
    if ($line -match "^\| (\d+) \| ") { $openRows[$Matches[1]] = $line }
}

$archiveBlocks = [ordered]@{}
if (Test-Path $archive) {
    $archiveLines = Get-Content $archive
    $currentNum = $null
    $buffer = [System.Text.StringBuilder]::new()
    foreach ($aline in $archiveLines) {
        if ($aline -match "^## Decision #(\d+)") {
            if ($currentNum) { $archiveBlocks[$currentNum] = $buffer.ToString() }
            $currentNum = $Matches[1]
            $buffer = [System.Text.StringBuilder]::new()
            continue
        }
        if ($currentNum) { [void]$buffer.AppendLine($aline) }
    }
    if ($currentNum) { $archiveBlocks[$currentNum] = $buffer.ToString() }
}

$candidateTerms = [regex]::Matches($rowLine, '`([^`]+)`') | ForEach-Object { $_.Groups[1].Value } | Select-Object -Unique
$hashRefMatches = [regex]::Matches($rowLine, '#(\d+)') | ForEach-Object { $_.Groups[1].Value } | Where-Object { $_ -ne "$DecisionNumber" } | Select-Object -Unique

if ($candidateTerms.Count -eq 0 -and $hashRefMatches.Count -eq 0) {
    Write-Output "No backtick-quoted terms or '#N' cross-references found in #${DecisionNumber}'s row - nothing to cross-check."
    exit 0
}

$terms = @()
foreach ($term in $candidateTerms) {
    $escaped = [regex]::Escape($term)
    $count = 0
    foreach ($num in $openRows.Keys) { if ($openRows[$num] -match $escaped) { $count++ } }
    foreach ($num in $archiveBlocks.Keys) { if ($archiveBlocks[$num] -match $escaped) { $count++ } }
    if ($count -ge 1 -and $count -le $MaxOccurrences) { $terms += $term }
}

Write-Output "Terms extracted from #${DecisionNumber} (dropping anything appearing in more than $MaxOccurrences entries total, as structural noise):"
$terms | ForEach-Object { Write-Output "  - ``$_``" }
$hashRefMatches | ForEach-Object { Write-Output "  - #$_ (direct cross-reference)" }
Write-Output ""

$candidates = [ordered]@{}
function Add-Candidate($num, $term, $source) {
    if ($num -eq "$DecisionNumber") { return }
    $key = "$source #$num"
    if (-not $candidates.Contains($key)) { $candidates[$key] = [System.Collections.Generic.List[string]]::new() }
    if (-not $candidates[$key].Contains($term)) { $candidates[$key].Add($term) }
}

foreach ($term in $terms) {
    $escaped = [regex]::Escape($term)
    foreach ($num in $openRows.Keys) {
        if ($openRows[$num] -match $escaped) { Add-Candidate $num $term "PROJECT_STATE.md" }
    }
    foreach ($num in $archiveBlocks.Keys) {
        if ($archiveBlocks[$num] -match $escaped) { Add-Candidate $num $term "decisions-archive.md" }
    }
}

foreach ($num in $hashRefMatches) {
    if ($openRows.Contains($num)) {
        Add-Candidate $num "#$num cross-ref" "PROJECT_STATE.md"
    } elseif ($archiveBlocks.Contains($num)) {
        Add-Candidate $num "#$num cross-ref" "decisions-archive.md"
    }
}

if ($candidates.Count -eq 0) {
    Write-Output "No other decision shares a distinctive term or cross-reference with #${DecisionNumber}. Nothing flagged."
} else {
    Write-Output "Candidates sharing terms with #${DecisionNumber} - review, don't auto-update:"
    foreach ($key in $candidates.Keys) {
        Write-Output "  $key - shared: $($candidates[$key] -join ', ')"
    }
}
