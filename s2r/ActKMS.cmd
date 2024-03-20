@echo off

>nul 2>&1 dism|| (start cmd /c "color 0c& mode 45,4& @echo/& @echo    *** Требуются права Администратора! ***& @echo/& @pause"& exit)
if exist %windir%\sysnative\ %windir%\sysnative\cmd /c "%~f0"& exit

cd /d "%~dp0"
2>nul (rd /q/s KMS& md KMS)
set "url=https://codeload.github.com/massgravel/Microsoft-Activation-Scripts/zip/refs/heads/master"
>tst.vbs echo set x=CreateObject("Microsoft.XMLHTTP") : x.Open "GET", WSh.Arguments(0), False : x.Send : With CreateObject("Adodb.Stream") : .type = 1 : .open : .write x.responseBody : .savetofile WSh.Arguments(1), 2 : End With
cscript //nologo tst.vbs "%url%" "tmp.zip"
>tst.vbs echo With CreateObject("Shell.Application") .NameSpace(WSh.Arguments(0)).CopyHere(.NameSpace(WSh.Arguments(1)).Items) End With
cscript //nologo tst.vbs "%CD%\KMS" "%CD%\tmp.zip"
del /q *.vbs *.zip
for /r %%i in (MAS_AIO*.cmd) do call "%%i"
