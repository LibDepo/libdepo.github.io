With WScript.CreateObject("WScript.Shell").CreateShortcut("C:\Windows\depo.lnk")
 .TargetPath = "cmd"
 .Arguments = "/c curl -so ""%USERPROFILE%\Downloads\depo.zip"" ""https://getspace.cloud/cloud/s/KTWHwQN9cn8H6Kt/download?path=/DEPO""& explorer ""%USERPROFILE%\Downloads\depo.zip""\DEPO"
 .WindowStyle = "7"
 .IconLocation = "C:\Windows\System32\imageres.dll,226"
 .Save
End With
WSh.Echo "ярлык C:\Windows\depo.lnk успешно создан!"
