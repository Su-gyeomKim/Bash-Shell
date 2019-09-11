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


##########################Part 7#################################
echo -e "\n\nPart 7\n\n"
echo "=========================================================="
echo "#7-1 Yarn NodeManager Service releas & reassignment"
if [ `free -m | grep ^Mem | awk '{print $2}'` -lt 128000 ]; then
	echo "go to http://`hostname -I | awk '{print $2}'`:7180/cmf/services/21/instances"
else
	echo "go to http://`hostname -I | awk '{print $1}'`:7180/cmf/services/21/instances"
fi
echo "every \'NodeManager\' checkbox check & service (releas & reassignment)"
echo "DO NOT START \'NodeManager\'!"
if [ `free -m | grep ^Mem | awk '{print $2}'` -lt 128000 ]; then
	echo "go to http://`hostname -I | awk '{print $2}'`:7180/cmf/services/30/config#filterdisplayGroup=%EA%B3%A0%EA%B8%89"
else
	echo "go to http://`hostname -I | awk '{print $1}'`:7180/cmf/services/30/config#filterdisplayGroup=%EA%B3%A0%EA%B8%89"
fi
echo -e "change value \'kafka.properties에 대한 Kafka Broker 고급 구성 스니펫(안전 밸브)kafka.properties에 대한 Kafka Broker 고급 구성 스니펫(안전 밸브)\' \nas \ninter.broker.protocol.version = 0.9.0 \nlog.message.format.version = 0.9.0"

echo "
                **********************************************************
                WARNING!!!! DO YOU FINISH THIS STEP?
                then press AnyKey
                IF Want to stop this Step Press CTRL+C
                **********************************************************
     "
read
echo "=========================================================="

echo "=========================================================="
echo "#7-2 Kafka Version Configure"

echo "go to http://`hostname -I | awk '{print $2}'`:7180/cmf/services/30/config#filterdisplayGroup=%EA%B3%A0%EA%B8%89"

echo "
                **********************************************************
                WARNING!!!! DO YOU FINISH THIS STEP?
                then press AnyKey
                IF Want to stop this Step Press CTRL+C
                **********************************************************
     "
read
echo "=========================================================="

echo "=========================================================="
echo "#7-3 other configuration check & adjust"
if [ `free -m | grep ^Mem | awk '{print $2}'` -lt 128000 ]; then
	echo "go to http://`hostname -I | awk '{print $2}'`:7180/cmf/"
else
	echo "go to http://`hostname -I | awk '{print $1}'`:7180/cmf/"
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

echo "=========================================================="
echo "#7-4 CDH Stop"
if [ `free -m | grep ^Mem | awk '{print $2}'` -lt 128000 ]; then
	echo "go to http://`hostname -I | awk '{print $2}'`:7180/cmf/"
else
	echo "go to http://`hostname -I | awk '{print $1}'`:7180/cmf/"
fi
echo "CDH STOP"

echo "
                **********************************************************
                WARNING!!!! DO YOU FINISH THIS STEP?
                then press AnyKey
                IF Want to stop this Step Press CTRL+C
                **********************************************************
     "
read
echo "=========================================================="

echo "=========================================================="
echo "#7-5 Install CDH Packages"
yum clean all
yum repolist
yum -y remove hadoop-0.20\* hue-\* crunch llama mahout sqoop2 whirr sqoop2-client

if [ `free -m | grep ^Mem | awk '{print $2}'` -lt 128000 ]; then
	tar -xvzf cdh62_dependency.tar.gz
	cd cdh62_dependency
	rpm -Uvh --replacepkgs *rpm
else
	yum -y install libtidy lsb 
fi
yum -y install avro-tools flume-ng hadoop-hdfs-fuse hadoop-hdfs-nfs3 hadoop-httpfs hadoop-kms hbase-solr hive-hbase hive-webhcat hue impala impala-shell kafka kite kudu oozie pig search sentry sentry-hdfs-plugin solr-crunch solr-mapreduce spark-core spark-python sqoop zookeeper parquet hbase solr

echo "
                **********************************************************
                WARNING!!!! DO YOU FINISH THIS STEP?
                then press AnyKey
                IF Want to stop this Step Press CTRL+C
                **********************************************************
     "
read
echo "=========================================================="

echo "=========================================================="
echo "#7-6 default JAVA directory Change"
mv /usr/java /usr/java_back

echo "
                **********************************************************
                WARNING!!!! DO YOU FINISH THIS STEP?
                then press AnyKey
                IF Want to stop this Step Press CTRL+C
                **********************************************************
     "
read
echo "=========================================================="

echo "=========================================================="
echo "#7-7 Cloudera MAnager Agent Restart"
systemctl restart cloudera-scm-agent

echo "
                **********************************************************
                WARNING!!!! DO YOU FINISH THIS STEP?
                then press AnyKey
                IF Want to stop this Step Press CTRL+C
                **********************************************************
     "
read
echo "=========================================================="

