#!/bin/bash

all: setup \
	pull-singularity \
	build-singularity \
	build-conda \
	list-all

setup:
	@echo "Setting up the directories"
	mkdir -p singularity singularity-def
	mkdir -p docker docker-files
	mkdir -p conda conda-yaml

pull-singularity:
	@echo "Pulling the singularity images"
	singularity pull --name singularity/bcftools.1.9.sif https://depot.galaxyproject.org/singularity/bcftools%3A1.9--ha228f0b_4

build-singularity:
	@echo "Building the singularity images"
	singularity build singularity/bcftools_from_docker.sif docker-archive:docker/bcftools.tar
	singularity build singularity/bcftools_from_dockerhub.sif docker://dockerbiotools/bcftools

build-docker:
	@echo "Building the docker images"
	docker build -t bcftools docker-files/bcftools

build-conda:
	@echo "Building the conda environments"
	conda env create -f conda-yaml/bcftools.yaml --prefix conda/bcftools

list-all:
	@echo "Listing all the images in 'available-images-environments.txt'"
	ls -d {singularity,docker,conda}/* | sort > available-images-environments.txt