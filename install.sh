#!/bin/bash
#Author  : Yuvaraj
#Company : Canvera
#Important : Please run this script as root 
#Intial proxy configuration file

#Remove the old configuration file
if [ -e /etc/apt/apt.conf.d/01proxy ] 
  then 
    rm -f /etc/apt/apt.conf.d/01proxy > /dev/null 2>&1
fi

#fetch the file from server
wget -P /etc/apt/apt.conf.d/ http://10.30.0.42:3142/canverarepoproxy/01proxy > /dev/null 2>&1
#Dowloading the proxy configuration.
#this script is used to check whether the user in office network or not
#if the user is office network then it will configure office repo proxy 
#by creating a file "01proxy" in the folder "/etc/apt/apt.conf.d/"

#Remove the old configuration file
if [ -e /etc/NetworkManager/dispatcher.d/apt-cacher-ng-proxy-detection.sh ] 
  then 
    rm -f /etc/NetworkManager/dispatcher.d/apt-cacher-ng-proxy-detection.sh > /dev/null 2>&1
fi

#fetch the file from server
wget -P /etc/NetworkManager/dispatcher.d/ http://10.30.0.42:3142/canverarepoproxy/apt-cacher-ng-proxy-detection.sh > /dev/null 2>&1
chmod +x /etc/NetworkManager/dispatcher.d/apt-cacher-ng-proxy-detection.sh > /dev/null 2>&1
#echo "$?"

if [ $? -eq 0 ] 
 then
   echo "Success !!!!"
   echo "Thank You for installing Canvera Repo Proxy"
   echo "You have achieved the following:"
   echo "	1. Reducing the load on canvera nework"
   echo "	2. 0 -100% time reduction in installation and upgradation of packages"
   echo "	3. Reducing the global carbon foot print there by going Green ;) ;)"
   exit 0
fi
if [ $? -ne 0 ] 
 then
   echo "Error !!!!"
   echo "Contact System administrator "
   exit 0
fi
