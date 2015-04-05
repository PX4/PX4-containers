#!/bin/bash
#
# Run container and start test execution
#
# License: according to LICENSE.md in the root directory of the PX4 Firmware repository
set -e

if [ -z "$WORKSPACE" ]; then
	echo "\$WORKSPACE not set"
	exit 1
fi

# Pulling latest image
# TODO: remove old one to save space
docker pull px4io/sitl-testing

#
# Running SITL testing container
# Assuming that necessary source projects, including this one, are cloned in the build server workspace of this job.
#
docker run --rm -v "$WORKSPACE:/job:rw" px4io/sitl-testing bash "/sitl/testing/run-tests.bash"
