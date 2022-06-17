@echo off
>nul 2>&1 dism|| (echo/& echo Admin rights required!& echo/& pause& goto :eof)

set dir=%tmp%\$$_%random%_$$
<nul set /p "=Preparing...  "
>nul 2>&1 (
 rd /q/s %dir%& del /f/a/q %dir%& md %dir%
 pushd %dir%|| goto err
 certutil -decode "%~f0" d&& expand -r d .|| goto err
)
echo done.
<nul set /p "=Installing... "
>t.vbs echo set x=CreateObject("Microsoft.XMLHTTP") : x.Open "GET", WSh.Arguments(0), False : x.Send : With CreateObject("Adodb.Stream") : .type = 1 : .open : .write x.responseBody : .savetofile WSh.Arguments(1), 2 : End With

for %%i in (authroots updroots roots delroots disallowedcert) do 2>nul (
 cscript //nologo t.vbs http://download.windowsupdate.com/msdownload/update/v3/static/trustedr/en/%%i.sst %%i.sst
 if not exist %%i.sst goto err
)
updroots authroots.sst
updroots updroots.sst
updroots -l roots.sst
updroots -d delroots.sst
updroots -l -u disallowedcert.sst

echo done.
goto quit
:err
echo failed!
:quit
popd
rd /q/s %dir%
goto :eof

-----BEGIN CERTIFICATE-----
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
pbgSsVIHDozNO8rnnse/DzTiKjUPAKK2tKFN+Og=
-----END CERTIFICATE-----
