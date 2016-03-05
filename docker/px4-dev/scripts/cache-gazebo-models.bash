#!/bin/bash
#
# Caching Gazebo models we don't need to load them each time the container runs.
#
# License: according to LICENSE.md in the root directory of the PX4 Firmware repository

# Prepare for automatic execution (not necessary if you execute the commands manually one by one)
set -e

# Add all the models we need here:
declare -a MODELS=("ground_plane" "sun")
MODEL_DIR="$HOME/.gazebo/models/"

# create model dir
mkdir -p "$MODEL_DIR"

# temporary location
mkdir models
cd models

for m in "${MODELS[@]}"
do
        wget "http://models.gazebosim.org/$m/model.tar.gz"
        tar -zvxf model.tar.gz
        cp -vfR $m "$HOME/.gazebo/models/"
        rm model.tar.gz
done

cd ..
rm -r models
