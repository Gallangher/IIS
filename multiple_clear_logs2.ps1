###########################################
#IIS logs purge script by Krzysztof Gerus#
###########################################




Get-Content .\server.txt | %{

#Variables
$path = "\c$\Windows\System32\LogFiles\HTTPERR "
$path_old_logs = "E:\IISLogs\W3SVC1\OLD_logs\"
$ReportFile = "c:\temp\purgeReport.txt"
$date = Get-Date
$days_move = 14
$days_delete = 180
 $Longpath = "\\"+$_+$path

 Write-Host $Longpath



 #Deleting files older than 180 days
[ARRAY]$ToDelete = Get-ChildItem -Path $longpath | ?{ ($date - $_.LastWriteTime).TotalDays -gt $days_delete }
$report = @()
$report += "Purge report for $($date.ToString('dd.MM.yyyy HH:mm:ss'))"
if ($ToDelete) {
	$report += "Removed $($ToDelete.Count) file(s):"
	$ToDelete | %{ $report += $($_.FullName.ToString()) }
	$ToDelete | %{ Remove-Item $_.FullName -Force }

	}
	else {
		$report += "No files to remove"
		}
$report += "----------------------------------------------"
$report | Out-File $ReportFile -Append
}


#Moving files older than 14 days
[ARRAY]$ToMove = Get-ChildItem -Path $path | ?{ ($date - $_.LastWriteTime).TotalDays -gt $days_move }
if ($ToMove) {
	$ToMove | %{ Copy-Item $_.FullName -Force -Destination $path_old_logs }
	$ToMove | %{  Remove-Item $_.FullName -Force }

}
