#!/bin/bash
#
# Install ROS
#
# License: according to LICENSE.md in the root directory of the PX4 Firmware repository

# Prepare for automatic execution (not necessary if you execute the commands manually one by one)
set -e
export DEBIAN_FRONTEND=noninteractive

# Main ROS Setup
# Following http://wiki.ros.org/indigo/Installation/Ubuntu
# Also adding dependencies for gazebo http://gazebosim.org/tutorials?tut=drcsim_install

## add ROS repository and key
## install main ROS pacakges
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu trusty main" > /etc/apt/sources.list.d/ros-latest.list'
wget https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -O - | sudo apt-key add -
sudo apt-get update
sudo apt-get -y install ros-indigo-desktop-full
sudo rosdep init
rosdep update

## setup environment variables
sudo sh -c 'echo "source /opt/ros/indigo/setup.bash" >> ~/.bashrc'
source ~/.bashrc

## get rosinstall and some additional dependencies
sudo apt-get -y install python-rosinstall ros-indigo-octomap-msgs ros-indigo-octomap-ros ros-indigo-joy ros-indigo-geodesy

## add osrf repository
## install drcsim
sudo sh -c 'echo "deb http://packages.osrfoundation.org/drc/ubuntu trusty main" > /etc/apt/sources.list.d/drc-latest.list'
wget http://packages.osrfoundation.org/drc.key -O - | sudo apt-key add -
sudo apt-get update
sudo apt-get -y install drcsim

## install mavros but from shadow repo to get latest version earlier
sudo sh -c 'echo "deb http://packages.ros.org/ros-shadow-fixed/ubuntu/ trusty main" > /etc/apt/sources.list.d/ros-shadow.list'
sudo apt-get update
sudo apt-get -y install ros-indigo-mavros ros-indigo-mavros-extras
