#!/bin/bash
#
# Create workspace at current location and fetch source repositories
#
# License: according to LICENSE.md in the root directory of the PX4 Firmware repository
set -e

WDIR=`pwd`
WORKSPACE=$WDIR/catkin_ws

# Setup workspace
mkdir -p $WORKSPACE/src
cd $WORKSPACE/src
catkin_init_workspace
cd $WORKSPACE
catkin_make
sh -c "echo 'source $WORKSPACE/devel/setup.bash' >> ~/.bashrc"

# Fetch sources
## PX4 firmware
cd $WORKSPACE/src
git clone https://github.com/PX4/Firmware.git
cd Firmware
git submodule update --init --recursive

## rotors simulator
cd $WORKSPACE/src
git clone https://github.com/PX4/rotors_simulator.git

## mav comm
cd $WORKSPACE/src
git clone https://github.com/PX4/mav_comm.git

## glog catkin
cd $WORKSPACE/src
git clone https://github.com/ethz-asl/glog_catkin.git

## catkin simple
cd $WORKSPACE/src
git clone https://github.com/catkin/catkin_simple.git


# Disable parallel make jobs for compilation.
# Sometimes required inside Docker container or VMs with not enough memory.
# If you're on a native Ubuntu installation, you can leave this away.
export ROS_PARALLEL_JOBS=

# Compile workspace
cd $WORKSPACE
source devel/setup.bash
catkin_make --cmake-args -DCONFIG=ros_sitl_simple
