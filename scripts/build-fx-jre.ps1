# Get the directory of the current script
$SCRIPT_DIR = Split-Path -Parent $MyInvocation.MyCommand.Definition

. "$SCRIPT_DIR\env.ps1"

# Check if the JavaFX directory exists
if (-Not (Test-Path -Path $env:JAVAFX_DIR)) {
  Write-Error "JavaFX directory '$env:JAVAFX_DIR' does not exist. Build cannot proceed."
  exit 1  # Exit with a non-zero status to indicate an error
}

. "$SCRIPT_DIR\clean.ps1"

# Build custom JRE with JavaFX modules
jlink --module-path "$env:JAVA_HOME\jmods;$env:JAVAFX_DIR" --add-modules "java.base,java.logging,javafx.base,javafx.swing,javafx.controls,javafx.graphics,javafx.fxml" --output "$env:JRE_DIR"

# Call Gradle to download dependencies
Start-Process -FilePath "$SCRIPT_DIR\..\gradlew.bat" -ArgumentList "download" -NoNewWindow
