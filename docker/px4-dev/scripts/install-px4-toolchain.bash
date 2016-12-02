#!/bin/bash
#
# Install PX4 toolchain
# Following http://dev.px4.io/starting-installing-linux.html
#
# License: according to LICENSE.md in the root directory of the PX4 Firmware repository

# Prepare for automatic execution (not necessary if you execute the commands manually one by one)
set -e
export DEBIAN_FRONTEND=noninteractive

sudo apt-get install software-properties-common -y
sudo add-apt-repository ppa:george-edison55/cmake-3.x -y
sudo apt-get update
sudo apt-get install python-argparse git-core wget zip \
    python-empy qtcreator cmake build-essential genromfs -y

# simulation tools
sudo apt-get install ant protobuf-compiler libeigen3-dev \
    libopencv-dev openjdk-7-jdk openjdk-7-jre clang-3.5 lldb-3.5 -y

# NuttX toolchain
sudo add-apt-repository ppa:team-gcc-arm-embedded/ppa -y
sudo apt-get update
sudo apt-get install python-serial openocd \
    flex bison libncurses5-dev autoconf texinfo build-essential \
    libftdi-dev libtool zlib1g-dev \
    python-empy gcc-arm-none-eabi -y
