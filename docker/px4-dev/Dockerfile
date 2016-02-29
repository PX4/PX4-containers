#
# PX4 POSIX SITL container
#
# License: according to LICENSE.md in the root directory of the PX4 Firmware repository

FROM ubuntu:trusty
MAINTAINER Andreas Antener <andreas@uaventure.com>

# Install basics
## Use the "noninteractive" debconf frontend
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update \
	&& apt-get -y install wget git sudo

# Add local files
# FIXME: this doesn't work when building from vagrant
COPY scripts/* /sitl/
RUN chmod +x -R /sitl/*
RUN chown -R root:root /sitl/*

# PX4 toolchain
RUN bash /sitl/install-px4-toolchain.bash

# Install python tools
RUN bash /sitl/install-python-tools.bash

# Standalone Gazebo
RUN bash /sitl/install-gazebo6.bash

# Some QT-Apps/Gazebo don't not show controls without this
ENV QT_X11_NO_MITSHM 1

CMD ["/bin/bash"]
