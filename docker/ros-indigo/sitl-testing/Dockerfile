#
# PX4 full ROS container, ready for SITL tests
#
# License: according to LICENSE.md in the root directory of the PX4 Firmware repository

FROM px4io/px4-ros-full:latest
MAINTAINER Andreas Antener <andreas@uaventure.com>

# Add local files
# FIXME: this doesn't work when building from vagrant
COPY scripts/testing/* /sitl/scripts/testing/
RUN chmod +x -R /sitl/scripts/testing/*
RUN chown -R root:root /sitl/scripts/testing/*

RUN bash /sitl/scripts/testing/setup-workspace.bash

CMD ["/usr/bin/bash"]
