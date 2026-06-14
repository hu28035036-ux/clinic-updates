[CmdletBinding(SupportsShouldProcess = $true)]
param(
    [int]$Keep = 10,
    [string]$Root = "",
    [switch]$Quiet
)

$ErrorActionPreference = "Stop"

if ($Keep -lt 1) {
    throw "Keep must be 1 or greater."
}

if (-not $Root) {
    $Root = Split-Path -Parent $PSScriptRoot
}

$Root = (Resolve-Path -LiteralPath $Root).Path
$namePattern = [regex]'(?i)^dosu_clinic_v(?<version>\d+(?:\.\d+){2,3})_(?<date>\d{8})\.zip$'
$items = @()
$ignored = @()

foreach ($file in Get-ChildItem -LiteralPath $Root -File -Filter "dosu_clinic_v*.zip") {
    $match = $namePattern.Match($file.Name)
    if (-not $match.Success) {
        $ignored += $file.Name
        continue
    }

    $versionParts = @($match.Groups["version"].Value.Split(".") | ForEach-Object { [int]$_ })
    while ($versionParts.Count -lt 4) {
        $versionParts += 0
    }

    $releaseDate = [datetime]::ParseExact(
        $match.Groups["date"].Value,
        "yyyyMMdd",
        [System.Globalization.CultureInfo]::InvariantCulture
    )

    $items += [pscustomobject]@{
        File = $file
        Name = $file.Name
        Major = $versionParts[0]
        Minor = $versionParts[1]
        Patch = $versionParts[2]
        Build = $versionParts[3]
        ReleaseDate = $releaseDate
        LastWriteTimeUtc = $file.LastWriteTimeUtc
    }
}

$sorted = @(
    $items | Sort-Object `
        @{ Expression = "Major"; Descending = $true },
        @{ Expression = "Minor"; Descending = $true },
        @{ Expression = "Patch"; Descending = $true },
        @{ Expression = "Build"; Descending = $true },
        @{ Expression = "ReleaseDate"; Descending = $true },
        @{ Expression = "LastWriteTimeUtc"; Descending = $true },
        @{ Expression = "Name"; Descending = $true }
)

$kept = @($sorted | Select-Object -First $Keep)
$pruned = @($sorted | Select-Object -Skip $Keep)

if (-not $Quiet) {
    Write-Host "Update ZIP retention"
    Write-Host "  Root       : $Root"
    Write-Host "  Policy     : keep latest $Keep ZIP file(s)"
    Write-Host "  Matched    : $($items.Count)"
    Write-Host "  Kept       : $($kept.Count)"
    Write-Host "  To prune   : $($pruned.Count)"
}

foreach ($item in $pruned) {
    if (-not $Quiet) {
        Write-Host "  prune      : $($item.Name)"
    }

    if ($PSCmdlet.ShouldProcess($item.File.FullName, "Remove old update ZIP")) {
        Remove-Item -LiteralPath $item.File.FullName
    }
}

if ((-not $Quiet) -and $ignored.Count -gt 0) {
    Write-Host "  ignored    : $($ignored -join ', ')"
}

