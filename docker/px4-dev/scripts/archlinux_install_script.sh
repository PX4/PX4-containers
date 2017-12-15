#!/bin/bash

# From clean distribution of ArchLinux, installs 
# all required packages for PX4 development on 
# posix and nuttx targets

# Install required packages
yes | pacman -Sy --noconfirm \
		arm-none-eabi-gcc \
		arm-none-eabi-newlib \
		base-devel \
		ccache \
		cmake \
		git \
		make \
		ninja \
		python-pip \
		tar \
		unzip \
		vim \
		wget \
		zip

# Install genromfs
wget https://sourceforge.net/projects/romfs/files/genromfs/0.5.2/genromfs-0.5.2.tar.gz
tar zxvf genromfs-0.5.2.tar.gz
cd genromfs-0.5.2 && make && make install && cd ..
rm genromfs-0.5.2.tar.gz genromfs-0.5.2 -r

# Install python dependencies
pip install \
		empy \
		jinja2 \
		numpy \
		serial \
		toml
