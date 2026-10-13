# Requires PowerShell 5.1+; no Python required.
param(
    [Parameter(Mandatory=$true)][string]$ProfileDir,
    [switch]$Launch,
    [string]$FirefoxExe = ""
)
$ErrorActionPreference = 'Stop'
$root = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
$source = Join-Path $root 'config\user.js'
$guide = Join-Path $root 'extensions\install.html'
if (-not (Test-Path -LiteralPath $ProfileDir -PathType Container)) { throw 'Profile directory does not exist. Create it via about:profiles and provide its Root Directory.' }
$target = (Resolve-Path -LiteralPath $ProfileDir).Path
if (-not ((Test-Path -LiteralPath (Join-Path $target 'prefs.js')) -or (Test-Path -LiteralPath (Join-Path $target 'times.json')))) {
    throw 'Target does not look like an initialized Firefox profile. Launch it once and close Firefox before running the installer.'
}
Write-Host 'Close Firefox completely before continuing.'
$answer = Read-Host "Install into $target ? Type YES to continue"
if ($answer -cne 'YES') { Write-Host 'Cancelled.'; exit 1 }
$output = Join-Path $target 'user.js'
if (Test-Path -LiteralPath $output) {
    $backup = Join-Path $target ('user.js.backup-' + (Get-Date -Format 'yyyyMMdd-HHmmss'))
    Copy-Item -LiteralPath $output -Destination $backup
    Write-Host "Saved backup: $backup"
}
Copy-Item -LiteralPath $source -Destination $output
Write-Host "Installed: $output"
if ($Launch) {
    if (-not $FirefoxExe) {
        $candidates = @("$env:ProgramFiles\Mozilla Firefox\firefox.exe", "${env:ProgramFiles(x86)}\Mozilla Firefox\firefox.exe")
        $FirefoxExe = $candidates | Where-Object { $_ -and (Test-Path -LiteralPath $_ -PathType Leaf) } | Select-Object -First 1
    }
    if (-not $FirefoxExe -or -not (Test-Path -LiteralPath $FirefoxExe -PathType Leaf)) {
        Write-Warning 'Firefox executable not found. Launch the selected profile manually and open extensions/install.html.'
        exit 0
    }
    $uri = ([System.Uri](Resolve-Path -LiteralPath $guide).Path).AbsoluteUri
    Start-Process -FilePath $FirefoxExe -ArgumentList @('-no-remote','-profile',('"'+$target+'"'),('"'+$uri+'"'))
}
Write-Host 'Open extensions/install.html in your selected Firefox profile, and approve each add-on installation.'
