#!/bin/bash
#
# Install Gazebo and ROS (and MAVROS)
# Following http://dev.px4.io/simulation-gazebo.html
#
# License: according to LICENSE.md in the root directory of the PX4 Firmware repository

# Prepare for automatic execution (not necessary if you execute the commands manually one by one)
set -e
export DEBIAN_FRONTEND=noninteractive

# Gazebo and ROS
sudo sh -c 'echo "deb http://packages.osrfoundation.org/gazebo/ubuntu-stable `lsb_release -cs` main" > /etc/apt/sources.list.d/gazebo-stable.list'
wget http://packages.osrfoundation.org/gazebo.key -O - | sudo apt-key add -
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu trusty main" > /etc/apt/sources.list.d/ros-latest.list'
wget https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -O - | sudo apt-key add -
sudo apt-get update

sudo apt-get -y install ros-indigo-gazebo6-ros-pkgs ros-indigo-ros-base

sudo rosdep init
rosdep update

## setup environment variables
sudo sh -c 'echo "source /opt/ros/indigo/setup.bash" >> ~/.bashrc'
source ~/.bashrc

## install mavros but from shadow repo to get latest version earlier
sudo sh -c 'echo "deb http://packages.ros.org/ros-shadow-fixed/ubuntu/ trusty main" > /etc/apt/sources.list.d/ros-shadow.list'
sudo apt-get update
sudo apt-get -y install ros-indigo-mavros ros-indigo-mavros-extras


# Set the plugin path so Gazebo finds our model and sim
export GAZEBO_PLUGIN_PATH=${GAZEBO_PLUGIN_PATH}:/root/Firmware/Tools/sitl_gazebo/Build
# Set the model path so Gazebo finds the airframes
export GAZEBO_MODEL_PATH=${GAZEBO_MODEL_PATH}:/root/Firmware/Tools/sitl_gazebo/models

