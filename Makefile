SHELL := /bin/bash
FEDORA_VERSION := 38
REG := quay.io
ORG := lrossett
NAME := fedora-toolbox-ros2
TAG := f${FEDORA_VERSION}-rolling
IMAGE := ${REG}/${ORG}/${NAME}:${TAG}
CRI_CLI := podman

.PHONY: build
build:
	@ ${CRI_CLI} build --build-arg FEDORA_VERSION=${FEDORA_VERSION} -t ${IMAGE} .

.PHONY: push
push:
	@ ${CRI_CLI} push ${IMAGE}

.PHONY: debug
debug:
	@ ${CRI_CLI} run -it ${IMAGE} /bin/bash
