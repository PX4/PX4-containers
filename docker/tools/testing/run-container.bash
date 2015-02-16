#!/bin/bash

WS=`pwd`
#
# Running SITL testing container
# Assuming that necessary source projects, including this one, are cloned in the build server workspace of this job.
#
docker run --rm -v $WS:/job:rw px4io/sitl-testing bash /job/container/docker/tools/testing/run-tests.bash
