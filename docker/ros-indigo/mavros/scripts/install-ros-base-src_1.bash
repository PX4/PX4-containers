#!/bin/bash
#
# Install ROS
#
# License: according to LICENSE.md in the root directory of the PX4 Firmware repository

# Prepare for automatic execution (not necessary if you execute the commands manually one by one)
set -e
export DEBIAN_FRONTEND=noninteractive

# Main ROS Setup (source install for Raspbian base OS)
# Following http://wiki.ros.org/ROSberryPi/Installing%20ROS%20Indigo%20on%20Raspberry%20Pi

## add ROS repository and key
## install main ROS pacakges
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu wheezy main" > /etc/apt/sources.list.d/ros-latest.list'
wget https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -O - | sudo apt-key add -

echo "*** Update the base ***"
sudo apt-get update
sudo apt-get -y upgrade

echo "*** Install required OS packages ***"
sudo apt-get -y install pkg-config
sudo apt-get -y install python-setuptools python-pip python-yaml python-argparse python-distribute python-docutils python-dateutil python-setuptools python-six

echo "*** Install required ROS packages ***"
sudo pip install rosdep rosinstall_generator wstool rosinstall

echo "*** ROSDEP ***"
sudo rosdep init
rosdep update
