#!/bin/bash
#
# Compiles and executes SITL tests
# Needs to runs inside container
#
# License: according to LICENSE.md in the root directory of the PX4 Firmware repository
set -e

echo "=====> prepare sources"
CATKIN_WS=/sitl/catkin_ws
CATKIN_ARGS=--cmake-args -DCONFIG=ros_sitl_simple
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
ln -s /job/rotors_simulator $CATKIN_WS/src/rotors_simulator
ln -s /job/mav_comm $CATKIN_WS/src/mav_comm

echo "sourcing $CATKIN_WS/devel/setup.bash"
source $CATKIN_WS/devel/setup.bash
cd $CATKIN_WS
echo "<====="

echo "=====> compile"
echo "compiling, without parallel builds"
export ROS_PARALLEL_JOBS=
catkin_make $CATKIN_ARGS
echo "<====="

# don't exit on error anymore from here on (because single tests or exports might fail)
set +e
echo "=====> run tests"
echo "running tests"
catkin_make $CATKIN_ARGS test
TEST_RESULT=$?
echo "<====="

echo "=====> process test results"
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
echo "<====="

# need to return error if tests failed, else Jenkins won't notice the failure
exit $TEST_RESULT
