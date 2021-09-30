@echo off

>nul 2>&1 dism|| (start cmd /c "color 0c& mode 45,4& @echo/& @echo    *** Требуются права Администратора! ***& @echo/& @pause"& exit)
2>nul cd/d%windir%\sysnative&&(cmd/c"%~f0"&exit)

cd /d "%~dp0"
set "url=https://farmanager.com/download.php?l=ru"
>tst.vbs echo set x=CreateObject("Microsoft.XMLHTTP") : x.Open "GET", WSh.Arguments(0), False : x.Send : With CreateObject("Adodb.Stream") : .type = 1 : .open : .write x.responseBody : .savetofile WSh.Arguments(1), 2 : End With
cscript //nologo tst.vbs "%url%" "idx"

setlocal EnableDelayedExpansion
set c=1& for /f "delims=" %%a in ('^<idx find "files/"') do set "ln=%%a"
del /q tst.vbs idx
:loop
for /f tokens^=^%c%^ delims^=^" %%a in ("%ln%") do ^
set "var=%%a"& if "!var:~0,5!"=="files" if "!var:~-4!"==".msi" goto install
set /a c+=1& goto loop

:install
msiexec /i https://farmanager.com/%var:.x86.=.x64.% /passive
msiexec /i https://www.7-zip.org/a/7z2103-x64.msi /passive
for %%i in ("%ProgramFiles%\7-Zip\*.exe") do mklink "%windir%\%%~nxi" "%%~i"
