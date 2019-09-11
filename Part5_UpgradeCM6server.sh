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

	##########################Part 5#################################

	echo -e "\n\npart5 Cloudera Manger Server Upgrade\n\n"
	echo "=========================================================="
	echo "#5-1 Cloudera Management Service Stop"
        if [ `free -m | grep ^Mem | awk '{print $2}'` -lt 128000 ]; then
                curl -u "admin:admin" http://`hostname -I | awk '{print $2}'`:7180/api/v14/cm/version
                curl -u "admin:admin" http://`hostname -I | awk '{print $2}'`:7180/api/v14/cm/scmDbInfo
        else
                curl -u "admin:admin" http://`hostname -I | awk '{print $1}'`:7180/api/v14/cm/version
                curl -u "admin:admin" http://`hostname -I | awk '{print $1}'`:7180/api/v14/cm/scmDbInfo
	fi
	echo "
		**********************************************************
		WARNING!!!! DID YOU STOP Cloudera Management Service Stop? 
		then press AnyKey
		IF Want to stop this Step Press CTRL+C
		**********************************************************
	     "
	read
        if [ `free -m | grep ^Mem | awk '{print $2}'` -lt 128000 ]; then
                echo curl -u "admin:admin" http://`hostname -I | awk '{print $2}'`:7180/api/v14/cm/service/commands/stop
        else
                echo curl -u "admin:admin" http://`hostname -I | awk '{print $1}'`:7180/api/v14/cm/service/commands/stop
        fi
	echo "=========================================================="

	echo "=========================================================="
	echo "#5-2 Cloudera Manager server Stop"
	systemctl stop cloudera-scm-server
	echo "=========================================================="

	echo "=========================================================="
	echo "#5-3 Cloudera Manager agent Stop"
	systemctl stop cloudera-scm-agent
	echo "=========================================================="

	echo "=========================================================="
	echo "#5-4 DataBase Backup"
	
	if [ `free -m | grep ^Mem | awk '{print $2}'` -lt 128000 ]; then
                echo curl -u "admin:admin" http://`hostname -I | awk '{print $2}'`:7180/api/v14/cm/scmDbInfo
        else
                echo curl -u "admin:admin" http://`hostname -I | awk '{print $1}'`:7180/api/v14/cm/scmDbInfo
        fi
	mysqldump -u root -p --all-databases > $backup/alldatabases_5.9_`date +%F`.sql
	echo "=========================================================="

	echo "=========================================================="
	echo "#5-5 Upgrade the Packages"
	yum clean all
	yum repolist
	yum -y upgrade cloudera-manager-server cloudera-manager-daemons cloudera-manager-agent
	echo "=========================================================="

	echo "=========================================================="
	echo "#5-6 Packages installation"
	rpm -qa 'cloudera-manager-*'
#: <<'COMMENT' 
        if [ `free -m | grep ^Mem | awk '{print $2}'` -lt 128000 ]; then
                echo curl -u "admin:admin" http://`hostname -I | awk '{print $2}'`:7180/api/v14/cm/version
        else
                echo curl -u "admin:admin" http://`hostname -I | awk '{print $1}'`:7180/api/v14/cm/version
        fi
#COMMENT
	echo "=========================================================="

	echo "=========================================================="
	echo "#5-7 Cloudera Manager agent Start"
	systemctl start cloudera-scm-agent
	echo "=========================================================="

	echo "=========================================================="
	echo "#5-8 Cloudera Manager Server Start"
	grep "CMF_JAVA_OPTS=\"-Xmx1g" /etc/default/cloudera-scm-server -l | xargs sed -i 's/CMF_JAVA_OPTS="-Xmx1g/CMF_JAVA_OPTS="-Xmx2G/'
	systemctl start cloudera-scm-server
	echo "=========================================================="

	echo "=========================================================="
	echo "#5-9 Check Cloudera Management Service WebPage"
: <<'COMMENT' 
        if [ `free -m | grep ^Mem | awk '{print $2}'` -lt 128000 ]; then
                echo "go to http://`hostname -I | awk '{print $2}'`:7180/cmf/"
        else
                echo "go to http://`hostname -I | awk '{print $1}'`:7180/cmf/"
        fi
COMMENT
	echo "In Part 5. only upgrading cm6 to Cloudera-scm-server"
	echo "So then, just showing `hostname` server in WebPage"

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
        echo " This server is not cloudera-scm-server installed"
		echo "`ls -l /etc/default/cloudera-scm-server`"
        echo "=========================================================="

fi
