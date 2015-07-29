#!/bin/bash
#
# Install ROS
#
# License: according to LICENSE.md in the root directory of the PX4 Firmware repository

# Prepare for automatic execution (not necessary if you execute the commands manually one by one)
set -e
export DEBIAN_FRONTEND=noninteractive

# Main ROS Setup (Ubuntu install)
# Following http://wiki.ros.org/indigo/Installation/Ubuntu

## add ROS repository and key
## install main ROS pacakges
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu trusty main" > /etc/apt/sources.list.d/ros-latest.list'
sudo apt-key adv --keyserver hkp://pool.sks-keyservers.net --recv-key 0xB01FA116
sudo apt-get update
sudo apt-get -y install ros-indigo-ros-base

## get rodep, rosinstall and some additional dependencies
sudo apt-get -y install python-rosdep python-rosinstall ros-indigo-geodesy
sudo rosdep init
rosdep update

## setup environment variables
sudo sh -c 'echo "source /opt/ros/indigo/setup.bash" >> ~/.bashrc'
#source ~/.bashrc

## install mavros
sudo apt-get -y install ros-indigo-mavros
#sudo apt-get -y install ros-indigo-mavros ros-indigo-mavros-extras
