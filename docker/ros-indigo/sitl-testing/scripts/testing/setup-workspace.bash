#!/bin/sh
#
# Create testing workspace for SITL testing
#
# License: according to LICENSE.md in the root directory of the PX4 Firmware repository
set -e

WORKSPACE=/sitl/catkin_ws

source /opt/ros/indigo/setup.bash
export ROS_PARALLEL_JOBS=

# Setup workspace
mkdir -p $WORKSPACE/src
cd $WORKSPACE/src
catkin_init_workspace
cd $WORKSPACE
catkin_make
echo "source $WORKSPACE/devel/setup.bash" >> ~/.bashrc

# glog catkin
cd $WORKSPACE/src
git clone https://github.com/ethz-asl/glog_catkin.git

# catkin simple
cd $WORKSPACE/src
git clone https://github.com/catkin/catkin_simple.git

cd $WORKSPACE
catkin_make

# remove build and source directories (binaries are installed now)
rm -r build src
