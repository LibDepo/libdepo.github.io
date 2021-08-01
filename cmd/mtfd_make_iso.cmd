@echo off
cls
echo/
md tmp\dir
>tmp\tst.vbs echo Set x = CreateObject("Microsoft.XMLHTTP") : x.Open "GET", WScript.Arguments(0), False : x.Send : With CreateObject("Adodb.Stream") : .type = 1 : .open : .write x.responseBody : .savetofile WScript.Arguments(1), 2 : End With
cd tmp
<nul set /p "=Download MakeISO... "
>nul cscript.exe tst.vbs "https://libdepo.github.io/files/MakeISO.cab" "a.cab"
echo done.
<nul set /p "=Download MTFD... "
>nul cscript.exe tst.vbs "https://libdepo.github.io/files/MTFD.GZ" "MTFD.GZ"
echo done.
echo/
expand a.cab -f:* .
echo/
move MEMDISK dir
move MTFD.GZ dir
>dir\isolinux.cfg (
 echo DEFAULT 0
 echo LABEL   0
 echo  KERNEL memdisk
 echo  APPEND raw floppy initrd=MTFD.GZ
)
oscdimg.exe -lMTFD -bisolinux.bin dir ..\MTFD.iso
echo/
IsoLinuxFixer.exe ..\MTFD.iso
cd ..
rd /q/s tmp
