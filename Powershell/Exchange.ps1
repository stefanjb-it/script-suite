<#

.DESCRIPTION
  This scripts starts|stops|restarts every Exchange service.

.NOTES
  Version:        1.0
  Author:         Stefan Joebstl
  Creation Date:  8.8.2020
  
#>

#---------------------------------------------------------[Initialisations]--------------------------------------------------------

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