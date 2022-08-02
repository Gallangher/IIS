function PurgeFiles($TargetDir, $Extensions, $DaysOld)
{
    $DaysOld = 0 - $DaysOld
    foreach ($File in Get-ChildItem $TargetDir -recurse -include $Extensions)
    {
        if ($File.LastWriteTime -lt ($(Get-Date).AddDays($DaysOld)))
        {
            $FileName = $File.FullName
            Remove-Item $FileName -Force
        }
    }
}

PurgeFiles -TargetDir D:\Logs\IIS\W3SVC1 -Extensions @("u_ex*.log") -DaysOld 31
PurgeFiles -TargetDir D:\Logs\IIS\W3SVC2 -Extensions @("u_ex*.log") -DaysOld 31
