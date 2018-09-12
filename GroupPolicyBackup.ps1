#Josh Gold
#This Powershell script backs up all Microsoft Group Policy Objects for a single domain and deletes backups older than 45 days

#Use these two lines if you want to force the script to follow Powershell best practices
Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

#Use this line if you want to push through any errors without screen output
#$ErrorActionPreference = "SilentlyContinue"

Import-Module GroupPolicy

#Path to the Root Folder
$PathName = "D:\SomeFolder\IT\Group Policy\Backups"

#Backs up all Group Policy Objects to specificed path
Get-GPO -All | foreach { Backup-GPO -Name $_.DisplayName -Path $PathName -Comment $_.DisplayName }

# Enter a number to indicate how many days old the identified file needs to be (must have a "-" in front of it).
$HowOld = -60

#Delete folders and files older than 60 days
#Remove the "-WhatIf" at the end, else the script will only show the files rather than delete them.

get-childitem $PathName -recurse | where {$_.lastwritetime -lt (get-date).adddays($HowOld) -and -not $_.psiscontainer} |% {remove-item $_.fullname -force}
