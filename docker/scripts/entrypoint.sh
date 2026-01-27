#!/bin/bash
set -e

USER_NAME=user
TARGET_UID=${LOCAL_USER_ID:-1000}

# From Ubuntu 24.04 there is existing UID 1000 for ubuntu user/group.
# Detect if it is in conflict with $LOCAL_USER_ID:
detectUIDConflict() {
    USER_NAME=user
    TARGET_UID=${LOCAL_USER_ID:-1000}

    # Check if UID is already taken
    EXISTING_USER=$(getent passwd "$TARGET_UID" | cut -d: -f1 || true)

    if [ -n "$EXISTING_USER" ] && [ "$EXISTING_USER" != "$USER_NAME" ]; then
        echo "UID $TARGET_UID already belongs to $EXISTING_USER — removing it"
        userdel "$EXISTING_USER" || true
    fi
}

# Start virtual X server in the background
# - DISPLAY default is :99, set in dockerfile
# - Users can override with `-e DISPLAY=` in `docker run` command to avoid
#   running Xvfb and attach their screen
if [[ -x "$(command -v Xvfb)" && "$DISPLAY" == ":99" ]]; then
	echo "Starting Xvfb"
	Xvfb :99 -screen 0 1600x1200x24+32 &
fi

# Check if the ROS_DISTRO is passed and use it
# to source the ROS environment
if [ -n "${ROS_DISTRO}" ]; then
	source "/opt/ros/$ROS_DISTRO/setup.bash"
fi

# Use the LOCAL_USER_ID if passed in at runtime
if [ -n "${LOCAL_USER_ID}" ]; then
	echo "Starting with UID : $LOCAL_USER_ID"
    # If UID conflicts, delete system user (ubuntu if 24.04)	
    detectUIDConflict
	# Now it's safe to modify existing user's id
    usermod -u "$TARGET_UID" "$USER_NAME"
    # Fix ownership of home (important!)
    chown -R "$TARGET_UID":"$TARGET_UID" "/home/$USER_NAME" || true
	# run as user
	exec gosu user "$@"
else
	exec "$@"
fi
