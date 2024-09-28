@REM Builds a custom JRE with JavaFX modules included

@echo off

cd /d "%~dp0"

call env.bat
call clean.bat

jlink --module-path "%JAVA_HOME%\jmods;%JAVAFX_DIR%" --add-modules java.base,java.logging,javafx.base,javafx.swing,javafx.controls,javafx.graphics,javafx.fxml --output %JRE_DIR%
