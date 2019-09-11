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

if [ -f /etc/default/cloudera-scm-server ]; then
echo "`ls -l /etc/default/cloudera-scm-server`"

	##########################Part 4#################################

	echo -e "\n\npart4 Config adjust by applying OpenJDK8\n\n"
	echo "=========================================================="
	echo "#4-1 JAVA_HOME direct change to all hosts"
        if [ `free -m | grep ^Mem | awk '{print $2}'` -lt 128000 ]; then
                curl -X PUT -H "Content-Type: application/json" -u "admin:admin" -d '{  "items": [ { "name" : "java_home", "value" : "/usr/lib/jvm/java-1.8.0-openjdk", "sensitive" : false } ] }' "http://`hostname -I | awk '{print $2}'`:7180/api/v14/cm/allHosts/config"
        else
                curl -X PUT -H "Content-Type: application/json" -u "admin:admin" -d '{  "items": [ { "name" : "java_home", "value" : "/usr/lib/jvm/java-1.8.0-openjdk", "sensitive" : false } ] }' "http://`hostname -I | awk '{print $2}'`:7180/api/v14/cm/allHosts/config"
        fi
	echo "=========================================================="

	echo "=========================================================="
	echo "#4-2 Additional configuration change"
	echo "Just Change & Save. Do NOT RESTART YET"
	echo "=========================================================="

else
        echo "=========================================================="
        echo " This server is not cloudera-scm-server installed"
		echo "`ls -l /etc/default/cloudera-scm-server`"
        echo "=========================================================="


fi
