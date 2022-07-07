# Script collect almost all information from IIS about websites.

# author:
# Krzysztof Gerus
# Gallanger - G.IT Solution
# 



Import-Module WebAdministration


$filename = "websites{0:yyyyMMdd-HHmm}" -f (Get-Date)

$hostname = hostname
$Websites = Get-ChildItem IIS:\Sites 
$date = (Get-Date).ToString('MMddyyyy')
foreach ($Site in $Websites) {
  
      #check is Default Web Site - this site is ignored in report 
     if ($site.name -ne "Default Web Site") 
    {


                $Binding = $Site.bindings
                [string]$BindingInfo = $Binding.Collection
                [string[]]$Bindings = $BindingInfo.Split(" ")#[0]
                $i = 0
                $status = $site.state
                $path = $site.PhysicalPath
                $fullName = $site.name

               #websites have last part of name -T, -A, -O, -P or 
               $state = $site.name.substring(0,$site.name.LastIndexOf("-"))
               $Envinroment = $site.name.substring($site.name.LastIndexOf("-")+1)   

                $status = $site.State
                $applicationPool = $site.applicationPool


                $appPoolDetails = Get-ChildItem -Path IIS:\AppPools\ |where {$_.name -Match $applicationPool } 

                $anon = get-WebConfigurationProperty -Filter /system.webServer/security/authentication/AnonymousAuthentication -Name Enabled -PSPath IIS:\sites -Location $site.name | select-object Value
                $basic = get-WebConfigurationProperty -Filter /system.webServer/security/authentication/BasicAuthentication -Name Enabled -PSPath IIS:\ -location $site.name | select-object Value
                Do{
                    if( $Bindings[($i)] -notlike "sslFlags=*"){
                        [string[]]$Bindings2 = $Bindings[($i+1)].Split(":")
                        $obj = New-Object PSObject
                        $obj | Add-Member Date $Date
                        $obj | Add-Member Host $hostname


                        $obj | add-Member ApplicationPool_managedRuntimeVersion    $appPoolDetails.managedRuntimeVersion
                        $obj | add-Member ApplicationPool_managedPipelineMode      $appPoolDetails.managedPipelineMode


                        $obj | Add-Member FullSiteName $Site.name
                        $obj | Add-Member State $state
                        $obj | Add-Member Envinroment  $Envinroment
                        $obj | Add-Member SiteID $site.id

                        $obj | Add-Member ItemXPath $site.ItemXPath

                        $obj | Add-member Path $site.physicalPath
                        $obj | Add-member Logs $site.logFile.directory
                        $obj | Add-Member Protocol $Bindings[($i)]
                        $obj | Add-Member Port $Bindings2[1]
                        $obj | Add-Member Header $Bindings2[2]
                        $obj | Add-member AuthAnon $Anon.value
                        $obj | Add-member AuthBasic $basic.value
                        $obj | Add-member WinAuth $winAuth.value
                        $obj | Add-member Status $status

                        $obj | Add-Member ApplicationPool $applicationPool

                        $obj | Add-Member ApplicationPool_Name      $appPoolDetails.name
                        $obj | Add-Member ApplicationPool_UserName  $appPoolDetails.processModel.userName

                        $obj | Add-Member ApplicationPool_Identity  $appPoolDetails.processModel.identityType
                        $obj | add-Member ApplicationPool_site      $appPoolDetails.state
                     $obj | Add-Member ApplicationPool_UserPass  $appPoolDetails.processModel.password

                       $obj | export-csv "c:\temp\$hostname-$filename.csv" -Append -notypeinformation
                        $i=$i+2
                    }
                    else{$i=$i+1}
                } while ($i -lt ($bindings.count))



    }

Else 
{Write-Host - "default web site - skipped"}
}
