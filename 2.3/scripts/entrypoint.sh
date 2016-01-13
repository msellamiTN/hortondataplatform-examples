#!/bin/bash
/root/scripts/startAmbari.sh
if [ -n "$BLUEPRINT_URL" ] && [ -n $CLUSTER_TEMPLATE_URL ];then
	/root/scripts/createCluster.sh
fi
/usr/sbin/sshd -D
