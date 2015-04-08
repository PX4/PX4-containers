#!/bin/bash
#
# Install ROS control packages
#
# License: according to LICENSE.md in the root directory of the PX4 Firmware repository

# Prepare for automatic execution (not necessary if you execute the commands manually one by one)
set -e
export DEBIAN_FRONTEND=noninteractive

sudo apt-get install ros-indigo-gazebo4-ros-pkgs ros-indigo-gazebo4-ros-control
