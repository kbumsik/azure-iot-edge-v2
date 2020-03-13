#!/bin/bash

# remove docker.pid if needed
rm /var/run/docker.pid

# Launch docker daemon in our service
dockerd & 2>/dev/null

#wait for docker to start.
sleep 5s

# Configure connection string
sed -i '/device_connection_string/c\  device_connection_string : \"'${DEVICE_CONNECTION_STRING}'\"' /etc/iotedge/config.yaml

# Configure docker socket
sudo touch /var/lib/iotedge/mgmt.sock
sudo touch /var/lib/iotedge/workload.sock

sudo chown iotedge:iotedge /var/lib/iotedge/mgmt.sock
sudo chown iotedge:iotedge /var/lib/iotedge/workload.sock

sudo chmod 660 /var/lib/iotedge/mgmt.sock
sudo chmod 666 /var/lib/iotedge/workload.sock

#Launch iotedge
/usr/bin/iotedged -c /etc/iotedge/config.yaml

while :
do
	echo "Just looping..."
	sleep 30
done
