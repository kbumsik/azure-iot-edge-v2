#!/bin/bash

# Launch docker daemon in our service
dockerd & 2>/dev/null

#wait for docker to start.
sleep 5s

# Configure docker socket
sudo touch /var/lib/iotedge/mgmt.sock
sudo touch /var/lib/iotedge/workload.sock

sudo chown iotedge:iotedge /var/lib/iotedge/mgmt.sock
sudo chown iotedge:iotedge /var/lib/iotedge/workload.sock

sudo chmod 660 /var/lib/iotedge/mgmt.sock
sudo chmod 666 /var/lib/iotedge/workload.sock

#Launch iotedge
/usr/bin/iotedged -c config.yaml

while :
do
	echo "Just looping..."
	sleep 30
done
