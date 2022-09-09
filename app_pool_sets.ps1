

Import-Module WebAdministration

Set-ItemProperty IIS:\AppPools\$appPoolName -name processModel -value @{userName="user_name";password="password";identitytype=3}
Set-ItemProperty IIS:\AppPools\$appPoolName -name managedRuntimeVersion -value v4.0	
Set-ItemProperty IIS:\AppPools\$appPoolName  -name enable32BitAppOnWin64 -value FALSE
