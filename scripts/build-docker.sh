#!/bin/bash

# Loop over docker-files directory
for df in docker-files/*; do
	# Get the name of the conda environment
	name=$(basename ${df})

	# Create the docker environment
	docker build -t ${name} docker-files/${name}
	docker save -o ${DOCKER_CACHEDIR}/${name}.tar ${name}
done
	