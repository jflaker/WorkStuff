﻿$csvPath = "C:\Users\it-temp\Desktop\Scripts\drives.csv"
$drives = Import-Csv -Path $csvPath
#$credential = Get-Credential
Clear-Host

foreach ($drive in $drives) {
    $driveLetter = $drive.DriveLetter
    $networkPath = $drive.NetworkPath

    if (!(Test-Path -Path "$driveLetter\")) {
        Write-Output "$driveLetter is not connected. Attempting to reconnect..."
        New-PSDrive -Name $driveLetter.TrimEnd(':') -PSProvider FileSystem -Root $networkPath -Credential $credential -Persist
        if (Test-Path -Path "$driveLetter\") {
            Write-Output "$driveLetter has been successfully reconnected."
        } else {
            Write-Output "Failed to reconnect $driveLetter."
        }
    } else {
        Write-Output "$driveLetter is already connected."
    }
}
