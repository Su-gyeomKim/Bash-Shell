#!/bin/bash

echo "	  *******************************************************
	go to URL MUST BE CHANGE when scripts run on dev, real server
		laptop is hostname -i Result is 10.0.1.15 172.22.5.101
		dev, real is 172.22.5.101
	  *******************************************************"

######################Global Variable############################
Version=8
mini_Version=212
backup=/backup
mkdir -p $backup
#################################################################

##########################Part 3#################################

if [ -f /etc/default/cloudera-scm-server ]; then
echo "`ls -l /etc/default/cloudera-scm-server`"

echo -e "\n\npart3 ClouderaJDK to OpenJDK\n\n"
echo "=========================================================="
echo "#3-1. Set to JAVA_HOME (Cloudera Manager installed server)"
	#cp /etc/default/cloudera-scm-server /etc/default/cloudera-scm-server_`date +%F`_BAK
	#echo "export JAVA_HOME="/usr/lib/jvm/java-1.8.0-openjdk"" >> /etc/default/cloudera-scm-server_test
	#cat /etc/default/cloudera-scm-server >> /etc/default/cloudera-scm-server_test
	#systemctl restart cloudera-scm-server

	echo "export JAVA_HOME="/usr/lib/jvm/java-1.8.0-openjdk"" >> /etc/default/cloudera-scm-server
	echo "=========================================================="

	echo "=========================================================="
	echo "#3-2. Restart Cloudera Manager Server"
	systemctl restart cloudera-scm-server
	echo "=========================================================="

	echo "=========================================================="
	echo "#3-3. Check OpenJDK Applied to Cloudera Manager Server"
        if [ `free -m | grep ^Mem | awk '{print $2}'` -lt 128000 ]; then
                echo "go to http://`hostname -I | awk '{print $2}'`:7180/cmf/help/about"
        else
                echo "go to http://`hostname -I | awk '{print $1}'`:7180/cmf/help/about"
        fi
	echo "check Java VM Name is OpenJDK 64-Bit Server VM"
	echo "check Java Version is 1.8.0_$mini_Version"
	echo "=========================================================="

else
	echo "=========================================================="
	echo " This server is not cloudera-scm-server installed"
	echo "`ls -l /etc/default/cloudera-scm-server`"
	echo "=========================================================="

fi
