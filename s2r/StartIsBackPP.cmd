@echo off

>nul 2>&1 dism|| call :error "   *** Требуются права Администратора! ***"
ver| >nul find "10.0."|| call :error "       *** Только для Windows 10! ***"
2>nul cd/d%windir%\sysnative&&(cmd/c"%~f0"&exit)
set x=& if defined ProgramFiles(x86) set "x= (x86)"

cd /d "%~dp0"
set f=StartIsBackPP\StartIsBackPlusPlus_setup.exe
:load
if exist %f% goto install
2>nul md StartIsBackPP
>tst.vbs echo Set x = CreateObject("Microsoft.XMLHTTP") : x.Open "GET", WSh.Arguments(0), False : x.Send : With CreateObject("Adodb.Stream") : .type = 1 : .open : .write x.responseBody : .savetofile WSh.Arguments(1), 2 : End With
cscript //nologo tst.vbs "https://www.startisback.com/StartIsBackPlusPlus_setup.exe" "%f%"
goto load

:install
%f% /elevated /silent
certutil -decode "%~f0" d&& expand d "%ProgramFiles%%x%\StartIsBack\msimg32.dll"
del /q tst.vbs d

for %%i in ("reg add HKEY_CURRENT_USER\Software\StartIsBack /t REG_DWORD /f /v") do (
%%~i "AutoUpdates" /d 0
%%~i "NoXAMLPrelaunch" /d 1
%%~i "Start_ShowPrinters" /d 1
)
start explorer
exit

:error
start cmd /c "color 0c& mode 45,4& @echo/& @echo %~1& @echo/& @pause"
exit

-----BEGIN CERTIFICATE-----
TVNDRgAAAAA6BQAAAAAAACwAAAAAAAAAAwEBAAEAAABNQgAASAAAAAEAAxUACgAA
AAAAAAAABVEPViAAbXNpbWczMi5kbGwA2om3OOoEAApbgICNACAHoHEUAEIAADQi
UFAAAPsP025qtbV1AIakh7KQHkeq9ZlK27bXtmcP7WIRW2+D713vbu5t4+733stq
p2YYShniFEUFJVEEkVFcVLu0AhZQIAUEQFHIgFFlREGxIIB4AACNCMAdFQB/g7p0
Ae/Aa0FcX1rwAG8qAcsBZYvdIi1+F2fahHKo7cQd2BHG0CdQKCAQKBFexAd4Qe+H
//33v+D9AIAAAAEAAJqDIemsi1x4AsqvmIW/qb+/koCteQwAahUYAkYRjMLw+Rtw
0EnCOL5zEDYoPCtPSBPfMiyHw8S11KM5iQOlZCx5tNlOQbVsNiekZsXNolws5RSa
rFoHHhsUWWnlCkCjrwdF131Nsk6Y4xCcLMNevA7m4dNFvpvsA5o3YgK7HRj/gN9o
dsPn7+DEpm34eb5aXeg9TEd3cva+mt7KqleEaGzAqbzzAjiowNeW8dX+uOPvJpXH
eRz/y+pN6X6tgGfMr8Fi7tKPopuFobIZnLrgRcjFchIPCyWO9HzjfE8FWOITI4et
MrubEueosqjOnfMVua0/tscs60oTUwp8RJ2KAxOBM0hejRSm0SjuuoaG3g0b6DdK
C21MS3j0dLhXxdy1akJk2+Xb+Dori3A76+9exHE3R4OzzavBO3HGBBliEefpx34t
9YvSIO2J5aw0FToSoM/a0yq6i56C1cSjH2r4OU7zK5dawbp5TFDBt7/dUmAdIcyj
e1VnOiHmZM6uZPbdgd75mJfCife+p4cG0dZjf6madA1WErSPIs935rk+gOLjm1Lh
YyrDr0Jm88kwL72RAvWno8qlvN/5vi5Vqu/Foe+ApkfR7+K7ejLe5j+hfLojGN/P
pM6Vd/Wdg2fiWZEJMuYXYVSNplFi8k/fXdwjKS8tlxuZkDSPz5P7LGoJiuV65rx/
XOz8P4IMw/giO0VchwoO/TjRF6MuWFLA0nvEYY/gVxYQhAMBhMqW465PBS0cZXJO
+HEBxmsaJFYaxzJbXoHW8zEzCQPONLCYeJIZpcS8TCRlelu32jNzkuWxPUCfG/72
jUV0rUTRYX1F8rKk4iuzeJaZ8m8liZJPy9TjSPcMbjEhmYpKU2zf4ttxFkmbhJtC
Xhr9Wazi2whURovmSuPiKD7PrtI9oNkCMiuXy9CgC+qtXkloTEucze9OXAIe4/A7
udfyJoCnbSPL4ULJe9nZN3SmXvqXcYQtx304z0hfBF12hnc3llVd/YaQqOWHYj5U
fEDzmNDD24/dj+CPSA+kPlB9WP6A/gP1iOARwyOQIaIZcSeizwjVkdwQtI7EjoSN
XaHUBHMIGkLA6vLD7fsG8fUQ2rqd5RQmxtUDc40FFo4XZNIEg0RY/i2LOvRiV4nE
Gxvja/ao/DXhQOau89seN2sH62pAmAMOmAG4MFGiXaBdx8DJ42hsPQxHpnPmRzak
tTd8hghe6FYveCPhQVClIXjJJ6QkeE0st2N5Ugo8ql5836vnAAIQa8G7uQn3WHC7
C1q7pl6sOMemt00oXFN64uFtDb17kckppEaaFvRwxvBuO9SUzK/2IdpSuk9cHVaQ
Jc/QcwriQ44zIzy/IYapAM7R2jKmSi6Ns0Gh6iT5WOCFwKcUPxhbxjjXZ6MlGUMC
4dqL4W4Mq8y53gJWQnzJRXlHf1WSy6HJ2DtgeuifCPuhov9HTW3rpwBo
-----END CERTIFICATE-----
