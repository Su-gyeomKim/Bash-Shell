#!/bin/bash

######################Global Variable############################
#:<<'COMMENT' / COMMENT is Bash Block Comment#
: <<'COMMENT' 
COMMENT

Old_version=5.9.0

tar_version=62
version=6.2
mini_version=.0

repoDir="/etc/yum.repos.d"
repoFile="$repoDir/cloudera-cdh$tar_version.repo" 
repoFile_cm="$repoDir/cloudera-manager$tar_version.repo"
#################################################################


####################### Part 1 #################################

echo "#Part1 Repository Build"

if [ -f /etc/default/cloudera-scm-server ]; then
	echo "=========================================================="
	echo "#1-1. Upload "cloudera_$tar_version.tar.gz""
	echo "Upload Setup files to server (by. FTP or portable media)"
        echo "
                **********************************************************
                WARNING!!!! DID YOU Upload "cloudera_$tar_version.tar.gz"?
                then press AnyKey
                IF Want to stop this Step Press CTRL+C
                **********************************************************
             "
        read
	echo "=========================================================="

	echo "=========================================================="
	echo "#1-2. Uncompress "cloudera_$tar_version.tar.gz""
	tar -xvzf cloudera_$tar_version.tar.gz
	echo "=========================================================="

	echo "=========================================================="
	echo "#1-3. Change Directory name as repos"
	mv cloudera-repos cloudera-$version
	echo "=========================================================="

	echo "=========================================================="
	echo "#1-4. Copy install files"
	##for Dev_server
	if [ ! -d /opt/BigData/repo ]; then 
		mkdir -p /opt/BigData/repo
	fi
	
	if [ `free -m | grep ^Mem | awk '{print $2}'` -lt 128000 ]; then
		mv cloudera-$version /opt/BigData/repo
		ln -s /opt/BigData/repo /var/www/html/yum/repo
	else
		cp -R cloudera-$version /opt/BigData/repo
		ln -s /opt/BigData/repo /var/www/html/repo
	fi

	##개발환경이랑 확인필요
	#for Local LapTop
	cd /var/www/html/yum
	#ln -s /opt/cloudera-$version cloudera-$version
	echo "=========================================================="
fi

##개발환경이랑 확인필요
echo "=========================================================="
echo "#1-5. Disable cloudera $Old_version Repositoy config file"
mv $repoDir/c* $repoDir/backup/
yum clean all
yum repolist
echo "=========================================================="

echo "=========================================================="
echo "#1-6. Change Repositoy config as cloudera $version"

#for Local LapTop
if [ `free -m | grep ^Mem | awk '{print $2}'` -lt 128000 ]; then
	echo [cloudera-cdh$version] > $repoFile
	echo name = Cloudera CDH$version, Version >> $repoFile
	echo baseurl = http://172.22.5.101/yum/repo/cloudera-$version/cdh6/$version$mini_version/redhat7/yum >> $repoFile
	echo gpgcheck = 0 >> $repoFile

	echo [cloudera-manager$version] > $repoFile_cm
	echo name = Cloudera Manager, Version $version$mini_version >> $repoFile_cm
	echo baseurl = http://172.22.5.101/yum/repo/cloudera-$version/cm6/$version$mini_version/redhat7/yum >> $repoFile_cm
	echo gpgcheck = 0  >> $repoFile_cm

fi
###for Real_server
if [ `hostname` = "bd-mgr01.local" ]; then

	echo [cloudera-cdh$version] > $repoFile
	echo name = Cloudera CDH$version, Version >> $repoFile
	echo baseurl = http://bd-mgr01.local:10081/repo/cloudera-$version/cdh6/$version$mini_version/redhat7/yum >> $repoFile
	echo gpgcheck = 0 >> $repoFile

	echo [cloudera-manager$version] > $repoFile_cm
	echo name = Cloudera Manager, Version $version$mini_version >> $repoFile_cm
	echo baseurl = http://bd-mgr01.local:10081/repo/cloudera-$version/cm6/$version$mini_version/redhat7/yum >> $repofile_cm
	echo gpgcheck = 0 >> $repofile_cm
fi

##for Dev_server
if [ `hostname` = "bd-dev03.local" ]; then
	echo [cloudera-cdh$version] > $repoFile
	echo name = Cloudera CDH$version, Version >> $repoFile
	echo baseurl = http://bd-dev03.local:10081/repo/cloudera-$version/cdh6/$version$mini_version/redhat7/yum >> $repoFile
	echo gpgcheck = 0 >> $repoFile

	echo [cloudera-manager$version] > $repoFile_cm
	echo name = Cloudera Manager, Version $version$mini_version >> $repoFile_cm
	echo baseurl = http://bd-dev03.local:10081/repo/cloudera-$version/cm6/$version$mini_version/redhat7/yum >> $repoFile_cm
	echo gpgcheck = 0  >> $repoFile_cm

fi

yum clean all
yum repolist
echo "=========================================================="
