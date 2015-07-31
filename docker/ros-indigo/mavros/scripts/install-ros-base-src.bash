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
sudo apt-get -y --no-install-recommends upgrade

echo "*** Install required OS packages ***"
sudo apt-get -y --no-install-recommends install pkg-config git mercurial build-essential
sudo apt-get -y --no-install-recommends install python-setuptools python-pip python-yaml python-argparse python-distribute python-docutils python-dateutil python-setuptools python-six

echo "*** Install required ROS packages ***"
sudo pip install rosdep rosinstall_generator wstool rosinstall

echo "*** ROSDEP ***"
sudo rosdep init
rosdep update

mkdir ~/ros_catkin_ws
cd ~/ros_catkin_ws

echo "*** rosinstall ***"
#   This will install only mavros and not mavros-extras (no image
#   support which the Edison can’t really handle well anyway).
rosinstall_generator ros_comm mavros --rosdistro indigo --deps --wet-only --exclude roslisp --tar > indigo-ros_comm-wet.rosinstall

echo "*** wstool ***"
sudo wstool init src -j1 indigo-ros_comm-wet.rosinstall
set +e # some of the commands might fail
while [ $? != 0 ]; do
  echo "*** wstool - download failures, retrying ***"
  sudo wstool update -t src -j1
done
set -e

echo "*** Install cmake and update sources.list ***"
mkdir ~/ros_catkin_ws/external_src
sudo apt-get -y --no-install-recommends install checkinstall cmake
sudo sh -c 'echo "deb-src http://mirrordirector.raspbian.org/raspbian/ testing main contrib non-free rpi" >> /etc/apt/sources.list'
sudo sh -c 'echo "deb http://http.debian.net/debian wheezy-backports main" >> /etc/apt/sources.list'
sudo apt-get -y update

echo "*** Install console bridge ***"
cd ~/ros_catkin_ws/external_src
sudo apt-get -y build-dep console-bridge
apt-get -y source -b console-bridge
sudo dpkg -i libconsole-bridge0.2_*.deb libconsole-bridge-dev_*.deb

echo "*** Install liblz4-dev ***"
sudo apt-get -y --force-yes install liblz4-dev

echo "*** rosdep install - Errors at the end are normal ***"
cd ~/ros_catkin_ws
set +e
#  Python errors after the following command are normal.
rosdep install --from-paths src --ignore-src --rosdistro indigo -y -r --os=debian:wheezy
set -e

echo "*** Building ROS ***"
cd ~/ros_catkin_ws
sudo ./src/catkin/bin/catkin_make_isolated --install -DCMAKE_BUILD_TYPE=Release -DMAVLINK_DIALECT=pixhawk --install-space /home/ros/indigo

sudo ln -sf /home/ros /opt/

echo "*** Updating .profile and .bashrc ***"
echo "source /home/ros/indigo/setup.bash" >> ~/.profile
echo "source ~/ros_catkin_ws/devel_isolated/setup.bash" >> ~/.bashrc

echo "*** Cleaning up ***"
sudo apt-get clean
sudo rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
sudo rm -rf ~/ros_catkin_ws/external_src
sudo rm -rf ~/ros_catkin_ws/src
# TBD: can we also remove ros build folders?
