@echo off

cd /d "%~dp0"

call env.bat

rmdir /S /Q %JRE_DIR%
del /Q %LIB_DIR%\*.jar
