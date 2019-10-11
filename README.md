## Azure IOT Edge V2 on balenaOS

**Work In Progress**

### Requirements:
1. Create iot hub on azure portal: https://docs.microsoft.com/en-us/azure/iot-hub/iot-hub-create-through-portal
2. Register a device: https://docs.microsoft.com/en-us/azure/iot-edge/how-to-register-device-portal
3. Copy the primary connection string and add it to `Device Environment Variables` in your balenaCloud fleet: `DEVICE_CONNECTION_STRING`.
4. `balena push myFleet` the this repo to your balenaCloud fleet.

# TODO:
- [x] use `sed` to insert the connection string from an ENV var before the iotedge gets started, so we can have different configuration strings for different devices.
- [ ] Improve how waiting for dockerd works.
- [x] Add a `Dockerfile.x86` for Intel based machines like Intel NUC or AAEON Upboard.
