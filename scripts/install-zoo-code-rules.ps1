[CmdletBinding(SupportsShouldProcess = $true)]
param(
    [string]$SourceRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")),
    [switch]$InstallModes
)

$ErrorActionPreference = "Stop"

$sourceRules = Join-Path $SourceRoot ".roo\rules"
$sourceModes = Join-Path $SourceRoot ".roomodes"
$targetRoot = Join-Path $HOME ".roo"
$targetRules = Join-Path $targetRoot "rules"
$backupRoot = Join-Path $targetRoot ("backups\engineering-rules-" + (Get-Date -Format "yyyyMMdd-HHmmss"))

if (-not (Test-Path $sourceRules)) {
    throw "Shared Zoo rules were not found at $sourceRules"
}

New-Item -ItemType Directory -Force -Path $targetRoot | Out-Null
New-Item -ItemType Directory -Force -Path $targetRules | Out-Null

$ruleFiles = Get-ChildItem -Path $sourceRules -File -Recurse
foreach ($rule in $ruleFiles) {
    $relative = $rule.FullName.Substring($sourceRules.Length).TrimStart('\', '/')
    $destination = Join-Path $targetRules $relative
    $destinationDirectory = Split-Path $destination -Parent
    New-Item -ItemType Directory -Force -Path $destinationDirectory | Out-Null

    if (Test-Path $destination) {
        $backup = Join-Path $backupRoot (Join-Path "rules" $relative)
        $backupDirectory = Split-Path $backup -Parent
        New-Item -ItemType Directory -Force -Path $backupDirectory | Out-Null
        Copy-Item -Path $destination -Destination $backup -Force
    }

    if ($PSCmdlet.ShouldProcess($destination, "Install Zoo Code shared engineering rule")) {
        Copy-Item -Path $rule.FullName -Destination $destination -Force
    }
}

if ($InstallModes) {
    if (-not (Test-Path $sourceModes)) {
        throw "Project mode definition was not found at $sourceModes"
    }

    # Zoo Code's UI owns the exact global-mode settings file. To avoid clobbering
    # machine-specific state, install an import-ready copy rather than overwriting it.
    $modeImportPath = Join-Path $targetRoot "engineering-rules.roomodes.yaml"
    if (Test-Path $modeImportPath) {
        New-Item -ItemType Directory -Force -Path $backupRoot | Out-Null
        Copy-Item -Path $modeImportPath -Destination (Join-Path $backupRoot "engineering-rules.roomodes.yaml") -Force
    }

    if ($PSCmdlet.ShouldProcess($modeImportPath, "Install import-ready Zoo Code custom modes")) {
        Copy-Item -Path $sourceModes -Destination $modeImportPath -Force
    }
}

Write-Host "Zoo Code shared rules installed to: $targetRules"
if ($InstallModes) {
    Write-Host "Import-ready mode file written to: $modeImportPath"
    Write-Host "Import it through Zoo Code's Modes UI or copy selected modes into the target project's .roomodes file."
}
if (Test-Path $backupRoot) {
    Write-Host "Backups of replaced files are in: $backupRoot"
}
