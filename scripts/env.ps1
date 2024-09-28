# Get the directory of the current script
$SCRIPT_DIR = Split-Path -Parent $MyInvocation.MyCommand.Definition

# Set ROOT_DIR to parent directory of the current script
$ROOT_DIR = Join-Path $SCRIPT_DIR ".."

# Set environment variables
$env:JRE_DIR = Join-Path $ROOT_DIR "jre"
$env:LIB_DIR = Join-Path $ROOT_DIR "lib"
$env:JAVAFX_DIR = Join-Path $env:LIB_DIR "javafx-jmods"
