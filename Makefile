SHELL := /bin/bash
REG := quay.io
ORG := lrossett
NAME := fedora-toolbox-ros2
TAG := f37-rolling
IMAGE := ${REG}/${ORG}/${NAME}:${TAG}
CRI_CLI := podman

.PHONY: build
build:
	@ ${CRI_CLI} build -t ${IMAGE} .

.PHONY: push
push:
	@ ${CRI_CLI} push ${IMAGE}

.PHONY: debug
debug:
	@ ${CRI_CLI} run -it ${IMAGE} /bin/bash
