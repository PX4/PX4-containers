#
# Container with tools for onboard computer connection to PX4 via MAVROS.
#
# License: according to LICENSE.md in the root directory of the PX4 Firmware repository

FROM resin/rpi-raspbian:jessie
LABEL maintainer="Andreas Antener <andreas@uaventure.com>"

# Install basics
## Use the "noninteractive" debconf frontend
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update \
    && apt-get -y --no-install-recommends upgrade \
    && apt-get -y --no-install-recommends install wget sudo openssl ca-certificates \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Main ROS Setup
COPY scripts/install-ros-base-src.bash /scripts/install-ros-base-src.bash
RUN chmod +x -R /scripts/* && chown -R root:root /scripts/*
RUN bash /scripts/install-ros-base-src.bash

# Incomming MAVLink port
EXPOSE 14555/udp

# Start-up
COPY tools/mavros.launch /scripts/
COPY tools/start.bash /scripts/
RUN chmod +x -R /scripts/* && chown -R root:root /scripts/*

ENTRYPOINT ["/bin/bash", "/scripts/start.bash"]
CMD ["/scripts/mavros.launch", "gcs_url:=udp://:14555@:14550", "fcu_url:=/dev/ttyAMA0:921600"]
