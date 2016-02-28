#
# PX4 POSIX SITL container
#
# License: according to LICENSE.md in the root directory of the PX4 Firmware repository

FROM ubuntu:trusty
MAINTAINER Andreas Antener <andreas@uaventure.com>

# Add local files
# FIXME: this doesn't work when building from vagrant
COPY scripts/* /sitl/
RUN chmod +x -R /sitl/*
RUN chown -R root:root /sitl/*

# Install basics
## Use the "noninteractive" debconf frontend
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update \
	&& apt-get -y install wget git sudo

# Main setup
RUN bash /sitl/install-sitl.bash

CMD ["/bin/bash"]
