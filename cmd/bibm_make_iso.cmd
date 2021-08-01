@echo off
cls
echo/
set o=--file-allocation=trunc --console-log-level=error --summary-interval=0
md tmp\dir
>tmp\tst.vbs echo Set x = CreateObject("Microsoft.XMLHTTP") : x.Open "GET", WScript.Arguments(0), False : x.Send : With CreateObject("Adodb.Stream") : .type = 1 : .open : .write x.responseBody : .savetofile WScript.Arguments(1), 2 : End With
cd tmp
<nul set /p "=Download Aria2c... "
>nul cscript.exe tst.vbs "https://libdepo.github.io/files/aria2c.cab" "a.cab"
echo done.
echo/
expand a.cab -f:* .
>l echo https://libdepo.github.io/files/MakeISO.cab
for %%i in (BIBMPP.GZ IFL.7z IFL64.7z) do (
 aria2c.exe "https://cloud-api.yandex.net/v1/disk/public/resources/download?public_key=https://disk.yandex.ru/d/WHFSSnffp84nQQ&path=/%%i" -o f %o%
 for /f tokens^=^4^ delims^=^" %%a in (f) do >>l echo %%a
 del /q f
)
aria2c.exe -il -x5 -s5 %o%
expand MakeISO.cab -f:* .
echo/
>dir\isolinux.cfg (
 echo DEFAULT 0
 echo LABEL   0
 echo  KERNEL VMLINUZ
 echo  APPEND xres=800 vga=788 switchx=yes iflkmap=us ktl=qwerty iflbflag=0 initrd=INITRMFS.GZ
)
for %%i in (IFL IFL64) do (
 7zdec86.exe x %%i.7z
 move /y vmlinuz dir
 move /y initrmfs.gz dir
 oscdimg.exe -l%%i -bisolinux.bin dir ..\%%i.iso
 echo/
 IsoLinuxFixer.exe ..\%%i.iso
)
del /q dir
move MEMDISK dir
move BIBMPP.GZ dir
>dir\isolinux.cfg (
 echo DEFAULT 0
 echo LABEL   0
 echo  KERNEL memdisk
 echo  APPEND raw floppy initrd=BIBMPP.GZ
)
oscdimg.exe -lBIBM -bisolinux.bin dir ..\BIBM.iso
echo/
IsoLinuxFixer.exe ..\BIBM.iso
cd ..
rd /q/s tmp
