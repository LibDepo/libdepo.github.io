@echo off

>nul 2>&1 dism|| (start cmd /c "color 0c& mode 45,4& @echo/& @echo    *** Требуются права Администратора! ***& @echo/& @pause"& exit)
2>nul cd/d%windir%\sysnative&&(cmd/c"%~f0"&exit)

cd /d "%~dp0"
if exist Java\*.exe goto install
md tmp
>tmp\tst.vbs echo set x=CreateObject("Microsoft.XMLHTTP") : x.Open "GET", WSh.Arguments(0), False : x.Send : With CreateObject("Adodb.Stream") : .type = 1 : .open : .write x.responseBody : .savetofile WSh.Arguments(1), 2 : End With
setlocal EnableDelayedExpansion
for %%j in (64 32) do call :geturl "https://www.filehorse.com/download-java-runtime-%%j/download/"
cscript //nologo tmp\tst.vbs "https://libdepo.github.io/files/aria2c.cab" "tmp\aria.cab"
expand tmp\aria.cab -f:*.exe tmp
tmp\aria2c -itmp\list -x4 -s4 --file-allocation=trunc -d Java
rd /q/s tmp

:install
for %%i in (Java\*.exe) do "%%i" /s
reg delete "HKLM\SOFTWARE\JavaSoft\Java Update" /f
reg delete "HKLM\SOFTWARE\WOW6432Node\JavaSoft\Java Update" /f
exit

:geturl
cscript //nologo tmp\tst.vbs %1 "tmp\idx"
for /f "delims=" %%a in ('^<tmp\idx find "/download/file"') do set "ln=%%a"
for /l %%i in (1,1,20000) do if "!ln:~%%i,40!"=="https://www.filehorse.com/download/file/" >>tmp\list echo !ln:~%%i,148!& exit /b
