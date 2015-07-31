#!/bin/bash
#
# Install video tools
# > Raspbian setup
#
# License: according to LICENSE.md in the root directory of the PX4 Firmware repository

# Prepare for automatic execution (not necessary if you execute the commands manually one by one)
set -e
export DEBIAN_FRONTEND=noninteractive

# Install gstreamer and v4l tools
sudo apt-get update
#sudo apt-get -y --no-install-recommends install gstreamer1.0* libv4l-dev v4l-utils libraspberrypi-bin libraspberrypi-dev
apt-get -y --no-install-recommends install \
	gstreamer1.0-plugins-bad \
	gstreamer1.0-plugins-ugly \
	gstreamer1.0-plugins-base \
	gstreamer1.0-plugins-base-apps \
	gstreamer1.0-plugins-good \
	gstreamer1.0-tools \
	gir1.2-gst-plugins-base-1.0 \
	gir1.2-gstreamer-1.0 \
	v4l-utils \
	libraspberrypi-bin \
	libraspberrypi-dev

sudo apt-get clean
sudo rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
