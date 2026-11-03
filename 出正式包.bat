@echo off
chcp 65001 >nul
setlocal
cd /d "%~dp0"
title Nagisaland 出正式包（加模拟器 + 正式签名）
rem 把 GitHub Actions 里下载的 Nagisaland-v*-arm64-v8a.apk 放进 ci\ 文件夹，双击运行；加 --lite 不带模拟器
set "PY="
py -3 -c "import sys" >nul 2>nul && set "PY=py -3"
if not defined PY python -c "import sys" >nul 2>nul && set "PY=python"
if not defined PY (echo 没找到 Python 3 & goto end)
java -version >nul 2>nul || for /d %%D in ("%~dp0tools\jre\*" "C:\Program Files\Eclipse Adoptium\*" "C:\Program Files\Java\*") do if exist "%%~D\bin\java.exe" set "PATH=%%~D\bin;%PATH%"
%PY% sign_release.py %*
:end
echo.
pause