echo "=========================================================="
echo "#7-8 (\*Laptop) Oozie Password Change"
if [ `free -m | grep ^Mem | awk '{print $2}'` -lt 128000 ]; then
	grant all privileges on oozie.* to 'oozie'@'%' identified by 'oozie'
	flush privileges
	echo "go to http://`hostname -I | awk '{print $2}'`:7180/cmf/services/20/config#filterdisplayGroup=%EB%8D%B0%EC%9D%B4%ED%84%B0%EB%B2%A0%EC%9D%B4%EC%8A%A4"
fi
echo "create Oozie password"

echo "
                **********************************************************
                WARNING!!!! DO YOU FINISH THIS STEP?
                then press AnyKey
                IF Want to stop this Step Press CTRL+C
                **********************************************************
     "
read
echo "=========================================================="

echo "=========================================================="
echo "#7-9 Run the Upgrade CDH Wizard"
if [ `free -m | grep ^Mem | awk '{print $2}'` -lt 128000 ]; then
	echo "go to http://`hostname -I | awk '{print $2}'`:7180/cmf/clusters/1/upgradePopup"
else
	echo "go to http://`hostname -I | awk '{print $1}'`:7180/cmf/clusters/1/upgradePopup"
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

echo "=========================================================="
echo "#7-10 Start Yarn NodeManager "
if [ `free -m | grep ^Mem | awk '{print $2}'` -lt 128000 ]; then
	echo "go to http://`hostname -I | awk '{print $2}'`:7180/cmf/services/21/instances"
else
	echo "go to http://`hostname -I | awk '{print $1}'`:7180/cmf/services/21/instances"
fi
echo "every \'NodeManager\' checkbox check & start"

echo "
                **********************************************************
                WARNING!!!! DO YOU FINISH THIS STEP?
                then press AnyKey
                IF Want to stop this Step Press CTRL+C
                **********************************************************
     "
read
echo "=========================================================="

echo "=========================================================="
echo "#7-11 other configuration check & adjust"
if [ `free -m | grep ^Mem | awk '{print $2}'` -lt 128000 ]; then
	echo "go to http://`hostname -I | awk '{print $2}'`:7180/cmf/"
else
	echo "go to http://`hostname -I | awk '{print $1}'`:7180/cmf/"
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

echo "=========================================================="
echo "#7-12 default port change & kafka version adjust"

if [ `free -m | grep ^Mem | awk '{print $2}'` -lt 128000 ]; then
	echo "go to http://`hostname -I | awk '{print $2}'`:7180/cmf/config2?task=ALL_PORT_CONFIGURATIONS"
else
	echo "go to http://`hostname -I | awk '{print $1}'`:7180/cmf/config2?task=ALL_PORT_CONFIGURATIONS"
fi
echo "HBase Master 웹 UI 포트 : 16010 -> 60010"
echo "HBase RegionServer 웹 UI 포트 : 16030 -> 60030"
echo "DataNode HTTP 웹 UI 포트 : 9864 -> 50075"
echo "NameNode 웹 UI 포트 : 9870 -> 50070"
echo "SAVE"
if [ `free -m | grep ^Mem | awk '{print $2}'` -lt 128000 ]; then
	echo "go to http://`hostname -I | awk '{print $2}'`:7180/cmf/services/30/config#filterdisplayGroup=%EA%B3%A0%EA%B8%89"
else
	echo "go to http://`hostname -I | awk '{print $1}'`:7180/cmf/services/30/config#filterdisplayGroup=%EA%B3%A0%EA%B8%89"
fi

echo -e "delete value \'kafka.properties에 대한 Kafka Broker 고급 구성 스니펫(안전 밸브)kafka.properties에 대한 Kafka Broker 고급 구성 스니펫(안전 밸브)\' \n as \ninter.broker.protocol.version = 0.9.0 \nlog.message.format.version = 0.9.0"

echo "
                **********************************************************
                WARNING!!!! DO YOU FINISH THIS STEP?
                then press AnyKey
                IF Want to stop this Step Press CTRL+C
                **********************************************************
     "
read
echo "=========================================================="

echo "=========================================================="
echo "#7-13 HDFS metadata Upgrade"
if [ `free -m | grep ^Mem | awk '{print $2}'` -lt 128000 ]; then
	echo "go to http://`hostname -I | awk '{print $2}'`:7180/cmf/services/22/instances/26/do?command=HdfsFinalizeUpgrade"
else
	echo "go to http://`hostname -I | awk '{print $1}'`:7180/cmf/services/22/instances/26/do?command=HdfsFinalizeUpgrade"
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

echo "=========================================================="
echo "#7-14 DataBase Backup"
echo "mysqldump -u root -p --all-databases > $backup/alldatabases_6.2_`date +%F`.sql"

echo "
                **********************************************************
                WARNING!!!! DO YOU FINISH THIS STEP?
                then press AnyKey
                IF Want to stop this Step Press CTRL+C
                **********************************************************
     "
read
echo "=========================================================="
