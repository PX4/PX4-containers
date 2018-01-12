TAG := $(if $(TAG),$(TAG),local)

.PHONY: px4-dev-base px4-dev-nuttx px4-dev-simulation px4-dev-ros

all: px4-dev-base px4-dev-nuttx px4-dev-simulation px4-dev-ros px4-dev-raspi px4-dev-armhf px4-dev-clang px4-dev-nuttx-cclang px4-dev-base-archlinux

px4-dev-base:
	docker build -t px4io/px4-dev-base:$(TAG) . -f Dockerfile_base

px4-dev-nuttx: px4-dev-base
	docker build -t px4io/px4-dev-nuttx:$(TAG) . -f Dockerfile_nuttx

px4-dev-simulation: px4-dev-base
	docker build -t px4io/px4-dev-simulation:$(TAG) . -f Dockerfile_simulation

px4-dev-ros: px4-dev-simulation
	docker build -t px4io/px4-dev-ros:$(TAG) . -f Dockerfile_ros


px4-dev-raspi: px4-dev-base
	docker build -t px4io/px4-dev-raspi:$(TAG) . -f Dockerfile_raspi

px4-dev-armhf: px4-dev-base
	docker build -t px4io/px4-dev-armhf:$(TAG) . -f Dockerfile_armhf



px4-dev-clang: px4-dev-base
	docker build -t px4io/px4-dev-clang:$(TAG) . -f Dockerfile_clang

px4-dev-nuttx-clang: px4-dev-clang
	docker build -t px4io/px4-dev-nuttx-clang:$(TAG) . -f Dockerfile_nuttx_clang


px4-dev-base-archlinux:
	docker build -t px4io/px4-dev-base-archlinux:$(TAG) . -f Dockerfile_base_archlinux

