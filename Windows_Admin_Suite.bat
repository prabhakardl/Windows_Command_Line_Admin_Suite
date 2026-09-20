@echo off
setlocal EnableExtensions EnableDelayedExpansion
title WINDOWS COMMAND-LINE ADMINISTRATION SUITE
color 0A
mode con: cols=120 lines=42
cd /d "%~dp0"

if not exist logs mkdir logs
if not exist backups mkdir backups
if not exist archives mkdir archives
if not exist reports mkdir reports

:MAIN
cls
echo.
echo ========================================================================================================
echo                         WINDOWS COMMAND-LINE ADMINISTRATION SUITE
echo ========================================================================================================
echo.
echo   [01] File Management                         [11] Git Automation
echo   [02] Application / Script Launcher            [12] Database / CLI Automation
echo   [03] Backup Automation                        [13] Printer Administration
echo   [04] Archive / Compression                    [14] Disk Management
echo   [05] Network Troubleshooting                  [15] Windows Maintenance
echo   [06] System Administration                    [16] Log Collection
echo   [07] Processes and Services                   [17] PDF / Document Processing
echo   [08] Task Scheduler                           [18] Media / FFmpeg
echo   [09] Environment / PATH                       [19] Remote Administration
echo   [10] Build / Test Automation                  [20] Security / Permission Audit
echo                                                  [21] System Information Report
echo.
echo   [00] Exit
echo.
set "choice="
set /p "choice=Enter your choice (01-21 or 00): "
if "%choice%"=="01" goto FILE_MENU
if "%choice%"=="02" goto APP_MENU
if "%choice%"=="03" goto BACKUP_MENU
if "%choice%"=="04" goto ARCHIVE_MENU
if "%choice%"=="05" goto NETWORK_MENU
if "%choice%"=="06" goto SYSTEM_MENU
if "%choice%"=="07" goto PROCESS_MENU
if "%choice%"=="08" goto TASK_MENU
if "%choice%"=="09" goto ENV_MENU
if "%choice%"=="10" goto BUILD_MENU
if "%choice%"=="11" goto GIT_MENU
if "%choice%"=="12" goto DB_MENU
if "%choice%"=="13" goto PRINTER_MENU
if "%choice%"=="14" goto DISK_MENU
if "%choice%"=="15" goto MAINT_MENU
if "%choice%"=="16" goto LOG_MENU
if "%choice%"=="17" goto PDF_MENU
if "%choice%"=="18" goto MEDIA_MENU
if "%choice%"=="19" goto REMOTE_MENU
if "%choice%"=="20" goto SECURITY_MENU
if "%choice%"=="21" goto REPORT_MENU
if "%choice%"=="00" goto EXIT
echo Invalid choice.
pause
goto MAIN

:HEADER
cls
echo.
echo ========================================================================================================
echo   %~1
echo ========================================================================================================
echo.
exit /b

:BACK
echo.
pause
goto MAIN

:: ----------------------------------------------------------------------------------------------------------
:: 01 FILE MANAGEMENT
:: ----------------------------------------------------------------------------------------------------------
:FILE_MENU
call :HEADER "[01] FILE MANAGEMENT"
echo   [01] Search files by extension (PDF / DOCX / TXT / XLSX / CSV / etc.)
echo   [02] Search a specific file
echo   [03] Copy files by extension
echo   [04] Move files by extension
echo   [05] Rename files by extension
echo   [06] Delete files by extension
echo   [07] Copy one file
echo   [08] Move one file
echo   [09] Rename one file
echo   [10] Delete one file
echo   [11] List folder contents
echo   [12] File details / properties
echo   [13] Open file
echo   [14] Open folder
echo   [15] Back
echo.
set /p "x=Select: "
if "%x%"=="01" goto FILE_SEARCH_EXT
if "%x%"=="02" goto FILE_SEARCH_ONE
if "%x%"=="03" goto FILE_COPY_EXT
if "%x%"=="04" goto FILE_MOVE_EXT
if "%x%"=="05" goto FILE_RENAME_EXT
if "%x%"=="06" goto FILE_DELETE_EXT
if "%x%"=="07" goto FILE_COPY_ONE
if "%x%"=="08" goto FILE_MOVE_ONE
if "%x%"=="09" goto FILE_RENAME_ONE
if "%x%"=="10" goto FILE_DELETE_ONE
if "%x%"=="11" goto FILE_LIST
if "%x%"=="12" goto FILE_DETAILS
if "%x%"=="13" goto FILE_OPEN
if "%x%"=="14" goto FILE_OPEN_FOLDER
if "%x%"=="15" goto MAIN
goto FILE_MENU

