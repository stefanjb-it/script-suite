<#
.DESCRIPTION
  This scripts will update windows and store the log of the update under the given directory. 

.OUTPUTS
  Standard location for log file: C:\temp\update.log

  Version:        1.0
  Author:         Stefan Joebstl
  Creation Date:  8.8.2020  
#>

#----------------------------------------------------------[Declarations]----------------------------------------------------------

#Script Version
$ScriptVersion = "1.0"

#Log File Info
$LogPath = "C:\temp"
$LogName = "update.log"
$Log = $LogPath + $LogName

#---------------------------------------------------------[Initialisations]--------------------------------------------------------

if(!(Test-Path -path $LogPath))  
{  
  New-Item -ItemType directory -Path $LogPath  
}

If(!(Get-PackageProvider NuGet))
{
  Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force
}

If(!(Get-Module PSWindowsUpdate))
{
  Install-Module PSWindowsUpdate -force
  Write-Output "$(Get-Date -format 'G') PSWindowsUpdate Module Installed" | Out-File -Append $Log
}

#-----------------------------------------------------------[Functions]------------------------------------------------------------

Function Update{
  If(!(Get-WindowsUpdate -WindowsUpdate))
  {
	Write-Output "$(Get-Date -format 'G') No Updates to Install" | Out-File -Append $Log
  }
  else
  {
    Write-Output "$(Get-Date -format 'G') Installing Updates" | Out-File -Append $Log
    Get-WindowsUpdate -WindowsUpdate -Install -AcceptAll -AutoReboot -Verbose | Out-File -Append $Log
  }
}

#-----------------------------------------------------------[Execution]------------------------------------------------------------

Update