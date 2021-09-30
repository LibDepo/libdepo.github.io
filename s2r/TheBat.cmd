@echo off

>nul 2>&1 dism|| (start cmd /c "color 0c& mode 45,4& @echo/& @echo    *** Требуются права Администратора! ***& @echo/& @pause"& exit)
2>nul cd/d%windir%\sysnative&&(cmd/c"%~f0"&exit)
reg add "HKEY_CURRENT_USER\Software\RIT\The Bat!" /v "RegistrationBlock" /t REG_SZ /d "BvSFMUIHBgcICgsbzubu6/j9+uM0xv3r5/T0+R8cLR0jGAwa2xVDJRhC/McR5JGZJ8Kg1Yi72njA/2k9tOsZdFgmXYzq1nE34s+Gsm6SCA7jmiS4aScNUvJba1voA7dAXHT2MB1EQvI+Eioqx+TnZj1oc8RohMkKd2Io6EqctrgKYUNpw144uEGMmsDWDQ==" /f
start msiexec /i https://www.ritlabs.com/download/the_bat/archive/thebat_64_9-1-18.msi /passive
