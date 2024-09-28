@echo off

set SCRIPT_DIR=%~dp0
cd /d "%SCRIPT_DIR%"

call "%SCRIPT_DIR%env.bat"

rmdir /S /Q %JRE_DIR%
del /Q %LIB_DIR%\*.jar
