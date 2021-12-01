#!/bin/bash

#IMPORTANT
#  This script works only on Ubuntu (16.04,18.04,20.04).

#DESCRIPTION
#  This script is based on the docker install instructions (https://docs.docker.com/engine/install/ubuntu/#install-using-the-repository).

#LOG
#  The logfile get stored under /var/log/docker/install.log.

#NOTES
#  Version:        1.0
#  Author:         Stefan Joebstl
#  Creation Date:  9.9.2020

#---------------------------------------------------------[Initialisations]--------------------------------------------------------

read -p 'Username for Docker access: ' username

#----------------------------------------------------------[Declarations]----------------------------------------------------------

#Script Version
ScriptVersion="1.0"
logPath="/var/log/docker"
logFile=$logPath"/install.log"
timer="9"

#-----------------------------------------------------------[Functions]------------------------------------------------------------

function install () {
	mkdir $logPath
	echo "Logfile getting stored under: "$logFile
	echo "After finishing the installation the system reboots"
	if [[ $(lsb_release -is) != "Ubuntu" ]];
	then
		echo "This Distribution is not supported: "$(lsb_release -is)
		exit 1
	fi
	apt-get -y update >> $logFile
	apt-get -y install apt-transport-https ca-certificates curl gnupg-agent software-properties-common >> $logFile
	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=1 apt-key add - >> $logFile
	add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" >> $logFile
	apt-get -y update >> $logFile
	apt-get -y install docker-ce docker-ce-cli containerd.io >> $logFile
	usermod -aG docker $1 >> $logFile
	read -p "Do you wish to reboot? [Y]yes [N]no " -n 1 -r
	echo ""
	if [[ $REPLY =~ ^[Yy]$ ]];
	then
		while [[ $timer != 0 ]] 
		do
			echo -ne "Restart in $timer seconds"\\r
			timer=$[$timer-1]
			sleep 1
		done
		reboot now
	fi
	exit 0
}

#-----------------------------------------------------------[Execution]------------------------------------------------------------

install $username