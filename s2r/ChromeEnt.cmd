@echo off

>nul 2>&1 dism|| (start cmd /c "color 0c& mode 45,4& @echo/& @echo    *** Требуются права Администратора! ***& @echo/& @pause"& exit)
2>nul cd/d%windir%\sysnative&&(cmd/c"%~f0"&exit)

cd /d "%~dp0"
set "url=https://dl.google.com/tag/chrome/install/GoogleChromeEnterpriseBundle64.zip"
for %%i in (%url%) do set "fname=Chrome\%%~nxi"

:load
if exist %fname% goto install
2>nul md Chrome
>tst.vbs echo set x=CreateObject("Microsoft.XMLHTTP") : x.Open "GET", WSh.Arguments(0), False : x.Send : With CreateObject("Adodb.Stream") : .type = 1 : .open : .write x.responseBody : .savetofile WSh.Arguments(1), 2 : End With
echo/
echo Download Chrome Enterprise...
cscript //nologo tst.vbs "%url%" "%fname%"
del /q tst.vbs
goto load

:install
md tmp
>tmp\tst.vbs echo With CreateObject("Shell.Application") .NameSpace(WSh.Arguments(0)).CopyHere(.NameSpace(WSh.Arguments(1)).Items) End With
cscript //nologo tmp\tst.vbs "%CD%\tmp" "%CD%\%fname%"
tmp\Installers\GoogleChromeStandaloneEnterprise64.msi /passive /norestart
rd /q/s tmp

sc delete gupdate
sc delete gupdatem
schtasks /delete /tn "GoogleUpdateTaskMachineCore" /f
schtasks /delete /tn "GoogleUpdateTaskMachineUA" /f
