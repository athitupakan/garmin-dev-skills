# Release-stripped build (-r) for the active device -> bin\<project>-release.prg
# Use to verify the optimized binary still runs in the simulator BEFORE
# exporting a store .iq. Catches issues that -r introduces:
#   - type pruning removes code paths whose only callers were debug-only
#   - aggressive optimization can expose latent null-deref / type errors
#
# Does NOT push. To push the release binary manually:
#   . .\.claude\skills\garmin-dev\scripts\windows\_env.ps1
#   & "$Sdk\bin\monkeydo.bat" "bin\$Project-release.prg" $Device

. "$PSScriptRoot\_env.ps1"

if (-not (Test-Path bin)) { New-Item -ItemType Directory bin | Out-Null }

$ReleasePrg = "bin\$Project-release.prg"

& "$Sdk\bin\monkeyc.bat" -d $Device -f $Jungle -o $ReleasePrg -y $Key -r -l 2 -w
$code = $LASTEXITCODE

if ($code -eq 0 -and (Test-Path $ReleasePrg)) {
    $size = (Get-Item $ReleasePrg).Length
    "RELEASE BUILD OK -> $ReleasePrg ($([math]::Round($size/1KB,1)) KB)"
}

exit $code
