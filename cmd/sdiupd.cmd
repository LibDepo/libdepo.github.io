@echo off
cd /d "%~dp0"
2>nul rd /q/s tmp& md tmp

if not exist ..\SDI_R*.exe if not exist ..\drivers if /i "%1" neq "scheme" goto empty
if exist bin\aria2c.exe goto next
>tmp\tst.vbs echo Set x = CreateObject("Microsoft.XMLHTTP") : x.Open "GET", WScript.Arguments(0), False : x.Send : With CreateObject("Adodb.Stream") : .type = 1 : .open : .write x.responseBody : .savetofile WScript.Arguments(1), 2 : End With
cscript.exe tmp\tst.vbs "https://libdepo.github.io/files/aria2c.cab" "tmp\a.cab"
md bin& expand tmp\a.cab -f:* bin

:next
bin\aria2c.exe http://driveroff.net/SDI_Update.torrent -d tmp --follow-torrent=false
>tmp\s bin\aria2c.exe -S tmp\SDI_Update.torrent
>tmp\z <tmp\s find /i ".7z"

if /i "%1"=="scheme" goto scheme
if not exist ..\SDI_R*.exe call :renew
for %%i in (..\SDI_R*.exe) do set sdi.exe=%%~nxi
2>nul >tmp\d dir /b ..\drivers\*.7z

set only=& (if /i "%1"=="only" set only=1)& if exist only* set only=1
setlocal EnableDelayedExpansion
if defined only (
for /f "tokens=1,2 delims=| " %%a in (tmp\z) do ^
for /f %%i in (tmp\d) do (
 set var=%%~ni
 set var=!var:~0,-5!
 set src=%%~nb
 set src=!src:~0,-5!
 if /i !var!==!src! if /i %%~ni neq %%~nb set files=!files!,%%a& >>tmp\t echo %%~nxb
)) else ^
for /f "tokens=1,2 delims=| " %%a in (tmp\z) do >nul find /i "%%~nxb" tmp\d||(set files=!files!,%%a& >>tmp\t echo %%~nxb)
endlocal& set files=%files%

if not defined files (
 >tmp\t echo No driver pack updates found.
 goto logging
)
bin\aria2c.exe tmp\SDI_Update.torrent -d tmp --seed-time=0 --file-allocation=trunc --select-file=%files:~1% --dht-file-path=bin\dht.dat --bt-request-peer-speed-limit=1M --bt-exclude-tracker="http://retracker.local/announce" --stop=10800

for /r %%i in (DP_*.7z) do set "pth=%%~dpi"

for /f %%a in (tmp\t) do ..\%sdi.exe% -7z t "%pth%%%a"&& (
 set var=%%~na
 call set var=%%var:~0,-5%%
 call del /q ..\drivers\%%var%%*.7z
 move "%pth%%%a" ..\drivers
)|| >>tmp\err echo ERROR: %%a
if defined var (
 pushd ..\indexes
 del /q/s *.bin
 cd ..
 %sdi.exe% -nogui -reindex -nologfile -preservecfg
 popd
)
:logging
>nul find /i "%sdi.exe%" tmp\s|| call :renew
>>log.txt (
 echo --- %date% ------------------------------
 if defined fname echo %fname%
 type tmp\t
 if exist tmp\err type tmp\err
 echo ---------------------------------------------
 echo/
)
rd /q/s tmp
goto :eof

:scheme
2>nul rd /q/s scheme& md scheme\drivers
setlocal EnableDelayedExpansion
for /f "tokens=2 delims=|" %%a in (tmp\z) do (
 set var=%%~na
 set var=!var:~0,-5!xxxxx.7z
 >scheme\drivers\!var! rem/
)
endlocal
echo -d| >nul xcopy "%~f0" scheme\sdiupd
>scheme\sdiupd\only rem/
for /f "tokens=1*" %%a in ('findstr /bc:":::" "%~f0"') do >>scheme\zrun.cmd echo %%b
rd /q/s tmp
goto :eof

::: @echo off
::: set xOS=x64_& if %PROCESSOR_ARCHITECTURE%==x86 if not defined PROCESSOR_ARCHITEW6432 set "xOS="
::: >%tmp%\sdi.cfg echo -hidepatreon -nologfile -nosnapshot -norestorepnt "-theme:Classic" -license:1 -showdrpnames2 -expertmode
::: for %%i in ("%~dp0SDI_%xOS%R*.exe") do start %%i -cfg:%tmp%\sdi.cfg& exit

:empty
>tmp\tst.vbs echo WScript.Echo MsgBox(Replace(WScript.Arguments(0), "^", vbCrLf), WScript.Arguments(1), WScript.Arguments(2))
for /f %%a in (
'cscript.exe //nologo tmp\tst.vbs "Не найдена необходимая структура папок!^Перейти на сайт для получения справки?^^<Да>   : перейти на сайт^<Нет> : создать схему развёртывания^ " 19 " Ошибка"'
) do if %%a==6 (start https://usbtor.ru/viewtopic.php?t=2122) else if %%a==7 call "%~f0" scheme
2>nul rd /q/s tmp bin
goto :eof

:renew
for /f "tokens=2 delims=|" %%a in ('^<tmp\s findstr /irc:"SDI_R[0-9]*.exe"') do set fname=%%~na.zip
bin\aria2c.exe http://sdi-tool.org/releases/%fname% -d tmp

>tmp\tst.vbs echo With CreateObject("Shell.Application") .NameSpace(WScript.Arguments(0)).CopyHere(.NameSpace(WScript.Arguments(1)).Items) End With
md tmp\new& cscript.exe tmp\tst.vbs "%CD%\tmp\new" "%CD%\tmp\%fname%"
del /q ..\SDI_*.*
robocopy.exe /e /move "%CD%\tmp\new" ..

