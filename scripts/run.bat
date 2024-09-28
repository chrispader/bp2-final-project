@echo off

set SCRIPT_DIR=%~dp0
cd /d "%SCRIPT_DIR%"

call "%SCRIPT_DIR%env.bat"

REM Check if JRE_DIR exists
if exist "%JRE_DIR%" (
    echo Custom JRE found, setting JAVA_HOME to %JRE_DIR%
    set JAVA_HOME=%JRE_DIR%
) else (
    echo No custom JRE found, using default JAVA_HOME
)

set BSF4Rexx_JavaStartupOptions=-cp %CLASSPATH%;%LIB_DIR%\*
set PATH=%JAVA_HOME%\bin;%PATH%

rexxj.sh MainApp.rex
