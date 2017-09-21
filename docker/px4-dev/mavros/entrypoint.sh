#!/bin/bash

source ~/catkin_ws/devel/setup.bash
export ROS_IP=`hostname -I`
export ROS_MASTER_URI=http://`hostname -I`:11311

echo "Running \"roslaunch mavros -p 11311 px4.launch $1\""
roslaunch mavros -p 11311 px4.launch $1
