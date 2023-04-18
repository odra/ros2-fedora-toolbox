SHELL := /bin/bash
FEDORA_VERSION := 37
ROS_VERSION := rolling
REG := quay.io
ORG := lrossett
NAME := fedora-toolbox-ros2
TAG := f${FEDORA_VERSION}-${ROS_VERSION}
IMAGE := ${REG}/${ORG}/${NAME}:${TAG}
CRI_CLI := podman

.PHONY: build
build:
	@ ${CRI_CLI} build \
		--build-arg FEDORA_VERSION=${FEDORA_VERSION} \
		--build-arg=${ROS_VERSION} \
		-t ${IMAGE} .

.PHONY: push
push:
	@ ${CRI_CLI} push ${IMAGE}

.PHONY: debug
debug:
	@ ${CRI_CLI} run -it ${IMAGE} /bin/bash
