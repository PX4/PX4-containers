# PX4 Development Container #

Containers with PX4 tool chain and SITL simulation support. With and without ROS.

License: according to LICENSE.md in the root directory of the PX4 Firmware repository

## Container Hierarchy ##

 - px4-dev-base
   - px4-dev-nuttx
   - px4-dev-simulation
     - px4-dev-ros
   - px4-dev-raspi
   - px4-dev-snapdragon
   - px4-dev-clang
     - px4-dev-nuttx-clang

## Running ##

If you like to run the container and use the Firmware source from outside, use the following command and specify the appropriate volume mapping for your machine.

```console
docker run -it --privileged \
	-v <local_src>:<container_src>:rw \
	-v /tmp/.X11-unix:/tmp/.X11-unix:ro \
	-e DISPLAY=${DISPLAY} \
	--name=container_name px4io/px4-dev-simulation /bin/bash

```

## Building ##

```console

docker build -t px4io/px4-dev-base -f Dockerfile_base .
docker build -t px4io/px4-dev-nuttx -f Dockerfile_nuttx .
docker build -t px4io/px4-dev-raspi -f Dockerfile_raspi .
docker build -t px4io/px4-dev-simulation -f Dockerfile_simulation .
docker build -t px4io/px4-dev-ros -f Dockerfile_ros .

```