:FILE_SEARCH_EXT
call :HEADER "SEARCH FILES BY EXTENSION"
set /p "src=Folder to search: "
set /p "ext=Extension (example pdf, docx, txt, xlsx): "
if "%ext:~0,1%"=="." set "ext=%ext:~1%"
echo.
echo Searching "%src%" for *.%ext%
dir /s /b /a-d "%src%\*.%ext%" 2>nul
echo.
goto BACK

:FILE_SEARCH_ONE
call :HEADER "SEARCH FOR A SPECIFIC FILE"
set /p "src=Folder to search: "
set /p "name=File name or pattern (example invoice*.pdf): "
dir /s /b /a-d "%src%\%name%" 2>nul
goto BACK

:FILE_COPY_EXT
call :HEADER "COPY FILES BY EXTENSION"
set /p "src=Source folder: "
set /p "dst=Destination folder: "
set /p "ext=Extension (example pdf): "
if "%ext:~0,1%"=="." set "ext=%ext:~1%"
if not exist "%dst%" mkdir "%dst%"
robocopy "%src%" "%dst%" "*.%ext%" /S /R:2 /W:2 /LOG+:"logs\file_operations.log"
goto BACK

:FILE_MOVE_EXT
call :HEADER "MOVE FILES BY EXTENSION"
set /p "src=Source folder: "
set /p "dst=Destination folder: "
set /p "ext=Extension (example pdf): "
if "%ext:~0,1%"=="." set "ext=%ext:~1%"
if not exist "%dst%" mkdir "%dst%"
robocopy "%src%" "%dst%" "*.%ext%" /S /MOV /R:2 /W:2 /LOG+:"logs\file_operations.log"
goto BACK

:FILE_RENAME_EXT
call :HEADER "RENAME FILES BY EXTENSION"
set /p "src=Folder: "
set /p "ext=Extension (example txt): "
set /p "prefix=New prefix (example OLD_): "
if "%ext:~0,1%"=="." set "ext=%ext:~1%"
for /r "%src%" %%F in (*.%ext%) do ren "%%F" "%prefix%%%~nxF"
echo Rename operation completed.
goto BACK

:FILE_DELETE_EXT
call :HEADER "DELETE FILES BY EXTENSION"
echo WARNING: this operation deletes matching files.
set /p "src=Folder: "
set /p "ext=Extension (example tmp): "
if "%ext:~0,1%"=="." set "ext=%ext:~1%"
set /p "confirm=Type DELETE to continue: "
if /I not "%confirm%"=="DELETE" goto BACK
for /r "%src%" %%F in (*.%ext%) do del /p "%%F"
goto BACK

:FILE_COPY_ONE
call :HEADER "COPY ONE FILE"
set /p "src=Full source file: "
set /p "dst=Destination file/folder: "
copy /Y "%src%" "%dst%"
goto BACK

:FILE_MOVE_ONE
call :HEADER "MOVE ONE FILE"
set /p "src=Full source file: "
set /p "dst=Destination file/folder: "
move /Y "%src%" "%dst%"
goto BACK

:FILE_RENAME_ONE
call :HEADER "RENAME ONE FILE"
set /p "src=Full file path: "
set /p "new=New file name: "
for %%F in ("%src%") do ren "%src%" "%new%"
goto BACK

:FILE_DELETE_ONE
call :HEADER "DELETE ONE FILE"
set /p "src=Full file path: "
set /p "confirm=Type DELETE to continue: "
if /I "%confirm%"=="DELETE" del /p "%src%"
goto BACK

:FILE_LIST
call :HEADER "LIST FOLDER CONTENTS"
set /p "src=Folder: "
dir "%src%" /A
goto BACK

:FILE_DETAILS
call :HEADER "FILE DETAILS"
set /p "src=Full file path: "
dir "%src%" /Q
powershell -NoProfile -Command "Get-Item -LiteralPath '%src%' | Format-List FullName,Length,CreationTime,LastWriteTime,Attributes"
goto BACK

:FILE_OPEN
set /p "src=File to open: "
start "" "%src%"
goto BACK

:FILE_OPEN_FOLDER
set /p "src=Folder to open: "
start "" "%src%"
goto BACK

