@echo off

if exist %windir%\sysnative\ %windir%\sysnative\cmd /c "%~fs0"& goto :eof
>nul 2>&1 dism|| (
 mshta "vbscript:CreateObject("Shell.Application").ShellExecute("%~fs0", "", "", "runas", 1) & Close()"
 goto :eof
)
if "%1"=="run" (
 title     *** Create 2-partition USB-drive ***
 chcp 860
 mode 80,40
 goto run
)
for %%i in ("reg add HKCU\Console\C2PUD /f /v") do (
 %%~i "FontSize"	/t REG_DWORD	/d 0x0010000c
 %%~i "FontFamily"	/t REG_DWORD	/d 0x00000030
 %%~i "FaceName"	/t REG_SZ	/d "Terminal"
)
start "C2PUD" cmd /c "%~f0" run
goto :eof

:run
cls
set tmp=%windir%\temp
2>nul md %tmp%
>%tmp%\s echo lis dis
diskpart /s %tmp%\s
echo/
set dsk=& set /p "dsk=Select disk number [empty = quit]: "|| goto quit
cls
>%tmp%\s (
 echo sel dis %dsk%
 echo det dis
)
diskpart /s %tmp%\s
call :isOK|| goto run
:size
echo/
echo/
set sz=& set /p "sz=1st part: enter FAT32 partition size, Mb [empty = quit, max = 32768]: "|| goto quit
if /i "%sz%"=="max" set sz=32768
2>nul set /a sz=%sz%|| goto size
if %sz%==0 goto size
if %sz% gtr 32768 (
 mshta vbscript:Execute("MsgBox ""Max. size of FAT32 partition is 32Gb!"",16,"" Error"":close"^)
 goto size
)
echo/
choice /m "2nd part: select file system [1 = exFAT, 0 = NTFS]:" /c 10 /n
if %errorlevel%==1 (set fs=exFAT) else set "fs=NTFS "
cls
>%tmp%\s (
 echo sel dis %dsk%
 echo det dis
)
diskpart /s %tmp%\s
echo/
echo/
echo   New partitioning:
echo   -----------------------------------
echo   FAT32 partition size is %sz% Mb
echo                  +
echo   %fs% partition size is remaining
echo   -----------------------------------
call :isOK|| goto run

>%tmp%\s (
 echo sel dis %dsk%
 echo cle
)
diskpart /s %tmp%\s
>%tmp%\s (
 echo sel dis %dsk%
 echo cle
 echo cre par prim size=%sz%
 echo act
 echo for fs=fat32 quick
 echo ass
 echo remove
 echo ass
 echo cre par prim
 echo for fs=%fs% quick
 echo ass
)
diskpart /s %tmp%\s
mshta vbscript:Execute("MsgBox ""Creating a USB-drive is completed!"",64,"" Information"":close")
goto quit

:isOK
echo/
echo/
choice /m "Is this correct"
if %errorlevel%==2 exit /b 1
exit /b 0

:quit
reg delete HKCU\Console\C2PUD /f
del /q %tmp%\s
