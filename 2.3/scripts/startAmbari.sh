#!/bin/bash
if test -f /sys/kernel/mm/transparent_hugepage/enabled; then
   echo never > /sys/kernel/mm/transparent_hugepage/enabled
fi
if test -f /sys/kernel/mm/transparent_hugepage/defrag; then
   echo never > /sys/kernel/mm/transparent_hugepage/defrag
fi
service ntp start &>/dev/null
sysctl -w vm.swappiness=0 &>/dev/null
echo ""
echo "----------------------------------------------------------------------------------------------------------------"
echo " Ambari Agent Start"
echo "----------------------------------------------------------------------------------------------------------------"
ambari-agent start
echo ""
echo "----------------------------------------------------------------------------------------------------------------"
echo " Ambari Server Setup"
echo "----------------------------------------------------------------------------------------------------------------"
ambari-server setup -s
echo ""
echo "----------------------------------------------------------------------------------------------------------------"
echo " Starting Ambari Server"
echo "----------------------------------------------------------------------------------------------------------------"
ambari-server start
sleep 5
echo ""
server_started_msg=$(ambari-server status|grep "Ambari Server running")
echo ""
if [ -n "$server_started_msg" ];then
	echo "SUCCESS: Ambari was started successfully."
	echo "To access Ambari's web UI point your browser at http://localhost:8080 . The default user and password are 'admin', 'admin'."
else
	echo "ERROR: Ambari Server could not be started."
fi
