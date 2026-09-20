@echo off
setlocal
set "SRC=%~1"
set "DST=%~2"
if "%SRC%"=="" exit /b 1
if "%DST%"=="" exit /b 1
if not exist "%DST%" mkdir "%DST%"
set "STAMP=%date:~-4%%date:~4,2%%date:~7,2%_%time:~0,2%%time:~3,2%%time:~6,2%"
set "STAMP=%STAMP: =0%"
robocopy "%SRC%" "%DST%\Backup_%STAMP%" /E /R:2 /W:2 /LOG+:"%~dp0..\logs\backup.log"
exit /b %ERRORLEVEL%
