#!/bin/bash

# From clean distribution of ArchLinux, installs 
# all required packages for PX4 development on 
# posix and nuttx targets

# Install required PX4 packages
yes | pacman -Sy --noconfirm \
		base-devel \
		make \
		cmake \
		git-core \
		python-pip \
		tar \
        unzip \
		vim \
		wget \
		zip \
		arm-none-eabi-gcc \
		arm-none-eabi-newlib

# Install genromfs
wget https://sourceforge.net/projects/romfs/files/genromfs/0.5.2/genromfs-0.5.2.tar.gz
tar zxvf genromfs-0.5.2.tar.gz
cd genromfs-0.5.2 && make && make install && cd ..
rm genromfs-0.5.2.tar.gz genromfs-0.5.2 -r

# Install python dependencies
pip install \
		serial \
		empy \
		numpy \
		toml \
		jinja2