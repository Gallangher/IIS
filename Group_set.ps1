$servers = 
"SVFL-WEB-P021",
"SVFL-WEB-P022",
"SVFL-WEB-P023",
"SVFL-WEB-P024",
"SVFL-WEB-A021",
"SVFL-WEB-A022",
"SVFL-WEB-A023",
"SVFL-WEB-A024",
"SVFL-WEB-O021",
"SVFL-WEB-O022",
"SVFL-WEB-O023",
"SVFL-WEB-O024",
"SVFL-WEB-T021",
"SVFL-WEB-T022",
"SVFL-WEB-T023",
"SVFL-WEB-T024"


foreach ( $server in $servers)
{
# Write-Host $server


<# 
#create local groups IIS users
    $IIS_group_path ="OU=L-Z,OU=Servers,OU=Local Resource Groups,OU=Groups,OU=Cegeka,DC=ndis,DC=be"
    $IIS_users = "DL_Server_"+$server+"_IIS_IUSRS"
    $IIS_description = "Application pools accounts on "+$server
     #   New-ADGroup -Name $IIS_users -SamAccountName $IIS_users -GroupCategory Security -GroupScope DomainLocal -DisplayName $IIS_users -Path $IIS_group_path -Description $IIS_description
    write-host $IIS_users "has been created"

DONE

DL_Server_SVFL-WEB-P021_IIS_IUSRS has been created
DL_Server_SVFL-WEB-P022_IIS_IUSRS has been created
DL_Server_SVFL-WEB-P023_IIS_IUSRS has been created
DL_Server_SVFL-WEB-P024_IIS_IUSRS has been created
DL_Server_SVFL-WEB-A021_IIS_IUSRS has been created
DL_Server_SVFL-WEB-A022_IIS_IUSRS has been created
DL_Server_SVFL-WEB-A023_IIS_IUSRS has been created
DL_Server_SVFL-WEB-A024_IIS_IUSRS has been created
DL_Server_SVFL-WEB-O021_IIS_IUSRS has been created
DL_Server_SVFL-WEB-O022_IIS_IUSRS has been created
DL_Server_SVFL-WEB-O023_IIS_IUSRS has been created
DL_Server_SVFL-WEB-O024_IIS_IUSRS has been created
DL_Server_SVFL-WEB-T021_IIS_IUSRS has been created
DL_Server_SVFL-WEB-T022_IIS_IUSRS has been created
DL_Server_SVFL-WEB-T023_IIS_IUSRS has been created
DL_Server_SVFL-WEB-T024_IIS_IUSRS has been created


#>


<# 

            #add group to loacal IIS groups
            #TBD

#> 

            #add new provided accounts for local Admins,
            #wait for LocalAdmins group
                $LocalAdminGroup="DL_Server_"+$server+"_LocalAdmins"
                $admins = "ORG_56146426_L","ORG_56146426_K","ORG_56146426_K","ORG_56146426_U"
                foreach($admin in $admins)
                    {
                    Add-ADGroupMember -Identity $LocalAdminGroup -Members $admin -WhatIf
                    }

#>

}
