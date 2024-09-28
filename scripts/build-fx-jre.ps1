# Get the directory of the current script
$SCRIPT_DIR = Split-Path -Parent $MyInvocation.MyCommand.Definition

# Change to the script directory
Set-Location -Path $SCRIPT_DIR

# Call env.ps1
. "$SCRIPT_DIR\env.ps1"

# Call clean.ps1 to clean directories
. "$SCRIPT_DIR\clean.ps1"

# Build custom JRE with JavaFX modules
jlink --module-path "$env:JAVA_HOME\jmods;$env:JAVAFX_DIR" --add-modules java.base,java.logging,javafx.base,javafx.swing,javafx.controls,javafx.graphics,javafx.fxml --output $env:JRE_DIR

# Call Gradle to download dependencies
Start-Process -FilePath "..\gradlew.bat" -ArgumentList "download" -NoNewWindow