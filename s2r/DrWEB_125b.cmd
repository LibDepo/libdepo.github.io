@echo off

>nul 2>&1 dism|| (start cmd /c "color 0c& mode 45,4& @echo/& @echo    *** Требуются права Администратора! ***& @echo/& @pause"& exit)
2>nul cd/d%windir%\sysnative&&(cmd/c"%~f0"&exit)

cd /d "%~dp0"
if exist DrWEB\*.exe goto install
md tmp& set "url=https://libdepo.github.io/files/aria2c.cab"
>tmp\tst.vbs echo set x=CreateObject("Microsoft.XMLHTTP") : x.Open "GET", WSh.Arguments(0), False : x.Send : With CreateObject("Adodb.Stream") : .type = 1 : .open : .write x.responseBody : .savetofile WSh.Arguments(1), 2 : End With
cscript //nologo tmp\tst.vbs "%url%" "tmp\aria.cab"
expand tmp\aria.cab -f:*.exe tmp
set "url=https://beta.drweb.ru/files/?unreg=t&p=win/12.5"
tmp\aria2c.exe "%url%/drweb-1250-win-space-beta-nightly.exe&lng=ru&t=f" -x5 -s5 -d DrWEB --file-allocation=trunc
tmp\aria2c.exe "%url%/keys/drweb32.key&lng=ru&t=f" -d DrWEB
tmp\aria2c.exe https://download.geo.drweb.com/pub/drweb/tools/drw_remover.exe -d DrWEB
rd /q/s tmp

>DrWEB\Getkey.url (
 echo [InternetShortcut]
 echo URL=https://beta.drweb.ru/files/?unreg=t^&p=win%%2F12.5%%2Fkeys%%2Fdrweb32.key^&lng=ru^&t=f
)
:install
DrWEB\drweb-1250-win-space-beta-nightly.exe /reboot yes /lang ru /silent yes
