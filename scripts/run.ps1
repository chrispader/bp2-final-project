# Get the directory of the current script
$SCRIPT_DIR = Split-Path -Parent $MyInvocation.MyCommand.Definition

. "$SCRIPT_DIR\env.ps1"

# Check if JRE_DIR exists
if (Test-Path -Path $env:JRE_DIR) {
    Write-Host "Custom JRE found, setting JAVA_HOME to $env:JRE_DIR"
    $env:JAVA_HOME = $env:JRE_DIR
} else {
    Write-Host "No custom JRE found, using default JAVA_HOME"
}

$env:BSF4Rexx_JavaStartupOptions = "-cp `"$env:CLASSPATH`";`"$env:LIB_DIR\*`""
$env:PATH = "$env:JAVA_HOME\bin;$env:PATH"

Start-Process "rexxj.cmd" -ArgumentList "../MainApp.rex" -NoNewWindow
