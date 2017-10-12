FROM px4io/px4-posix-ros-base

RUN apt-get update && \
    apt-get install -y python-wstool \
                       python-rosinstall-generator \
                       python-catkin-tools

RUN ["/bin/bash", "-c", " \
    source /opt/ros/kinetic/setup.bash && \
    rosdep init && \
    rosdep update \
"]
