# PX4 Development Container #

Containers with PX4 tool chain and SITL simulation support. With and without ROS.

License: according to LICENSE.md in the root directory of the PX4 Firmware repository

## Running ##

If you like to run the container and use the Firmware source from outside, use the following command and specify the appropriate volume mapping for your machine.

```
docker run -it --privileged \
	-v <local_src>:<container_src>:rw \
	-v /tmp/.X11-unix:/tmp/.X11-unix:ro \
	-e DISPLAY=:0 \
	-p 14556:14556/udp \
	--name=container_name px4io/px4-dev bash

```

## Building ##

```
docker build -t px4io/px4-dev -f ./Dockerfile .
docker build -t px4io/px4-dev-ros -f ./DockerfileRos .
```

### Building DockerfileSnapdragon

First create the trimmed SDK which is required for the install:


Download the following:
	"https://developer.qualcomm.com/download/hexagon/qualcomm_hexagon_sdk_lnx_3_0_eval.bin"
	"http://support.intrinsyc.com/attachments/download/1011/qrlSDK.tgz"

```
./trimSnapdragonSDK.sh
```

This will create cross_toolchain/trimmedSDK.tgz

This file is used by DockerfileSnapdragon:

```
docker build -t px4io/px4-dev-snapdragon -f ./DockerfileSnapdragon .
```
