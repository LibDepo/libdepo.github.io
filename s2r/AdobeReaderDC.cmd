REGEDIT4

;@echo off& cls& cd /d "%~dp0"
;>nul 2>&1 dism|| (start cmd /c "color 0c& mode 45,4& @echo/& @echo    *** Требуются права Администратора! ***& @echo/& @pause"& exit)
;2>nul cd/d%windir%\sysnative&&(cmd/c"%~f0"&exit)
;set "dir=%ProgramFiles(x86)%\Adobe\Acrobat Reader DC\Reader"
;if exist AdobeReaderDC\*.exe goto install
;2>nul md tmp& set url=https://ardownload2.adobe.com/pub/adobe/reader/win/AcrobatDC
;>tmp\tst.vbs echo set x=CreateObject("Microsoft.XMLHTTP") : x.Open "GET", WSh.Arguments(0), False : x.Send : With CreateObject("Adodb.Stream") : .type = 1 : .open : .write x.responseBody : .savetofile WSh.Arguments(1), 2 : End With
;cscript //nologo tmp\tst.vbs "https://libdepo.github.io/files/aria2c.cab" "tmp\aria.cab"
;expand tmp\aria.cab -f:*.exe tmp
;>tmp\list (
;echo %url%/1900820071/AcroRdrDC1900820071_ru_RU.exe
;echo %url%/2100720099/AcroRdrDCUpd2100720099.msp
;)
;tmp\aria2c -x8 -s8 -itmp\list -d AdobeReaderDC --file-allocation=trunc
;rd /q/s tmp
;:install
;AdobeReaderDC\AcroRdrDC1900820071_ru_RU.exe /sPB /msi DISABLE_ARM_SERVICE_INSTALL=1
;AdobeReaderDC\AcroRdrDCUpd2100720099.msp /passive /norestart
;schtasks /delete /tn "Adobe Acrobat Update Task" /f
;robocopy "%dir%\plug_ins" "%dir%\optional" Updater.api /mov
;>"%dir%\AcroApp\RUS\Viewer.aapp" echo ^<Application xmlns="http://ns.adobe.com/acrobat/app/2014" title="1" id="Viewer" majorVersion="1" requiresDoc="true" minorVersion="0"^>^</Application^>
;regedit /s "%~f0"
;exit

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Adobe\Acrobat Reader\DC\FeatureLockDown]
"bUpdater"=dword:00000000

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Adobe\Acrobat Reader\DC\FeatureLockDown\cServices]
"bToggleAdobeDocumentServices"=dword:00000001
"bTogglePrefsSync"=dword:00000001
"bToggleAdobeSign"=dword:00000001
"bToggleWebConnectors"=dword:00000001
"bToggleDocumentCloud"=dword:00000001

[HKEY_CURRENT_USER\Software\Adobe\Acrobat Reader\DC\IPM]
"bShowMsgAtLaunch"=dword:00000000

[HKEY_CURRENT_USER\Software\Adobe\Acrobat Reader\DC\Originals]
"iPageViewLayoutMode"=dword:00000002

[HKEY_CURRENT_USER\Software\Adobe\Acrobat Reader\DC\AVGeneral]
"bHideShareButtonLabel"=dword:00000001
"bRHPSticky"=dword:00000001

[HKEY_CURRENT_USER\Software\Adobe\Acrobat Reader\DC\RememberedViews]
"iRememberView"=dword:00000002
