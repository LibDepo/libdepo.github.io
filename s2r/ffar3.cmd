@echo off
for /f "delims=" %%a in ('
curl -sf "https://farmanager.com/download.php?l=ru"^| find ".msi"
') do set "ln=%%a"& goto next
:next
setlocal EnableDelayedExpansion
for /l %%i in (1,1,2000) do if "!ln:~%%i,11!"=="files/Far30" call :chk %%i&& (
 msiexec /i "https://farmanager.com/!ln:~%%i,33!" /passive
 cd /d "%ProgramFiles%\Far Manager"&& (
  echo/
  echo Download: Far3 modding
  curl -O# https://libdepo.github.io/files/far3mod.7z
  tar -xf far3mod.7z
  del /q far3mod.7z
 )
 goto :eof
)
:chk
set /a p1=%1+16, p2=%1+29
if "!ln:~%p1%,5!"==".x64." if "!ln:~%p2%,4!"==".msi" exit /b 0
exit /b 1
