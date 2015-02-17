#
# MAVROS container for Edison
#
# License: according to LICENSE.md in the root directory of the PX4 Firmware repository

FROM debian:wheezy
MAINTAINER Andreas Antener <andreas@uaventure.com>

# Install basics
## Use the "noninteractive" debconf frontend
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update \
	&& apt-get -y upgrade \
	&& apt-get -y install build-essential wget


# Setup ROS Repositories
RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu wheezy main" > /etc/apt/sources.list.d/ros-latest.list' && \
	wget https://raw.githubusercontent.com/ros/rosdistro/master/ros.key --no-check-certificate -O - | apt-key add - && \
	apt-get update && \
	apt-get -y upgrade


# Install bootstrap dependencies
RUN apt-get -y install python-setuptools python-pip python-yaml python-argparse python-distribute python-docutils python-dateutil python-setuptools python-six && \
	pip install rosdep rosinstall_generator wstool rosinstall


# Initializing rosdep
RUN rosdep init && \
	rosdep update

# Create a catkin Workspace
RUN mkdir /ros_catkin_ws
WORKDIR /ros_catkin_ws

# ROS-Comm: (recommended) ROS package, build, and communication libraries. No GUI tools. 
RUN rosinstall_generator ros_comm mavros_extras --rosdistro indigo --deps --wet-only --exclude roslisp --tar > indigo-ros_comm-wet.rosinstall && \
	wstool init src indigo-ros_comm-wet.rosinstall

# Resolve Dependencies
# Dependencies not available in the Raspbian stable branch
# Needed for Ros_Comm: libconsole-bridge-dev and liblz4-dev
RUN mkdir /ros_catkin_ws/external_src
WORKDIR /ros_catkin_ws/external_src

RUN apt-get -y install checkinstall cmake && \
	sh -c 'echo "deb-src http://mirrordirector.raspbian.org/raspbian/ testing main contrib non-free rpi" >> /etc/apt/sources.list' && \
	wget http://archive.raspbian.org/raspbian.public.key -O - | apt-key add - && \
	apt-get update

RUN apt-get -y install pkg-config

# libconsole-bridge-dev: Install with the following: 
RUN apt-get -y build-dep console-bridge && \
	apt-get -y source -b console-bridge && \
	dpkg -i libconsole-bridge0.2_*.deb libconsole-bridge-dev_*.deb


# liblz4-dev: Install with the following:
# Excpetion from installation, for Edison
RUN sh -c 'echo "deb http://http.debian.net/debian wheezy-backports main" >> /etc/apt/sources.list' && \
	apt-get update && \
	apt-get -y install liblz4-dev


WORKDIR /ros_catkin_ws

# Resolving Dependencies with rosdep
RUN rosdep install --from-paths src --ignore-src --rosdistro indigo -y -r --os=debian:wheezy


# Building the catkin Workspace
RUN ./src/catkin/bin/catkin_make_isolated --install -DCMAKE_BUILD_TYPE=Release --install-space /opt/ros/indigo


RUN sh -c 'echo "source /opt/ros/indigo/setup.bash" >> ~/.bashrc'
CMD ["/usr/bin/bash"]
