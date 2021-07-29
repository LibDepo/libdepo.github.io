set sdi_drv=...

>d dir /b %sdi_drv%
set files=& for /f "tokens=1,2 delims=| " %%a in (
'aria -S sdi.torrent^| find ".7z"'
) do find "%%~nxb" d|| (
 call set files=%%files%%,%%a
 >>t echo %%~nxb
)
if not defined files goto :eof
aria --files=%files:~1%

for /f %%a in (t) do sdi -7z t %%a&& (
 set var=%%~na
 call set var=%%var:~0,-5%%
 call del /q %sdi_drv%\%%var%%_*.7z
 move %%a %sdi_drv%
)

for /r %%a in (DP_*.bin) do del /q "%%~dpa*.bin"& goto next
:next
sdi -nogui -reindex
del /q *.cfg& rd /q/s logs