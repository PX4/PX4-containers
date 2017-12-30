#!/bin/bash

# Add local user
# Either use the LOCAL_USER_ID if passed in at runtime or
# fallback

USER_ID=${LOCAL_USER_ID:-9001}

echo "Starting with UID : $USER_ID"
useradd --shell /bin/bash -u $USER_ID -o -c "" -m user
usermod -a -G dialout user

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

if [ -f /opt/ros/kinetic/setup.bash ]; then
	source /opt/ros/kinetic/setup.bash
fi

exec gosu user "$@"
