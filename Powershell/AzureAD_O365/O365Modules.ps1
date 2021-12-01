<#

.DESCRIPTION
  Installs all Azure and O365 Powershell modules

.NOTES
  Version:        1.0
  Author:         Stefan Joebstl
  Creation Date:  1.12.2021
  
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

#----------------------------------------------------------[Declarations]----------------------------------------------------------

#Script Version
$ScriptVersion = "1.0"

$title   = ''
$msg     = 'What do you want to do?'
$options = '&Install', '&Uninstall', '&Cancel'
$default = 2

#-----------------------------------------------------------[Functions]------------------------------------------------------------

Function ModuleAction {
  $response = $Host.UI.PromptForChoice($title, $msg, $options, $default)
  switch($response){
    0{
      Install-Module ExchangeOnlineManagement
      Install-Module MSOnline
      Install-Module AzureAD
      Install-Module Microsoft.Online.SharePoint.PowerShell
      Install-Module SharePointPnPPowerShellOnline
      Install-Module MicrosoftTeams
      Write-Host "Modules ready to use!" -ForegroundColor Green
    }
    1{
      Uninstall-Module ExchangeOnlineManagement
      Uninstall-Module MSOnline
      Uninstall-Module AzureAD
      Uninstall-Module Microsoft.Online.SharePoint.PowerShell
      Uninstall-Module SharePointPnPPowerShellOnline
      Uninstall-Module MicrosoftTeams
      Write-Host "Modules uninstalled successful!" -ForegroundColor Green
    }
    2{
      Write-Host "Action cancelled by User" -ForegroundColor Red
      exit
    }
  }
}

#-----------------------------------------------------------[Execution]------------------------------------------------------------

ModuleAction