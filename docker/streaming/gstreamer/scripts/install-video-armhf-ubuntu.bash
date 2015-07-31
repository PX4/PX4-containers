#!/bin/bash
#
# Install video tools
# > Ubuntu setup
#
# License: according to LICENSE.md in the root directory of the PX4 Firmware repository

# Prepare for automatic execution (not necessary if you execute the commands manually one by one)
set -e
export DEBIAN_FRONTEND=noninteractive

# Install gstreamer and v4l tools
# > install repo version to get all deps
sudo apt-get update
#sudo apt-get -y --no-install-recommends install gstreamer1.0* libmjpegutils-2.1-0 libmpeg2encpp-2.1-0 libmplex2-2.1-0 libnettle4 libxml2-dev
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
	libmjpegutils-2.1-0 \
	libmpeg2encpp-2.1-0 \
	libmplex2-2.1-0 \
	libnettle4 \
	libxml2-dev \
	libwayland-cursor0 \
	libwayland-egl1-mesa
# > now overwrite gstreamer from local binaries because repo version is out of date
# > source: http://forum.odroid.com/viewtopic.php?f=77&t=5960
cd /scripts
sudo tar -xzf gstreamer.tar.gz
cd deb
sudo dpkg -i --force-overwrite \
	gir1.2-gst-plugins-base-1.0_* \
	gir1.2-gstreamer-1.0_* \
	gstreamer1.0-plugins-bad_* \
	gstreamer1.0-plugins-base_* \
	gstreamer1.0-plugins-base-apps_* \
	gstreamer1.0-plugins-good_* \
	gstreamer1.0-tools_* \
	gstreamer1.0-x_* \
	libgstreamer-plugins-bad1.0-0_* \
	libgstreamer-plugins-base1.0-0_* \
	libgstreamer-plugins-good1.0-0_* \
	libgstreamer1.0-0_*
# > this is going to leave us with unmet dependencies, try to fix them
sudo apt-get -y -f install
cd ..
sudo rm -rf deb gstreamer.tar.gz

# Install raspberry video tools for RPI camera
sudo sh -c 'echo "deb http://ppa.launchpad.net/fo0bar/rpi2/ubuntu trusty main" > /etc/apt/sources.list.d/fo0bar-rpi2-trusty.list'
echo "-----BEGIN PGP PUBLIC KEY BLOCK-----
Version: SKS 1.1.5
Comment: Hostname: keyserver.ubuntu.com

mI0ET3S2EQEEANGfyo5r8h5wEptUBCOChmosJH8AmK6R/i1nHbhJCZ4GCXHRDPnTBcZ1fbXJ
w/+4iYg7K1NWUQgGpS08mZcnkcCbvOoVToOJRMxtaBv2Mn1XmZ2HUwW41tN45abs9dTFn17E
0P+TI6IQlvr7bA4GB+SWc/IAZQ3G5HZW7lirny9bABEBAAG0HUxhdW5jaHBhZCBQUEEgZm9y
IFJ5YW4gRmlubmlliLgEEwECACIFAk90thECGwMGCwkIBwMCBhUIAgkKCwQWAgMBAh4BAheA
AAoJEK2Z7HuoBgKvQ3IEALphFKur3G/jCW+glDyZw0axxd98LmAWytlNrII01CYyll4VB/Ky
C7iX2hiv3h513vCByFJ5LVNUP+hFiyFiWdbJBMqitBffgBGSZHaAKAbEGelZAQ2iZD1xS1IH
FXMANlvTCb/CsyIwstKCICm6RYN6qlo5/0w+kNpAl58NXyNf
=S55Y
-----END PGP PUBLIC KEY BLOCK-----" | sudo apt-key add -;

sudo apt-get update
sudo apt-get -y --no-install-recommends install libraspberrypi-bin libraspberrypi-dev

sudo apt-get clean
sudo rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
