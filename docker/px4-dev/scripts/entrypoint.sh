#!/bin/bash

# Add local user
# Either use the LOCAL_USER_ID if passed in at runtime or
# fallback

if [ -n "${LOCAL_USER_ID}" ]; then

	echo "Starting with UID : $LOCAL_USER_ID"

	# modify existing user's id
	usermod -u $LOCAL_USER_ID user

	if [ -d "$CCACHE_DIR" ]; then
		chown -R $USER_ID $CCACHE_DIR
	fi

	exec gosu user "$@"

else
	if [ -d "$CCACHE_DIR" ]; then
		chown -R $USER_ID $CCACHE_DIR
	fi

	exec "$@"
fi
