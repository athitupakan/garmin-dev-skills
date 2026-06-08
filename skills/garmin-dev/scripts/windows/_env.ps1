# Shared env + project config for garmin-dev scripts (Windows / PowerShell).
# Dot-source from sibling scripts:  . "$PSScriptRoot\_env.ps1"
#
# Auto-detects SDK + JDK at runtime so SDK upgrades / JDK reinstalls do not
# require editing this file. Override any of the variables below if you need
# something other than the default.
#
# Exports:
#   $Sdk      Connect IQ SDK root (newest installed)
#   $Project  binary name stem (defaults to project folder name, lowercase)
#   $Device   target device id (from manifest.xml first product)
#   $Prg      output .prg path
#   $Jungle   jungle file
#   $Key      developer key file

# ---- Project (override here if you want a different binary name) ----------
$Project = (Get-Item .).Name.ToLower()

# ---- JDK auto-detect ------------------------------------------------------
# Garmin Connect IQ SDK 9.x requires JDK 17 specifically. The `jdk-17*` glob
# patterns below are intentional, not lazy. If Garmin moves to a newer JDK in a
# future SDK release, update the glob and the JAVA_HOME version regex together.
function Find-Jdk {
    $candidates = @()
    if ($env:JAVA_HOME -and (Test-Path "$env:JAVA_HOME\bin\java.exe")) {
        # Verify version 17 -- JAVA_HOME may point at JDK 8/11/21 etc.; using
        # the wrong JDK makes monkeyc fail with cryptic class-version errors.
        $verOut = & "$env:JAVA_HOME\bin\java.exe" -version 2>&1 | Out-String
        if ($LASTEXITCODE -eq 0 -and $verOut -match 'version "17') {
            $candidates += $env:JAVA_HOME
        } else {
            Write-Warning "JAVA_HOME ($env:JAVA_HOME) is not JDK 17 -- skipping. Searching standard install paths..."
        }
    }
    $candidates += Get-ChildItem "$env:USERPROFILE\.jdks\*"                 -Directory -ErrorAction SilentlyContinue | Sort-Object Name -Descending | ForEach-Object FullName
    $candidates += Get-ChildItem "C:\Program Files\Microsoft\jdk-17*"       -Directory -ErrorAction SilentlyContinue | ForEach-Object FullName
    $candidates += Get-ChildItem "C:\Program Files\Eclipse Adoptium\jdk-17*" -Directory -ErrorAction SilentlyContinue | ForEach-Object FullName
    $candidates += Get-ChildItem "C:\Program Files\Java\jdk-17*"            -Directory -ErrorAction SilentlyContinue | ForEach-Object FullName
    foreach ($c in $candidates) {
        if ($c -and (Test-Path "$c\bin\java.exe")) { return $c }
    }
    return $null
}
$jdk = Find-Jdk
if (-not $jdk) {
    throw "JDK 17 not found. Install Microsoft OpenJDK 17 from https://learn.microsoft.com/java/openjdk/download or set JAVA_HOME to a valid JDK root."
}
$env:JAVA_HOME = $jdk
$env:PATH = "$jdk\bin;$env:PATH"

# ---- Connect IQ SDK auto-detect ------------------------------------------
$sdkRoot = "$env:APPDATA\Garmin\ConnectIQ\Sdks"
$Sdk = Get-ChildItem "$sdkRoot\connectiq-sdk-win-*" -Directory -ErrorAction SilentlyContinue |
       Sort-Object Name -Descending | Select-Object -First 1 -ExpandProperty FullName
if (-not $Sdk) {
    throw "Connect IQ SDK not found under $sdkRoot. Install via SDK Manager: https://developer.garmin.com/connect-iq/sdk/"
}

# ---- Device (from manifest.xml first product) ----------------------------
if (-not (Test-Path manifest.xml)) {
    throw "manifest.xml not found in current directory. Run scripts from the project root."
}
[xml]$manifest = Get-Content manifest.xml
$Device = ($manifest.manifest.application.products.product | Select-Object -First 1).id
if (-not $Device) {
    throw "No <iq:product> entries found in manifest.xml. Add at least one target device via the 'Monkey C: Edit Products' VSCode command."
}

# ---- Derived paths -------------------------------------------------------
$Prg    = "bin\$Project.prg"
$Jungle = "monkey.jungle"
$Key    = "developer_key"
