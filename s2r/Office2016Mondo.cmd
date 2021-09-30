@echo off

>nul 2>&1 dism|| (start cmd /c "color 0c& mode 45,4& @echo/& @echo    *** Требуются права Администратора! ***& @echo/& @pause"& goto :eof)
2>nul cd/d%windir%\sysnative&&(cmd/c"%~f0"&exit)

cd /d "%~dp0"
if exist Office2016Mondo\Office\Data\v64.cab cd Office2016Mondo& goto install

set "url=https://download.microsoft.com/download/2/7/A/27AF1BE6-DD20-4CB4-B154-EBAB8A7D4A7E/officedeploymenttool_14326-20404.exe"
md tmp& cd tmp
>tst.vbs echo set x=CreateObject("Microsoft.XMLHTTP") : x.Open "GET", WSh.Arguments(0), False : x.Send : With CreateObject("Adodb.Stream") : .type = 1 : .open : .write x.responseBody : .savetofile WSh.Arguments(1), 2 : End With
:load
cscript //nologo tst.vbs "%url%" "odt.exe"
if not exist odt.exe goto load

odt.exe /extract:. /quiet
>nul robocopy . ..\Office2016Mondo setup.exe /mov

set "url=https://raw.githubusercontent.com/OfficeDev/Office-IT-Pro-Deployment-Scripts/master/Office-ProPlus-Deployment/Deploy-OfficeClickToRun/OffScrubc2r.vbs"
cscript //nologo tst.vbs "%url%" "..\Office2016Mondo\OffScrubC2R.vbs"
cd ..\Office2016Mondo& rd /q/s ..\tmp

for /f "tokens=1 delims=[]" %%a in ('find /n "exit" "%~f0"') do >config.xml <"%~f0" more +%%a
>uninstall.cmd echo Cscript.exe OffScrubC2R.vbs ALL /Quiet /NoCancel /Force /OSE
echo/
echo Download Office 2016 Mondo...
setup.exe /download config.xml

:install
setup.exe /configure config.xml

if exist "%ProgramFiles%\Microsoft Office\Office16\ospp.vbs" cd /d "%ProgramFiles%\Microsoft Office\Office16"
if exist "%ProgramFiles(x86)%\Microsoft Office\Office16\ospp.vbs" cd /d "%ProgramFiles(x86)%\Microsoft Office\Office16"

for /f %%x in ('dir /b ..\root\Licenses16\MondoVL_KMS*.xrm-ms') do cscript ospp.vbs /inslic:"..\root\Licenses16\%%x"
for /f %%x in ('dir /b ..\root\Licenses16\MondoVL_MAK*.xrm-ms') do cscript ospp.vbs /inslic:"..\root\Licenses16\%%x"

cscript ospp.vbs /inpkey:HFTND-W9MK4-8B7MJ-B6C4G-XQBR2
cscript ospp.vbs /sethst:kms.digiboy.ir
cscript ospp.vbs /act

exit
<!-- 
 "Groove" = OneDrive for business
 "Lync"   = Skype for business
-->

<Configuration>
  <Add OfficeClientEdition="64">
    <Product ID="MondoRetail">
      <Language ID="MatchOS" />
<!--
      <ExcludeApp ID="Word" />
      <ExcludeApp ID="Excel" />
      <ExcludeApp ID="Access" />
      <ExcludeApp ID="PowerPoint" />
      <ExcludeApp ID="Visio" />
      <ExcludeApp ID="Outlook" />
-->
      <ExcludeApp ID="Groove" />
      <ExcludeApp ID="OneDrive" />
      <ExcludeApp ID="Lync" />
      <ExcludeApp ID="OneNote" />
      <ExcludeApp ID="Publisher" />
      <ExcludeApp ID="Project" />
    </Product>
  </Add>
  <Display Level="Full" AcceptEULA="TRUE" />
  <Property Name="AUTOACTIVATE" Value="0" />
  <Property Name="FORCEAPPSHUTDOWN" Value="TRUE" />
  <Updates Enabled="FALSE" />
</Configuration>
