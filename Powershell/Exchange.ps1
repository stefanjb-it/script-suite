<#

.DESCRIPTION
  This scripts starts|stops|restarts every Exchange service.

.NOTES
  Version:        1.0
  Author:         Stefan Joebstl
  Creation Date:  8.8.2020
  
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

#----------------------------------------------------------[Declarations]----------------------------------------------------------

#Script Version
$ScriptVersion = "1.0"

$title   = ''
$msg     = 'What do you want to do?'
$options = '&Start', '&Terminate', '&Restart', '&Cancel'
$default = 3

#-----------------------------------------------------------[Functions]------------------------------------------------------------

function ExchangeAction {
  $response = $Host.UI.PromptForChoice($title, $msg, $options, $default)
  switch($response){
    0{
	  Get-Service *Exchange* | Where {$_.DisplayName -NotLike "*Hyper-V*"}  | Start-Service
	}
	1{
	  Get-Service *Exchange* | Where {$_.DisplayName -NotLike "*Hyper-V*"}  | Stop-Service -Force
	}
	2{
	  Get-Service *Exchange* | Where {$_.DisplayName -NotLike "*Hyper-V*"}  | Restart-Service -Force
	}
	3{
	  Write-Output "Cancelled"
	  exit
	}
  }
}

#-----------------------------------------------------------[Execution]------------------------------------------------------------

ExchangeAction