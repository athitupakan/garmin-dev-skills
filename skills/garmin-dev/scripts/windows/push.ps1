# Push existing bin\<project>.prg to a running simulator. No build.
# Blocks while monkeydo streams device logs. Ctrl+C to stop.

. "$PSScriptRoot\_env.ps1"

if (-not (Test-Path $Prg)) {
    Write-Host "No .prg at $Prg — run build.ps1 first." -ForegroundColor Red
    exit 1
}

if (-not (Get-Process simulator -ErrorAction SilentlyContinue)) {
    Write-Host "Simulator not running — launch via run.ps1 or open simulator.exe manually." -ForegroundColor Yellow
    exit 1
}

& "$Sdk\bin\monkeydo.bat" $Prg $Device
