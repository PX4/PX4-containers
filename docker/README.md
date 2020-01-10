# PX4 Development Container #

Containers with PX4 tool chain and SITL simulation support. With and without ROS.

License: according to LICENSE.md in the root directory of the PX4 Firmware repository.

## Container Hierarchy ##

 - px4-dev-base-archlinux
 - px4-dev-base-bionic
   - px4-dev-armhf
   - px4-dev-clang
     - px4-dev-nuttx-clang
   - px4-dev-nuttx
   - px4-dev-raspi
   - px4-dev-simulation-bionic
     - px4-dev-ros-melodic
       - px4-dev-ros2-bouncy
       - px4-dev-ros2-crystal
       - px4-dev-ros2-dashing
       - px4-dev-ros2-eloquent
 - px4-dev-base-xenial
   - px4-dev-simulation-xenial
     - px4-dev-ros-kinetic
       - px4-dev-ros2-ardent
 - px4-docs

## Running ##

If you like to run the container and use the Firmware source from outside, use the following command and specify the appropriate volume mapping for your machine.

```console
docker run -it --privileged \
	-v <local_src>:<container_src>:rw \
	-v /tmp/.X11-unix:/tmp/.X11-unix:ro \
	-e DISPLAY=${DISPLAY} \
	--name=container_name px4io/px4-dev-simulation-bionic /bin/bash

```

## Building ##

```console
docker build -t px4io/px4-dev-ros-melodic -f Dockerfile_ros-melodic .

```

or

```console
make px4-dev-ros-melodic

```
