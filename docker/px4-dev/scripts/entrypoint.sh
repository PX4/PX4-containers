#!/bin/bash

# Add local user
# Either use the LOCAL_USER_ID if passed in at runtime or
# fallback

USER_ID=${LOCAL_USER_ID:-9001}

echo "Starting with UID : $USER_ID"
useradd --shell /bin/bash -u $USER_ID -o -c "" -m user
usermod -a -G dialout user
usermod -a -G sudo user

if [ -d "$CCACHE_DIR" ]; then
	chown -R $USER_ID $CCACHE_DIR
	if [ ! $? -eq 0 ]; then
		echo "ccache permission issues, disabling"
		export CCACHE_DISABLE=1
	else
		export CCACHE_BASEDIR=`pwd`
		export CCACHE_UMASK=002
	fi
else
	export CCACHE_DISABLE=1
fi

# unsetting ROS_DISTRO to silence ROS_DISTRO override warning
unset ROS_DISTRO

# setup ros1 environment
if [ -v ROS1_DISTRO ] && [ ! -z "$ROS1_DISTRO" ] && [ -f /opt/ros/$ROS1_DISTRO/setup.bash ]; then
	source /opt/ros/$ROS1_DISTRO/setup.bash
fi

# setup ros2 environment
if [ -v ROS2_DISTRO ] && [ ! -z "$ROS2_DISTRO" ] && [ -f /opt/ros/$ROS2_DISTRO/setup.bash ]; then
	source /opt/ros/$ROS2_DISTRO/setup.bash
fi

unset ROS1_DISTRO
unset ROS2_DISTRO

exec gosu user "$@"
