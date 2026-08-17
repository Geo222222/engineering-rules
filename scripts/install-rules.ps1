param(
    [Parameter(Mandatory = $true)]
    [string]$TargetRepo,
    [switch]$Force
)

$ErrorActionPreference = "Stop"
$SourceRoot = Split-Path -Parent $PSScriptRoot
$TargetRepo = (Resolve-Path $TargetRepo).Path

$Files = @(
    "AGENTS.md",
    ".github/copilot-instructions.md",
    ".github/instructions/code-style.instructions.md",
    ".github/instructions/safety-architecture.instructions.md",
    ".github/instructions/workflow-testing.instructions.md",
    ".vscode/settings.json",
    "docs/engineering/ARCHITECTURE.md",
    "docs/engineering/PRODUCT.md",
    "docs/engineering/TESTING.md",
    "docs/engineering/PROJECT_OVERRIDES.md"
)

foreach ($RelativePath in $Files) {
    $Source = Join-Path $SourceRoot $RelativePath
    $Destination = Join-Path $TargetRepo $RelativePath
    $DestinationDir = Split-Path -Parent $Destination

    if ((Test-Path $Destination) -and -not $Force) {
        throw "Refusing to overwrite existing file: $Destination. Re-run with -Force only after reviewing the existing project rules."
    }

    New-Item -ItemType Directory -Path $DestinationDir -Force | Out-Null
    Copy-Item $Source $Destination -Force
    Write-Host "Installed $RelativePath"
}

Write-Host "Engineering rules installed into $TargetRepo"
Write-Host "Next: replace docs/engineering templates with facts derived from the target repository."
