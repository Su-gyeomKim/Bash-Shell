#!/bin/bash

echo "	  *******************************************************
	go to URL MUST BE CHANGE when scripts run on dev, real server
	  *******************************************************"


######################Global Variable############################
Version=8
mini_Version=212
backup=/backup
mkdir -p $backup
#################################################################

if [ ! -f /etc/default/cloudera-scm-server ]; then
echo "`ls -l /etc/default/cloudera-scm-server`"

	##########################Part 6#################################

	echo -e "\n\n\part6 Cloudera Manger Agent Upgrade to Non Manager server\n\n"
	echo "=========================================================="
	echo "#6-1 Cloudera Manager Agent Stop"
	systemctl stop cloudera-scm-agent
	echo "=========================================================="

	echo "=========================================================="
	echo "#6-2 Upgrade the Packages"
	yum clean all
	yum repolist
	yum -y upgrade cloudera-manager-daemons cloudera-manager-agent
	echo "=========================================================="
		
	echo "=========================================================="
	echo "#6-3 Packages installation"
	rpm -qa 'cloudera-manager-*'
	echo "=========================================================="

	echo "=========================================================="
	echo "#6-4 Cloudera Manager agent Start"
	systemctl start cloudera-scm-agent
	echo "=========================================================="

	echo "=========================================================="
	echo "6-5 Check Cloudera Manager Upgrade"
	if [ `free -m | grep ^Mem | awk '{print $2}'` -lt 128000 ]; then
		echo "go to http://`hostname -I | awk '{print $2}'`:7180/cmf/upgrade"
	else
		echo "go to http://`hostname -I | awk '{print $1}'`:7180/cmf/upgrade"
	fi

	echo "
			**********************************************************
			WARNING!!!! DO YOU FINISH THIS STEP?
			then press AnyKey
			IF Want to stop this Step Press CTRL+C
			**********************************************************
	     "
	read
	echo "=========================================================="

else
        echo "=========================================================="
        echo " This server is cloudera-scm-server installed"
		echo "`ls -l /etc/default/cloudera-scm-server`"
        echo "=========================================================="

fi
