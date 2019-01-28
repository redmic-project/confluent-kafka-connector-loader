#!/bin/sh

if [ -z "${CONNECT_SERVICE_NAME}" ]
then
	echo "You must define 'CONNECT_SERVICE_NAME' in environment, with the name of Connect service"
	exit 1
fi

connectServiceReplication=$(docker service ls -f name=${CONNECT_SERVICE_NAME} --format '{{.Replicas}}')
connectServiceDesiredReplicas=$(echo ${connectServiceReplication} | cut -d '/' -f 2)

if [ -z "${connectServiceDesiredReplicas}" ]
then
	echo "Connect service replication not found, aborting!"
	exit 1
fi

echo "Scaling Connect service to 0 .."
docker service scale ${CONNECT_SERVICE_NAME}=0

if cp -a /jar/. /connect-jars
then
	echo "Jars copied to Connect volume successfully"
else
	echo "Error while copying jars!"
fi

echo "Scaling Connect service to ${connectServiceDesiredReplicas} .."
docker service scale -d ${CONNECT_SERVICE_NAME}=${connectServiceDesiredReplicas}

echo "Done!"
