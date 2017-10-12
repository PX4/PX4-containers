#!/bin/bash

source ~/catkin_ws/devel/setup.bash

# Set ROS_IP if it is unset
: ${ROS_IP=`hostname -I`}
export ROS_IP

# Set ROS_MASTER_URI if it is unset
: ${ROS_MASTER_URI=http://`hostname -I`:11311}
export ROS_MASTER_URI

echo "ROS_IP: ${ROS_IP}"
echo "ROS_MASTER_URI: ${ROS_MASTER_URI}"

echo "Running \"roslaunch mavros -p 11311 px4.launch $1\""
roslaunch mavros -p 11311 px4.launch $1
