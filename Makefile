#!/bin/bash

singularity: pull-singularity \
	download-singularity \
	build-singularity

docker: pull-docker \
	build-docker

conda: build-conda

check:
	@[ -z "${SINGULARITY_CACHEDIR}" ] && mkdir -p singularity && export SINGULARITY_CACHEDIR=singularity && echo "SINGULARITY_CACHEDIR is set to singularity" || echo "SINGULARITY_CACHEDIR is defined as ${SINGULARITY_CACHEDIR}"
	@[ -z "${DOCKER_CACHEDIR}" ] && mkdir -p docker && export DOCKER_CACHEDIR=docker && echo "DOCKER_CACHEDIR is set to docker" || echo "DOCKER_CACHEDIR is defined as ${DOCKER_CACHEDIR}"
	@[ -z "${CONDA_CACHEDIR}" ] && mkdir -p conda && export CONDA_CACHEDIR=conda && echo "CONDA_CACHEDIR is set to conda" || echo "CONDA_CACHEDIR is defined as ${CONDA_CACHEDIR}"

pull-singularity: scripts/pull-singularity.sh \
	resources/singularity-urls.txt
	@echo "Pulling the singularity images"
	sbatch scripts/pull-singularity.sh

download-singularity: scripts/download-singularity.sh \
	resources/nfcore-pipelines.txt
	@echo "Download nfcore pipelines singularity images"
	sbatch scripts/download-singularity.sh

build-singularity: scripts/build-singularity.sh \
	singularity-def/*.def
	@echo "Building the singularity images"
	sbatch scripts/build-singularity.sh

pull-docker: scripts/pull-docker.sh \
	resources/docker-urls.txt
	@echo "Pulling the docker images"
	sh scripts/pull-docker.sh

build-docker: scripts/build-docker.sh \
	docker-files/*/Dockerfile
	@echo "Building the docker images"
	sh scripts/build-docker.sh

build-conda: scripts/build-conda.sh \
	conda-yaml/*.yaml
	@echo "Building the conda environments"
	sh scripts/build-conda.sh

list-all:
	@echo "Listing all the images in 'available-images-environments.txt'"
	ls -d ${SCRATCH}/software-env/{conda,docker,singularity}/* | sort > available-images-environments.txt