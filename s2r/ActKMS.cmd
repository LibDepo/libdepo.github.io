@echo off

>nul 2>&1 dism|| (start cmd /c "color 0c& mode 45,4& @echo/& @echo    *** Требуются права Администратора! ***& @echo/& @pause"& exit)
if exist %windir%\sysnative\ %windir%\sysnative\cmd /c "%~f0"& exit

cd /d "%~dp0"
if exist KMS\*.cmd goto install
2>nul md KMS
set "url=https://raw.githubusercontent.com/massgravel/Microsoft-Activation-Scripts/master/MAS/All-In-One-Version/MAS_1.5_AIO_CRC32_21D20776.cmd"
>tst.vbs echo set x=CreateObject("Microsoft.XMLHTTP") : x.Open "GET", WSh.Arguments(0), False : x.Send : With CreateObject("Adodb.Stream") : .type = 1 : .open : .write x.responseBody : .savetofile WSh.Arguments(1), 2 : End With
cscript //nologo tst.vbs "%url%" "KMS\kms.cmd"
del /q tst.vbs
:install
call KMS\kms.cmd
