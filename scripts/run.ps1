# Get the directory of the current script
$SCRIPT_DIR = Split-Path -Parent $MyInvocation.MyCommand.Definition

# Change to the script directory
Set-Location -Path $SCRIPT_DIR

# Call env.ps1 (equivalent to call env.bat)
. "$SCRIPT_DIR\env.ps1"

# Check if JRE_DIR exists
if (Test-Path -Path $env:JRE_DIR) {
    Write-Host "Custom JRE found, setting JAVA_HOME to $env:JRE_DIR"
    $env:JAVA_HOME = $env:JRE_DIR
} else {
    Write-Host "No custom JRE found, using default JAVA_HOME"
}

# Set BSF4Rexx_JavaStartupOptions environment variable
$env:BSF4Rexx_JavaStartupOptions = "-cp $env:CLASSPATH;$env:LIB_DIR\*"

# Add JRE to the PATH
$env:PATH = "$env:JAVA_HOME\bin;$env:PATH"

# Call rexxj.sh
Start-Process "./rexxj.sh" -ArgumentList "MainApp.rex" -NoNewWindow
