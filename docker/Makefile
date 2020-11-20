
.PHONY: px4-dev-armhf, px4-dev-base-archlinux, px4-dev-base-bionic, \
		px4-dev-base-focal, px4-dev-clang, \
		px4-dev-nuttx-bionic, px4-dev-nuttx-focal, px4-dev-nuttx-clang, \
		px4-dev-raspi, px4-dev-ros-melodic, \
		px4-dev-ros-noetic, px4-dev-ros2-bouncy, \
		px4-dev-ros2-crystal, px4-dev-ros2-dashing, px4-dev-ros2-eloquent, \
		px4-dev-ros2-foxy, px4-dev-simulation-bionic, px4-dev-simulation-focal, \
		px4-docs\


all: px4-dev-armhf, px4-dev-base-archlinux, px4-dev-base-bionic, \
		px4-dev-base-focal, px4-dev-clang, \
		px4-dev-nuttx-bionic, px4-dev-nuttx-focal, px4-dev-nuttx-clang, \
		px4-dev-raspi, px4-dev-ros-melodic, \
		px4-dev-ros-noetic, px4-dev-ros2-bouncy, \
		px4-dev-ros2-crystal, px4-dev-ros2-dashing, px4-dev-ros2-eloquent, \
		px4-dev-ros2-foxy, px4-dev-simulation-bionic, px4-dev-simulation-focal, \
		px4-docs \

px4-dev-armhf:
	docker build -t px4io/px4-dev-armhf . -f Dockerfile_armhf

px4-dev-aarch64:
	docker build -t px4io/px4-dev-aarch64 . -f Dockerfile_aarch64

px4-dev-base-archlinux:
	docker build -t px4io/px4-dev-base-archlinux . -f Dockerfile_base-archlinux

px4-dev-base-bionic:
	docker build -t px4io/px4-dev-base-bionic . -f Dockerfile_base-bionic

px4-dev-base-focal:
	docker build -t px4io/px4-dev-base-focal . -f Dockerfile_base-focal

px4-dev-clang: px4-dev-base-bionic
	docker build -t px4io/px4-dev-clang . -f Dockerfile_clang

px4-dev-nuttx-bionic: px4-dev-base-bionic
	docker build -t px4io/px4-dev-nuttx-bionic . -f Dockerfile_nuttx-bionic

px4-dev-nuttx-focal: px4-dev-base-focal
	docker build -t px4io/px4-dev-nuttx-focal . -f Dockerfile_nuttx-focal

px4-dev-nuttx-clang: px4-dev-clang
	docker build -t px4io/px4-dev-nuttx-clang . -f Dockerfile_nuttx_clang

px4-dev-raspi: px4-dev-base-bionic
	docker build -t px4io/px4-dev-raspi . -f Dockerfile_raspi

px4-dev-ros-melodic: px4-dev-simulation-bionic
	docker build -t px4io/px4-dev-ros-melodic . -f Dockerfile_ros-melodic

px4-dev-ros-noetic: px4-dev-simulation-focal
	docker build -t px4io/px4-dev-ros-noetic . -f Dockerfile_ros-noetic

px4-dev-ros2-bouncy: px4-dev-ros-melodic
	docker build -t px4io/px4-dev-ros2-bouncy . -f Dockerfile_ros2-bouncy

px4-dev-ros2-crystal: px4-dev-ros-melodic
	docker build -t px4io/px4-dev-ros2-crystal . -f Dockerfile_ros2-crystal

px4-dev-ros2-bouncy: px4-dev-ros-melodic
	docker build -t px4io/px4-dev-ros2-bouncy . -f Dockerfile_ros2-bouncy

px4-dev-ros2-dashing: px4-dev-ros-melodic
	docker build -t px4io/px4-dev-ros2-dashing . -f Dockerfile_ros2-dashing

px4-dev-ros2-eloquent: px4-dev-ros-melodic
	docker build -t px4io/px4-dev-ros2-eloquent . -f Dockerfile_ros2-eloquent

px4-dev-ros2-foxy: px4-dev-ros-noetic
	docker build -t px4io/px4-dev-ros2-foxy . -f Dockerfile_ros2-foxy

px4-dev-simulation-bionic: px4-dev-base-bionic
	docker build -t px4io/px4-dev-simulation-bionic . -f Dockerfile_simulation-bionic

px4-dev-simulation-focal: px4-dev-base-focal
	docker build -t px4io/px4-dev-simulation-focal . -f Dockerfile_simulation-focal

px4-docs:
	docker build -t px4io/px4-dev-docs . -f Dockerfile_docs
