#!/bin/bash
#
# Install video tools
# > Raspbian setup
#
# License: according to LICENSE.md in the root directory of the PX4 Firmware repository

# Prepare for automatic execution (not necessary if you execute the commands manually one by one)
set -e
export DEBIAN_FRONTEND=noninteractive

# Install gstreamer
sudo apt-get update
sudo apt-get -y install gstreamer1.0* libv4l-dev v4l-utils libraspberrypi-bin libraspberrypi-dev
