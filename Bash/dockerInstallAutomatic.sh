#!/bin/bash

#IMPORTANT
#  This script works only on Ubuntu (16.04,18.04,20.04).

#DESCRIPTION
#  This script is based on the docker install instructions (https://docs.docker.com/engine/install/ubuntu/#install-using-the-repository).

#VARIABLES
#  The first variable ($1) is the username, who can access docker after installation without root rights (ONLY WHEN PROVIDED!).

#LOG
#  The logfile get stored under /var/log/docker/docker_install.log.

#NOTES
#  Version:        1.0
#  Author:         Stefan Joebstl
#  Creation Date:  9.9.2020

#---------------------------------------------------------[Initialisations]--------------------------------------------------------

#----------------------------------------------------------[Declarations]----------------------------------------------------------

#Script Version
ScriptVersion="1.0"
logPath="/var/log/docker"
logFile=$logPath"/install.log"
timer="5"

#-----------------------------------------------------------[Functions]------------------------------------------------------------

function install () {
	mkdir $logPath
	if [[ $(lsb_release -is) != "Ubuntu" ]];
	then
		echo "This Distribution is not supported: "$(lsb_release -is) >> $logFile
		exit 1
	fi
	apt-get -y update >> $logFile
	apt-get -y install apt-transport-https ca-certificates curl gnupg-agent software-properties-common >> $logFile
	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=1 apt-key add - >> $logFile
	add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" >> $logFile
	apt-get -y update >> $logFile
	apt-get -y install docker-ce docker-ce-cli containerd.io >> $logFile
	if [[ ! -z "$1" ]];
	then
		usermod -aG docker $1 >> logFile
	fi
	while [[ $timer != 0 ]] 
	do
		timer=$[$timer-1]
		sleep 1
	done
	reboot now
}

#-----------------------------------------------------------[Execution]------------------------------------------------------------

install $1
