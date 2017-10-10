# Mavros container
## Quick start

Run mavros on the default `fcu_url` (`udp://:14540@127.0.0.1:14557`) with the following command:

    $ docker run --rm -it px4-posix-mavros

## Custom Mavros arguments

The entrypoint of the container makes it run mavros directly with the parameters you give (default is `fcu_url:="udp://:14540@127.0.0.1:14557"`):

    $ docker run --rm -it -p 11311:11311 px4io/px4-posix-mavros fcu_url:="udp://:14540@127.0.0.1:14557"

## Build mavros image

You can build the image yourself by cloning this repository, navigating to this folder and running:

    $ docker build -t <image_name_you_want> .

## More details

Note that mavros starts a ROS master if it doesn't find any, which is set to run on port "11311" in the Dockerfile.

Thanks to the `-p 11311:11311` part of the command above, the container binds its `11311` port to `localhost:11311` on the host. Since ROS is looking for the master locally on this port by default, it means that the host now has a ROS master running on `http://localhost:11311`. Try, for instance:

    $ rostopic list

This setup can be quite useful; one can for instance run ROS nodes on different containers, all set to use the mavros container as their ROS master (check the `ROS_MASTER_URI` environment variable) while at the same time running ROS nodes transparently on the host.
