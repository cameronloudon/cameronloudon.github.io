<#
Reads each file's wrapper:/identity: frontmatter fields and emits/refreshes
a mechanically-derived generated: { by, at } frontmatter field, matching
OKF v0.2's real actor-identity convention exactly (nested mapping, not a
flat dotted key - corrected 2026-07-28 after direct verification against
the live spec found the original flat generated.by: shape didn't match).
wrapper:/identity: stay the single source of truth; generated: is derived
once and then left completely alone on every later run - no comparison,
no inference - unless the file is explicitly named via -ForceRestamp.
(Second correction, 2026-08-04: the first fix compared by: to detect
"nothing changed," but that fails the moment the same author genuinely
re-edits a file's content without changing wrapper:/identity: - caught
directly on decisions-archive.md, the same day the first fix shipped.
Considered two automatic-detection alternatives - a commit-diff walk, a
content hash - and rejected both in favor of an explicit signal: this
project already prefers stated-over-inferred wherever inference has a
real failure mode (role: not applicable stated rather than blank,
stage: as an explicit marker), and a diff-walk's specific failure mode
- confidently landing on a wrong date if it ever misjudges a commit -
is worse than staleness for a field whose whole job is being a
trustworthy record.)
Same relationship refs: already has to the
generated ## Links footer (generate-links-footer.ps1), applied to a
frontmatter field instead of a body-text footer. Full schema:
_ai-context/attribution-schema.md.

Derivation rule for the `by` half:
  wrapper: Person       -> by: human:<identity, lowercased, spaces to hyphens>
  any other wrapper:    -> by: <wrapper>/<identity> literally

Derivation rule for the `at` half: the file's own last-commit author date,
via `git log -1 --format=%aI -- <file>` - never a model-asserted date, per
this project's standing rule (the isolation safeguard, and Open Decision
#47's wrong-self-inferred-date finding, are the concrete reasons why).
This means the file must already have at least one commit before this
script can compute `at:` for it - a hard failure, not a guess, if it
doesn't. Documented workflow (Cowork's proposal, verified empirically
against a real git repo before adoption - author date is untouched by
--amend --no-edit, only committer date advances):
  1. Edit the file (add/change wrapper:/identity:), commit it normally -
     generated: will be stale, incomplete, or absent at this point, and
     that's fine.
  2. Run this script. `git log` now resolves against the commit just
     made, so `at:` matches that commit's real author date exactly.
  3. `git add` the file again, `git commit --amend --no-edit` - folds the
     derived generated: block into the same commit, one commit for the
     change, not two, and the `at:` value written in step 2 still matches
     the amended commit's author date exactly, since amend --no-edit
     never touches it.

