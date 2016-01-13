#!/bin/bash
if [ -z "$BLUEPRINT_URL" ] || [ -z $CLUSTER_TEMPLATE_URL ];then
	echo "ERROR: Environment variables BLUEPRINT_URL or CLUSTER_TEMPLATE_URL are not defined."
	exit 1
fi
get_progress() {
	echo $(curl -s -H "X-Requested-By: ambari" -X GET -u admin:admin http://localhost:8080/api/v1/clusters/TestCluster/requests/1|grep progress_percent|awk '{print substr($3,0,length($3))}')	
}
get_status() {
	echo $(curl -s -H "X-Requested-By: ambari" -X GET -u admin:admin http://localhost:8080/api/v1/clusters/TestCluster/requests/1|grep request_status|cut -d '"' -f 4)	
}
echo "----------------------------------------------------------------------------------------------------------------"
echo " Cluster Creation"
echo "----------------------------------------------------------------------------------------------------------------"
if [ ! -d /root/log ];then
	mkdir /root/log
fi
wget -O /tmp/blueprint.json $BLUEPRINT_URL &>/root/log/cluster-creation.log
wget -O /tmp/cluster.json $CLUSTER_TEMPLATE_URL &>>/root/log/cluster-creation.log
echo "Deploying Cluster..."
curl -H "X-Requested-By: ambari" -X POST -u admin:admin -d @/tmp/blueprint.json http://localhost:8080/api/v1/blueprints/TestCluster &>>/root/log/cluster-creation.log
curl -H "X-Requested-By: ambari" -X POST -u admin:admin -d @/tmp/cluster.json http://localhost:8080/api/v1/clusters/TestCluster &>>/root/log/cluster-creation.log
while [ $(get_status) == "PENDING" ] || [ $(get_status) == "IN_PROGRESS" ]
do
	printf "%.2f%% completed.\n" $(get_progress)
	sleep 10
done

if [ $(get_status) == "COMPLETED" ];then
	echo "The cluster was successfully deployed."
else
	echo "ERROR: Cluster deployment failed.Check the log file at /root/log/cluster-creation.log"
fi
