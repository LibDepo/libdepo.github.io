@echo off

>nul 2>&1 dism|| (start cmd /c "color 0c& mode 45,4& @echo/& @echo    *** Требуются права Администратора! ***& @echo/& @pause"& exit)
2>nul cd/d%windir%\sysnative&&(cmd/c"%~f0"&exit)

cd /d "%~dp0"
if exist VCRedist\*.exe goto install
md tmp& set url=https://pastebin.com/raw/46rfrtBv
>tmp\tst.vbs echo set x=CreateObject("Microsoft.XMLHTTP") : x.Open "GET", WSh.Arguments(0), False : x.Send : With CreateObject("Adodb.Stream") : .type = 1 : .open : .write x.responseBody : .savetofile WSh.Arguments(1), 2 : End With
cscript //nologo tmp\tst.vbs "%url%" "tmp\idx"

for /f %%a in ('^<tmp\idx find "://"') do set url=%%a& goto next
:next
cscript //nologo tmp\tst.vbs "https://libdepo.github.io/files/aria2c.cab" "tmp\aria.cab"
expand tmp\aria.cab -f:*.exe tmp
tmp\aria2c -x3 -s3 "%url%" -d tmp -o vcr.zip --file-allocation=trunc
>tmp\tst.vbs echo With CreateObject("Shell.Application") .NameSpace(WSh.Arguments(0)).CopyHere(.NameSpace(WSh.Arguments(1)).Items) End With
md VCRedist& cscript //nologo tmp\tst.vbs "%CD%\VCRedist" "%CD%\tmp\vcr.zip"
rd /q/s tmp

:install
for %%i in (VCRedist\*.exe) do "%%i" /y
