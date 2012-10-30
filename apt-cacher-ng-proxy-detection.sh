#!/bin/bash
#Author  : Yuvaraj
#Company : Canvera
# list of hosts that the acng-proxy might be running on.  
#Seperate each host by new line
hosts=(
        10.30.0.42 
               
)
 
set_host() {
        host=$1
        echo "Acquire::http { Proxy "\"http://$host:3142\""; };" > /home/yuva/iamexecuting
        echo "Acquire::http { Proxy "\"http://$host:3142\""; };" > /etc/apt/apt.conf.d/01proxy
        if [[ -z $host ]]; then
                line="# Proxy: disabled because none are contactable"
		rm -f /etc/apt/apt.conf.d/01proxy > /dev/null 2>&1
        fi
 	
        
        exit 0
}
 
try_host() {
        host=$1
        # if we can get to the supplied host
        if ping -c1 -W2 "$host" > /dev/null 2>&1; then
                # tell ACNG to use it
                set_host "$host"
        fi
}
 
# Run through all possible ACNG hosts trying them one at a time
for host in "${hosts[@]}"; do
        try_host "$host"
done
 
# no proxies found, unset upstream proxy (i.e. we connect straight to the internet)
set_host
