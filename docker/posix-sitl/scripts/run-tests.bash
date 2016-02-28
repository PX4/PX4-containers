#!/bin/bash
#
# Run container and start test execution
#
# License: according to LICENSE.md in the root directory of the PX4 Firmware repository
set -e

# TODO:
echo "=====> compile"
#make posix_sitl_default gazebo
echo "<====="
# > run tests
# > capture results
# > copy results outside container
# etc..
# see https://github.com/PX4/containers/blob/master/docker/ros-indigo/sitl-testing/scripts/testing/run-tests.bash#L48
