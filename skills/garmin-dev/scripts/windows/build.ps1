# Compile source\ + resources\ -> bin\<project>.prg (debug build).
# Does not launch simulator. Does not push.

. "$PSScriptRoot\_env.ps1"

if (-not (Test-Path bin)) { New-Item -ItemType Directory bin | Out-Null }

# -l 2 = informative type check (warn on ambiguity)
# -w   = show build warnings
& "$Sdk\bin\monkeyc.bat" -d $Device -f $Jungle -o $Prg -y $Key -l 2 -w
exit $LASTEXITCODE
