#!/bin/bash
#
# Installation as described here: http://wiki.ros.org/ROSberryPi/Installing%20ROS%20Indigo%20on%20Raspberry%20Pi
# Exceptions from here: http://wiki.ros.org/wiki/edison
#

apt-get update
apt-get -y upgrade
apt-get -y install build-essential wget sudo

WORKSPACE=/ros_catkin_ws

# Setup ROS Repositories
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu wheezy main" > /etc/apt/sources.list.d/ros-latest.list'
wget https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -O - | sudo apt-key add -

# Now, make sure your Debian package index is up-to-date: 
sudo apt-get update
sudo apt-get -y upgrade

# Install bootstrap dependencies
sudo apt-get -y install python-setuptools python-pip python-yaml python-argparse python-distribute python-docutils python-dateutil python-setuptools python-six
sudo pip install rosdep rosinstall_generator wstool rosinstall


# Initializing rosdep
sudo rosdep init
rosdep update

# Create a catkin Workspace
mkdir $WORKSPACE
cd $WORKSPACE

# ROS-Comm: (recommended) ROS package, build, and communication libraries. No GUI tools. 
rosinstall_generator ros_comm mavros_extras --rosdistro indigo --deps --wet-only --exclude roslisp --tar > indigo-ros_comm-wet.rosinstall
wstool init src indigo-ros_comm-wet.rosinstall

# Resolve Dependencies
# Dependencies not available in the Raspbian stable branch
# Needed for Ros_Comm: libconsole-bridge-dev and liblz4-dev 
mkdir $WORKSPACE/external_src
sudo apt-get -y install checkinstall cmake
sudo sh -c 'echo "deb-src http://mirrordirector.raspbian.org/raspbian/ testing main contrib non-free rpi" >> /etc/apt/sources.list'
wget http://archive.raspbian.org/raspbian.public.key -O - | sudo apt-key add -
sudo apt-get update

# libconsole-bridge-dev: Install with the following: 
cd $WORKSPACE/external_src
sudo apt-get -y build-dep console-bridge
apt-get -y source -b console-bridge
sudo dpkg -i libconsole-bridge0.2_*.deb libconsole-bridge-dev_*.deb


# liblz4-dev: Install with the following:
#cd $WORKSPACE/external_src
#apt-get -y source -b lz4
#sudo dpkg -i liblz4_*.deb liblz4-dev_*.deb

# Excpetion from installation, for Edison
sudo sh -c 'echo "deb http://http.debian.net/debian wheezy-backports main" >> /etc/apt/sources.list'
sudo apt-get update
sudo apt-get -y install liblz4-dev


# Resolving Dependencies with rosdep
cd $WORKSPACE
rosdep install --from-paths src --ignore-src --rosdistro indigo -y -r --os=debian:wheezy


# Building the catkin Workspace
cd $WORKSPACE
sudo ./src/catkin/bin/catkin_make_isolated --install -DCMAKE_BUILD_TYPE=Release --install-space /opt/ros/indigo

sh -c 'echo "source /opt/ros/indigo/setup.bash" >> ~/.bashrc'

