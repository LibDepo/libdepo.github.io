@echo off

>nul 2>&1 dism|| (start cmd /c "color 0c& mode 45,4& @echo/& @echo    *** Требуются права Администратора! ***& @echo/& @pause"& exit)
2>nul cd/d%windir%\sysnative&&(cmd/c"%~f0"&exit)

cd /d "%~dp0"
set "url=https://www.rarlab.com/rar/winrar-x64-602ru.exe"
for %%i in (%url%) do set "fname=WinRAR\%%~nxi"

:load
if exist %fname% goto install
2>nul md WinRAR
>tst.vbs echo set x=CreateObject("Microsoft.XMLHTTP") : x.Open "GET", WSh.Arguments(0), False : x.Send : With CreateObject("Adodb.Stream") : .type = 1 : .open : .write x.responseBody : .savetofile WSh.Arguments(1), 2 : End With
cscript //nologo tst.vbs "%url%" "%fname%"
del /q tst.vbs
goto load

:install
%fname% /S
certutil -decode "%~f0" "%ProgramW6432%\WinRAR\rarreg.key"
exit

-----BEGIN CERTIFICATE-----
UkFSIHJlZ2lzdHJhdGlvbiBkYXRhDQpEYXRhYmFzZSBBZG1pbmlzdHJhdG9yDQpV
bmxpbWl0ZWQgQ29tcGFueSBMaWNlbnNlDQpVSUQ9MGJkNWMwODU2YmUzMWQ0Mzhm
M2MNCjY0MTIyMTIyNTA4ZjNjMDc4MjYxYzdmOTc3YThlZDEyZmExNzRiMmRkYWJi
MjdjNDM4MDdiOQ0KOTVkZDMxNmI1NjJiYjQzYzA2YTQ2MGZjZTZjYjVmZmRlNjI4
OTAwNzk4NjFiZTU3NjM4NzE3DQo3MTMxY2VkODM1ZWQ2NWNjNzQzZDk3NzdmMmVh
NzFhOGUzMmM3ZTU5M2NmNjY3OTQzNDM1NjUNCmI0MWJjZjU2OTI5NDg2YjhiY2Rh
YzMzZDUwZWNmNzczOTk2MDY1ZWE5MDM4NTJmNDE5NjE0NQ0KNTYwNTU2M2I5YjU0
NWM2NjYyMDRhNzJlYzgwNjE3ZTBhYjhmYzEzZTU5NTIxMmViNjJlZTk2DQoxN2Q5
ZWJkNjVkMzM2MzI0M2MxNjc0NTk4YjEyNDExYTg2MzM5ZjI5M2FjNzViYzg2MDky
MjUNCjM0NzZjM2ZiMjJhNWM0ZjI0NDEyMDk4MWFlNDM1ZWJiOGIxYzhmMzVhNjEy
MDIwODgyNjgwNg==
-----END CERTIFICATE-----
