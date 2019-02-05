#
# PX4 full ROS container, ready for SITL tests
#
# License: according to LICENSE.md in the root directory of the PX4 Firmware repository

FROM px4io/px4-ros-full:latest
LABEL maintainer="Andreas Antener <andreas@uaventure.com>"

# Add local files
# FIXME: this doesn't work when building from vagrant
COPY scripts/testing/* /sitl/testing/
RUN chmod +x -R /sitl/testing/*
RUN chown -R root:root /sitl/testing/*

RUN bash /sitl/testing/setup-workspace.bash

CMD ["/bin/bash"]
