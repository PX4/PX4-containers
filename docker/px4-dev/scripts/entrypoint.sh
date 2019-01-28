#!/bin/bash

# Add local user
# Either use the LOCAL_USER_ID if passed in at runtime or
# fallback

if [ "${ROS_DISTRO}" == "melodic" ]; then
	export DISPLAY=:0
	Xvfb :1 -screen 0 1600x1200x24+32 &
fi

if [ -n "${LOCAL_USER_ID}" ]; then

	echo "Starting with UID : $LOCAL_USER_ID"

	# modify existing user's id
	usermod -u $LOCAL_USER_ID user

	exec gosu user "$@"

else

	exec "$@"
fi
