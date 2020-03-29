# PX4 Containers

Contains Dockerfiles for Docker containers to build and test PX4, with and without ROS and ROS2.

License: according to [LICENSE](https://github.com/PX4/Firmware/blob/master/LICENSE) in the root directory of the PX4 Firmware repository.

[![Build Status](https://github.com/PX4/containers/workflows/Build%20Docker%20images/badge.svg)](https://github.com/PX4/containers/actions)


## Container Hierarchy

- [px4io/px4-dev-base-archlinux](https://hub.docker.com/r/px4io/px4-dev-base-archlinux) [![](https://images.microbadger.com/badges/image/px4io/px4-dev-base-archlinux.svg)](http://microbadger.com/images/px4io/px4-dev-base-archlinux) [![Docker Pulls](https://img.shields.io/docker/pulls/px4io/px4-dev-base-archlinux.svg)](https://hub.docker.com/r/px4io/px4-dev-base-archlinux)
- [px4io/px4-dev-base-bionic](https://hub.docker.com/r/px4io/px4-dev-base-bionic) [![](https://images.microbadger.com/badges/image/px4io/px4-dev-base-bionic.svg)](http://microbadger.com/images/px4io/px4-dev-base-bionic) [![Docker Pulls](https://img.shields.io/docker/pulls/px4io/px4-dev-base-bionic.svg)](https://hub.docker.com/r/px4io/px4-dev-base-bionic)
    - [px4io/px4-dev-clang](https://hub.docker.com/r/px4io/px4-dev-clang) [![](https://images.microbadger.com/badges/image/px4io/px4-dev-clang.svg)](http://microbadger.com/images/px4io/px4-dev-clang) [![Docker Pulls](https://img.shields.io/docker/pulls/px4io/px4-dev-clang.svg)](https://hub.docker.com/r/px4io/px4-dev-clang)
    - [px4io/px4-dev-nuttx-bionic](https://hub.docker.com/r/px4io/px4-dev-nuttx-bionic) [![](https://images.microbadger.com/badges/image/px4io/px4-dev-nuttx-bionic.svg)](http://microbadger.com/images/px4io/px4-dev-nuttx-bionic) [![Docker Pulls](https://img.shields.io/docker/pulls/px4io/px4-dev-nuttx-bionic.svg)](https://hub.docker.com/r/px4io/px4-dev-nuttx-bionic)
    - [px4io/px4-dev-nuttx-clang](https://hub.docker.com/r/px4io/px4-dev-nuttx-clang) [![](https://images.microbadger.com/badges/image/px4io/px4-dev-nuttx-clang.svg)](http://microbadger.com/images/px4io/px4-dev-nuttx-clang) [![Docker Pulls](https://img.shields.io/docker/pulls/px4io/px4-dev-nuttx-clang.svg)](https://hub.docker.com/r/px4io/px4-dev-nuttx-clang)
    - [px4io/px4-dev-raspi](https://hub.docker.com/r/px4io/px4-dev-raspi) [![](https://images.microbadger.com/badges/image/px4io/px4-dev-raspi.svg)](http://microbadger.com/images/px4io/px4-dev-raspi) [![Docker Pulls](https://img.shields.io/docker/pulls/px4io/px4-dev-raspi.svg)](https://hub.docker.com/r/px4io/px4-dev-raspi)
    - [px4io/px4-dev-simulation-bionic](https://hub.docker.com/r/px4io/px4-dev-simulation-bionic) [![](https://images.microbadger.com/badges/image/px4io/px4-dev-simulation-bionic.svg)](http://microbadger.com/images/px4io/px4-dev-simulation-bionic) [![Docker Pulls](https://img.shields.io/docker/pulls/px4io/px4-dev-simulation-bionic.svg)](https://hub.docker.com/r/px4io/px4-dev-simulation-bionic)
        - [px4io/px4-dev-ros-melodic](https://hub.docker.com/r/px4io/px4-dev-ros-melodic) [![](https://images.microbadger.com/badges/image/px4io/px4-dev-ros-melodic.svg)](http://microbadger.com/images/px4io/px4-dev-ros-melodic) [![Docker Pulls](https://img.shields.io/docker/pulls/px4io/px4-dev-ros-melodic.svg)](https://hub.docker.com/r/px4io/px4-dev-ros-melodic)
            - [px4io/px4-dev-ros2-bouncy](https://hub.docker.com/r/px4io/px4-dev-ros2-bouncy) [![](https://images.microbadger.com/badges/image/px4io/px4-dev-ros2-bouncy.svg)](http://microbadger.com/images/px4io/px4-dev-ros2-bouncy) [![Docker Pulls](https://img.shields.io/docker/pulls/px4io/px4-dev-ros2-bouncy.svg)](https://hub.docker.com/r/px4io/px4-dev-ros2-bouncy)
            - [px4io/px4-dev-ros2-crystal](https://hub.docker.com/r/px4io/px4-dev-ros2-crystal) [![](https://images.microbadger.com/badges/image/px4io/px4-dev-ros2-crystal.svg)](http://microbadger.com/images/px4io/px4-dev-ros2-crystal) [![Docker Pulls](https://img.shields.io/docker/pulls/px4io/px4-dev-ros2-crystal.svg)](https://hub.docker.com/r/px4io/px4-dev-ros2-crystal)
            - [px4io/px4-dev-ros2-dashing](https://hub.docker.com/r/px4io/px4-dev-ros2-dashing) [![](https://images.microbadger.com/badges/image/px4io/px4-dev-ros2-dashing.svg)](http://microbadger.com/images/px4io/px4-dev-ros2-dashing) [![Docker Pulls](https://img.shields.io/docker/pulls/px4io/px4-dev-ros2-dashing.svg)](https://hub.docker.com/r/px4io/px4-dev-ros2-dashing)
            - [px4io/px4-dev-ros2-eloquent](https://hub.docker.com/r/px4io/px4-dev-ros2-eloquent) [![](https://images.microbadger.com/badges/image/px4io/px4-dev-ros2-eloquent.svg)](http://microbadger.com/images/px4io/px4-dev-ros2-eloquent) [![Docker Pulls](https://img.shields.io/docker/pulls/px4io/px4-dev-ros2-eloquent.svg)](https://hub.docker.com/r/px4io/px4-dev-ros2-eloquent)
- [px4io/px4-dev-base-focal](https://hub.docker.com/r/px4io/px4-dev-base-focal) [![](https://images.microbadger.com/badges/image/px4io/px4-dev-base-focal.svg)](http://microbadger.com/images/px4io/px4-dev-base-focal) [![Docker Pulls](https://img.shields.io/docker/pulls/px4io/px4-dev-base-focal.svg)](https://hub.docker.com/r/px4io/px4-dev-base-focal)
    - [px4io/px4-dev-nuttx-focal](https://hub.docker.com/r/px4io/px4-dev-nuttx-focal) [![](https://images.microbadger.com/badges/image/px4io/px4-dev-nuttx-focal.svg)](http://microbadger.com/images/px4io/px4-dev-nuttx-focal) [![Docker Pulls](https://img.shields.io/docker/pulls/px4io/px4-dev-nuttx-focal.svg)](https://hub.docker.com/r/px4io/px4-dev-nuttx-focal)
    - [px4io/px4-dev-simulation-focal](https://hub.docker.com/r/px4io/px4-dev-simulation-focal) [![](https://images.microbadger.com/badges/image/px4io/px4-dev-simulation-focal.svg)](http://microbadger.com/images/px4io/px4-dev-simulation-focal) [![Docker Pulls](https://img.shields.io/docker/pulls/px4io/px4-dev-simulation-focal.svg)](https://hub.docker.com/r/px4io/px4-dev-simulation-focal)
- [px4io/px4-dev-base-xenial](https://hub.docker.com/r/px4io/px4-dev-base-xenial) [![](https://images.microbadger.com/badges/image/px4io/px4-dev-base-xenial.svg)](http://microbadger.com/images/px4io/px4-dev-base-xenial) [![Docker Pulls](https://img.shields.io/docker/pulls/px4io/px4-dev-base-xenial.svg)](https://hub.docker.com/r/px4io/px4-dev-base-xenial)
    - [px4io/px4-dev-simulation-xenial](https://hub.docker.com/r/px4io/px4-dev-simulation-xenial) [![](https://images.microbadger.com/badges/image/px4io/px4-dev-simulation-xenial.svg)](http://microbadger.com/images/px4io/px4-dev-simulation-xenial) [![Docker Pulls](https://img.shields.io/docker/pulls/px4io/px4-dev-simulation-xenial.svg)](https://hub.docker.com/r/px4io/px4-dev-simulation-xenial)
        - [px4io/px4-dev-ros-kinetic](https://hub.docker.com/r/px4io/px4-dev-ros-kinetic) [![](https://images.microbadger.com/badges/image/px4io/px4-dev-ros-kinetic.svg)](http://microbadger.com/images/px4io/px4-dev-ros-kinetic) [![Docker Pulls](https://img.shields.io/docker/pulls/px4io/px4-dev-ros-kinetic.svg)](https://hub.docker.com/r/px4io/px4-dev-ros-kinetic)
            - [px4io/px4-dev-ros2-ardent](https://hub.docker.com/r/px4io/px4-dev-ros2-ardent) [![](https://images.microbadger.com/badges/image/px4io/px4-dev-ros2-ardent.svg)](http://microbadger.com/images/px4io/px4-dev-ros2-ardent) [![Docker Pulls](https://img.shields.io/docker/pulls/px4io/px4-dev-ros2-ardent.svg)](https://hub.docker.com/r/px4io/px4-dev-ros2-ardent)
- [px4io/px4-dev-armhf](https://hub.docker.com/r/px4io/px4-dev-armhf) [![](https://images.microbadger.com/badges/image/px4io/px4-dev-armhf.svg)](http://microbadger.com/images/px4io/px4-dev-armhf) [![Docker Pulls](https://img.shields.io/docker/pulls/px4io/px4-dev-armhf.svg)](https://hub.docker.com/r/px4io/px4-dev-armhf)
- [px4io/px4-docs](https://hub.docker.com/r/px4io/px4-docs) [![](https://images.microbadger.com/badges/image/px4io/px4-docs.svg)](http://microbadger.com/images/px4io/px4-docs) [![Docker Pulls](https://img.shields.io/docker/pulls/px4io/px4-docs.svg)](https://hub.docker.com/r/px4io/px4-docs)


## Running

If you like to run the container and use the Firmware source from outside of the container, use the following command and specify the appropriate volume mapping.

```
docker run -it --rm \
    -v <local_src>:/home/user/Firmware:rw \
    -v /tmp/.X11-unix:/tmp/.X11-unix:ro \
    -e DISPLAY=${DISPLAY} \
    -e LOCAL_USER_ID="$(id -u)" \
    --name=container_name px4io/px4-dev-simulation-bionic /bin/bash
```

Or use [docker_run.sh](https://github.com/PX4/Firmware/blob/master/Tools/docker_run.sh).

## Building

```
cd docker
docker build -t px4io/px4-dev-ros-melodic -f Dockerfile_ros-melodic .
```

or:

```
cd docker
make px4-dev-ros-melodic
```
