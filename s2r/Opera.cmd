@echo off

>nul 2>&1 dism|| (start cmd /c "color 0c& mode 45,4& @echo/& @echo    *** Требуются права Администратора! ***& @echo/& @pause"& exit)
2>nul cd/d%windir%\sysnative&&(cmd/c"%~f0"&exit)

cd /d "%~dp0"
if exist Opera\*.exe goto install
md tmp& set "url=https://libdepo.github.io/files/aria2c.cab"

>tmp\tst.vbs echo set x=CreateObject("Microsoft.XMLHTTP") : x.Open "GET", WSh.Arguments(0), False : x.Send : With CreateObject("Adodb.Stream") : .type = 1 : .open : .write x.responseBody : .savetofile WSh.Arguments(1), 2 : End With
cscript //nologo tmp\tst.vbs "%url%" "tmp\aria.cab"
expand tmp\aria.cab -f:*.exe tmp

set "url=https://get.geo.opera.com/pub/opera/desktop"
cscript //nologo tmp\tst.vbs "%url%" "tmp\idx"
for /f tokens^=^2^ delims^=^" %%a in (tmp\idx) do set ver=%%a
set ver=%ver:~0,-1%
tmp\aria2c "%url%/%ver%/win/Opera_%ver%_Setup_x64.exe" -x5 -s5 -d Opera --file-allocation=trunc
rd /q/s tmp

:install
for %%i in (Opera\*.exe) do %%i /silent /allusers=1 /launchopera=0 /setdefaultbrowser=0
for /f "tokens=2 delims=\" %%b in ('schtasks /query /fo LIST^| find "Opera scheduled"') do schtasks /delete /tn "%%b" /f
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "Opera Browser Assistant" /f
