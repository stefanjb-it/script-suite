<#

.DESCRIPTION
  This script enable automatic winlogon and sets the given credentials as parameters for the login.

.NOTES
  Version:        1.0
  Author:         Stefan Joebstl
  Creation Date:  5.10.2020
  
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

$Domain = Read-Host -Prompt 'Domain for user (leave blank for local user)'
$Username = Read-Host -Prompt 'Username for autologon'
$securedValue = Read-Host -Prompt 'Password for autologon user' -AsSecureString
$bstr = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($securedValue)
$Password = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($bstr)

#----------------------------------------------------------[Declarations]----------------------------------------------------------

#Script Version
$ScriptVersion = "1.0"

$title   = ''
$msg     = 'Do you want to active autologon?'
$options = '&Yes', '&No'
$default = 1  # 0=Yes, 1=No

#-----------------------------------------------------------[Functions]------------------------------------------------------------

function setLogon{
$response = $Host.UI.PromptForChoice($title, $msg, $options, $default)
  if ($response -eq 0) {
    Set-ItemProperty "hklm:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" -Name "DefaultDomainName" -Value $Domain
    Set-ItemProperty "hklm:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" -Name "AutoAdminLogon" -Value 1
    Set-ItemProperty "hklm:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" -Name "DefaultUserName" -Value $Username
    Set-ItemProperty "hklm:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" -Name "DefaultPassword" -Value $Password
  } 
}

#-----------------------------------------------------------[Execution]------------------------------------------------------------

setLogon