index.md is skipped entirely - hand-written curation, not attribution
data. Files with neither wrapper: nor identity: are skipped (nothing to
derive - most files, since this field is forward-only per Open Decision
#58). Files with no OKF frontmatter block at all are also skipped, not
treated as an error, same reasoning as generate-links-footer.ps1. A file
with only one of wrapper:/identity: is a hard failure (fail loudly rather
than guess the missing half). A file with both but no git history yet is
also a hard failure (fail loudly rather than fabricate a timestamp) -
run this after the file's first commit, per the workflow above.

Usage:
  .\generate-provenance.ps1 -BundlePath "C:\path\to\_ai-context"
#>

param(
    [Parameter(Mandatory=$true)][string]$BundlePath,
    [string[]]$ForceRestamp = @()
)

$marker = "# generated from wrapper:+identity:+commit-date - do not hand-edit"
$files = Get-ChildItem -Path $BundlePath -Filter *.md | Where-Object { $_.Name -ne "index.md" }

$results = @()
$errors = @()

foreach ($f in $files) {
    $content = [System.IO.File]::ReadAllText($f.FullName, [System.Text.Encoding]::UTF8)

    if ($content -notmatch '(?s)^---\r?\n(.*?)\r?\n---\r?\n') {
        $results += [PSCustomObject]@{ File = $f.Name; Status = "skipped (no OKF frontmatter)"; Generated = "" }
        continue
    }
    $frontmatter = $Matches[1]
    $fmLines = $frontmatter -split "`r?`n"

    $wrapper = $null
    $identity = $null
    $identityLineIdx = -1
    $generatedLineIdx = -1
    $legacyGeneratedByLineIdx = -1

    for ($i = 0; $i -lt $fmLines.Count; $i++) {
        if ($fmLines[$i] -match '^wrapper:\s*(.+?)\s*$') {
            $wrapper = $Matches[1].Trim('"').Trim("'")
        } elseif ($fmLines[$i] -match '^identity:\s*(.+?)\s*$') {
            $identity = $Matches[1].Trim('"').Trim("'")
            $identityLineIdx = $i
        } elseif ($fmLines[$i] -match '^generated:') {
            $generatedLineIdx = $i
        } elseif ($fmLines[$i] -match '^generated\.by:') {
            # One-time migration: the original 2026-07-28 build wrote a flat
            # generated.by: key before the real spec's nested shape was
            # confirmed. Strip it rather than leave it sitting alongside the
            # new generated: block as dead, conflicting content.
            $legacyGeneratedByLineIdx = $i
        }
    }

    if ($legacyGeneratedByLineIdx -ge 0) {
        # Filter by index rather than slice - PowerShell's `0..-1` range
        # doesn't mean "empty," it wraps and returns [0, -1] (last element),
        # which would silently corrupt the very first line when the legacy
        # key happens to be at index 0.
        $keep = New-Object System.Collections.Generic.List[string]
        for ($j = 0; $j -lt $fmLines.Count; $j++) {
            if ($j -ne $legacyGeneratedByLineIdx) { $keep.Add($fmLines[$j]) }
        }
        $fmLines = $keep.ToArray()
        if ($generatedLineIdx -gt $legacyGeneratedByLineIdx) { $generatedLineIdx-- }
        if ($identityLineIdx -gt $legacyGeneratedByLineIdx) { $identityLineIdx-- }
    }

    if (-not $wrapper -and -not $identity) {
        $results += [PSCustomObject]@{ File = $f.Name; Status = "skipped (no wrapper:/identity:)"; Generated = "" }
        continue
    }

    if (-not $wrapper -or -not $identity) {
        $missing = if (-not $wrapper) { "wrapper:" } else { "identity:" }
        $errors += "$($f.Name): has one of wrapper:/identity: but not both - missing $missing"
        $results += [PSCustomObject]@{ File = $f.Name; Status = "FAILED - incomplete pair"; Generated = "" }
        continue
    }

    if ($wrapper -eq "Person") {
        $slug = $identity.ToLower() -replace '\s+', '-'
        $by = "human:$slug"
    } else {
        $by = "$wrapper/$identity"
    }

    # Explicit-signal guard (second correction, 2026-08-04) - a file with
    # generated: already present is always left alone, full stop, unless
    # named here. No by:/content comparison of any kind: the first fix's
    # by:-comparison approach silently skipped a genuine same-author
    # re-edit, since by: doesn't change when the author doesn't change.
    # Whoever just made a real edit is the only one who actually knows
    # it happened - they name the file, nothing is inferred. This also
    # means a malformed generated: line (present but not the expected
    # shape) is left alone by default too, not auto-fixed - fixing it
    # unasked would be exactly the kind of inference this guard exists
    # to eliminate.
    if ($generatedLineIdx -ge 0 -and $ForceRestamp -notcontains $f.Name) {
        $results += [PSCustomObject]@{ File = $f.Name; Status = "skipped (already stamped - not in -ForceRestamp)"; Generated = "" }
        continue
    }

    # -C targets the file's own directory explicitly - git log run from
    # wherever this script happens to be invoked (not necessarily inside
    # the bundle's own repo) silently found "no history" for a file that
    # genuinely had a commit, caught testing against a synthetic fixture
    # before trusting this against real files.
    $at = (git -C "$($f.DirectoryName)" log -1 --format=%aI -- "$($f.Name)") 2>$null
    if ([string]::IsNullOrWhiteSpace($at)) {
        $errors += "$($f.Name): wrapper:/identity: present but no git history for this file yet - commit it first, then run this script (see docstring workflow)"
        $results += [PSCustomObject]@{ File = $f.Name; Status = "FAILED - no commit history"; Generated = "" }
        continue
    }
    $at = $at.Trim()

    $generatedValue = "{ by: $by, at: $at }"
    $newLine = "generated: $generatedValue  $marker"

    if ($generatedLineIdx -ge 0) {
        $fmLines[$generatedLineIdx] = $newLine
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

    $results += [PSCustomObject]@{ File = $f.Name; Status = "OK"; Generated = $generatedValue }
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
Write-Output "Skipped (already stamped, not forced): $(@($results | Where-Object {$_.Status -eq 'skipped (already stamped - not in -ForceRestamp)'}).Count)"
Write-Output "Skipped (no OKF frontmatter): $(@($results | Where-Object {$_.Status -eq 'skipped (no OKF frontmatter)'}).Count)"
Write-Output "FAILED: $(@($results | Where-Object {$_.Status -like 'FAILED*'}).Count)"
if ($errors.Count -gt 0) {
    Write-Output "---ERRORS---"
    $errors | ForEach-Object { Write-Output $_ }
    exit 1
}
