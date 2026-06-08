# Full cycle: ensure simulator running, compile, push. Idempotent.
# Blocks at the end while monkeydo streams device logs. Ctrl+C to stop.

. "$PSScriptRoot\_env.ps1"

if (-not (Test-Path bin)) { New-Item -ItemType Directory bin | Out-Null }

if (-not (Get-Process simulator -ErrorAction SilentlyContinue)) {
    Write-Host "Launching simulator..." -ForegroundColor Cyan
    # cmd /c start truly detaches — Start-Process would link the sim to this
    # ps1's process tree, so killing the script would kill the sim too.
    cmd /c start "" "$Sdk\bin\simulator.exe"
    Start-Sleep -Seconds 2
}

Write-Host "Compiling..." -ForegroundColor Cyan
& "$Sdk\bin\monkeyc.bat" -d $Device -f $Jungle -o $Prg -y $Key
if ($LASTEXITCODE -ne 0) {
    Write-Host "BUILD FAILED (exit $LASTEXITCODE)" -ForegroundColor Red
    exit $LASTEXITCODE
}

Write-Host "Pushing to simulator (Ctrl+C to stop)..." -ForegroundColor Green
& "$Sdk\bin\monkeydo.bat" $Prg $Device
