@echo off
title Install - Windows Command-Line Administration Suite
cd /d "%~dp0"
echo ============================================================
echo WINDOWS COMMAND-LINE ADMINISTRATION SUITE - INSTALL CHECK
echo ============================================================
echo.
if not exist backups mkdir backups
if not exist archives mkdir archives
if not exist logs mkdir logs
if not exist reports mkdir reports
if not exist scripts mkdir scripts
if not exist config mkdir config
echo Required project folders created.
echo.
echo Optional tools detected:
where git >nul 2>&1 && echo [OK] Git || echo [--] Git not installed
where python >nul 2>&1 && echo [OK] Python || echo [--] Python not installed
where java >nul 2>&1 && echo [OK] Java || echo [--] Java not installed
where 7z >nul 2>&1 && echo [OK] 7-Zip || echo [--] 7-Zip not installed
where soffice >nul 2>&1 && echo [OK] LibreOffice || echo [--] LibreOffice not installed
where pandoc >nul 2>&1 && echo [OK] Pandoc || echo [--] Pandoc not installed
where ffmpeg >nul 2>&1 && echo [OK] FFmpeg || echo [--] FFmpeg not installed
where mysql >nul 2>&1 && echo [OK] MySQL || echo [--] MySQL not installed
where sqlcmd >nul 2>&1 && echo [OK] SQL Server CLI || echo [--] SQL Server CLI not installed
where psql >nul 2>&1 && echo [OK] PostgreSQL || echo [--] PostgreSQL not installed
echo.
echo Installation/check complete.
pause
