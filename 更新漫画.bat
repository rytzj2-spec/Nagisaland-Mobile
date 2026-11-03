@echo off
setlocal
cd /d "%~dp0"
title 更新 Nagisaland 漫画 VeneraX

rem ---------- 找 Python（跳过微软商店的假 python） ----------
set "PY="
py -3 -c "import sys" >nul 2>nul && set "PY=py -3"
if defined PY goto havepy
python -c "import sys" >nul 2>nul && set "PY=python"
if defined PY goto havepy
for /d %%D in ("%LOCALAPPDATA%\Programs\Python\Python3*") do if exist "%%D\python.exe" set "PY="%%D\python.exe""
if defined PY goto havepy
for /d %%D in ("C:\Program Files\Python3*") do if exist "%%D\python.exe" set "PY="%%D\python.exe""
if defined PY goto havepy
echo 没找到 Python。请安装 Python 3 （python.org，安装时勾选 Add to PATH），装好后再运行本脚本。
echo 也可以直接在 Claude 里说“更新漫画”，让它帮你打包。
goto end

:havepy
rem ---------- 找 Java ----------
java -version >nul 2>nul && goto havejava
for /d %%D in ("C:\Program Files\Eclipse Adoptium\*" "C:\Program Files\Java\*" "C:\Program Files\Microsoft\jdk*" "C:\Program Files\Android\Android Studio\jbr") do if exist "%%~D\bin\java.exe" set "PATH=%%~D\bin;%PATH%"
java -version >nul 2>nul && goto havejava
echo 没找到 Java。请安装 Java 17 或更新版本 （例如 adoptium.net），装好后再运行本脚本。
echo 也可以直接在 Claude 里说“更新漫画”，让它帮你打包。
goto end

:havejava
echo 使用 Python: %PY%
%PY% update_venerax.py %*

:end
echo.
pause
