@echo off
REM 1) 先登录一次: gh auth login -h github.com -p https -w
REM 2) 双击本脚本，或 PowerShell: .\scripts\upload-mac-release.ps1

set PATH=C:\Program Files\GitHub CLI;%PATH%
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0upload-mac-release.ps1"
pause