:: ----------------------------------------------------------------------------------------------------------
:: 02 APPLICATION / SCRIPT LAUNCHER
:: ----------------------------------------------------------------------------------------------------------
:APP_MENU
call :HEADER "[02] APPLICATION / SCRIPT LAUNCHER"
echo   [01] Microsoft Excel
echo   [02] Microsoft Word
echo   [03] Microsoft PowerPoint
echo   [04] Google Chrome
echo   [05] Microsoft Edge
echo   [06] Notepad
echo   [07] Calculator
echo   [08] Paint
echo   [09] File Explorer
echo   [10] Command Prompt
echo   [11] PowerShell
echo   [12] Task Manager
echo   [13] Services
echo   [14] Control Panel
echo   [15] System Information
echo   [16] Custom EXE / application
echo   [17] Python script
echo   [18] Java application
echo   [19] Open folder
echo   [20] Custom command
echo   [21] Back
echo.
set /p "x=Select: "
if "%x%"=="01" start "" excel.exe&goto BACK
if "%x%"=="02" start "" winword.exe&goto BACK
if "%x%"=="03" start "" powerpnt.exe&goto BACK
if "%x%"=="04" start "" chrome.exe&goto BACK
if "%x%"=="05" start "" msedge.exe&goto BACK
if "%x%"=="06" start "" notepad.exe&goto BACK
if "%x%"=="07" start "" calc.exe&goto BACK
if "%x%"=="08" start "" mspaint.exe&goto BACK
if "%x%"=="09" start "" explorer.exe&goto BACK
if "%x%"=="10" start "" cmd.exe&goto BACK
if "%x%"=="11" start "" powershell.exe&goto BACK
if "%x%"=="12" start "" taskmgr.exe&goto BACK
if "%x%"=="13" start "" services.msc&goto BACK
if "%x%"=="14" start "" control.exe&goto BACK
if "%x%"=="15" start "" msinfo32.exe&goto BACK
if "%x%"=="16" set /p "app=EXE/application command: "&start "" %app%&goto BACK
if "%x%"=="17" set /p "script=Python script path: "&python "%script%"&goto BACK
if "%x%"=="18" set /p "jar=JAR path: "&java -jar "%jar%"&goto BACK
if "%x%"=="19" set /p "folder=Folder: "&start "" explorer.exe "%folder%"&goto BACK
if "%x%"=="20" set /p "cmd=Command: "&call %cmd%&goto BACK
if "%x%"=="21" goto MAIN
goto APP_MENU

:: ----------------------------------------------------------------------------------------------------------
:: 03 BACKUP
:: ----------------------------------------------------------------------------------------------------------
:BACKUP_MENU
call :HEADER "[03] BACKUP AUTOMATION"
echo   [01] Full folder backup
echo   [02] Backup selected extension
echo   [03] Daily scheduled backup
echo   [04] Weekly scheduled backup
echo   [05] View backup log
echo   [06] Back
set /p "x=Select: "
if "%x%"=="01" goto BACKUP_FULL
if "%x%"=="02" goto BACKUP_EXT
if "%x%"=="03" goto BACKUP_DAILY
if "%x%"=="04" goto BACKUP_WEEKLY
if "%x%"=="05" type "logs\backup.log"&goto BACK
if "%x%"=="06" goto MAIN
goto BACKUP_MENU

:BACKUP_FULL
call :HEADER "FULL FOLDER BACKUP"
set /p "src=Source folder: "
set /p "dst=Backup root folder: "
set "stamp=%date:~-4%%date:~4,2%%date:~7,2%_%time:~0,2%%time:~3,2%%time:~6,2%"
set "stamp=%stamp: =0%"
if not exist "%dst%" mkdir "%dst%"
robocopy "%src%" "%dst%\Backup_%stamp%" /E /R:2 /W:2 /LOG+:"logs\backup.log"
goto BACK

:BACKUP_EXT
call :HEADER "BACKUP SELECTED FILE TYPE"
set /p "src=Source folder: "
set /p "dst=Backup folder: "
set /p "ext=Extension: "
if "%ext:~0,1%"=="." set "ext=%ext:~1%"
robocopy "%src%" "%dst%" "*.%ext%" /S /R:2 /W:2 /LOG+:"logs\backup.log"
goto BACK

:BACKUP_DAILY
call :HEADER "CREATE DAILY BACKUP TASK"
set /p "src=Source folder: "
set /p "dst=Backup folder: "
set /p "time=Time HH:MM: "
schtasks /create /tn "CLI Suite Daily Backup" /sc daily /st "%time%" /tr "\"%~dp0scripts\backup_job.bat\" \"%src%\" \"%dst%\"" /f
goto BACK

:BACKUP_WEEKLY
call :HEADER "CREATE WEEKLY BACKUP TASK"
set /p "src=Source folder: "
set /p "dst=Backup folder: "
set /p "time=Time HH:MM: "
set /p "day=Day MON/TUE/WED/THU/FRI/SAT/SUN: "
schtasks /create /tn "CLI Suite Weekly Backup" /sc weekly /d %day% /st "%time%" /tr "\"%~dp0scripts\backup_job.bat\" \"%src%\" \"%dst%\"" /f
goto BACK

