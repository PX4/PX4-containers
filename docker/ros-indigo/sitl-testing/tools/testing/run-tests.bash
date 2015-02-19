#!/bin/bash

#
# Compiles and executes SITL tests
# Needs to runs inside container
#

WORKSPACE=/sitl/catkin_ws
mkdir -p $WORKSPACE/src

echo "deleting previous test results"
if [ -d /job/test_results ]; then
	rm -r /job/test_results
fi

echo "creating symlinks to build job sources"
ln -s /job/Firmware $WORKSPACE/src/Firmware
ln -s /job/euroc_simulator $WORKSPACE/src/euroc_simulator
ln -s /job/mav_comm $WORKSPACE/src/mav_comm

echo "sourcing $WORKSPACE/devel/setup.bash"
source $WORKSPACE/devel/setup.bash
cd $WORKSPACE

echo "compiling, without parallel builds"
export ROS_PARALLEL_JOBS=
catkin_make

echo "running tests"
#echo "rostest px4 demo_tests.launch gui:=true headless:=false"
#rostest px4 demo_tests.launch gui:=true headless:=false
catkin_make test

echo "copy build test results to job directory"
cp -r $WORKSPACE/build/test_results /job/
