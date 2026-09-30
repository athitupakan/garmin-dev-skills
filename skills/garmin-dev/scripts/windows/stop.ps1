# Close the Connect IQ simulator and any monkeydo log streams.
# Does not need a project — runs from any directory.

$stopped = $false

$monkeydo = Get-CimInstance Win32_Process -Filter "Name = 'java.exe'" -ErrorAction SilentlyContinue |
            Where-Object { $_.CommandLine -match 'MonkeyDoDeux' }
foreach ($p in $monkeydo) {
    Stop-Process -Id $p.ProcessId -Force -ErrorAction SilentlyContinue
    $stopped = $true
}

$sim = Get-Process simulator -ErrorAction SilentlyContinue
if ($sim) {
    $sim | Stop-Process -Force -ErrorAction SilentlyContinue
    $stopped = $true
}

if ($stopped) {
    Write-Host "Simulator stopped." -ForegroundColor Green
} else {
    Write-Host "Simulator was not running." -ForegroundColor Yellow
}
