@echo off

>nul 2>&1 dism|| (start cmd /c "color 0c& mode 45,4& @echo/& @echo    *** Требуются права Администратора! ***& @echo/& @pause"& exit)
2>nul cd/d%windir%\sysnative&&(cmd/c"%~f0"&exit)

cd /d "%~dp0"
set "url=http://www.faststonesoft.net/DN/FSViewerSetup75.exe"
for %%i in (%url%) do set "fname=FSViewer\%%~nxi"

:load
if exist %fname% goto install
2>nul md FSViewer
echo Download FastStone Image Viewer...
>tst.vbs echo set x=CreateObject("Microsoft.XMLHTTP") : x.Open "GET", WSh.Arguments(0), False : x.Send : With CreateObject("Adodb.Stream") : .type = 1 : .open : .write x.responseBody : .savetofile WSh.Arguments(1), 2 : End With
cscript //nologo tst.vbs "%url%" "%fname%"
del /q tst.vbs
certutil -decode "%~f0%" FSViewer\FSSettings.db
set exe=& <%fname% set /p "exe="
if "%exe:~0,2%" neq "MZ" del /q %fname%
goto load

:install
%fname% /S /R
exit

-----BEGIN CERTIFICATE-----
VFBGMBBUUHJvZ3JhbVNldHRpbmdzAAhVc2VyTmFtZQYJRmFzdFN0b25lEFJlZ2lz
dHJhdGlvbkNvZGUGF1hZSlFVLVJJTUNQLUVSUFRVLUtHR1ZIB01vbnRoTm8CAAZU
cnlQcm8IC0luc3RhbGxEYXRlAgAKTGFuZ3VhZ2VObwILAAA=
-----END CERTIFICATE-----