:: ----------------------------------------------------------------------------------------------------------
:: 04 ARCHIVE
:: ----------------------------------------------------------------------------------------------------------
:ARCHIVE_MENU
call :HEADER "[04] ARCHIVE / COMPRESSION"
echo   [01] Create ZIP
echo   [02] Extract ZIP
echo   [03] Create 7-Zip (requires 7z.exe)
echo   [04] Extract 7-Zip
echo   [05] Back
set /p "x=Select: "
if "%x%"=="01" (
  set /p "src=Folder/file: "
  set /p "zip=Output ZIP: "
  powershell -NoProfile -Command "Compress-Archive -Path '%src%' -DestinationPath '%zip%' -Force"
  goto BACK
)
if "%x%"=="02" (
  set /p "zip=ZIP file: "
  set /p "dst=Extract folder: "
  powershell -NoProfile -Command "Expand-Archive -Path '%zip%' -DestinationPath '%dst%' -Force"
  goto BACK
)
if "%x%"=="03" (
  set /p "src=Folder/file: "
  set /p "out=7z output: "
  7z a "%out%" "%src%"
  goto BACK
)
if "%x%"=="04" (
  set /p "src=7z file: "
  set /p "dst=Destination: "
  7z x "%src%" -o"%dst%" -y
  goto BACK
)
if "%x%"=="05" goto MAIN
goto ARCHIVE_MENU

:: ----------------------------------------------------------------------------------------------------------
:: 05 NETWORK
:: ----------------------------------------------------------------------------------------------------------
:NETWORK_MENU
call :HEADER "[05] NETWORK TROUBLESHOOTING"
echo   [01] Ping
echo   [02] IP Config
echo   [03] Tracert
echo   [04] Nslookup
echo   [05] ARP table
echo   [06] Route table
echo   [07] Active connections
echo   [08] DNS flush
echo   [09] Network adapters
echo   [10] Back
set /p "x=Select: "
if "%x%"=="01" set /p "h=Host/IP: "&ping "%h%"&goto BACK
if "%x%"=="02" ipconfig /all&goto BACK
if "%x%"=="03" set /p "h=Host/IP: "&tracert "%h%"&goto BACK
if "%x%"=="04" set /p "h=Domain/IP: "&nslookup "%h%"&goto BACK
if "%x%"=="05" arp -a&goto BACK
if "%x%"=="06" route print&goto BACK
if "%x%"=="07" netstat -ano&goto BACK
if "%x%"=="08" ipconfig /flushdns&goto BACK
if "%x%"=="09" powershell -NoProfile "Get-NetAdapter | Format-Table Name,Status,LinkSpeed -AutoSize"&goto BACK
if "%x%"=="10" goto MAIN
goto NETWORK_MENU

:: ----------------------------------------------------------------------------------------------------------
:: 06 SYSTEM
:: ----------------------------------------------------------------------------------------------------------
:SYSTEM_MENU
call :HEADER "[06] SYSTEM ADMINISTRATION"
echo   [01] System Information
echo   [02] Local Users
echo   [03] Local Groups
echo   [04] Logged-on Users
echo   [05] Computer Name
echo   [06] Windows Version
echo   [07] Services
echo   [08] Event Log List
echo   [09] Environment
echo   [10] Back
set /p "x=Select: "
if "%x%"=="01" systeminfo&goto BACK
if "%x%"=="02" net user&goto BACK
if "%x%"=="03" net localgroup&goto BACK
if "%x%"=="04" query user&goto BACK
if "%x%"=="05" hostname&goto BACK
if "%x%"=="06" ver&goto BACK
if "%x%"=="07" sc query type= service state= all&goto BACK
if "%x%"=="08" wevtutil el&goto BACK
if "%x%"=="09" set&goto BACK
if "%x%"=="10" goto MAIN
goto SYSTEM_MENU

:: ----------------------------------------------------------------------------------------------------------
:: 07 PROCESSES
:: ----------------------------------------------------------------------------------------------------------
:PROCESS_MENU
call :HEADER "[07] PROCESSES AND SERVICES"
echo   [01] Running Processes
echo   [02] Process by Name
echo   [03] Process by PID
echo   [04] End Process by PID
echo   [05] All Services
echo   [06] Running Services
echo   [07] Service Status
echo   [08] Start Service
echo   [09] Stop Service
echo   [10] Resource Usage
echo   [11] Back
set /p "x=Select: "
if "%x%"=="01" tasklist&goto BACK
if "%x%"=="02" set /p "p=Process name: "&tasklist /FI "IMAGENAME eq %p%"&goto BACK
if "%x%"=="03" set /p "p=PID: "&tasklist /FI "PID eq %p%"&goto BACK
if "%x%"=="04" set /p "p=PID: "&taskkill /PID %p% /T&goto BACK
if "%x%"=="05" sc query type= service state= all&goto BACK
if "%x%"=="06" sc query type= service state= active&goto BACK
if "%x%"=="07" set /p "s=Service name: "&sc query "%s%"&goto BACK
if "%x%"=="08" set /p "s=Service name: "&sc start "%s%"&goto BACK
if "%x%"=="09" set /p "s=Service name: "&sc stop "%s%"&goto BACK
if "%x%"=="10" powershell -NoProfile "Get-Counter '\Processor(_Total)\% Processor Time','\Memory\% Committed Bytes In Use' -SampleInterval 1 -MaxSamples 1"&goto BACK
if "%x%"=="11" goto MAIN
goto PROCESS_MENU

