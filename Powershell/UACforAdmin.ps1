<#

.DESCRIPTION
  The script disables or enables the UAV prompt for local Admins.

.NOTES
  Version:        1.2
  Author:         Stefan Joebstl
  Creation Date:  1.5.2020
  
#>

#---------------------------------------------------------[Initialisations]--------------------------------------------------------

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