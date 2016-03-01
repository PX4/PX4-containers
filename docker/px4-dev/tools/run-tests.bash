#!/bin/bash
#
# Starts tests from within the container
#
# License: according to LICENSE.md in the root directory of the PX4 Firmware repository
set -e

# TODO

SRC_DIR=/root/Firmware
export GAZEBO_MODEL_PATH=${GAZEBO_MODEL_PATH}:${SRC_DIR}/Tools/sitl_gazebo/models
export GAZEBO_PLUGIN_PATH=${SRC_DIR}/Tools/sitl_gazebo/Build/:${GAZEBO_PLUGIN_PATH}
export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:${SRC_DIR}/Tools/sitl_gazebo/Build/msgs/
export ROS_PACKAGE_PATH=${ROS_PACKAGE_PATH}:${SRC_DIR}

ln -s /job/Firmware ${SRC_DIR}

echo "=====> compile"
make posix_sitl_default
mkdir -p Tools/sitl_gazebo/Build
cd Tools/sitl_gazebo/Build
cmake -Wno-dev ..
make -j4
echo "<====="

# > run tests
echo "=====> run tests"
rostest px4 mavros_tests_posix.launch
echo "<====="

# > capture results
# > copy results outside container
# etc..
# see https://github.com/PX4/containers/blob/master/docker/ros-indigo/sitl-testing/scripts/testing/run-tests.bash#L48