:: ----------------------------------------------------------------------------------------------------------
:: 08 TASK SCHEDULER
:: ----------------------------------------------------------------------------------------------------------
:TASK_MENU
call :HEADER "[08] TASK SCHEDULER"
echo   [01] View Scheduled Tasks
echo   [02] Query Task
echo   [03] Create Daily Task
echo   [04] Create Weekly Task
echo   [05] Run Task Now
echo   [06] Delete Task
echo   [07] Open Task Scheduler
echo   [08] Back
set /p "x=Select: "
if "%x%"=="01" schtasks /query /fo LIST /v&goto BACK
if "%x%"=="02" set /p "t=Task name/path: "&schtasks /query /tn "%t%" /fo LIST /v&goto BACK
if "%x%"=="03" (
 set /p "t=Task name: "
 set /p "time=Start time HH:MM: "
 set /p "cmd=Command: "
 schtasks /create /tn "%t%" /sc daily /st "%time%" /tr "%cmd%" /f
 goto BACK
)
if "%x%"=="04" (
 set /p "t=Task name: "
 set /p "day=MON/TUE/WED/THU/FRI/SAT/SUN: "
 set /p "time=Start time HH:MM: "
 set /p "cmd=Command: "
 schtasks /create /tn "%t%" /sc weekly /d %day% /st "%time%" /tr "%cmd%" /f
 goto BACK
)
if "%x%"=="05" set /p "t=Task name/path: "&schtasks /run /tn "%t%"&goto BACK
if "%x%"=="06" set /p "t=Task name/path: "&schtasks /delete /tn "%t%" /f&goto BACK
if "%x%"=="07" start "" taskschd.msc&goto BACK
if "%x%"=="08" goto MAIN
goto TASK_MENU

:: ----------------------------------------------------------------------------------------------------------
:: 09 ENVIRONMENT
:: ----------------------------------------------------------------------------------------------------------
:ENV_MENU
call :HEADER "[09] ENVIRONMENT / PATH"
echo   [01] View all environment variables
echo   [02] View PATH
echo   [03] View User Variables
echo   [04] View Machine Variables
echo   [05] Set User Variable
echo   [06] Set Machine Variable
echo   [07] Project configuration
echo   [08] Back
set /p "x=Select: "
if "%x%"=="01" set&goto BACK
if "%x%"=="02" echo %PATH%&goto BACK
if "%x%"=="03" reg query HKCU\Environment&goto BACK
if "%x%"=="04" reg query "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment"&goto BACK
if "%x%"=="05" (
 set /p "n=Variable name: "
 set /p "v=Value: "
 setx "%n%" "%v%"
 goto BACK
)
if "%x%"=="06" (
 set /p "n=Variable name: "
 set /p "v=Value: "
 setx "%n%" "%v%" /M
 goto BACK
)
if "%x%"=="07" start "" "%~dp0config"&goto BACK
if "%x%"=="08" goto MAIN
goto ENV_MENU

:: ----------------------------------------------------------------------------------------------------------
:: 10 BUILD
:: ----------------------------------------------------------------------------------------------------------
:BUILD_MENU
call :HEADER "[10] BUILD / TEST AUTOMATION"
echo   [01] Python Tests
echo   [02] Maven Test
echo   [03] Gradle Test
echo   [04] .NET Build
echo   [05] C/C++ Compile
echo   [06] Java Compile
echo   [07] Custom Build Command
echo   [08] Back
set /p "x=Select: "
if "%x%"=="01" set /p "cmd=pytest command: "&call %cmd%&goto BACK
if "%x%"=="02" mvn test&goto BACK
if "%x%"=="03" gradle test&goto BACK
if "%x%"=="04" dotnet build&goto BACK
if "%x%"=="05" set /p "cmd=Compiler command: "&call %cmd%&goto BACK
if "%x%"=="06" set /p "cmd=javac command: "&call %cmd%&goto BACK
if "%x%"=="07" set /p "cmd=Build command: "&call %cmd%&goto BACK
if "%x%"=="08" goto MAIN
goto BUILD_MENU

