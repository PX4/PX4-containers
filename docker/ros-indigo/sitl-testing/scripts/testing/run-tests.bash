#!/bin/bash
#
# Compiles and executes SITL tests
# Needs to runs inside container
#
# License: according to LICENSE.md in the root directory of the PX4 Firmware repository
set -e

CATKIN_WS=/sitl/catkin_ws
TEST_RESULTS=$CATKIN_WS/build/test_results
BAGS=/root/.ros
CHARTS=/root/.ros/charts
EXPORT_CHARTS=/sitl/testing/export_charts.py

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

cd $BAGS
for bag in `ls *.bag`
do
	echo "processing bag: $bag"
	python $EXPORT_CHARTS $CHARTS $bag
done

echo "copy build test results to job directory"
cp -r $TEST_RESULTS /job/
cp $BAGS/*.bag /job/test_results/
cp -r $CHARTS /job/test_results/
