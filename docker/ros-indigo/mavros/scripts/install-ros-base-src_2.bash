#!/bin/bash
#
# Install ROS
#
# License: according to LICENSE.md in the root directory of the PX4 Firmware repository

# Prepare for automatic execution (not necessary if you execute the commands manually one by one)
set -e
export DEBIAN_FRONTEND=noninteractive

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
sudo apt-get -y install checkinstall cmake
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

# overwrite the exit code from before because it usually has errors
exit 0