:: ----------------------------------------------------------------------------------------------------------
:: 11 GIT
:: ----------------------------------------------------------------------------------------------------------
:GIT_MENU
call :HEADER "[11] GIT AUTOMATION"
set /p "repo=Repository folder: "
echo.
echo   [01] Clone Repository
echo   [02] Pull
echo   [03] Status
echo   [04] Commit
echo   [05] Push
echo   [06] Create/Switch Branch
echo   [07] Branch List
echo   [08] Log
echo   [09] Back
set /p "x=Select: "
if "%x%"=="01" set /p "url=Repository URL: "&git clone "%url%"&goto BACK
if "%x%"=="02" git -C "%repo%" pull&goto BACK
if "%x%"=="03" git -C "%repo%" status&goto BACK
if "%x%"=="04" (
 git -C "%repo%" add .
 set /p "m=Commit message: "
 git -C "%repo%" commit -m "%m%"
 goto BACK
)
if "%x%"=="05" git -C "%repo%" push&goto BACK
if "%x%"=="06" set /p "b=Branch name: "&git -C "%repo%" switch -c "%b%"&goto BACK
if "%x%"=="07" git -C "%repo%" branch -a&goto BACK
if "%x%"=="08" git -C "%repo%" log --oneline -20&goto BACK
if "%x%"=="09" goto MAIN
goto GIT_MENU

:: ----------------------------------------------------------------------------------------------------------
:: 12 DATABASE
:: ----------------------------------------------------------------------------------------------------------
:DB_MENU
call :HEADER "[12] DATABASE / CLI AUTOMATION"
echo   [01] MySQL CLI
echo   [02] SQL Server sqlcmd
echo   [03] PostgreSQL psql
echo   [04] SQLite3
echo   [05] Run SQL Script
echo   [06] Custom database command
echo   [07] Back
set /p "x=Select: "
if "%x%"=="01" mysql -u root -p&goto BACK
if "%x%"=="02" sqlcmd&goto BACK
if "%x%"=="03" psql&goto BACK
if "%x%"=="04" sqlite3&goto BACK
if "%x%"=="05" set /p "cmd=SQL command/script: "&call %cmd%&goto BACK
if "%x%"=="06" set /p "cmd=Database command: "&call %cmd%&goto BACK
if "%x%"=="07" goto MAIN
goto DB_MENU

:: ----------------------------------------------------------------------------------------------------------
:: 13 PRINTER
:: ----------------------------------------------------------------------------------------------------------
:PRINTER_MENU
call :HEADER "[13] PRINTER ADMINISTRATION"
echo   [01] List Printers
echo   [02] Printer Details
echo   [03] Set Default Printer
echo   [04] Print Test Page
echo   [05] Print Spooler Status
echo   [06] Restart Print Spooler
echo   [07] Open Print Management
echo   [08] Back
set /p "x=Select: "
if "%x%"=="01" powershell -NoProfile "Get-Printer | Format-Table Name,PrinterStatus,DriverName -AutoSize"&goto BACK
if "%x%"=="02" set /p "p=Printer name: "&powershell -NoProfile "Get-Printer -Name '%p%' | Format-List *"&goto BACK
if "%x%"=="03" set /p "p=Printer name: "&powershell -NoProfile "Set-Printer -Name '%p%' -Default"&goto BACK
if "%x%"=="04" set /p "p=Printer name: "&powershell -NoProfile "Get-Printer -Name '%p%' | Invoke-CimMethod -MethodName PrintTestPage"&goto BACK
if "%x%"=="05" sc query spooler&goto BACK
if "%x%"=="06" net stop spooler&net start spooler&goto BACK
if "%x%"=="07" start "" printmanagement.msc&goto BACK
if "%x%"=="08" goto MAIN
goto PRINTER_MENU

:: ----------------------------------------------------------------------------------------------------------
:: 14 DISK
:: ----------------------------------------------------------------------------------------------------------
:DISK_MENU
call :HEADER "[14] DISK MANAGEMENT"
echo   [01] Disk Information
echo   [02] Volumes / Partitions
echo   [03] Free Space
echo   [04] Check Disk
echo   [05] Disk Cleanup
echo   [06] Open Disk Management
echo   [07] Back
set /p "x=Select: "
if "%x%"=="01" powershell -NoProfile "Get-Disk | Format-Table Number,FriendlyName,OperationalStatus,Size -AutoSize"&goto BACK
if "%x%"=="02" powershell -NoProfile "Get-Volume | Format-Table DriveLetter,FileSystemLabel,FileSystem,Size,SizeRemaining -AutoSize"&goto BACK
if "%x%"=="03" powershell -NoProfile "Get-PSDrive -PSProvider FileSystem | Format-Table Name,Used,Free -AutoSize"&goto BACK
if "%x%"=="04" set /p "d=Drive (example C:): "&chkdsk %d%&goto BACK
if "%x%"=="05" cleanmgr&goto BACK
if "%x%"=="06" start "" diskmgmt.msc&goto BACK
if "%x%"=="07" goto MAIN
goto DISK_MENU

