#!/bin/bash
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
echo " Ambari Server Start"
echo "----------------------------------------------------------------------------------------------------------------"
ambari-server start
echo "----------------------------------------------------------------------------------------------------------------"
echo ""
server_started_msg=$(ambari-server status|grep "Ambari Server running")
echo ""
if [ -n "$server_started_msg" ];then
	echo "SUCCESS: Ambari was started successfully."
	echo "To access Ambari's web UI point your browser at http://localhost:8080 . The default user and password are 'admin', 'admin'."
	echo "An instance of Ambari Agent is alredy running in this host. You can register it from Ambari's web UI using the host name 'hortonworks-test'."
else
	echo "ERROR: Ambari Server could not be started."
fi
