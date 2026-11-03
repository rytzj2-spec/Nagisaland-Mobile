@echo off
setlocal
cd /d "%~dp0"
title Nagisaland 漫画更新面板

set "PY="
py -3 -c "import sys" >nul 2>nul && set "PY=py -3"
if defined PY goto run
python -c "import sys" >nul 2>nul && set "PY=python"
if defined PY goto run
for /d %%D in ("%LOCALAPPDATA%\Programs\Python\Python3*") do if exist "%%D\python.exe" set "PY="%%D\python.exe""
if defined PY goto run
for /d %%D in ("C:\Program Files\Python3*") do if exist "%%D\python.exe" set "PY="%%D\python.exe""
if defined PY goto run
echo 没找到 Python。请安装 Python 3 （python.org，安装时勾选 Add to PATH），装好后再运行。
pause
goto :eof

:run
echo 正在打开漫画更新面板，浏览器会自动弹出。
echo 用完关掉这个黑窗口即可。
echo.
%PY% panel.py
pause
