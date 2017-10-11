# Purpose

The containers in this directory are meant to be used in a "microservices" fashion, i.e. having (as much as possible) one container representing one logical module.

## Example use-cases

* __Deployment on drones:__ one could have `px4-posix-mavros` and a ROS module deriving from `px4-posix-ros-base` running on an Intel Aero.
* __Continuous integration:__ the system could run the tested code against fixed containers (SITL, Mavros, ...), ensuring that those containers don't change between different runs.
* __Development:__ a developer working on a specific ROS module could just run his simulation in a container, mavros in another one, and his ROS nodes directly on his machine. This way she would not have to care about maintaining a working simulation environment.
* __Quick start guide:__ a new developer can just run a set of containers and enjoy the simulation without having to go through the pain of installing the full system.

# Hierarchy

The containers are organized as follows. Containers listed in bold are already implemented, others are just suggestions for further development.

* __`px4-base`__
    * __`px4-base-posix`__
        * __`px4-posix-ros-core`__
            * __`px4-posix-ros-base`__
                * __`px4-posix-ros-build`__
                    * __`px4-posix-mavros`__
                * `px4-posix-ros-gazebo`
                    * `px4-posix-dev-full`
        * `px4-posix-sim`
            * `px4-posix-gazebo`
            * `px4-posix-jmavsim`
    * `px4-base-nuttx`
    * `px4-base-raspi`

# Naming conventions

* All container names start with the `px4-` prefix (e.g. `px4-base`)
* Using `-dev-` in a name means that it includes development tools (in case there is a need for that). However, it is likely that developers would rather extend one of these images and build their own development image with the specific tools they use.

# Folders organization

* Each dockerfile is in its own directory, together with a README explaining its purpose.
* There may be other files at the same level as the dockerfile and README, for instance resource files that need to be copied in the image.
* There is a flat folder hierarchy between docker files (e.g. even though px4-base-posix derives from px4-base, they both have their own directory at the same level in the hierarchy).
