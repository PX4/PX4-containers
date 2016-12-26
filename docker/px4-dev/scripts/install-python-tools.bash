#!/bin/bash
#
# Install python tools used by demo and test scripts
#
# License: according to LICENSE.md in the root directory of the PX4 Firmware repository

# Prepare for automatic execution (not necessary if you execute the commands manually one by one)
set -e
export DEBIAN_FRONTEND=noninteractive

#
# Install some Python Ubuntu packages
#
sudo apt-get -y install python-pip python-mock python-enum34 python-protobuf \
    python-pandas python-numpy python-jinja2

## Install Fuse support
sudo apt-get -y install fuse
pip install fusepy

## Get add-apt-repository
sudo apt-get install -y software-properties-common python-software-properties

#
# Install some packages from source
#
mkdir -p python_src
cd python_src

# Used to create graphs for web
git clone --branch px4_plots https://github.com/PX4/bearcart
cd bearcart
python setup.py install
cd ..

# Used to create plots from rosbags
git clone https://github.com/aktaylor08/RosbagPandas
cd RosbagPandas
python setup.py install
cd ..

# Install Dronekit
git clone https://github.com/dronekit/dronekit-python.git
cd dronekit-python
python setup.py build
python setup.py install
cd ..

# Install px4tools
pip install px4tools

rm -rf python_src
