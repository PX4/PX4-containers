#!/bin/bash
#
# Install ROS
#
# License: according to LICENSE.md in the root directory of the PX4 Firmware repository

# Prepare for automatic execution (not necessary if you execute the commands manually one by one)
set -e
export DEBIAN_FRONTEND=noninteractive

echo "*** Building ROS ***"
cd ~/ros_catkin_ws
sudo ./src/catkin/bin/catkin_make_isolated --install -DCMAKE_BUILD_TYPE=Release -DMAVLINK_DIALECT=pixhawk --install-space /home/ros/indigo

sudo ln -sf /home/ros /opt/

echo "*** Updating .profile and .bashrc ***"
echo "source /home/ros/indigo/setup.bash" >> ~/.profile
echo "source ~/ros_catkin_ws/devel_isolated/setup.bash" >> ~/.bashrc
