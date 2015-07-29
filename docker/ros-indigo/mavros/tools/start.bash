#!/bin/bash
set -e

if [ $# -lt 1 ]; then
	echo "Require at least 1 argument that specifies the launchfile"
	echo "Add additional arguments if necessary (e.g. launchfile arguments)"
	echo "See dockerfile and ROS launchfile"
	exit 1
fi

# launch MAVROS
source /opt/ros/indigo/setup.bash
exec roslaunch $@
