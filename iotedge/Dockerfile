FROM balenalib/raspberrypi3-debian:stretch

# Install requirements
RUN apt-get update --yes && apt-get install iptables ---yes

# Download and install docker.
RUN curl -fSLs https://get.docker.com | sudo sh

# Download and install the standard libiothsm implementation
RUN curl -L https://github.com/Azure/azure-iotedge/releases/download/1.0.9-rc2/libiothsm-std_1.0.9.rc2-1-1_debian9_armhf.deb -o libiothsm-std.deb && sudo dpkg -i ./libiothsm-std.deb

# Download and install the IoT Edge Security Daemon
RUN curl -L https://github.com/Azure/azure-iotedge/releases/download/1.0.9-rc2/iotedge_1.0.9.rc2-1_debian9_armhf.deb -o iotedge.deb && sudo dpkg -i ./iotedge.deb

# Run apt-get fix
RUN sudo apt-get install -f --yes

# Configure iotedge
WORKDIR /etc/iotedge
# listen
RUN sed -i '/iotedge.mgmt.socket/c\  management_uri: \"unix:\/\/\/var\/lib\/iotedge\/mgmt.sock\"' ./config.yaml
RUN sed -i '/iotedge.socket/c\  workload_uri: \"unix:\/\/\/var\/lib\/iotedge\/workload.sock\"' ./config.yaml
# connect
RUN sed -i '/management_uri: \"unix:\/\/\/var\/run\/iotedge\/mgmt.sock\"/c\  management_uri: \"unix:\/\/\/var\/lib\/iotedge\/mgmt.sock\"' ./config.yaml
RUN sed -i '/workload_uri: \"unix:\/\/\/var\/run\/iotedge\/workload.sock\"/c\  workload_uri: \"unix:\/\/\/var\/lib\/iotedge\/workload.sock\"' ./config.yaml
# runtime
RUN sed -i '/moby_runtime:/c\  # moby_runtime:' ./config.yaml
RUN sed -i '/uri: \"unix:\/\/\/var\/run\/docker.sock\"/c\  # uri: \"unix:\/\/\/var\/run\/docker.sock\"' ./config.yaml

# Startup script
WORKDIR /usr/src/app
COPY start.sh .
RUN chmod +x start.sh

# Run startup script
CMD [ "./start.sh" ]
