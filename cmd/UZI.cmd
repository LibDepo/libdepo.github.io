@echo off
>nul chcp 65001
for /f %%a in ('echo prompt $H^| cmd') do set "del=%%a"
echo/
echo =================================================
echo 	Unblocking files from unsafe zone
echo =================================================
echo/
if "%~1"=="" cd /d "%~dp0"
if /i "%~1" neq "/l" (call :chk %1) else for /f "delims=" %%b in (
'type "%~2"^| (^>nul (pause ^& pause ^& pause^)^& findstr "^"^)'
) do call :chk "%%~b"
echo/
echo =================================================
echo  Done.
echo/
pause
goto :eof
:chk
2>nul (
 for /f "delims=" %%a in ('dir /s/b/a-d %1') do <"%%~a":Zone.Identifier set /p "~="&& (
  rem/>"%%~a":Zone.Identifier&& call :out 0A "Unblocked"|| call :out 0C "Access denied"
 )|| call :out 07 "Skipped"
)
exit /b
:out
pushd %tmp%& <nul>"%~2" set/p"=%del%"& findstr/rva:%1 "^$" "%~2" nul& del/q "%~2"& popd
for %%` in (`) do echo : 	%%a
