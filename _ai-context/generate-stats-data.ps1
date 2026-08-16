<#
.SYNOPSIS
    Generates the small JSON data file the public /stats/ page reads.
    The one script in this family whose designed job is to write real
    output data, not just report -- same "mechanical, never hand-edited"
    principle as generate-links-footer.ps1/generate-provenance.ps1, applied
    to site content instead of frontmatter.

.NOTES
    Run at session-close, alongside the other PROJECT_STATE.md updates --
    not a live backend, not a GitHub Action. Cameron's explicit "keep it
    simple" direction for this page.

    Computed fields, all mechanical, all re-derivable from repo state --
    nothing here is asserted or guessed:
      sessions_logged    - count of _session-logs/session-*.md files on disk
      articles_published - real entries in _ideas/, _signals/, _now/,
                            _skills/, excluding each collection's own
                            hand-written index (index.html/signals.html/
                            now.html) -- these are the collection's own
                            index, not an article
      messages_archived  - count of _messages/*.md files, excluding
                            index.md (an index is not an archived exchange)
      open_decisions     - count of PROJECT_STATE.md Open Decisions rows
                            whose Gate column isn't the closed-decision
                            em-dash marker

    Additional mechanical counts (added 2026-08-04):
      discussion_threads - count of "## Thread" headers in _messages/index.md
      tooling_scripts    - count of _ai-context/*.ps1 files
      independent_reviews - count of "role: Review" frontmatter lines
                             across _messages/*.md (excluding index.md)

    whats_next is NOT computed here -- it's hand-rewritten in full into
    _data/stats.json, by whoever closes the session, BEFORE this script
    runs (translating PROJECT_STATE.md's live Open Decisions into plain
    English -- real editorial content, same content/HTML boundary this
    project already draws elsewhere). This script only validates that
    array's length against open_decisions and fails loudly on a mismatch
    -- it never invents or silently trusts the array's content, only
    checks a countable fact about it, then carries it forward unchanged.

    gibberish_decoded and recent_catches are forward-only tallies, same
    principle as growth_history: summed/collected from two new mandatory
    Validation Record lines (_ai-context/rct-validation-checklist.md)
    across every _session-logs/*.md whose own date: frontmatter is
    2026-08-04 or later -- never backfilled against older logs that
    predate this convention. recent_catches keeps the 5 most recent
    "Yes" entries; gibberish_decoded sums every numeric entry, "No"/0
    included, since an explicit zero is real data, not nothing.

    Growth history: appends today's messages_archived count to
    _ai-context/stats-history.json if today's date isn't already recorded
    (re-running the same day updates today's entry rather than
    duplicating it). Seeded once, 2026-07-31, with four real historical
    checkpoints mined directly from git log on PROJECT_STATE.md's own
    text -- exact commit hashes cited in the seed data, not fabricated,
    and not full archaeology either: four verified points, not forty
    guessed ones.

    ASCII-only by the same deliberate choice as function-b-state-check.ps1
    and generate-index-entry.ps1 -- this file has no BOM, and Windows
    PowerShell 5.1 misreads non-ASCII source characters on a BOM-less
    file (Open Decision #39's bug class).

.USAGE
    .\generate-stats-data.ps1 -RepoRoot "C:\path\to\repo"
#>

param(
    [string]$RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
)

function Get-RealEntryCount {
    param([string]$Folder, [string]$IndexFileName)
    if (-not (Test-Path $Folder)) { return 0 }
    $items = Get-ChildItem $Folder | Where-Object { $_.Name -ne $IndexFileName }
    return @($items).Count
}

# ------------------------------------------------------------------
# Mechanical counts
# ------------------------------------------------------------------
$sessionLogsDir = Join-Path $RepoRoot "_session-logs"
$sessionsLogged = @(Get-ChildItem $sessionLogsDir -Filter "session-*.md" -ErrorAction SilentlyContinue).Count

$articlesPublished = 0
$articlesPublished += Get-RealEntryCount (Join-Path $RepoRoot "_ideas") "index.html"
$articlesPublished += Get-RealEntryCount (Join-Path $RepoRoot "_signals") "signals.html"
$articlesPublished += Get-RealEntryCount (Join-Path $RepoRoot "_now") "now.html"
$articlesPublished += Get-RealEntryCount (Join-Path $RepoRoot "_skills") "index.html"

$messagesDir = Join-Path $RepoRoot "_messages"
$messagesArchived = @(Get-ChildItem $messagesDir -Filter "*.md" -ErrorAction SilentlyContinue |
    Where-Object { $_.Name -ne "index.md" }).Count

# Open Decisions: cross-reference PROJECT_STATE.md's Open Decisions table
# against decisions-archive.md's own "## Decision #N" headers, rather
# than parsing PROJECT_STATE.md's Gate column at all. Tried Gate-column
# parsing first (Gate == em-dash meaning closed) and it undercounted --
# #56 is genuinely still open (real design questions live in its Owner
# column) but its own Gate field is just an em-dash, the same shape as a
# fully archived row. The table's own per-row convention isn't
# consistent enough for a single-column rule to read reliably. What IS
# reliable: decisions-archive.md is this project's own authoritative
# record of what's actually resolved -- a decision number appears there
# if and only if it's closed. Verified directly before trusting this:
# table currently lists #1-61, archive lists everything in that range
# except {48, 56, 61} -- exactly the three real open decisions.
$projectStatePath = Join-Path $RepoRoot "PROJECT_STATE.md"
$archivePath = Join-Path $RepoRoot "_ai-context\decisions-archive.md"

$tableNumbers = [regex]::Matches((Get-Content $projectStatePath -Raw -Encoding UTF8), '(?m)^\|\s*(\d+)\s*\|') |
    ForEach-Object { [int]$_.Groups[1].Value } | Select-Object -Unique

$archivedNumbers = [regex]::Matches((Get-Content $archivePath -Raw -Encoding UTF8), '(?m)^## Decision #(\d+)') |
    ForEach-Object { [int]$_.Groups[1].Value } | Select-Object -Unique

$openDecisions = @($tableNumbers | Where-Object { $archivedNumbers -notcontains $_ }).Count

# discussion_threads: real "## Thread N" headers in _messages/index.md
$indexPath = Join-Path $RepoRoot "_messages\index.md"
$discussionThreads = @([regex]::Matches((Get-Content $indexPath -Raw -Encoding UTF8), '(?m)^## Thread \d+')).Count

# tooling_scripts: the _ai-context/*.ps1 family itself
$toolingScripts = @(Get-ChildItem (Join-Path $RepoRoot "_ai-context") -Filter "*.ps1" -ErrorAction SilentlyContinue).Count

# independent_reviews: role: Review frontmatter lines across _messages/,
# excluding index.md (hand-written curation, not a promoted record)
$independentReviews = @(Get-ChildItem $messagesDir -Filter "*.md" -ErrorAction SilentlyContinue |
    Where-Object { $_.Name -ne "index.md" } |
    ForEach-Object { Get-Content $_.FullName -Raw -Encoding UTF8 } |
    Select-String -Pattern '(?m)^role:\s*Review\s*$').Count

# whats_next: validated, not computed -- see docstring. Read whatever is
# already sitting in the existing stats.json (hand-rewritten earlier in
# this same session-close sequence) and fail loudly if its length doesn't
# match the live open-decision count, rather than silently trusting it.
$whatsNext = @()
$existingDataPath = Join-Path $RepoRoot "_data\stats.json"
if (Test-Path $existingDataPath) {
    $existingData = Get-Content $existingDataPath -Raw -Encoding UTF8 | ConvertFrom-Json
    if ($existingData.whats_next) { $whatsNext = @($existingData.whats_next) }
}
if (@($whatsNext).Count -ne $openDecisions) {
    Write-Output "FAILED: whats_next in _data/stats.json has $(@($whatsNext).Count) entries, but $openDecisions decisions are currently open."
    Write-Output "Hand-rewrite the whats_next array in _data/stats.json to match PROJECT_STATE.md's live Open Decisions before running this script."
    exit 1
}

# gibberish_decoded / recent_catches: forward-only, from session logs
# dated 2026-08-04 or later (this convention's own start date -- see
# docstring). Parsed from each log's own date: frontmatter, not its
# filename, since filenames use the reserved-ID-vs-actual-date pattern
# and don't reliably reflect when the session's real work happened.
$tallyStartDate = [datetime]"2026-08-04"
$gibberishDecoded = 0
$catchCandidates = New-Object System.Collections.Generic.List[object]

$logFiles = Get-ChildItem $sessionLogsDir -Filter "session-*.md" -ErrorAction SilentlyContinue
foreach ($log in $logFiles) {
    $logContent = Get-Content $log.FullName -Raw -Encoding UTF8

    $dateMatch = [regex]::Match($logContent, '(?m)^date:\s*(\S+)\s*$')
    if (-not $dateMatch.Success) { continue }
    # Plain [datetime] cast in a try/catch, not TryParse -- the 2-arg
    # TryParse(string, [ref]datetime) overload doesn't resolve on this
    # PowerShell version (caught by actually running this against real
    # session logs, not assumed to work from the method signature alone).
    $logDate = $null
    try { $logDate = [datetime]$dateMatch.Groups[1].Value } catch { continue }
    if ($logDate -lt $tallyStartDate) { continue }

    $sessionIdMatch = [regex]::Match($logContent, '(?m)^session_id:\s*(\S+)\s*$')
    $sessionId = if ($sessionIdMatch.Success) { $sessionIdMatch.Groups[1].Value } else { $log.BaseName }

    $gibberishMatch = [regex]::Match($logContent, '(?m)^\s*-\s*\*\*Gibberish decoded:\*\*\s*(\d+)')
    if ($gibberishMatch.Success) { $gibberishDecoded += [int]$gibberishMatch.Groups[1].Value }

    $catchMatch = [regex]::Match($logContent, ('(?m)^\s*-\s*\*\*Caught and fixed \(public\):\*\*\s*Yes\s*[-' + [char]0x2014 + ']\s*(.+)$'))
    if ($catchMatch.Success) {
        $catchCandidates.Add([ordered]@{
            date        = $logDate.ToString("yyyy-MM-dd")
            session     = $sessionId
            description = $catchMatch.Groups[1].Value.Trim()
        })
    }
}

# Explicit List[object], not a bare pipeline result -- an empty pipeline
# result serialized to {} instead of [] via ConvertTo-Json when nested as
# a hashtable property value, the same PowerShell 5.1 array-wrapping
# ambiguity $historyList was already built to avoid above. Caught by
# running this against the real (currently empty) tally, not assumed.
[System.Collections.Generic.List[object]]$recentCatches = @($catchCandidates | Sort-Object { [datetime]$_.date } -Descending | Select-Object -First 5)

# ------------------------------------------------------------------
# Growth history -- seed once, then append
# ------------------------------------------------------------------
$historyPath = Join-Path $RepoRoot "_ai-context\stats-history.json"
if (-not (Test-Path $historyPath)) {
    # Four real checkpoints, mined from git log on PROJECT_STATE.md's own
    # text, 2026-07-31. Each date is the commit's real author date; each
    # count is the bundle total that commit's own text states as current.
    $seed = @(
        [ordered]@{ date = "2026-07-09"; count = 8;   commit = "a40a56c"; note = "Piloted, small slice" }
        [ordered]@{ date = "2026-07-27"; count = 58;  commit = "faaf66f"; note = "Mechanical inventory correction (8 listed vs 58 real)" }
        [ordered]@{ date = "2026-07-29"; count = 476; commit = "f415f97"; note = "Historical backlog closed out" }
        [ordered]@{ date = "2026-07-31"; count = 495; commit = "ba19ae8"; note = "Backlog regrowth cleared to zero" }
    )
    $seed | ConvertTo-Json | Set-Content -Path $historyPath -Encoding UTF8
}

$today = Get-Date -Format "yyyy-MM-dd"
# Explicit List[object] + foreach, not @(...) array coercion -- @() around
# a ConvertFrom-Json array result hit a real PowerShell 5.1 quirk in
# testing (produced one wrapper element shaped {value: [...], Count: N}
# instead of a flat array), and a piped Where-Object result separately
# hit "'count' is a ReadOnly property" when mutated in place. A plain
# List with foreach/.Add() sidesteps both ambiguities rather than
# depending on which array shape PowerShell's pipeline happens to hand
# back for a given input size.
$rawHistory = Get-Content $historyPath -Encoding UTF8 -Raw | ConvertFrom-Json
$historyList = New-Object System.Collections.Generic.List[object]
foreach ($item in $rawHistory) {
    if ($item.date -ne $today) { $historyList.Add($item) }
}
$historyList.Add([ordered]@{ date = $today; count = $messagesArchived; commit = $null; note = $null })
$history = $historyList
$history | ConvertTo-Json | Set-Content -Path $historyPath -Encoding UTF8

# ------------------------------------------------------------------
# Write the page's data file
# ------------------------------------------------------------------
$dataPath = Join-Path $RepoRoot "_data\stats.json"
$dataDir = Split-Path $dataPath -Parent
if (-not (Test-Path $dataDir)) { New-Item -ItemType Directory -Path $dataDir -Force | Out-Null }

$output = [ordered]@{
    generated_at        = (Get-Date -Format "yyyy-MM-ddTHH:mm:sszzz")
    sessions_logged     = $sessionsLogged
    articles_published  = $articlesPublished
    messages_archived   = $messagesArchived
    open_decisions      = $openDecisions
    discussion_threads  = $discussionThreads
    tooling_scripts     = $toolingScripts
    independent_reviews = $independentReviews
    gibberish_decoded   = $gibberishDecoded
    whats_next          = $whatsNext
    recent_catches      = $recentCatches
    growth_history      = $history
}
$output | ConvertTo-Json -Depth 5 | Set-Content -Path $dataPath -Encoding UTF8

Write-Output "=== Stats data generated ==="
Write-Output "Sessions logged: $sessionsLogged"
Write-Output "Articles published: $articlesPublished"
Write-Output "Messages archived: $messagesArchived"
Write-Output "Open decisions: $openDecisions"
Write-Output "Discussion threads: $discussionThreads"
Write-Output "Tooling scripts: $toolingScripts"
Write-Output "Independent reviews: $independentReviews"
Write-Output "Gibberish decoded (total): $gibberishDecoded"
Write-Output "What's Next entries: $(@($whatsNext).Count) (validated against $openDecisions open decisions)"
Write-Output "Recent catches surfaced: $(@($recentCatches).Count)"
Write-Output "Growth history: $($history.Count) points, latest = $today : $messagesArchived"
Write-Output "Written to: $dataPath"
Write-Output "History file: $historyPath"
exit 0
