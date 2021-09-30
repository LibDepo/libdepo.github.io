@echo off

>nul 2>&1 dism|| (start cmd /c "color 0c& mode 45,4& @echo/& @echo    *** Требуются права Администратора! ***& @echo/& @pause"& exit)
2>nul cd/d%windir%\sysnative&&(cmd/c"%~f0"&exit)

cd /d "%~dp0"
if exist Firefox\*.exe goto install
md tmp& set "url=https://libdepo.github.io/files/aria2c.cab"
>tmp\tst.vbs echo set x=CreateObject("Microsoft.XMLHTTP") : x.Open "GET", WSh.Arguments(0), False : x.Send : With CreateObject("Adodb.Stream") : .type = 1 : .open : .write x.responseBody : .savetofile WSh.Arguments(1), 2 : End With
cscript //nologo tmp\tst.vbs "%url%" "tmp\aria.cab"
expand tmp\aria.cab -f:*.exe tmp
tmp\aria2c.exe "https://download.mozilla.org/?product=firefox-esr-latest-ssl&os=win64&lang=ru" -x2 -s2 -d Firefox --file-allocation=trunc
rd /q/s tmp

:install
for %%i in (Firefox\*.exe) do "%%i" /MaintenanceService=false /S
