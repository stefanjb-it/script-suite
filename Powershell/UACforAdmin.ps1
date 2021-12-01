<#

.DESCRIPTION
  The script disables or enables the UAC prompt for local Admins.

.NOTES
  Version:        1.2
  Author:         Stefan Joebstl
  Creation Date:  1.5.2020
  
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
$ScriptVersion = "1.2"

$title   = ''
$msg     = 'Do you what to enable or disable the UAC for local admins?'
$options = '&enable', '&disable',  '&cancel'
$default = 2

#-----------------------------------------------------------[Functions]------------------------------------------------------------

function setUAV_GPO {
	$response = $Host.UI.PromptForChoice($title, $msg, $options, $default)
	switch($response){
		0{
			Set-ItemProperty "hklm:SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "ValidateAdminCodeSignatures" -Value 1
		}
		1{
			Set-ItemProperty "hklm:SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "ValidateAdminCodeSignatures" -Value 0
		}
		2{
			Write-Output "Cancelled"
			exit
		}
	}
}

#-----------------------------------------------------------[Execution]------------------------------------------------------------

setUAV_GPO