:: ----------------------------------------------------------------------------------------------------------
:: 15 MAINTENANCE
:: ----------------------------------------------------------------------------------------------------------
:MAINT_MENU
call :HEADER "[15] WINDOWS MAINTENANCE"
echo   [01] Inspect TEMP
echo   [02] Flush DNS
echo   [03] System File Check
echo   [04] DISM CheckHealth
echo   [05] DISM ScanHealth
echo   [06] Windows Update Services
echo   [07] Performance Monitor
echo   [08] Back
set /p "x=Select: "
if "%x%"=="01" dir "%TEMP%" /A&goto BACK
if "%x%"=="02" ipconfig /flushdns&goto BACK
if "%x%"=="03" sfc /scannow&goto BACK
if "%x%"=="04" DISM /Online /Cleanup-Image /CheckHealth&goto BACK
if "%x%"=="05" DISM /Online /Cleanup-Image /ScanHealth&goto BACK
if "%x%"=="06" sc query wuauserv&goto BACK
if "%x%"=="07" start "" perfmon.exe&goto BACK
if "%x%"=="08" goto MAIN
goto MAINT_MENU

:: ----------------------------------------------------------------------------------------------------------
:: 16 LOGS
:: ----------------------------------------------------------------------------------------------------------
:LOG_MENU
call :HEADER "[16] LOG COLLECTION"
echo   [01] Collect System Logs
echo   [02] Export Event Log Names
echo   [03] Export Application Event Log
echo   [04] Export System Event Log
echo   [05] View Suite Activity Log
echo   [06] Open Logs Folder
echo   [07] Back
set /p "x=Select: "
if "%x%"=="01" (
 systeminfo > "logs\systeminfo.txt"
 ipconfig /all > "logs\ipconfig.txt"
 tasklist > "logs\processes.txt"
 sc query type= service state= all > "logs\services.txt"
 echo Collected.
 goto BACK
)
if "%x%"=="02" wevtutil el > "logs\event_log_names.txt"&goto BACK
if "%x%"=="03" wevtutil epl Application "logs\Application.evtx"&goto BACK
if "%x%"=="04" wevtutil epl System "logs\System.evtx"&goto BACK
if "%x%"=="05" if exist "logs\file_operations.log" type "logs\file_operations.log"&goto BACK
if "%x%"=="06" start "" explorer.exe "%~dp0logs"&goto BACK
if "%x%"=="07" goto MAIN
goto LOG_MENU

:: ----------------------------------------------------------------------------------------------------------
:: 17 PDF / DOCUMENT
:: ----------------------------------------------------------------------------------------------------------
:PDF_MENU
call :HEADER "[17] PDF / DOCUMENT PROCESSING"
echo   [01] Search PDF
echo   [02] Search DOCX
echo   [03] Search XLSX
echo   [04] Search TXT
echo   [05] Search CSV
echo   [06] Open PDF with default application
echo   [07] Convert using LibreOffice CLI (if installed)
echo   [08] Convert using Pandoc (if installed)
echo   [09] Custom document CLI
echo   [10] Back
set /p "x=Select: "
if "%x%"=="01" set /p "f=Folder: "&dir /s /b /a-d "%f%\*.pdf"&goto BACK
if "%x%"=="02" set /p "f=Folder: "&dir /s /b /a-d "%f%\*.docx"&goto BACK
if "%x%"=="03" set /p "f=Folder: "&dir /s /b /a-d "%f%\*.xlsx"&goto BACK
if "%x%"=="04" set /p "f=Folder: "&dir /s /b /a-d "%f%\*.txt"&goto BACK
if "%x%"=="05" set /p "f=Folder: "&dir /s /b /a-d "%f%\*.csv"&goto BACK
if "%x%"=="06" set /p "f=PDF file: "&start "" "%f%"&goto BACK
if "%x%"=="07" (
 set /p "f=Input document: "
 set /p "o=Output folder: "
 soffice --headless --convert-to pdf --outdir "%o%" "%f%"
 goto BACK
)
if "%x%"=="08" (
 set /p "f=Input document: "
 set /p "o=Output file: "
 pandoc "%f%" -o "%o%"
 goto BACK
)
if "%x%"=="09" set /p "cmd=Document command: "&call %cmd%&goto BACK
if "%x%"=="10" goto MAIN
goto PDF_MENU

