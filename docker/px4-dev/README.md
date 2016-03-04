# PX4 Development Container #

Containers with PX4 tool chain and SITL simulation support. With and without ROS.

License: according to LICENSE.md in the root directory of the PX4 Firmware repository

## Running ##

If you like to run the container and use the Firmware source from outside, use the following command and specify the right volume mapping.

TODO: need to add ports to connect QGC

```
docker run -it --privileged \
	-v <local_src>:<container_src>:rw \
	-v /tmp/.X11-unix:/tmp/.X11-unix:ro \
	-e DISPLAY=:0 \
	--name=container_name px4io/px4-dev bash

```

## Building ##

```
docker build -t px4io/px4-dev -f ./Dockerfile .
docker build -t px4io/px4-dev-ros -f ./DockerfileRos .
```
