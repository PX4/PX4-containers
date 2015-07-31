# PX4 MAVROS Container #

Container with tools for onboard computer connection to PX4 via MAVROS.

License: according to LICENSE.md in the root directory of the PX4 Firmware repository

There multiple Docker images built from this [repository](https://github.com/PX4/containers/tree/master/docker/ros-indigo/mavros):

For ARM hardware: `px4io/mavros:armhf-ubuntu-trusty`

This should run on any `armhf` computer with compatible kernel.

For x64 hardware: `px4io/mavros:ubuntu-trusty`

## Tested hardware ##

Computers:

- Odroid U3
- Raspberry PI 2

## Usage ##

TODO: usage description, or link to PX4 wiki

`sudo docker run -P --privileged --rm px4io/mavros:armhf-ubuntu-trusty`

(Change image according to platform)

To specify arguments for `mavros.launch` (or a different launch file):

`sudo docker run -P --privileged --rm px4io/mavros:armhf-ubuntu-trusty /scripts/mavros.launch fcu_url:=/dev/ttyAMA0:921600`

## Building ##

The containers were built with the following commands:

```
docker build -t px4io/mavros:armhf-ubuntu-trusty -f DockerfileArmhfUbuntu .
docker build -t px4io/mavros:ubuntu-trusty -f DockerfileUbuntu .

# There would be a source build based on raspbian-jessie but it needs to be built on an actual ARM device (or a decent cross-compiler setup).
#docker build -t px4io/mavros:raspbian-jessie -f DockerfileRaspbian .
```

Notes:

- built on x64 (with QEMU for ARM containers)
- see the scripts directory for installation procedures
