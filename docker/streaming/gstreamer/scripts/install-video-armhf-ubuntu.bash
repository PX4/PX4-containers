#!/bin/bash
#
# Install video tools
# > Ubuntu setup
#
# License: according to LICENSE.md in the root directory of the PX4 Firmware repository

# Prepare for automatic execution (not necessary if you execute the commands manually one by one)
set -e
export DEBIAN_FRONTEND=noninteractive

# Install gstreamer
# > install repo version to get all deps
sudo apt-get update
sudo apt-get -y install gstreamer1.0* libmjpegutils-2.1-0 libmpeg2encpp-2.1-0 libmplex2-2.1-0 libnettle4
# > now overwrite gstreamer from local binaries because repo version is out of date
# > source: http://forum.odroid.com/viewtopic.php?f=77&t=5960
sudo apt-get -y install 
cd /scripts
sudo tar -xzf gstreamer.tar.gz
cd deb
sudo dpkg -i --force-overwrite *
# > this is going to leave us with unmet dependencies, try to fix them
sudo apt-get -y -f install
cd ..
sudo rm -rf deb gstreamer.tar.gz

# Install v4l tools for C920 support
sudo apt-get -y install libv4l-dev v4l-utils

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
sudo apt-get -y install libraspberrypi-bin libraspberrypi-dev
