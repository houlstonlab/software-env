#!/bin/bash

all: setup \
	pull-singularity \
	build-singularity \
	pull-docker \
	build-docker \
	build-conda \
	list-all

setup:
	@echo "Setting up the directories"
	mkdir -p singularity singularity-def
	mkdir -p docker docker-files
	mkdir -p conda conda-yaml
	mkdir -p resources

pull-singularity: scripts/pull-singularity.sh resources/singularity-urls.txt
	@echo "Pulling the singularity images"
	sh scripts/pull-singularity.sh

build-singularity: scripts/build-singularity.sh resources/docker-urls.txt docker/*.tar
	@echo "Building the singularity images"
	sh scripts/build-singularity.sh

pull-docker: scripts/pull-docker.sh resources/docker-urls.txt
	@echo "Pulling the docker images"
	sh scripts/pull-docker.sh

build-docker: scripts/build-docker.sh docker-files/*/Dockerfile
	@echo "Building the docker images"
	sh scripts/build-docker.sh

build-conda: scripts/build-conda.sh conda-yaml/*.yaml
	@echo "Building the conda environments"
	sh scripts/build-conda.sh

list-all:
	@echo "Listing all the images in 'available-images-environments.txt'"
	ls -d {singularity,docker,conda}/* | sort > available-images-environments.txt