<#

.DESCRIPTION
  This script enable automatic winlogon and sets the given credentials as parameters for the login.

.NOTES
  Version:        1.0
  Author:         Stefan Joebstl
  Creation Date:  5.10.2020
  
#>

#---------------------------------------------------------[Initialisations]--------------------------------------------------------

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