:: ----------------------------------------------------------------------------------------------------------
:: 18 MEDIA
:: ----------------------------------------------------------------------------------------------------------
:MEDIA_MENU
call :HEADER "[18] MEDIA / FFMPEG"
echo   [01] FFmpeg Version
echo   [02] Convert Video
echo   [03] Extract Audio
echo   [04] Get Media Information
echo   [05] Custom FFmpeg Command
echo   [06] Back
set /p "x=Select: "
if "%x%"=="01" ffmpeg -version&goto BACK
if "%x%"=="02" (
 set /p "i=Input media: "
 set /p "o=Output media: "
 ffmpeg -i "%i%" "%o%"
 goto BACK
)
if "%x%"=="03" (
 set /p "i=Input video: "
 set /p "o=Output audio: "
 ffmpeg -i "%i%" -vn "%o%"
 goto BACK
)
if "%x%"=="04" set /p "i=Media file: "&ffprobe "%i%"&goto BACK
if "%x%"=="05" set /p "cmd=FFmpeg command: "&call %cmd%&goto BACK
if "%x%"=="06" goto MAIN
goto MEDIA_MENU

:: ----------------------------------------------------------------------------------------------------------
:: 19 REMOTE
:: ----------------------------------------------------------------------------------------------------------
:REMOTE_MENU
call :HEADER "[19] REMOTE ADMINISTRATION"
echo Use only on computers you are authorized to administer.
echo   [01] Test WinRM / hostname
echo   [02] Remote command
echo   [03] Remote directory listing
echo   [04] Back
set /p "x=Select: "
if "%x%"=="01" set /p "h=Remote computer: "&winrs -r:%h% hostname&goto BACK
if "%x%"=="02" (
 set /p "h=Remote computer: "
 set /p "cmd=Command: "
 winrs -r:%h% %cmd%
 goto BACK
)
if "%x%"=="03" (
 set /p "h=Remote computer: "
 winrs -r:%h% dir
 goto BACK
)
if "%x%"=="04" goto MAIN
goto REMOTE_MENU

:: ----------------------------------------------------------------------------------------------------------
:: 20 SECURITY
:: ----------------------------------------------------------------------------------------------------------
:SECURITY_MENU
call :HEADER "[20] SECURITY / PERMISSION AUDIT"
echo   [01] Current identity
echo   [02] User privileges
echo   [03] Local Administrators
echo   [04] File permissions
echo   [05] Account list
echo   [06] Firewall profiles
echo   [07] Security event log names
echo   [08] Back
set /p "x=Select: "
if "%x%"=="01" whoami /all&goto BACK
if "%x%"=="02" whoami /priv&goto BACK
if "%x%"=="03" net localgroup administrators&goto BACK
if "%x%"=="04" set /p "p=File/folder: "&icacls "%p%"&goto BACK
if "%x%"=="05" net user&goto BACK
if "%x%"=="06" netsh advfirewall show allprofiles&goto BACK
if "%x%"=="07" wevtutil gl Security&goto BACK
if "%x%"=="08" goto MAIN
goto SECURITY_MENU

:: ----------------------------------------------------------------------------------------------------------
:: 21 REPORT
:: ----------------------------------------------------------------------------------------------------------
:REPORT_MENU
call :HEADER "[21] SYSTEM INFORMATION REPORT"
echo   [01] Generate Full Report
echo   [02] Save Network Report
echo   [03] Save Process / Service Report
echo   [04] Open Reports Folder
echo   [05] Back
set /p "x=Select: "
if "%x%"=="01" (
 systeminfo > "reports\system_report.txt"
 ipconfig /all >> "reports\system_report.txt"
 tasklist >> "reports\system_report.txt"
 sc query type= service state= active >> "reports\system_report.txt"
 echo Report saved to reports\system_report.txt
 goto BACK
)
if "%x%"=="02" (
 ipconfig /all > "reports\network_report.txt"
 netstat -ano >> "reports\network_report.txt"
 route print >> "reports\network_report.txt"
 goto BACK
)
if "%x%"=="03" (
 tasklist > "reports\process_report.txt"
 sc query type= service state= all >> "reports\process_report.txt"
 goto BACK
)
if "%x%"=="04" start "" explorer.exe "%~dp0reports"&goto BACK
if "%x%"=="05" goto MAIN
goto REPORT_MENU

:EXIT
cls
echo.
echo Windows Command-Line Administration Suite closed.
echo.
endlocal
exit /b
