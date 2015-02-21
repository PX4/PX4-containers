#!/bin/bash

#
# Compiles and executes SITL tests
# Needs to runs inside container
#

CATKIN_WS=/sitl/catkin_ws
mkdir -p $CATKIN_WS/src

echo "deleting previous test results"
if [ -d /job/test_results ]; then
	rm -r /job/test_results
fi

echo "creating symlinks to build job sources"
ln -s /job/Firmware $CATKIN_WS/src/Firmware
ln -s /job/euroc_simulator $CATKIN_WS/src/euroc_simulator
ln -s /job/mav_comm $CATKIN_WS/src/mav_comm

echo "sourcing $CATKIN_WS/devel/setup.bash"
source $CATKIN_WS/devel/setup.bash
cd $CATKIN_WS

echo "compiling, without parallel builds"
export ROS_PARALLEL_JOBS=
catkin_make

echo "running tests"
#echo "rostest px4 demo_tests.launch gui:=true headless:=false"
#rostest px4 demo_tests.launch gui:=true headless:=false
catkin_make test

echo "copy build test results to job directory"
cp -r $CATKIN_WS/build/test_results /job/
