# Watch source\ + resources\ — rebuild + re-push on file change. Polls every 2s.
# Prerequisite: simulator running (run.ps1 once first).
# Ctrl+C to stop. Background monkeydo job is cleaned up on exit.

. "$PSScriptRoot\_env.ps1"

if (-not (Test-Path bin)) { New-Item -ItemType Directory bin | Out-Null }

$monkeydoJob = $null

function Invoke-BuildAndPush {
    & "$Sdk\bin\monkeyc.bat" -d $Device -f $Jungle -o $Prg -y $Key
    if ($LASTEXITCODE -ne 0) {
        Write-Host "[$(Get-Date -Format HH:mm:ss)] BUILD FAILED" -ForegroundColor Red
        return
    }

    if ($script:monkeydoJob -and $script:monkeydoJob.State -eq 'Running') {
        Stop-Job   $script:monkeydoJob -ErrorAction SilentlyContinue
        Remove-Job $script:monkeydoJob -Force -ErrorAction SilentlyContinue
    }

    $script:monkeydoJob = Start-Job -ScriptBlock {
        param($sdk, $prg, $device, $jdk)
        $env:JAVA_HOME = $jdk
        $env:PATH = "$jdk\bin;$env:PATH"
        & "$sdk\bin\monkeydo.bat" $prg $device
    } -ArgumentList $Sdk, $Prg, $Device, $env:JAVA_HOME

    Write-Host "[$(Get-Date -Format HH:mm:ss)] PUSHED" -ForegroundColor Green
}

try {
    Write-Host "Watching source\ + resources\ — Ctrl+C to stop" -ForegroundColor Cyan
    Invoke-BuildAndPush
    $lastBuild = Get-Date

    while ($true) {
        Start-Sleep -Seconds 2
        $changes = Get-ChildItem source, resources -Recurse -File -ErrorAction SilentlyContinue |
                   Where-Object { $_.LastWriteTime -gt $lastBuild }
        if ($changes) {
            $names = ($changes | Select-Object -First 3).Name -join ', '
            Write-Host "[$(Get-Date -Format HH:mm:ss)] CHANGED: $names" -ForegroundColor Yellow
            Invoke-BuildAndPush
            $lastBuild = Get-Date
        }
    }
}
finally {
    if ($monkeydoJob) {
        Stop-Job   $monkeydoJob -ErrorAction SilentlyContinue
        Remove-Job $monkeydoJob -Force -ErrorAction SilentlyContinue
    }
}
