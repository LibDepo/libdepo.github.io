@echo off

>nul 2>&1 dism|| (start cmd /c "color 0c& mode 45,4& @echo/& @echo    *** Требуются права Администратора! ***& @echo/& @pause"& exit)
2>nul cd/d%windir%\sysnative&&(cmd/c"%~f0"&exit)

cd /d "%~dp0"
set "url=https://totalcommander.ch/win/tcmd1000x64.exe"
for %%i in (%url%) do set "fname=TotalCMD\%%~nxi"

:load
if exist %fname% goto install
2>nul md TotalCMD
>tst.vbs echo set x=CreateObject("Microsoft.XMLHTTP") : x.Open "GET", WSh.Arguments(0), False : x.Send : With CreateObject("Adodb.Stream") : .type = 1 : .open : .write x.responseBody : .savetofile WSh.Arguments(1), 2 : End With
cscript //nologo tst.vbs "%url%" "%fname%"
del /q tst.vbs
goto load

:install
%fname% /AMGDU
certutil -decode "%~f0" "%ProgramW6432%\totalcmd\WINCMD.KEY"
exit

-----BEGIN CERTIFICATE-----
XWNS4FlqTa4ChWEYL26dbZNZ3QnUVE24sYQ2qQRdw2jDs0cNdY672YLfHWvPdPlZ
vCeG0grh5a1tCmbl5H2fYa74peFFEEoWUgOB+P3fv+WQPoed7BeS+jDQeJlcdvUS
Sw3nl0RESUMPidj269rqPqXkKRczYr/EgXmdTeaORYjCT+4kvZsjlxMzfjuYvZk/
gT56/S67g7nHiqqby1C2GfW7mHl+bGmZZTZVVJJ9WIF1ucgMbPbNRumB6ogaHEoG
ME6Lit/c+vTl/Uf4qK3V+RbcjanSvYj4IpnUd6f0/UAoMymy6yQbanOaiLCb9nh8
JQEIEUEWzCMRq9zE01758d9dtqsTv5KKLcx1Ao3d+xbs5GnyyDLJTStRPCITNAEq
S5EKNBr3AjyZV3GobyoNQgY6gCwRZ8Y4A18myR6SuW3q20EtaE7/Qv0ZEvNZHHBp
RI1Xn5NanbPzLi4w04yMV1thVBOa6UJkIGUhC8LTwP0J4UOSAilBTt/jSFsjEfzG
KFo+Ww7qS+CXlmf0VLL0qM4QpGTgcc5RkGWbJV0ilJcdtdXLNhPTL6PopMj6pkhV
WzGp5Hiij5vkSpt+jl/aGN5vtPmzhYicw8cLD2wj4pL0TeBXj5b+zWD5Kg5QGEoa
iRqfQe6c5xnyhZwp6YidQSMCQtLvB9N6gjSZF91uCzAIzSs/Hz+R3c7CXtU95zrU
eyXzZKYW3Vy+84YifrAAr7lyBV/25NEYcV1jyKIueEKLyWJi9myb0Mv4GUwbx4w8
DMl9L7vxEKjX3mF0oVUrjPeIdHmARK3JDeuMGkwwAgGErV03fkcMQUwXugXk2FVU
dd/kwphnAJt6c+tLJSiLYj+YWknga+rcceWu8AwS7OHkmpb6GwAmP8tdwxff0Mvd
1/83j/LAOJ6LfgZ3fKUTQk8NHarjb8dQqIf0JtJRLOZm7dJV/3Zllp1jkt4uCd1p
+m9KX9vwjwU16PbHC+n6rwx3L63lbECr9JYTPXT/xD7WGcv6x0gtTKiRDL/Kjo1n
QpvOFBoCjk+IlkhlZF298SSCA9Zs8ZSpId5Htbg1JDKK0rQqtyNw2x/sMZZunlXI
+7jJUJcjSMtR9DYDrPcqTHFETTDCkZdrphdwkpYFrVwngZtF9SDJFhEXvOpB1m2s
BMiQGOBLdkKt7RpWKIj8uPjNm55aiQiCuaN+ZVufE45Db3B5cmlnaHQgqSAxOTk5
IGJ5IENocmlzdGlhbiBHaGlzbGVyLCBDLiBHaGlzbGVyICYgQ28uLCBhbGwgcmln
aHRzIHJlc2VydmVkLiBVbmF1dGhvcml6ZWQgY29weWluZyBwcm9oaWJpdGVkIQCI
/lcvjbllY5//R9qXVB+fLg==
-----END CERTIFICATE-----
