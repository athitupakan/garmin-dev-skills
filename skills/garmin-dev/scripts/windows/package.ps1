# Store-ready .iq package (-e + -r) for ALL products listed in manifest.xml
# Output: bin\<project>.iq — upload at https://apps.garmin.com/en-US/developer/upload
#
# With -e / --package-app, monkeyc reads <iq:products> from manifest.xml and
# compiles a binary for each. Do NOT pass -d here — packaging targets every
# product at once.

. "$PSScriptRoot\_env.ps1"

if (-not (Test-Path bin)) { New-Item -ItemType Directory bin | Out-Null }

$IqFile = "bin\$Project.iq"

& "$Sdk\bin\monkeyc.bat" -e -f $Jungle -o $IqFile -y $Key -r -w
$code = $LASTEXITCODE

if ($code -eq 0 -and (Test-Path $IqFile)) {
    $size = (Get-Item $IqFile).Length
    "PACKAGE OK -> $IqFile ($([math]::Round($size/1KB,1)) KB)"
    "Upload at: https://apps.garmin.com/en-US/developer/upload"
}

exit $code
