#
# PX4 full ROS container
#
# License: according to LICENSE.md in the root directory of the PX4 Firmware repository

FROM ubuntu:14.04.1
LABEL maintainer="Andreas Antener <andreas@uaventure.com>"

# Add local files
# FIXME: this doesn't work when building from vagrant
COPY scripts/* /sitl/
RUN chmod +x -R /sitl/*
RUN chown -R root:root /sitl/*

# Install basics
## Use the "noninteractive" debconf frontend
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update \
	&& apt-get -y install wget git mercurial sudo

# Main ROS Setup
RUN bash /sitl/install-ros.bash

# Install some utilities
# x11-utils to get xdpyinfo, for X11 display debugging
# mesa-utils provides glxinfo, handy for understanding the 3D support
# jstest-gtk provides a graphical joystick testing and configuration tool
RUN apt-get -y install x11-utils mesa-utils jstest-gtk

# Install python tools
RUN bash /sitl/install-python-tools.bash

# Some QT-Apps/Gazebo don't not show controls without this
ENV QT_X11_NO_MITSHM 1

CMD ["/bin/bash"]
