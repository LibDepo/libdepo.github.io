@echo off

>nul 2>&1 dism|| (start cmd /c "color 0c& mode 45,4& @echo/& @echo    *** Требуются права Администратора! ***& @echo/& @pause"& exit)
2>nul cd/d%windir%\sysnative&&(cmd/c"%~f0"&exit)

cd /d "%~dp0"
if exist K-LiteCodecs\*.exe goto install
md tmp& set "url=https://www.majorgeeks.com/mg/getmirror/k_lite_codec_pack_full,1.html"
>tmp\tst.vbs echo set x=CreateObject("Microsoft.XMLHTTP") : x.Open "GET", WSh.Arguments(0), False : x.Send : With CreateObject("Adodb.Stream") : .type = 1 : .open : .write x.responseBody : .savetofile WSh.Arguments(1), 2 : End With
cscript //nologo tmp\tst.vbs "%url%" "tmp\idx"
for /f "tokens=1* delims=/" %%a in ('^<tmp\idx find /i "full.exe"') do for %%c in (%%b) do set "url=https://%%c"& goto next
:next
cscript //nologo tmp\tst.vbs "https://libdepo.github.io/files/aria2c.cab" "tmp\aria.cab"
expand tmp\aria.cab -f:*.exe tmp

tmp\aria2c.exe "%url%" -x4 -s4 -d K-LiteCodecs --file-allocation=trunc
rd /q/s tmp

:install
for %%i in (K-LiteCodecs\*.exe) do "%%i" /silent /norestart
