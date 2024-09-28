# Get the directory of the current script
$SCRIPT_DIR = Split-Path -Parent $MyInvocation.MyCommand.Definition

# Change to the script directory
Set-Location -Path $SCRIPT_DIR

# Call env.ps1 (equivalent to call env.bat)
. "$SCRIPT_DIR\env.ps1"

# Delete the JRE directory and all .jar files in the LIB_DIR
Remove-Item -Recurse -Force -Path $env:JRE_DIR
Remove-Item -Force -Path (Join-Path $env:LIB_DIR "*.jar")
