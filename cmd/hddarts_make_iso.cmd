@echo off
cls
echo/
md tmp\dir
>tmp\tst.vbs echo Set x = CreateObject("Microsoft.XMLHTTP") : x.Open "GET", WScript.Arguments(0), False : x.Send : With CreateObject("Adodb.Stream") : .type = 1 : .open : .write x.responseBody : .savetofile WScript.Arguments(1), 2 : End With
cd tmp
<nul set /p "=Download MakeISO... "
>nul cscript.exe tst.vbs "https://libdepo.github.io/files/MakeISO.cab" "a.cab"
echo done.
<nul set /p "=Download HDDaRTs... "
>nul cscript.exe tst.vbs "https://libdepo.github.io/files/HDDaRTs.7z" "h.7z"
echo done.
echo/
expand a.cab -f:* .
echo/
7zdec86.exe x h.7z
echo/
move MEMDISK dir
move ISOLINUX.CFG dir
move Extra\HDDaRTs.gz dir
oscdimg.exe -lHDDARTS -bisolinux.bin dir ..\HDDaRTs.iso
echo/
IsoLinuxFixer.exe ..\HDDaRTs.iso
cd ..
rd /q/s tmp
