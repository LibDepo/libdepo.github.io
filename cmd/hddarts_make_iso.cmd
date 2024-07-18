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
>nul cscript.exe tst.vbs "https://libdepo.github.io/files/HDDaRTs.gz" "dir\HDDaRTs.gz"
echo done.
echo/
expand a.cab -f:* .
echo/
move MEMDISK dir
move ISOLINUX.CFG dir
oscdimg.exe -lHDDARTS -bisolinux.bin dir ..\HDDaRTs.iso
echo/
IsoLinuxFixer.exe ..\HDDaRTs.iso
cd ..
rd /q/s tmp
