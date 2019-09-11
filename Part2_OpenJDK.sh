#!/bin/bash

######################Global Variable############################
Version=8
mini_Version=212
backup=/backup
mkdir $backup
#################################################################


echo "=========================================================="
echo "#2-1. Upload "openjdk$Version_$mini_Version.tar.gz""
        echo "
                **********************************************************
                WARNING!!!! DID YOU Upload openjdk$Version_$mini_Version.tar.gz?
                then press AnyKey
                IF Want to stop this Step Press CTRL+C
                **********************************************************
             "
        read
echo "=========================================================="

echo "=========================================================="
echo "#2-2. Uncompress "openjdk$Version_$mini_Version.tar.gz""
tar -xvzf openjdk$Version\_$mini_Version.tar.gz
echo "=========================================================="

#echo "=========================================================="
echo "#2-3. Change Directory to Openjdk Repository"
cd openjdk$Version\_$mini_Version
echo "=========================================================="

echo "=========================================================="
echo "#2-4. install openjdk$Version_$mini_Version"
rpm -Uvh --replacepkgs *rpm
echo "=========================================================="

echo "=========================================================="
echo "#2-5. Check Install status"
yum list installed | grep jdk
echo "=========================================================="

echo "=========================================================="
echo "#2-6. Change JAVA version"
alternatives --config java
echo "=========================================================="

echo "=========================================================="
echo "Check JAVA version"
java -version
echo "=========================================================="
