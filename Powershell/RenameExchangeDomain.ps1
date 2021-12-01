<#

.IMPORTANT
  This script must be executed in the EMS.

.DESCRIPTION
  This script renames the external and internal hostname of the Exchange Server virtual directories.

.NOTES
  Version:        1.0
  Author:         Stefan Joebstl
  Creation Date:  15.8.2020
  
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


$serverName = Read-Host -Prompt 'Name of the Server (example: SRVEX1)'
$internalHostname = Read-Host -Prompt 'Hostname for internal access (example: internal_mail.contoso.local)'
$externalHostname = Read-Host -Prompt 'Hostname for external access (example: external_mail.contoso.com)'
$autodiscoverHostname = Read-Host -Prompt 'Hostname for the autodiscover url (example: autodiscover.contoso.com)'

#----------------------------------------------------------[Declarations]----------------------------------------------------------

#Script Version
$ScriptVersion = "1.0"

$owainturl = "https://" + "$internalHostname" + "/owa"
$owaexturl = "https://" + "$externalHostname" + "/owa"
$ecpinturl = "https://" + "$internalHostname" + "/ecp"
$ecpexturl = "https://" + "$externalHostname" + "/ecp"
$ewsinturl = "https://" + "$internalHostname" + "/EWS/Exchange.asmx"
$ewsexturl = "https://" + "$externalHostname" + "/EWS/Exchange.asmx"
$easinturl = "https://" + "$internalHostname" + "/Microsoft-Server-ActiveSync"
$easexturl = "https://" + "$externalHostname" + "/Microsoft-Server-ActiveSync"
$oabinturl = "https://" + "$internalHostname" + "/OAB"
$oabexturl = "https://" + "$externalHostname" + "/OAB"
$mapiinturl = "https://" + "$internalHostname" + "/mapi"
$mapiexturl = "https://" + "$externalHostname" + "/mapi"
$aduri = "https://" + "$autodiscoverHostname" + "/Autodiscover/Autodiscover.xml"

#-----------------------------------------------------------[Functions]------------------------------------------------------------

function UpdateEX{
  Get-OwaVirtualDirectory -Server $serverName | Set-OwaVirtualDirectory -internalurl $owainturl -externalurl $owaexturl -Confirm:$false
  Get-EcpVirtualDirectory -server $serverName | Set-EcpVirtualDirectory -internalurl $ecpinturl -externalurl $ecpexturl -Confirm:$false
  Get-WebServicesVirtualDirectory -server $serverName | Set-WebServicesVirtualDirectory -internalurl $ewsinturl -externalurl $ewsexturl -Confirm:$false
  Get-ActiveSyncVirtualDirectory -Server $serverName | Set-ActiveSyncVirtualDirectory -internalurl $easinturl -externalurl $easexturl -Confirm:$false
  Get-OabVirtualDirectory -Server $serverName | Set-OabVirtualDirectory -internalurl $oabinturl -externalurl $oabexturl -Confirm:$false
  Get-MapiVirtualDirectory -Server $serverName | Set-MapiVirtualDirectory -externalurl $mapiexturl -internalurl $mapiinturl -Confirm:$false
  Get-OutlookAnywhere -Server $serverName | Set-OutlookAnywhere -externalhostname $externalhostname -internalhostname $internalhostname -ExternalClientsRequireSsl:$true -InternalClientsRequireSsl:$true -ExternalClientAuthenticationMethod 'Negotiate'  -Confirm:$false
  Get-ClientAccessService $serverName | Set-ClientAccessService -AutoDiscoverServiceInternalUri $aduri -Confirm:$false
  Get-OwaVirtualDirectory -Server $serverName | fl server,externalurl,internalurl
  Get-EcpVirtualDirectory -server $serverName | fl server,externalurl,internalurl
  Get-WebServicesVirtualDirectory -server $serverName | fl server,externalurl,internalurl
  Get-ActiveSyncVirtualDirectory -Server $serverName | fl server,externalurl,internalurl
  Get-OabVirtualDirectory -Server $serverName | fl server,externalurl,internalurl
  Get-MapiVirtualDirectory -Server $serverName | fl server,externalurl,internalurl
  Get-OutlookAnywhere -Server $serverName | fl servername,ExternalHostname,InternalHostname
  Get-ClientAccessService $serverName | fl name,AutoDiscoverServiceInternalUri
}

#-----------------------------------------------------------[Execution]------------------------------------------------------------

UpdateEX