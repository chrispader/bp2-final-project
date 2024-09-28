@REM Builds a custom JRE with JavaFX modules included

@echo off

set SCRIPT_DIR=%~dp0
cd /d "%SCRIPT_DIR%"

call "%SCRIPT_DIR%env.bat"
call "%SCRIPT_DIR%clean.bat"

jlink --module-path "%JAVA_HOME%\jmods;%JAVAFX_DIR%" --add-modules java.base,java.logging,javafx.base,javafx.swing,javafx.controls,javafx.graphics,javafx.fxml --output %JRE_DIR%
