<#

.DESCRIPTION
  Assigns AD telephone number to teams user based on AD group

.NOTES
  Version:        1.0
  Author:         Stefan Joebstl
  Creation Date:  13.09.2023
  
#>

#---------------------------------------------------------[Initialisations]--------------------------------------------------------

Write-Host " ________  ________  ________  ___  ________  _________               ________  ___  ___  ___  _________  _______      " -ForegroundColor Yellow
Write-Host "|\   ____\|\   ____\|\   __  \|\  \|\   __  \|\___   ___\            |\   ____\|\  \|\  \|\  \|\___   ___\\  ___ \     " -ForegroundColor Red
Write-Host "\ \  \___|\ \  \___|\ \  \|\  \ \  \ \  \|\  \|___ \  \_|____________\ \  \___|\ \  \\\  \ \  \|___ \  \_\ \   __/|    " -ForegroundColor Yellow
Write-Host " \ \_____  \ \  \    \ \   _  _\ \  \ \   ____\   \ \  \|\____________\ \_____  \ \  \\\  \ \  \   \ \  \ \ \  \_|/__  " -ForegroundColor Red
Write-Host "  \|____|\  \ \  \____\ \  \\  \\ \  \ \  \___|    \ \  \|____________|\|____|\  \ \  \\\  \ \  \   \ \  \ \ \  \_|\ \ " -ForegroundColor Yellow
Write-Host "    ____\_\  \ \_______\ \__\\ _\\ \__\ \__\        \ \__\               ____\_\  \ \_______\ \__\   \ \__\ \ \_______\" -ForegroundColor Red
Write-Host "   |\_________\|_______|\|__|\|__|\|__|\|__|         \|__|              |\_________\|_______|\|__|    \|__|  \|_______|" -ForegroundColor Yellow
Write-Host "   \|_________|                                                         \|_________|                                   " -ForegroundColor Red
Write-Host "                                                                                                                       " -ForegroundColor Yellow
Write-Host "                                                                                                                       " -ForegroundColor Red

if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
[Security.Principal.WindowsBuiltInRole] "Administrator")) {
  Write-Warning "Insufficient permissions. Run this script as Administrator!"
  Break
}

if (!(Get-Module -ListAvailable -Name MicrosoftTeams)) {
    Write-Warning "Teams Powershell module missing! Run [Install-Module -Name MicrosoftTeams -Force -AllowClobber]"
    Break
}

#----------------------------------------------------------[Declarations]----------------------------------------------------------

#Script Version
$ScriptVersion = "1.0" 

#AD Group
$baseGroup = ""

#Phone number type
$pNumberT = ""

#-----------------------------------------------------------[Functions]------------------------------------------------------------

#-----------------------------------------------------------[Execution]------------------------------------------------------------

Connect-MicrosoftTeams

$users=Get-ADGroupMember -Identity $baseGroup

foreach ($user in $users) {
    $user = Get-ADUser -Identity $user.SamAccountName -Properties UserPrincipalName, telephoneNumber
    $assigned=Get-CsPhoneNumberAssignment -TelephoneNumber $user.telephoneNumber
    if (!$assigned) {
        Set-CsPhoneNumberAssignment -Identity $user.UserPrincipalName -PhoneNumber $user.telephoneNumber -PhoneNumberType $pNumberT
    }
}
