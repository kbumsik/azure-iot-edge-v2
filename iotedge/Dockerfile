FROM balenalib/raspberrypi3-debian:stretch

# Env variables
ARG DEVICE_CONNECTION_STRING

# Install requirements
RUN apt-get update && apt-get install iptables

# Download and install docker.
RUN curl -fSLs https://get.docker.com | sudo sh

# Download and install the standard libiothsm implementation
RUN curl -L https://aka.ms/libiothsm-std-linux-armhf-latest -o libiothsm-std.deb && sudo dpkg -i ./libiothsm-std.deb

# Download and install the IoT Edge Security Daemon
RUN curl -L https://aka.ms/iotedged-linux-armhf-latest -o iotedge.deb && sudo dpkg -i ./iotedge.deb

# Run apt-get fix
RUN sudo apt-get install -f

# Configure iotedge
WORKDIR /etc/iotedge
# connection string
RUN sed -i '/device_connection_string/c\  device_connection_string : \"'${DEVICE_CONNECTION_STRING}'\"' ./config.yaml
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

CMD [ "./start.sh" ]
